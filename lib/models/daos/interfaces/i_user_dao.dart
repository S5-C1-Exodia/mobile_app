/// Interface for user session and authentication management.
///
/// This interface defines methods for saving, retrieving, and clearing user sessions,
/// as well as handling authentication flows such as starting an auth session,
/// obtaining an authentication URL, validating callbacks, and logging out.
abstract class IUserDAO {
  /// Saves the session identifier.
  ///
  /// [sessionId] The session identifier to be saved.
  Future<void> saveSession(String sessionId);

  /// Retrieves the current session identifier.
  ///
  /// Returns the session identifier if available, otherwise null.
  Future<String?> getSession();

  /// Clears the current session.
  Future<void> clearSession();

  /// Starts a new authentication session.
  ///
  /// Returns the new session identifier if successful, otherwise null.
  Future<String?> startAuthSession();

  /// Gets the authentication URL for the given session.
  ///
  /// [sessionId] The session identifier for which to get the auth URL.
  /// Returns the authentication URL if available, otherwise null.
  Future<String?> getAuthUrl(String sessionId);

  /// Validates the authentication callback.
  ///
  /// [code] The authorization code received from the callback.
  /// [state] The state parameter received from the callback.
  /// Returns true if the callback is valid, otherwise false.
  Future<bool> validateCallback(String code, String state);

  /// Logs out the current user and clears session data.
  Future<void> logout();
}