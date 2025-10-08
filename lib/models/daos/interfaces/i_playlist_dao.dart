import 'package:mobile_app/models/dtos/playlist_dto.dart';
import 'package:mobile_app/models/dtos/playlists_dto.dart';
import '../../playlist.dart';
import '../../playlists.dart';

/// **IPlaylistDAO**
///
/// This abstract class defines the **Data Access Object (DAO)** interface
/// responsible for managing data operations related to playlists.
/// It specifies the contract for retrieving playlist information from
/// a data source such as a local database, remote API, or other storage system.
abstract class IPlaylistDAO {
  /// Retrieves a single playlist based on its unique [id].
  ///
  /// Returns a [Future] that completes with a [Playlist] object
  /// once the data has been successfully fetched.
  ///
  /// Throws an exception if the playlist cannot be found or
  /// if there is a data retrieval error.
  Future<Playlist> getPlaylistById(String id);

  /// Retrieves all playlists available in the data source.
  ///
  /// Returns a [Future] that completes with a [Playlists] object,
  /// which typically contains a list of [Playlist] instances.
  ///
  /// Throws an exception if data retrieval fails.
  Future<Playlists> getAllPlaylists();
}
