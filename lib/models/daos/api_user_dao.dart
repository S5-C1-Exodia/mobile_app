import 'package:url_launcher/url_launcher.dart';
import 'interfaces/i_user_dao.dart';

/// Implementation of [IUserDAO] that manages user session in memory
/// and provides URL launching functionality.
class UserDAO implements IUserDAO {
  /// Stores the current session identifier in memory.
  String? _sessionId;

  @override
  /// Saves the user session identifier in memory.
  Future<void> saveSession(String sessionId) async {
    _sessionId = sessionId;
    print('Session saved: $sessionId');
  }

  @override
  /// Retrieves the current session identifier from memory.
  ///
  /// Returns the session identifier, or `null` if no session is stored.
  Future<String?> getSession() async {
    return _sessionId;
  }

  @override
  /// Clears the stored user session identifier.
  Future<void> clearSession() async {
    _sessionId = null;
  }

  @override
  /// Launches the given URL in an external application.
  ///
  /// Throws an [Exception] if the URL cannot be opened.
  Future<void> urlLauncher(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw Exception('Failed to open: $url');
    }
  }
}
