import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/playlist.dart';
import '../providers/app_provider.dart';
import '../core/theme/palettes.dart';

/// Stateless widget that displays a list of recent playlists.
///
/// - Adapts colors to the current theme.
/// - Shows a default list if no playlists are provided.
/// - Displays a message if the list is empty.
/// - Each playlist is shown with its name and author.
/// - Handles tap events (currently no action).
class RecentPlaylistsBody extends StatelessWidget {
  /// The list of recent playlists to display. If null, a default list is used.
  final List<Playlist>? playlists;

  /// Creates a [RecentPlaylistsBody] widget.
  ///
  /// [playlists] is optional. If not provided, a default list is shown.
  const RecentPlaylistsBody({super.key, this.playlists});

  @override
  Widget build(BuildContext context) {
    // Access the app provider for theme information.
    final appProvider = Provider.of<AppProvider>(context);
    // Determine if the current theme is dark.
    final bool isDark = appProvider.themeMode == ThemeMode.dark;
    // Select the appropriate color palette.
    final AppPalette palette = isDark ? paletteDark : paletteLight;
    // Use provided playlists or a default list.
    final List<Playlist> items = playlists ?? [
      Playlist(id: '1', name: 'Chill Vibes', autor: 'Damso', tracks: []),
      Playlist(id: '2', name: 'Workout', autor: 'Ninho', tracks: []),
      Playlist(id: '3', name: 'Focus', autor: 'Booba', tracks: []),
    ];

    // Show a message if there are no playlists.
    if (items.isEmpty) {
      return Center(
        child: Text(
          'No recent playlists',
          style: TextStyle(color: palette.white60),
        ),
      );
    }

    // Display the list of recent playlists.
    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final p = items[index];
        return Container(
          decoration: BoxDecoration(
            color: palette.card,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: palette.white30,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.queue_music, color: palette.accentGreen),
            ),
            title: Text(
              p.name,
              style: TextStyle(
                color: palette.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(p.autor, style: TextStyle(color: palette.white60)),
            onTap: () {},
          ),
        );
      },
    );
  }
}