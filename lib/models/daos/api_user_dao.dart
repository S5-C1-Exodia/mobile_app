import 'dart:convert';
import 'package:http/http.dart' as http;
import 'interfaces/i_user_dao.dart';

/// Implementation of IUserDAO for managing user authentication and session via API.
///
/// Handles saving, retrieving, and clearing user sessions, as well as starting authentication flows,
/// obtaining authorization URLs, validating callbacks, and logging out.
class ApiUserDAO implements IUserDAO {
  /// Base URL for the Spotify API endpoints.
  static const String baseUrl = 'https://api.entreprise-de-sousa/api/spotify';

  /// Stores the current session identifier.
  String? _sessionId;

  /// Stores the current authentication URL.
  String? _authUrl;

  /// Saves the session identifier locally.
  ///
  /// [sessionId] The session identifier to save.
  @override
  Future<void> saveSession(String sessionId) async {
    _sessionId = sessionId;
  }

  /// Retrieves the current session identifier.
  ///
  /// Returns the session identifier if available, otherwise null.
  @override
  Future<String?> getSession() async => _sessionId;

  /// Clears the current session and authentication URL.
  @override
  Future<void> clearSession() async {
    _sessionId = null;
    _authUrl = null;
  }

  /// Starts a new authentication session with the required scopes.
  ///
  /// Returns the session state if successful, otherwise null.
  @override
  Future<String?> startAuthSession() async {
    const scopes = [
      "user-read-email",
      "playlist-read-private",
      "user-library-read"
    ];
    final url = Uri.parse('$baseUrl/auth/start');

    final res = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({"scopes": scopes}),
    );


    if (res.statusCode != 200) {
      return null;
    }

    final data = json.decode(res.body);
    final authUrl = data['authorizationUrl'] ??
        data['authorizationurl'] ??
        data['AuthorizationUrl'];
    final state = data['state'] ?? data['State'];

    if (authUrl == null || state == null) {
      return null;
    }

    _authUrl = authUrl;
    _sessionId = state;


    return state;
  }

  /// Retrieves the authentication URL for the current session.
  ///
  /// [sessionId] The session identifier (unused, returns stored URL).
  /// Returns the authentication URL if available, otherwise null.
  @override
  Future<String?> getAuthUrl(String sessionId) async => _authUrl;

  /// Validates the authentication callback by checking the state.
  ///
  /// [code] The authorization code received.
  /// [state] The state parameter received.
  /// Returns true if the callback is valid, otherwise false.
  @override
  Future<bool> validateCallback(String code, String state) async {
    if (_sessionId == null || _sessionId != state) {
      return false;
    }
    print('Valid Callback — code=$code, state=$state');
    return true;
  }

  /// Logs out the current user and clears session data.
  @override
  Future<void> logout() async {
    if (_sessionId != null) {
      try {
        final url = Uri.parse('$baseUrl/logout');
        await http.post(url);
      } catch (e) {
      }
    }
    _sessionId = null;
    _authUrl = null;
  }
}