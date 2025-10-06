import 'package:url_launcher/url_launcher.dart';

abstract class IUserDAO {
  Future<void> saveSession(String sessionId);
  Future<String?> getSession();
  Future<void> clearSession();
  Future<void> urlLauncher(String url);
}

class UserDAO implements IUserDAO {
  String? _sessionId;

  @override
  Future<void> saveSession(String sessionId) async {
    _sessionId = sessionId;
    print('Session saved: $sessionId');
  }

  @override
  Future<String?> getSession() async {
    return _sessionId;
  }

  @override
  Future<void> clearSession() async {
    _sessionId = null;
  }

  @override
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