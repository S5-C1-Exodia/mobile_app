import 'dart:convert';

import 'package:flutter/foundation.dart';
import '../models/daos/api_user_dao.dart';
import 'package:http/http.dart' as http;

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

  /// Constructs a [ConnexionVM] with the given [IUserDAO].
  ConnexionVM(this._userDAO);

  /// Returns whether an operation is loading.
  bool get isLoading => _isLoading;

  /// Returns the current error message, if any.
  String? get errorMessage => _errorMessage;

  /// Returns whether the user is connected.
  bool get isConnected => _isConnected;

  /// Initiates the authentication process.
  ///
  /// Retrieves an authentication URL and session ID, saves the session,
  /// and launches the authentication URL.
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

  /// Generates a mock authentication URL and session ID.
  ///
  /// Returns a map containing 'session_id' and 'url'.
  Future<Map<String, dynamic>> _getAuthUrl() async {
    final sessionId = 'session_${DateTime.now().millisecondsSinceEpoch}';
    final authUrl = 'https://accounts.spotify.com/authorize?client_id=xxx&response_type=code&redirect_uri=xxx&state=$sessionId';

    return {
      'session_id': sessionId,
      'url': authUrl,
    };
  }

  /// Handles the authentication callback with the given [code].
  ///
  /// Exchanges the code and session ID for authentication and updates the connection state.
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
