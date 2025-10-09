/// Interface defining user session management operations.
///
/// Any class implementing this interface should provide methods to
/// save, retrieve, and clear a user session, as well as launch a URL.
abstract class IUserDAO {
  /// Saves the user session identifier.
  ///
  /// [sessionId]: The unique identifier of the session to save.
  Future<void> saveSession(String sessionId);

  /// Retrieves the saved user session identifier.
  ///
  /// Returns the session identifier, or `null` if no session is found.
  Future<String?> getSession();

  /// Clears the saved user session.
  Future<void> clearSession();

  /// Launches a URL in the browser or an external application.
  ///
  /// [url]: The URL to open.
  Future<void> urlLauncher(String url);
}