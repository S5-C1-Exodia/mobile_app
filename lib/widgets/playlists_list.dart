import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_app/core/theme/palettes.dart';
import 'package:mobile_app/models/playlist.dart';
import 'package:mobile_app/providers/app_provider.dart';
import 'package:mobile_app/viewmodels/playlist_vm.dart';
import 'package:mobile_app/screens/swipe_screen.dart';
import 'package:mobile_app/models/daos/interfaces/i_playlist_dao.dart';

/// Stateless widget that displays a list of playlists and loads tracks on tap before opening the SwipeScreen.
///
/// - Shows a message if no playlists are available.
/// - Adapts colors to the current theme.
/// - Loads the full playlist from the DAO when a playlist is tapped.
/// - Displays a loading indicator while fetching data.
/// - Handles errors and displays them in a snackbar.
///
/// [playlists] is the list of playlists to display.
/// [palette] is the color palette for theming.
class PlaylistsList extends StatelessWidget {
  /// The list of playlists to display.
  final List<Playlist> playlists;

  /// The color palette used for theming.
  final AppPalette palette;

  /// Creates a [PlaylistsList] widget.
  ///
  /// [playlists] and [palette] are required.
  const PlaylistsList({
    super.key,
    required this.playlists,
    required this.palette,
  });

  @override
  Widget build(BuildContext context) {
    // Access the app provider for theme information.
    final appProvider = Provider.of<AppProvider>(context);
    // Determine if the current theme is dark.
    final bool isDark = appProvider.themeMode == ThemeMode.dark;
    // Select the appropriate color palette.
    final AppPalette currentPalette = isDark ? paletteDark : paletteLight;

    return Column(
      children: [
        Expanded(
          child: playlists.isEmpty
              // Show a message if there are no playlists.
              ? Center(
            child: Text('Aucune playlist', style: TextStyle(color: currentPalette.white70)),
          )
              // Display the list of playlists.
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
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ListTile(
                    leading: Icon(Icons.queue_music, color: currentPalette.accentGreen),
                    title: Text(
                      playlist.name.toUpperCase(),
                      style: TextStyle(color: currentPalette.white, fontWeight: FontWeight.bold, fontSize: 26),
                    ),
                    subtitle: Text(playlist.autor, style: TextStyle(color: currentPalette.white60, fontSize: 20)),
                    trailing: Icon(Icons.chevron_right, color: currentPalette.white30),
                    onTap: () async {
                      // Retrieve the DAO via the IPlaylistDAO interface.
                      final dao = Provider.of<IPlaylistDAO?>(context, listen: false);
                      if (dao == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('DAO non initialisé')),
                        );
                        return;
                      }

                      // Show loader modal.
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => const Center(child: CircularProgressIndicator()),
                      );

                      try {
                        // Fetch the full playlist by ID.
                        final fullPlaylist = await dao.getPlaylistById(playlist.id);

                        // Create a PlaylistVM with the loaded playlist.
                        final playlistVM = PlaylistVM(fullPlaylist);

                        if (context.mounted) {
                          Navigator.of(context, rootNavigator: true).pop(); // Close loader.
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => SwipeScreen(playlistVM: playlistVM)),
                          );
                        }
                      } catch (e) {
                        if (context.mounted) {
                          Navigator.of(context, rootNavigator: true).pop(); // Close loader.
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur : $e')));
                        }
                      }
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