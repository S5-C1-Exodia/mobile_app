import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_app/models/daos/interfaces/i_playlist_dao.dart';
import 'package:mobile_app/models/daos/interfaces/i_user_dao.dart';
import 'package:mobile_app/models/playlist.dart';
import 'package:mobile_app/models/playlists.dart';
import 'package:mobile_app/models/track.dart';

/// Data Access Object responsible for managing playlists through the backend API.
///
/// This class handles communication with the Spotify API via the backend server.
/// It automatically retrieves the user's session using the provided [IUserDAO].
class APIPlaylistDAO implements IPlaylistDAO {
  final IUserDAO userDAO;

  /// Base URL of the backend API.
  final String api_link = "https://dana-impeachable-dilemmatically.ngrok-free.dev";

  /// Creates an instance of [APIPlaylistDAO].
  ///
  /// The [userDAO] is required to retrieve the current user's active session.
  APIPlaylistDAO({required this.userDAO});

  /// Fetches all playlists of the currently authenticated user from the backend API.
  ///
  /// This method:
  /// - Retrieves the session token from [userDAO].
  /// - Sends a GET request to the `/api/spotify/playlists` endpoint.
  /// - Parses and returns a [Playlists] object containing the retrieved playlists.
  ///
  /// Throws an [Exception] if no session is found or if the API request fails.
  @override
  Future<Playlists> getAllPlaylists() async {
    final session = await userDAO.getSession();
    if (session == null || session.isEmpty) {
      throw Exception('[APIPlaylistDAO] No valid session found.');
    }

    final url = Uri.parse('$api_link/api/spotify/playlists');
    print('[APIPlaylistDAO] GET $url (session=$session)');

    final response = await http.get(
      url,
      headers: {
        'accept': 'application/json',
        'X-Session-Id': session,
        'X-Page-Token': '1',
      },
    );

    print('[APIPlaylistDAO] status: ${response.statusCode}');
    print('[APIPlaylistDAO] body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('API error (${response.statusCode}): ${response.body}');
    }

    final Map<String, dynamic> data = jsonDecode(response.body);
    final List items = data['items'] ?? [];

    final playlists = items.map<Playlist>((item) {
      return Playlist(
        id: item['playlistId']?.toString() ?? '',
        name: item['name']?.toString() ?? '',
        autor: item['owner']?.toString() ?? '',
        imageUrl: item['imageUrl']?.toString(),
        tracks: const <Track>[],
      );
    }).toList();

    print('[APIPlaylistDAO] Playlists received: ${playlists.map((p) => p.name).toList()}');
    return Playlists(playlists: playlists);
  }

  /// Fetches a specific playlist and its tracks from the backend API.
  ///
  /// This method:
  /// - Retrieves the user's session via [userDAO].
  /// - Sends a GET request to `/playlists/{id}/tracks`.
  /// - Parses the JSON response to create a [Playlist] with its [Track]s.
  ///
  /// Throws an [Exception] if the session is invalid or the request fails.
  @override
  Future<Playlist> getPlaylistById(String id) async {
    final session = await userDAO.getSession();
    if (session == null || session.isEmpty) {
      throw Exception('[APIPlaylistDAO] No valid session found.');
    }

    final url = Uri.parse('$api_link/playlists/$id/tracks?X-Session-Id=$session&offset=1');
    print('[APIPlaylistDAO] GET $url (session=$session)');

    final response = await http.get(
      url,
      headers: {
        'accept': 'application/json',
        'X-Session-Id': session,
      },
    );

    print('[APIPlaylistDAO] status: ${response.statusCode}');
    print('[APIPlaylistDAO] body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('API error (${response.statusCode}): ${response.body}');
    }

    final Map<String, dynamic> data = jsonDecode(response.body);

    final playlistId = data['id']?.toString() ?? id;
    final name = data['name']?.toString() ?? 'Unknown';
    final owner = data['owner']?.toString() ?? 'Anonymous';

    final imageUrl = (data['images'] != null && data['images'].isNotEmpty)
        ? data['images'][0]['url']
        : null;

    final List<dynamic> items = data['tracks'] ?? [];
    final tracks = items.map<Track>((t) {
      final artists = (t['artists'] ?? [])
          .map((a) => a['name']?.toString() ?? '')
          .join(', ');
      return Track(
        title: t['name']?.toString() ?? '',
        artist: artists,
      );
    }).toList();

    return Playlist(
      id: playlistId,
      name: name,
      autor: owner,
      imageUrl: imageUrl,
      tracks: tracks,
    );
  }
}
