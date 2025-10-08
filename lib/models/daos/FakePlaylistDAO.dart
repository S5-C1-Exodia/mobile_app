import 'package:mobile_app/models/daos/interfaces/IPlaylistDAO.dart';
import 'package:mobile_app/models/playlist.dart';
import 'package:mobile_app/models/playlists.dart';
import 'package:mobile_app/models/track.dart';

/// **FakePlaylistDAO**
///
/// A mock implementation of the [IPlaylistDAO] interface used for testing
/// or development purposes without requiring a real data source.
///
/// This class simulates data access by returning a predefined set of
/// playlists and tracks. It is useful for testing the application's
/// behavior independently from external APIs or databases.
class FakePlaylistDAO implements IPlaylistDAO {
  /// Contains the fake playlist data used by this DAO.
  final Playlists datas;

  /// Creates a new instance of [FakePlaylistDAO] and initializes it
  /// with a static set of playlists and tracks.
  ///
  /// Each playlist has a unique [id], [name], [autor], [imageUrl],
  /// and a list of [Track] objects.
  FakePlaylistDAO()
      : datas = Playlists(playlists: [
    Playlist(
      id: "1",
      name: "Voiture",
      autor: "Exodia",
      imageUrl: "imageUrl",
      tracks: [
        Track(title: "Test 1", artist: "Artist 1"),
        Track(title: "Test 2", artist: "Artist 2"),
      ],
    ),
    Playlist(
      id: "2",
      name: "Travail",
      autor: "Exodia",
      imageUrl: "imageUrl",
      tracks: [
        Track(title: "Test 3", artist: "Artist 3"),
        Track(title: "Test 4", artist: "Artist 4"),
      ],
    ),
    Playlist(
      id: "3",
      name: "Sport",
      autor: "Exodia",
      imageUrl: "imageUrl",
      tracks: [
        Track(title: "Test 5", artist: "Artist 5"),
        Track(title: "Test 6", artist: "Artist 6"),
      ],
    ),
  ]);

  /// Returns all playlists available in this fake data source.
  ///
  /// This method simulates asynchronous data fetching by returning
  /// a [Future] containing the [Playlists] object.
  @override
  Future<Playlists> getAllPlaylists() async {
    return datas;
  }

  /// Retrieves a single playlist matching the provided [id].
  ///
  /// Returns a [Future] that completes with the matching [Playlist].
  ///
  /// Throws an [Exception] if no playlist with the given [id] is found.
  @override
  Future<Playlist> getPlaylistById(String id) async {
    final result = datas.playlists.firstWhere(
          (playlist) => playlist.id == id,
      orElse: () => throw Exception('Playlist not found'),
    );
    return result;
  }
}
