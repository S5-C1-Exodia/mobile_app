import 'package:mobile_app/models/dtos/playlistDTO.dart';
import 'package:mobile_app/models/dtos/trackDTO.dart';
import 'package:mobile_app/models/playlist.dart';
import 'package:mobile_app/viewmodels/trackVM.dart';

class PlaylistVM{
  final Playlist model;
  final TrackVM? current;

  PlaylistVM({required this.model, this.current});
}