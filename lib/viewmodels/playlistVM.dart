import 'package:mobile_app/models/playlist.dart';
import 'package:mobile_app/viewmodels/trackVM.dart';

class PlaylistVM {
  final Playlist model;
  final TrackVM current;

  PlaylistVM(this.model)
      : current = (model.tracks != null && model.tracks.isNotEmpty)
            ? TrackVM(model : model.tracks[0])
            : throw Exception('La playlist ne contient aucun morceau');
}