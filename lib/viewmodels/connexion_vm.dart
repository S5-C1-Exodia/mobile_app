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

  // Callback pour notifier la connexion réussie (séparation des couches)
  void Function()? onConnectionSuccess;

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
        print('🔗 Deep link reçu: $uri');
        print('   Scheme: ${uri.scheme}, Host: ${uri.host}');
        print('   Query params: ${uri.queryParameters}');
        print('   État attendu: $_state');

        if (_isSpotifyCallback(uri)) {
          print('✅ C\'est un callback Spotify valide');

          // Essayer 'state' d'abord (standard OAuth), puis 'sid'
          final st = uri.queryParameters['state'] ?? uri.queryParameters['sid'];
          print('   State/SID reçu: $st');

          if (st != null) {
            print('✅ Session ID reçu !');
            _state = st; // Mettre à jour avec le nouveau SID
            _isLoading = false;
            _isConnected = true;
            await _userDAO.saveSession(st);

            // Appeler le callback si défini (navigation)
            onConnectionSuccess?.call();

            notifyListeners();
          } else {
            print('❌ Aucun Session ID reçu');
            _isLoading = false;
            _errorMessage = 'Aucun identifiant de session reçu';
            notifyListeners();
          }
        } else {
          print('❌ Pas un callback Spotify valide');
        }
      }, onError: (err) {
        print('Erreur listener deep link: $err');
        _errorMessage = err.toString();
        _isLoading = false;
        notifyListeners();
      });

      final initialUri = await _appLinks!.getInitialAppLink();
      if (initialUri != null && _isSpotifyCallback(initialUri)) {
        final st = initialUri.queryParameters['state'] ?? initialUri.queryParameters['sid'];
        if (st != null) {
          print('Session ID du lien initial: $st');
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

      // Timeout de sécurité : 2 minutes max
      Future.delayed(const Duration(minutes: 2), () {
        if (_isLoading) {
          print('⏱️ Timeout : pas de callback reçu');
          _isLoading = false;
          _errorMessage = 'Délai d\'attente dépassé. Veuillez réessayer.';
          notifyListeners();
        }
      });

    } catch (e) {
      print('Erreur connect: $e');
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
    // Ne pas mettre isLoading à false ici,
    // il sera mis à false quand le callback arrivera
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
      _errorMessage = null;
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
    onConnectionSuccess = null;
    super.dispose();
  }
}