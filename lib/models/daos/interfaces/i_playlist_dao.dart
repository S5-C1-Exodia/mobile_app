import 'package:mobile_app/models/dtos/playlist_dto.dart';
import 'package:mobile_app/models/dtos/playlists_dto.dart';

abstract class IPlaylistDAO {
  Future<PlaylistDTO?> getPlaylistById(String id);
  Future<PlaylistsDTO?> getAllPlaylists();
}