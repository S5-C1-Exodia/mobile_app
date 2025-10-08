import 'package:flutter/foundation.dart';
import 'package:mobile_app/models/daos/interfaces/i_playlist_dao.dart';
import 'package:mobile_app/models/playlists.dart';
import 'package:mobile_app/models/playlist.dart';

/// **PlaylistsVM**
///
/// The **ViewModel** responsible for managing the state and logic related
/// to the list of playlists in the application.
///
/// This class follows the **MVVM (Model-View-ViewModel)** architecture pattern.
/// It acts as an intermediary between the user interface and the data layer,
/// handling data retrieval, loading states, and error management.
///
/// The [PlaylistsVM] fetches playlist data from the provided [IPlaylistDAO],
/// stores it locally, and notifies listeners (e.g., Flutter widgets)
/// whenever the state changes.
class PlaylistsVM extends ChangeNotifier {
  /// The Data Access Object used to retrieve playlists from a data source.
  final IPlaylistDAO dao;

  /// Internal list of playlists currently loaded.
  List<Playlist> _playlists = [];

  /// Public getter that exposes the loaded playlists.
  List<Playlist> get playlists => _playlists;

  /// Indicates whether data is currently being loaded.
  bool _isLoading = false;

  /// Public getter for the loading state.
  bool get isLoading => _isLoading;

  /// Holds an error message if data loading fails.
  String? _errorMessage;

  /// Public getter for the error message.
  String? get errorMessage => _errorMessage;

  /// Creates a new [PlaylistsVM] instance with the given [dao].
  PlaylistsVM({required this.dao});

  /// Loads all playlists from the data source.
  ///
  /// - Sets the loading state to `true` before starting the operation.
  /// - Fetches playlists asynchronously using the [dao].
  /// - Updates the internal playlist list upon success.
  /// - Handles and stores any error that occurs during loading.
  /// - Notifies all listeners when the state changes.
  Future<void> loadPlaylists() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final Playlists data = await dao.getAllPlaylists();
      _playlists = data.playlists;
    } catch (e) {
      _errorMessage = "Error while loading playlists";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
