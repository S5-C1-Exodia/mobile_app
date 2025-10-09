// lib/viewmodels/playlistsVM.dart
import 'package:flutter/foundation.dart';
import 'package:mobile_app/models/daos/interfaces/i_playlist_dao.dart';
import 'package:mobile_app/models/playlists.dart';
import 'package:mobile_app/models/playlist.dart';

class PlaylistsVM extends ChangeNotifier {
  IPlaylistDAO? dao;

  List<Playlist> _playlists = [];
  List<Playlist> get playlists => _playlists;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  PlaylistsVM({this.dao});

  /// Appelé par ChangeNotifierProxyProvider quand le DAO est prêt
  void updateDAO(IPlaylistDAO? newDao) {
    dao = newDao;
    print('[PlaylistsVM] DAO updated: ${dao != null}');
    notifyListeners();
  }

  Future<void> loadPlaylists() async {
    if (_isLoading) {
      print('[PlaylistsVM] loadPlaylists skipped: already loading');
      return;
    }
    if (dao == null) {
      print('[PlaylistsVM] loadPlaylists skipped: dao == null');
      return;
    }

    print('[PlaylistsVM] loadPlaylists START');
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final Playlists data = await dao!.getAllPlaylists();
      _playlists = data.playlists;
      print('[PlaylistsVM] loaded playlists count: ${_playlists.length}');
    } catch (e, stack) {
      _errorMessage = "Error while loading playlists: $e";
      if (kDebugMode) {
        print('[PlaylistsVM] ❌ $e');
        print(stack);
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
