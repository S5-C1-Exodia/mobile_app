import 'track.dart';

class Playlist {
  final String id;
  final String name;
  final String? imageUrl;
  final String autor;
  final List<Track> tracks;

  Playlist({
    required this.id,
    required this.name,
    required this.autor,
    this.imageUrl,
    required this.tracks,
  });
}

