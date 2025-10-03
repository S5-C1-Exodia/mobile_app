import 'package:mobile_app/models/daos/interfaces/IPlaylistDAO.dart';
import 'package:mobile_app/models/dtos/playlistDTO.dart';
import 'package:mobile_app/models/dtos/playlistsDTO.dart';

class FakePlaylistDAO implements IPlaylistDAO {
  final PlaylistsDTO datas;

  FakePlaylistDAO()
      : datas = PlaylistsDTO(playlists: [
          PlaylistDTO(id: "1", name: "Voiture", owner: "Exodia", imageUrl: "imageUrl", tracks: []),
          PlaylistDTO(id: "2", name: "Travail", owner: "Exodia", imageUrl: "imageUrl", tracks: []),
          PlaylistDTO(id: "3", name: "Sport", owner: "Exodia", imageUrl: "imageUrl", tracks: [])
        ]);
  
  @override
  Future<PlaylistsDTO> getAllPlaylists() async {
    return datas;
  }

  @override
  Future<PlaylistDTO> getPlaylistById(String id) async {
    PlaylistDTO? result = null;
      result = datas.playlists.firstWhere(
        (playlist) => playlist.id == id,
        orElse: () => throw Exception('Playlist not found'),
      );
    return result;
  }
}