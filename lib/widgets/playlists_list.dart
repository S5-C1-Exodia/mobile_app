import 'package:flutter/material.dart';
import 'package:mobile_app/Screens/swipe_screen.dart';
import 'package:provider/provider.dart';
import '../core/theme/palettes.dart';
import '../models/playlist.dart';
import '../providers/app_provider.dart';

/// A widget that displays a list of playlists in a vertical scrollable view.
///
/// If the list is empty, a message is shown. Each playlist is displayed as a card
/// with its name, author, and an icon. Tapping a playlist navigates to the [SwipeScreen].
/// The widget adapts its style to the current theme using [AppPalette].
///
/// Parameters:
/// - [playlists]: The list of playlists to display.
/// - [palette]: The color palette to use for theming.
class PlaylistsList extends StatelessWidget {
  final List<Playlist> playlists;
  final AppPalette palette;
  const PlaylistsList({
    super.key,
    required this.playlists,
    required this.palette,
  });

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final bool isDark = appProvider.themeMode == ThemeMode.dark;
    final AppPalette palette = isDark ? paletteDark : paletteLight;

    return Column(
      children: [
        Expanded(
          child: playlists.isEmpty
              ? Center(
                  child: Text(
                    'Aucune playlist',
                    style: TextStyle(color: palette.white70),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: playlists.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final p = playlists[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Card(
                        color: palette.card,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: ListTile(
                          leading: Icon(
                            Icons.queue_music,
                            color: palette.accentGreen,
                          ),
                          title: Text(
                            p.name.toUpperCase(),
                            style: TextStyle(
                              color: palette.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 26,
                            ),
                          ),
                          subtitle: Text(
                            p.autor,
                            style: TextStyle(
                              color: palette.white60,
                              fontSize: 20,
                            ),
                          ),
                          trailing: Icon(
                            Icons.chevron_right,
                            color: palette.white30,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SwipeScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
