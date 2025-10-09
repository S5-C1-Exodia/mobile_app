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

  Completer<void>? _initCompleter;

  ConnexionVM(this._userDAO) {
    _initCompleter = Completer<void>();
    _initLinks();
  }

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isConnected => _isConnected;
  String? get state => _state;

  Future<void> _initLinks() async {
    try {
      _appLinks = AppLinks();

      _linkSub = _appLinks!.uriLinkStream.listen((uri) async {
        print('Deep link reçu: $uri');
        if (_isSpotifyCallback(uri)) {
          final st = uri.queryParameters['sid'];
          if (st != null) {
            print('Session ID extrait du callback: $st');
            _state = st;
            _isConnected = true;
            await _userDAO.saveSession(st);
            notifyListeners();
          }
        }
      }, onError: (err) {
        print('Erreur listener deep link: $err');
        _errorMessage = err.toString();
        notifyListeners();
      });

      final initialUri = await _appLinks!.getInitialAppLink();
      if (initialUri != null && _isSpotifyCallback(initialUri)) {
        final st = initialUri.queryParameters['sid'];
        if (st != null) {
          print('Session ID du lien initial: $st');
          _state = st;
          _isConnected = true;
          await _userDAO.saveSession(st);
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

  bool _isSpotifyCallback(Uri uri) {
    return uri.scheme == 'swipez' && uri.host == 'oauth-callback';
  }

  Future<void> connect() async {
    if (_initCompleter != null && !_initCompleter!.isCompleted) {
      print('Attente de la fin de l\'initialisation...');
      await _initCompleter!.future;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final sessionId = await _userDAO.startAuthSession();
      if (sessionId == null) {
        throw Exception("Impossible d'obtenir la session depuis l'API");
      }

      _state = sessionId;
      await _userDAO.saveSession(sessionId);

      final authUrl = await _userDAO.getAuthUrl(sessionId);
      if (authUrl == null) {
        throw Exception("URL d'authentification non reçue");
      }

      _authUrl = authUrl;
      print('Lancement de l\'URL OAuth: $authUrl');

      final launched = await launchUrl(
        Uri.parse(authUrl),
        mode: LaunchMode.externalApplication,
      );

      if (!launched) {
        throw Exception("Impossible d'ouvrir le navigateur");
      }
    } catch (e) {
      print('Erreur connect: $e');
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

  @override
  void dispose() {
    _linkSub?.cancel();
    super.dispose();
  }
}