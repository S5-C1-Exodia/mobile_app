abstract class IUserDAO {
  Future<void> saveSession(String sessionId);
  Future<String?> getSession();
  Future<void> clearSession();
  Future<void> urlLauncher(String url);
}