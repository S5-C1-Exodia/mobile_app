import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:app_links/app_links.dart';
import '../models/daos/interfaces/i_user_dao.dart';

class ConnexionVM extends ChangeNotifier {
  final IUserDAO _userDAO;

  bool _isLoading = false;
  String? _errorMessage;
  bool _isConnected = false;
  String? _state;
  String? _authUrl;

  AppLinks? _appLinks;
  StreamSubscription<Uri>? _linkSub;

  ConnexionVM(this._userDAO) {
    _initLinks();
  }

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isConnected => _isConnected;
  String? get state => _state;

  Future<void> _initLinks() async {
    _appLinks = AppLinks();

    _linkSub = _appLinks!.uriLinkStream.listen((uri) async {
      if (_isSpotifyCallback(uri)) {
        final st = uri.queryParameters['state'];
        if (st != null) {
          _state = st;
          _isConnected = true;
          await _userDAO.saveSession(st);
          notifyListeners();
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
          _isConnected = true;
          await _userDAO.saveSession(st);
          notifyListeners();
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

  Future<void> connect() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final sessionId = await _userDAO.startAuthSession();
      if (sessionId == null) {
        throw Exception("Impossible to get session from API");
      }

      _state = sessionId;
      await _userDAO.saveSession(sessionId);

      final authUrl = await _userDAO.getAuthUrl(sessionId);
      if (authUrl == null) {
        throw Exception("URL authentification wasn't get");
      }

      _authUrl = authUrl;
      await launchUrl(Uri.parse(authUrl), mode: LaunchMode.externalApplication);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

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
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
