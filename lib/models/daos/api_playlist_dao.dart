// lib/models/daos/api_playlist_dao.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_app/models/daos/interfaces/i_playlist_dao.dart';
import 'package:mobile_app/models/daos/interfaces/i_user_dao.dart';
import 'package:mobile_app/models/playlist.dart';
import 'package:mobile_app/models/playlists.dart';
import 'package:mobile_app/models/track.dart';

class APIPlaylistDAO implements IPlaylistDAO {
  final String session_id;
  final String api_link = "https://dana-impeachable-dilemmatically.ngrok-free.dev";

  APIPlaylistDAO._(this.session_id);

  /// Crée le DAO en utilisant l'instance IUserDAO fournie (important).
  static Future<APIPlaylistDAO> create(IUserDAO userDAO) async {
    // final session = await userDAO.getSession();
    final session = '7d1657ef59694f77a0f8b4bbd6464e36';
    if (session == null || session.isEmpty) {
      throw Exception('Aucune session utilisateur trouvée.');
    }
    print('[APIPlaylistDAO.create] using session: $session');
    return APIPlaylistDAO._(session);
  }

  @override
  Future<Playlists> getAllPlaylists() async {
    final url = Uri.parse('$api_link/api/spotify/playlists');
    print('[APIPlaylistDAO] GET $url (session=$session_id)');

    final response = await http.get(
      url,
      headers: {
        // Passe application/json — adapte si ton backend exige text/plain
        'accept': 'application/json',
        'X-Session-Id': session_id,
        'X-Page-Token': '1',
      },
    );

    print('[APIPlaylistDAO] status: ${response.statusCode}');
    print('[APIPlaylistDAO] body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Erreur API (${response.statusCode}) : ${response.body}');
    }

    final Map<String, dynamic> data = jsonDecode(response.body);

    final List items = data['items'] ?? [];
    print('[APIPlaylistDAO] items.length = ${items.length}');

    final List<Playlist> playlistList = items.map<Playlist>((item) {
      return Playlist(
        id: item['playlistId']?.toString() ?? '',
        name: item['name']?.toString() ?? '',
        autor: item['owner']?.toString() ?? '',
        imageUrl: item['imageUrl']?.toString(),
        tracks: const <Track>[],
      );
    }).toList();

    print('[APIPlaylistDAO] Playlists reçues: ${playlistList.map((p) => p.name).toList()}');

    return Playlists(playlists: playlistList);
  }

  @override
  Future<Playlist> getPlaylistById(String id) {
    throw UnimplementedError();
  }
}
