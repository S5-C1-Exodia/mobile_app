import 'package:flutter/material.dart';
import 'package:mobile_app/screens/swipe_screen.dart';
import 'package:mobile_app/viewmodels/playlistVM.dart';
import '../core/theme/palettes.dart';
import '../models/playlist.dart';
import '../providers/app_provider.dart';
import 'package:provider/provider.dart';

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
    final AppPalette currentPalette = isDark ? paletteDark : paletteLight;

    return Column(
      children: [
        Expanded(
          child: playlists.isEmpty
              ? Center(
            child: Text(
              'Aucune playlist',
              style: TextStyle(color: currentPalette.white70),
            ),
          )
              : ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: playlists.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final playlist = playlists[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Card(
                  color: currentPalette.card,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.queue_music, color: currentPalette.accentGreen),
                    title: Text(
                      playlist.name.toUpperCase(),
                      style: TextStyle(
                        color: currentPalette.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                      ),
                    ),
                    subtitle: Text(
                      playlist.autor,
                      style: TextStyle(
                        color: currentPalette.white60,
                        fontSize: 20,
                      ),
                    ),
                    trailing: Icon(Icons.chevron_right, color: currentPalette.white30),
                    onTap: () {
                      final playlistVM = PlaylistVM(playlist);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SwipeScreen(playlistVM: playlistVM),
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
