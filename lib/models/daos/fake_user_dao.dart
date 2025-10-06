import 'api_user_dao.dart';

class FakeUserDAO implements IUserDAO {
  String? _sessionId;

  @override
  Future<void> saveSession(String sessionId) async {
    _sessionId = sessionId;
    print('[FAKE] Session saved: $sessionId');
  }

  @override
  Future<String?> getSession() async {
    return _sessionId;
  }

  @override
  Future<void> clearSession() async {
    _sessionId = null;
    print('[FAKE] Session erased');
  }

  @override
  Future<void> urlLauncher(String url) async {
    print('[FAKE] URL launched: $url');
  }
}