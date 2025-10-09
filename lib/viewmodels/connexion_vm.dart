import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:app_links/app_links.dart';
import 'package:http/http.dart' as http;
import '../models/daos/interfaces/i_user_dao.dart';
import 'package:url_launcher/url_launcher.dart';

/// ViewModel responsible for managing user authentication state and logic.
///
/// Handles connection, disconnection, and authentication callback processing.
/// Notifies listeners on state changes.
class ConnexionVM extends ChangeNotifier {
  /// Data access object for user session management.
  final IUserDAO _userDAO;

  /// Indicates if an operation is currently loading.
  bool _isLoading = false;
  /// Stores the latest error message, if any.
  String? _errorMessage;
  /// Indicates if the user is currently connected.
  bool _isConnected = false;
  String? _state;
  AppLinks? _appLinks;
  StreamSubscription<Uri>? _linkSub;

  /// Constructs a [ConnexionVM] with the given [IUserDAO].
  ConnexionVM(this._userDAO) {
    _initAppLinks();
  }

  /// Returns whether an operation is loading.
  bool get isLoading => _isLoading;
  /// Returns the current error message, if any.
  String? get errorMessage => _errorMessage;
  /// Returns whether the user is connected.
  bool get isConnected => _isConnected;

  Future<void> _initAppLinks() async {
    _appLinks = AppLinks();

    _linkSub = _appLinks!.uriLinkStream.listen((uri) async {
      if (_isSpotifyCallback(uri)) {
        final st = uri.queryParameters['state'];
        if (st != null) {
          _state = st;
          await _handleCallback(st);
        }
      }
    }, onError: (err) {
      _errorMessage = err.toString();
      notifyListeners();
    });

    try {
      final initialUri = await _appLinks!.getInitialAppLink();
      if (initialUri != null && _isSpotifyCallback(initialUri)) {
        final st = initialUri.queryParameters['state'];
        if (st != null) {
          _state = st;
          await _handleCallback(st);
        }
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  bool _isSpotifyCallback(Uri uri) {
    return uri.scheme == 'swipez' &&
        uri.host == 'oauth-callback' &&
        uri.path == '/spotify';
  }

  /// Initiates the authentication process.
  ///
  /// Retrieves an authentication URL and session ID, saves the session,
  /// and launches the authentication URL.
  Future<void> connect() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final res = await http.get(
        Uri.parse('https://ula-zoophagous-compressively.ngrok-free.dev/api/spotify/start/auth'),
      );

      if (res.statusCode != 200) {
        throw Exception('Server error: ${res.statusCode}');
      }

      final data = json.decode(res.body);
      final url = data['auth_url'] as String?;
      final state = data['state'] as String?;

      if (url == null || state == null) {
        throw Exception('Invalid answer from server.');
      }

      await _userDAO.saveSession(state);

      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Handles the authentication callback with the given [code].
  ///
  /// Exchanges the code and session ID for authentication and updates the connection state.
  Future<void> _handleCallback(String state) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final resp = await http.get(
        Uri.parse('https://ula-zoophagous-compressively.ngrok-free.dev/api/spotify/me?state=$state'),
      );

      if (resp.statusCode == 200) {
        _isConnected = true;
        await _userDAO.saveSession(state);
      } else {
        throw Exception('Callbackfailed (${resp.statusCode})');
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Disconnects the user and clears the session.
  Future<void> disconnect() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _userDAO.clearSession();
      _isConnected = false;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
