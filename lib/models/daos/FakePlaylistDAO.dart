import 'package:mobile_app/models/daos/interfaces/IPlaylistDAO.dart';
import 'package:mobile_app/models/dtos/playlistDTO.dart';
import 'package:mobile_app/models/dtos/playlistsDTO.dart';
import 'package:mobile_app/models/playlist.dart';
import 'package:mobile_app/models/playlists.dart';

class FakePlaylistDAO implements IPlaylistDAO {
  final Playlists datas;

  FakePlaylistDAO()
      : datas = Playlists(playlists: [
          Playlist(id: "1", name: "Voiture", autor: "Exodia", imageUrl: "imageUrl", tracks: []),
          Playlist(id: "2", name: "Travail", autor: "Exodia", imageUrl: "imageUrl", tracks: []),
          Playlist(id: "3", name: "Sport", autor: "Exodia", imageUrl: "imageUrl", tracks: [])
        ]);
  
  @override
  Future<Playlists> getAllPlaylists() async {
    return datas;
  }

  @override
  Future<Playlist> getPlaylistById(String id) async {
    Playlist? result = null;
      result = datas.playlists.firstWhere(
        (playlist) => playlist.id == id,
        orElse: () => throw Exception('Playlist not found'),
      );
    return result;
  }
}