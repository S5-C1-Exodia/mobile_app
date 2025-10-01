import 'track.dart';

class Playlist {
  final String name;
  final String? imageUrl;
  final List<Track> tracks;

  Playlist({
    required this.name,
    this.imageUrl,
    required this.tracks,
  });
}

