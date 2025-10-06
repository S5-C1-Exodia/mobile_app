import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme/palettes.dart';
import '../models/playlist.dart';
import '../providers/app_provider.dart';
import '../widgets/playlists_list.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_bar.dart';

/// A stateless widget that displays a list of playlists in the app.
///
/// The screen includes:
/// - A custom app bar with the app title.
/// - A list of sample playlists, each with a name and author.
/// - A custom bottom navigation bar with the playlists tab selected.
///
/// The appearance adapts to the current theme (light or dark).
///
/// Parameters:
/// - [onToggleTheme]: Callback to toggle the app theme.
/// - [palette]: The color palette to use for theming.
///
/// Usage:
/// ```dart
/// PlaylistsScreen(onToggleTheme: ..., palette: ...)
/// ```
class PlaylistsScreen extends StatelessWidget {
  const PlaylistsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final bool isDark = appProvider.themeMode == ThemeMode.dark;
    final AppPalette palette = isDark ? paletteDark : paletteLight;

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
      body: PlaylistsList(playlists: samplePlaylists),
      bottomNavigationBar: CustomBottomBar(
        currentIndex: 1,
        onTap: (i) {
          // Placeholder navigation pour les autres onglets (à compléter selon besoin)
          // index 0 est géré dans CustomBottomBar (search)
          if (i == 3) {
            // Aller au profil
            // TODO: implémenter navigation profil si nécessaire
          }
        },
      ),
    );

  }
}
