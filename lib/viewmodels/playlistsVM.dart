import 'package:flutter/foundation.dart';
import 'package:mobile_app/models/daos/interfaces/IPlaylistDAO.dart';
import 'package:mobile_app/models/playlists.dart';
import 'package:mobile_app/models/playlist.dart';

class PlaylistsVM extends ChangeNotifier {
  final IPlaylistDAO dao;

  List<Playlist> _playlists = [];
  List<Playlist> get playlists => _playlists;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  PlaylistsVM({required this.dao});

  Future<void> loadPlaylists() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final Playlists data = await dao.getAllPlaylists();
      _playlists = data.playlists;
    } catch (e) {
      _errorMessage = "Erreur lors du chargement des playlists";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
