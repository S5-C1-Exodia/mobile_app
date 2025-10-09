import 'dart:convert';
import 'package:http/http.dart' as http;
import 'interfaces/i_user_dao.dart';

class ApiUserDAO implements IUserDAO {
  static const String baseUrl = 'https://dana-impeachable-dilemmatically.ngrok-free.dev/api/spotify';

  String? _sessionId;
  String? _authUrl;

  @override
  Future<void> saveSession(String sessionId) async {
    _sessionId = sessionId;
    print('Session saved : $sessionId');
  }

  @override
  Future<String?> getSession() async => _sessionId;

  @override
  Future<void> clearSession() async {
    _sessionId = null;
    _authUrl = null;
  }

  @override
  Future<String?> startAuthSession() async {
    const scopes = [
      "user-read-email",
      "playlist-read-private",
      "user-library-read"
    ];
    final url = Uri.parse('$baseUrl/auth/start');
    print('POST $url');

    final res = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({"scopes": scopes}),
    );

    print('Status: ${res.statusCode}');
    print('Body: ${res.body}');

    if (res.statusCode != 200) {
      print('Error startAuthSession: ${res.statusCode}');
      return null;
    }

    final data = json.decode(res.body);
    final authUrl = data['authorizationUrl'] ??
        data['authorizationurl'] ??
        data['AuthorizationUrl'];
    final state = data['state'] ?? data['State'];

    if (authUrl == null || state == null) {
      print('Invalid answer: ${res.body}');
      return null;
    }

    _authUrl = authUrl;
    _sessionId = state;

    print('Auth start OK — state: $state');
    print('URL: $authUrl');

    return state;
  }

  @override
  Future<String?> getAuthUrl(String sessionId) async => _authUrl;

  @override
  Future<bool> validateCallback(String code, String state) async {
    if (_sessionId == null || _sessionId != state) {
      print('State mismatch: $_sessionId != $state');
      return false;
    }
    print('Valid Callback — code=$code, state=$state');
    return true;
  }

  @override
  Future<void> logout() async {
    if (_sessionId != null) {
      try {
        final url = Uri.parse('$baseUrl/logout');
        await http.post(url);
        print('Logout done');
      } catch (e) {
        print('Error logout: $e');
      }
    }
    _sessionId = null;
    _authUrl = null;
  }
}
