import '../../playlist.dart';
import '../../playlists.dart';

abstract class IPlaylistDAO {
  Future<Playlist> getPlaylistById(String id);
  Future<Playlists> getAllPlaylists();
}