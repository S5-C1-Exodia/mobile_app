import 'package:mobile_app/models/dtos/trackDTO.dart';

class PlaylistDTO{
  final String id;
  final String name;
  final String owner;
  final String imageUrl;
  final List<TrackDTO> tracks;

  PlaylistDTO({
    required this.id,
    required this.name,
    required this.owner,
    required this.imageUrl,
    required this.tracks
  });
}