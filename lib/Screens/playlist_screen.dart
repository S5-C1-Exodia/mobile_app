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
    ];

    return Scaffold(
      backgroundColor: palette.background,
      appBar: const CustomAppBar(titleKey: 'appTitle'),
      body: PlaylistsList(playlists: samplePlaylists, palette: palette),
    );

  }
}
