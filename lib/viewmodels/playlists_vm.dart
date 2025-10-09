import 'package:flutter/foundation.dart';
import '../models/daos/interfaces/i_playlist_dao.dart';
import '../models/playlists.dart';
import '../models/playlist.dart';

class PlaylistsVM extends ChangeNotifier {
  IPlaylistDAO? _dao;

  bool isLoading = false;
  String? errorMessage;
  List<Playlist> playlists = [];

  PlaylistsVM({IPlaylistDAO? dao}) {
    _dao = dao;
    if (_dao != null) {
      loadPlaylists();
    }
  }

  void updateDAO(IPlaylistDAO dao) {
    _dao = dao;
    loadPlaylists();
  }

  Future<void> loadPlaylists() async {
    if (_dao == null) return;

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final all = await _dao!.getAllPlaylists();
      playlists = all.playlists;
    } catch (e) {
      errorMessage = 'Erreur lors du chargement des playlists : $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
