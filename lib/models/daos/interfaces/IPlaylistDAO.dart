import 'package:mobile_app/models/dtos/playlistDTO.dart';
import 'package:mobile_app/models/dtos/playlistsDTO.dart';

abstract class IPlaylistDAO {
  Future<PlaylistDTO> getPlaylistById(String id);
  Future<PlaylistsDTO> getAllPlaylists();
}