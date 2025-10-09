import 'interfaces/i_user_dao.dart';

/// Fake implementation of [IUserDAO] for testing purposes.
///
/// This class simulates user session management and URL launching
/// without performing any real persistence or external actions.
class FakeUserDAO implements IUserDAO {
  /// Stores the current session identifier in memory.
  String? _sessionId;

  @override
  /// Simulates saving the user session identifier in memory.
  ///
  /// [sessionId]: The unique identifier of the session to save.
  Future<void> saveSession(String sessionId) async {
    _sessionId = sessionId;
    print('[FAKE] Session saved: $sessionId');
  }

  @override
  /// Simulates retrieving the current session identifier from memory.
  ///
  /// Returns the session identifier, or `null` if no session is stored.
  Future<String?> getSession() async {
    return _sessionId;
  }

  @override
  /// Simulates clearing the stored user session identifier.
  Future<void> clearSession() async {
    _sessionId = null;
    print('[FAKE] Session erased');
  }

  @override
  /// Simulates launching the given URL.
  ///
  /// [url]: The URL to "launch".
  Future<void> urlLauncher(String url) async {
    print('[FAKE] URL launched: $url');
  }

  @override
  Future<String?> getAuthUrl(String sessionId) {
    // TODO: implement getAuthUrl
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<String?> startAuthSession() {
    // TODO: implement startAuthSession
    throw UnimplementedError();
  }

  @override
  Future<bool> validateCallback(String code, String state) {
    // TODO: implement validateCallback
    throw UnimplementedError();
  }
}
