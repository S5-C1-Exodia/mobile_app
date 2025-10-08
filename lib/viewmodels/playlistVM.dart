import 'package:mobile_app/models/playlist.dart';
import 'package:mobile_app/viewmodels/trackVM.dart';

/// **PlaylistVM**
///
/// The **ViewModel** responsible for managing a single playlist and its state
/// within the application.
///
/// This class is part of the **MVVM (Model-View-ViewModel)** architecture.
/// It acts as a bridge between the [Playlist] model and the user interface,
/// providing logic to handle the currently selected track and navigate
/// through the playlist’s tracks.
///
/// The [PlaylistVM] exposes the current [TrackVM] and allows track switching
/// while maintaining an internal index of the active track.
class PlaylistVM {
  /// The underlying playlist model that this ViewModel manages.
  final Playlist model;

  /// The currently selected track, wrapped in a [TrackVM].
  late TrackVM current;

  /// Internal index tracking the position of the current track in the playlist.
  int _currentIndex = 0;

  /// Creates a new [PlaylistVM] from the provided [model].
  ///
  /// Throws an [Exception] if the playlist does not contain any tracks.
  PlaylistVM(this.model) {
    if (model.tracks == null || model.tracks.isEmpty) {
      throw Exception('The playlist does not contain any tracks');
    }
    current = TrackVM(model: model.tracks[_currentIndex]);
  }

  /// Moves to the next track in the playlist.
  ///
  /// - If the current track is not the last one, advances to the next track.
  /// - If already at the last track, remains on it.
  /// Updates the [current] property with a new [TrackVM] instance.
  void nextTrack() {
    if (_currentIndex < model.tracks.length - 1) {
      _currentIndex++;
      current = TrackVM(model: model.tracks[_currentIndex]);
    } else {
      // If at the end of the playlist, remain on the last track.
      current = TrackVM(model: model.tracks.last);
    }
  }
}
