abstract class IUserDAO {
  Future<void> saveSession(String sessionId);
  Future<String?> getSession();
  Future<void> clearSession();

  Future<String?> startAuthSession();
  Future<String?> getAuthUrl(String sessionId);
  Future<bool> validateCallback(String code, String state);
  Future<void> logout();
}
