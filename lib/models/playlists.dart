import 'package:mobile_app/models/playlist.dart';

/// Represents a collection of playlists.
///
/// Contains a list of [Playlist] objects.
class Playlists {
  /// The list of playlists.
  final List<Playlist> playlists;

  /// Creates a [Playlists] instance.
  ///
  /// [playlists] The list of playlists to include.
  Playlists({required this.playlists});
}