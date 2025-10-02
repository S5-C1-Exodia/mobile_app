import 'package:mobile_app/models/daos/interfaces/i_playlist_dao.dart';
import 'package:mobile_app/models/dtos/playlist_dto.dart';
import 'package:mobile_app/models/dtos/playlists_dto.dart';

class FakePlaylistDAO implements IPlaylistDAO {
  final PlaylistsDTO datas;

  FakePlaylistDAO()
      : datas = PlaylistsDTO(playlists: [
          PlaylistDTO(id: "1", name: "Voiture", owner: "Exodia", imageUrl: "imageUrl"),
          PlaylistDTO(id: "2", name: "Travail", owner: "Exodia", imageUrl: "imageUrl"),
          PlaylistDTO(id: "3", name: "Sport", owner: "Exodia", imageUrl: "imageUrl")
        ]);

  @override
  Future<PlaylistsDTO?> getAllPlaylists() async {
    return datas;
  }

  @override
  Future<PlaylistDTO?> getPlaylistById(String id) async {
    PlaylistDTO? result = null;
      result = datas.playlists.firstWhere(
        (playlist) => playlist.id == id,
        orElse: () => throw Exception('Playlist not found'),
      );
    return result;
  }
}