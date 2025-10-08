import 'track.dart';

/// A model class representing a playlist of music tracks.
///
/// Contains information about the playlist's name, optional image URL,
/// author, and the list of tracks included in the playlist.
class Playlist {
  final String id;
  final String name;
  final String? imageUrl;
  final String autor;
  final List<Track> tracks;

  /// Creates a [Playlist] instance with the given properties.
  ///
  /// [name] and [autor] are required, [imageUrl] is optional,
  /// and [tracks] is a required list of [Track] objects.
  Playlist({
    required this.id,
    required this.name,
    required this.autor,
    this.imageUrl,
    required this.tracks,
  });
}
