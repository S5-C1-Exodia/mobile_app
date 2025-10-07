import 'package:mobile_app/models/playlist.dart';
import 'package:mobile_app/viewmodels/trackVM.dart';

class PlaylistVM {
  final Playlist model;
  late TrackVM current;
  int _currentIndex = 0;

  PlaylistVM(this.model) {
    if (model.tracks == null || model.tracks.isEmpty) {
      throw Exception('La playlist ne contient aucun morceau');
    }
    current = TrackVM(model: model.tracks[_currentIndex]);
  }

  void nextTrack() {
    if (_currentIndex < model.tracks.length - 1) {
      _currentIndex++;
      current = TrackVM(model: model.tracks[_currentIndex]);
    } else {
      // Si on est au bout, on reste sur le dernier
      current = TrackVM(model: model.tracks.last);
    }
  }
}
