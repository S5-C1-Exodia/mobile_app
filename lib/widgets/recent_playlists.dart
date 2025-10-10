import 'package:flutter/material.dart';
import '../models/playlist.dart';
import 'recent_playlists_body.dart';

/// Widget IHM pur qui délègue l'affichage à RecentPlaylistsBody.
class RecentPlaylists extends StatelessWidget {
  final List<Playlist>? playlists;
  const RecentPlaylists({super.key, this.playlists});

  @override
  Widget build(BuildContext context) {
    return RecentPlaylistsBody(playlists: playlists);
  }
}