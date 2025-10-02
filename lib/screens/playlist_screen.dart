import 'package:flutter/material.dart';
import '../core/theme/palettes.dart';
import '../models/playlist.dart';
import '../widgets/playlists_list.dart';
import '../widgets/custom_app_bar.dart';

class PlaylistsScreen extends StatelessWidget {
  final AppPalette palette;
  final VoidCallback onToggleTheme;
  const PlaylistsScreen({super.key, required this.palette, required this.onToggleTheme});

  @override
  Widget build(BuildContext context) {
    final List<Playlist> samplePlaylists = [
      Playlist(name: 'Chill Vibes', autor: 'Damso', tracks: []),
      Playlist(name: 'Workout', autor: 'Ninho', tracks: []),
      Playlist(name: 'Focus', autor: 'Booba', tracks: []),
      Playlist(name: 'Hits', autor: 'Aya Nakamura', tracks: []),
      Playlist(name: 'Classics', autor: 'Jul', tracks: []),
      Playlist(name: 'Party', autor: 'PNL', tracks: []),
      Playlist(name: 'Relax', autor: 'SCH', tracks: []),
      Playlist(name: 'Road Trip', autor: 'Kaaris', tracks: []),
      Playlist(name: 'Sleep', autor: 'Lomepal', tracks: []),
      Playlist(name: 'Jazz', autor: 'Orelsan', tracks: []),
      Playlist(name: 'Rock', autor: 'Soprano', tracks: []),
      Playlist(name: 'Pop', autor: 'Vianney', tracks: []),
    ];

    return Scaffold(
      backgroundColor: palette.background,
      appBar: CustomAppBar(titleKey: 'appTitle'),
      body: PlaylistsList(playlists: samplePlaylists, palette: palette),
    );

  }
}
