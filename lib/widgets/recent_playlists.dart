import 'package:flutter/material.dart';
import '../models/playlist.dart';
import 'recent_playlists_body.dart';

/// Pure UI widget that delegates the display to [RecentPlaylistsBody].
///
/// Displays a list of recent playlists by passing the [playlists] parameter
/// to the [RecentPlaylistsBody] widget.
///
/// {@tool snippet}
/// Example usage:
/// ```dart
/// RecentPlaylists(playlists: myPlaylists)
/// ```
/// {@end-tool}
class RecentPlaylists extends StatelessWidget {
  /// The list of playlists to display. Can be null.
  final List<Playlist>? playlists;

  /// Creates a [RecentPlaylists] widget.
  ///
  /// The [playlists] parameter is optional.
  const RecentPlaylists({super.key, this.playlists});

  @override
  Widget build(BuildContext context) {
    return RecentPlaylistsBody(playlists: playlists);
  }
}
