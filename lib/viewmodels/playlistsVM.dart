import 'package:flutter/foundation.dart';
import 'package:mobile_app/models/daos/interfaces/IPlaylistDAO.dart';
import 'package:mobile_app/models/dtos/playlistsDTO.dart';
import 'package:mobile_app/viewmodels/playlistVM.dart';

class PlaylistsVM extends ChangeNotifier {
  PlaylistsDTO model;
  List<PlaylistVM> list_playlist;
  final IPlaylistDAO dao;

  PlaylistsVM({
    required this.model,
    required this.list_playlist,
    required this.dao,
  });

  Future<void> refreshPlaylistList() async {
    final playlists = await dao.getAllPlaylists();

    model = playlists;

    list_playlist = [];
    model.playlists.forEach((playlist){
      list_playlist.add(PlaylistVM(model: playlist));
      });

    notifyListeners();
  }
}
