import 'package:flutter/foundation.dart';
import '../models/daos/interfaces/i_playlist_dao.dart';
import '../models/playlist.dart';

/// ViewModel for managing playlists state and data.
///
/// Handles loading playlists from a data access object ([IPlaylistDAO]),
/// manages loading and error states, and notifies listeners on changes.
/// Use [updateDAO] to change the DAO and reload playlists.
/// Call [loadPlaylists] to manually refresh the playlists list.
class PlaylistsVM extends ChangeNotifier {
  /// The data access object for playlists.
  IPlaylistDAO? _dao;

  /// Indicates if playlists are currently being loaded.
  bool isLoading = false;

  /// Stores the latest error message, if any.
  String? errorMessage;

  /// The list of loaded playlists.
  List<Playlist> playlists = [];

  /// Creates a [PlaylistsVM] with an optional [dao].
  ///
  /// If a [dao] is provided, playlists are loaded immediately.
  PlaylistsVM({IPlaylistDAO? dao}) {
    _dao = dao;
    if (_dao != null) {
      loadPlaylists();
    }
  }

  /// Updates the DAO and reloads playlists.
  void updateDAO(IPlaylistDAO dao) {
    _dao = dao;
    loadPlaylists();
  }

  /// Loads playlists asynchronously from the DAO.
  ///
  /// Updates [isLoading], [errorMessage], and [playlists] accordingly.
  /// Notifies listeners on state changes.
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