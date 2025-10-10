import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:app_links/app_links.dart';
import '../models/daos/interfaces/i_user_dao.dart';

/// ViewModel for managing user connection and authentication state.
///
/// Handles OAuth authentication flow, deep link callbacks, and session management.
/// Notifies listeners on state changes for UI updates.
class ConnexionVM extends ChangeNotifier {
  /// Data access object for user-related operations.
  final IUserDAO _userDAO;

  /// Indicates if a loading operation is in progress.
  bool _isLoading = false;

  /// Stores the latest error message, if any.
  String? _errorMessage;

  /// Indicates if the user is currently connected.
  bool _isConnected = false;

  /// Stores the current session state or ID.
  String? _state;

  /// Stores the authentication URL for OAuth.
  String? _authUrl;

  /// Handles app deep links.
  AppLinks? _appLinks;

  /// Subscription to the deep link stream.
  StreamSubscription<Uri>? _linkSub;

  /// Completer to track initialization completion.
  Completer<void>? _initCompleter;

  /// Callback to notify successful connection (for navigation or UI).
  void Function()? onConnectionSuccess;

  /// Constructs a [ConnexionVM] with the given [IUserDAO].
  ConnexionVM(this._userDAO) {
    _initCompleter = Completer<void>();
    _initLinks();
  }

  /// Returns whether a loading operation is in progress.
  bool get isLoading => _isLoading;

  /// Returns the latest error message, if any.
  String? get errorMessage => _errorMessage;

  /// Returns whether the user is connected.
  bool get isConnected => _isConnected;

  /// Returns the current session state or ID.
  String? get state => _state;

  /// Initializes deep link handling and processes initial app link.
  Future<void> _initLinks() async {
    try {
      _appLinks = AppLinks();

      _linkSub = _appLinks!.uriLinkStream.listen((uri) async {
        if (_isSpotifyCallback(uri)) {

          final st = uri.queryParameters['state'] ?? uri.queryParameters['sid'];

          if (st != null) {
            _state = st;
            _isLoading = false;
            _isConnected = true;
            await _userDAO.saveSession(st);
            onConnectionSuccess?.call();

            notifyListeners();
          } else {
            _isLoading = false;
            _errorMessage = 'No session ID received';
            notifyListeners();
          }
        } else {
        }
      }, onError: (err) {
        _errorMessage = err.toString();
        _isLoading = false;
        notifyListeners();
      });

      final initialUri = await _appLinks!.getInitialAppLink();
      if (initialUri != null && _isSpotifyCallback(initialUri)) {
        final st = initialUri.queryParameters['state'] ?? initialUri.queryParameters['sid'];
        if (st != null) {
          print('Session ID of the initial link: $st');
          _state = st;
          _isConnected = true;
          await _userDAO.saveSession(st);

          onConnectionSuccess?.call();

          notifyListeners();
        }
      }
    } catch (e) {
      print('Erreur init links: $e');
      _errorMessage = e.toString();
      notifyListeners();
    } finally {
      _initCompleter?.complete();
    }
  }

  /// Checks if the given [uri] is a valid Spotify OAuth callback.
  bool _isSpotifyCallback(Uri uri) {
    return uri.scheme == 'swipez' && uri.host == 'oauth-callback';
  }

  /// Starts the OAuth connection process.
  ///
  /// Launches the authentication URL in an external browser and waits for a callback.
  /// Handles errors and sets a timeout for the operation.
  Future<void> connect() async {
    if (_initCompleter != null && !_initCompleter!.isCompleted) {
      await _initCompleter!.future;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final sessionId = await _userDAO.startAuthSession();
      if (sessionId == null) {
        throw Exception("Unable to get the session from API");
      }

      _state = sessionId;
      await _userDAO.saveSession(sessionId);

      final authUrl = await _userDAO.getAuthUrl(sessionId);
      if (authUrl == null) {
        throw Exception("Authentication URL not received");
      }

      _authUrl = authUrl;

      final launched = await launchUrl(
        Uri.parse(authUrl),
        mode: LaunchMode.externalApplication,
      );

      if (!launched) {
        throw Exception("Unable to open the browser");
      }

      Future.delayed(const Duration(minutes: 2), () {
        if (_isLoading) {
          _isLoading = false;
          _errorMessage = 'Timeout exceeded. Please try again.';
          notifyListeners();
        }
      });

    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Disconnects the user and clears the session.
  ///
  /// Handles logout and session cleanup, and notifies listeners.
  Future<void> disconnect() async {
    _isLoading = true;
    notifyListeners();

    try {
      if (_state != null) {
        await _userDAO.logout();
      }
      await _userDAO.clearSession();
      _state = null;
      _isConnected = false;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Disposes resources and cancels subscriptions.
  @override
  void dispose() {
    _linkSub?.cancel();
    onConnectionSuccess = null;
    super.dispose();
  }
}