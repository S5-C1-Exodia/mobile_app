import 'dart:convert';

import 'package:flutter/foundation.dart';
import '../models/daos/api_user_dao.dart';
import 'package:http/http.dart' as http;

class ConnexionVM extends ChangeNotifier {
  final IUserDAO _userDAO;

  bool _isLoading = false;
  String? _errorMessage;
  bool _isConnected = false;

  ConnexionVM(this._userDAO);

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isConnected => _isConnected;

  Future<void> connect() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _getAuthUrl();

      final sessionId = response['session_id'] as String;
      final authUrl = response['url'] as String;

      await _userDAO.saveSession(sessionId);
      await _userDAO.urlLauncher(authUrl);

    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Map<String, dynamic>> _getAuthUrl() async {
    final sessionId = 'session_${DateTime.now().millisecondsSinceEpoch}';
    final authUrl = 'https://accounts.spotify.com/authorize?client_id=xxx&response_type=code&redirect_uri=xxx&state=$sessionId';

    return {
      'session_id': sessionId,
      'url': authUrl,
    };
  }

  Future<void> handleCallback(String code) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final sessionId = await _userDAO.getSession();
      if (sessionId == null) {
        throw Exception('Session not found');
      }

      final response = await http.post(
        Uri.parse('A mettre quand Mathis m\'aura donné l\'URL'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'code': code,
          'session_id': sessionId,
        }),
      );

      if (response.statusCode == 200) {
        _isConnected = true;
      } else {
        throw Exception('Error during authentification');
      }
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
