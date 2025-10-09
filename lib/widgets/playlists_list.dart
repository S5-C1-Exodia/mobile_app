import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_app/core/theme/palettes.dart';
import 'package:mobile_app/models/playlist.dart';
import 'package:mobile_app/providers/app_provider.dart';
import 'package:mobile_app/viewmodels/playlist_vm.dart';
import 'package:mobile_app/screens/swipe_screen.dart';
import 'package:mobile_app/models/daos/interfaces/i_playlist_dao.dart';

/// PlaylistsList: affiche la liste et charge les tracks au clic avant d'ouvrir SwipeScreen.
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
            child: Text('Aucune playlist', style: TextStyle(color: currentPalette.white70)),
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
                      // Récupère le DAO via l'interface IPlaylistDAO
                      final dao = Provider.of<IPlaylistDAO?>(context, listen: false);
                      if (dao == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('DAO non initialisé')),
                        );
                        return;
                      }

                      // Affiche loader modal
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => const Center(child: CircularProgressIndicator()),
                      );

                      try {
                        final fullPlaylist = await dao.getPlaylistById(playlist.id);

                        final playlistVM = PlaylistVM(fullPlaylist);

                        if (context.mounted) {
                          Navigator.of(context, rootNavigator: true).pop(); // ferme loader
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => SwipeScreen(playlistVM: playlistVM)),
                          );
                        }
                      } catch (e) {
                        if (context.mounted) {
                          Navigator.of(context, rootNavigator: true).pop(); // ferme loader
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
