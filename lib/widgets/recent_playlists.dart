import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/playlist.dart';
import '../providers/app_provider.dart';
import '../core/theme/palettes.dart';

/// Widget that displays a vertical list of recent playlists.
///
/// If no playlists are provided or the list is empty, a message is shown.
/// The style adapts to the current theme (light/dark) using [AppProvider] and [AppPalette].
///
/// Parameters:
/// - [playlists]: Optional list of playlists to display. If null, a default list is used.
class RecentPlaylists extends StatelessWidget {
  final List<Playlist>? playlists;
  const RecentPlaylists({super.key, this.playlists});

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final bool isDark = appProvider.themeMode == ThemeMode.dark;
    final AppPalette palette = isDark ? paletteDark : paletteLight;


    final List<Playlist> items = playlists ?? [
      Playlist(id: '1', name: 'Chill Vibes', autor: 'Damso', tracks: []),
      Playlist(id: '2', name: 'Workout', autor: 'Ninho', tracks: []),
      Playlist(id: '3', name: 'Focus', autor: 'Booba', tracks: []),
    ];

    if (items.isEmpty) {
      return Center(
        child: Text(
          'No recent playlists',
          style: TextStyle(color: palette.white60),
        ),
      );
    }

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
