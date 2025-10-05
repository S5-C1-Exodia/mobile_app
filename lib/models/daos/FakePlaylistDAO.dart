import 'package:mobile_app/models/daos/interfaces/IPlaylistDAO.dart';
import 'package:mobile_app/models/dtos/playlistDTO.dart';
import 'package:mobile_app/models/dtos/playlistsDTO.dart';
import 'package:mobile_app/models/playlist.dart';
import 'package:mobile_app/models/playlists.dart';
import 'package:mobile_app/models/track.dart';

class FakePlaylistDAO implements IPlaylistDAO {
  final Playlists datas;

  FakePlaylistDAO()
      : datas = Playlists(playlists: [
          Playlist(id: "1", name: "Voiture", autor: "Exodia", imageUrl: "imageUrl", tracks: [
            Track(title: "Test 1", artist: "Artist 1"),
            Track(title: "Test 2", artist: "Artist 2"),
          ]),
          Playlist(id: "2", name: "Travail", autor: "Exodia", imageUrl: "imageUrl", tracks: [
            Track(title: "Test 3", artist: "Artist 3"),
            Track(title: "Test 4", artist: "Artist 4"),
          ]),
          Playlist(id: "3", name: "Sport", autor: "Exodia", imageUrl: "imageUrl", tracks: [
            Track(title: "Test 5", artist: "Artist 5"),
            Track(title: "Test 6", artist: "Artist 6"),
          ])
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