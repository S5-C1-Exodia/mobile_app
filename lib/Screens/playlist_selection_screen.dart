import 'package:flutter/material.dart';
import 'package:mobile_app/Screens/swipe_screen.dart';
import 'package:mobile_app/widgets/custom_app_bar.dart';
import 'package:mobile_app/widgets/custom_bottom_bar.dart';
import 'package:mobile_app/L10n/app_localizations.dart';

import '../models/playlist.dart';

class PlaylistSelectionScreen extends StatefulWidget {
  @override
  _PlaylistSelectionScreenState createState() => _PlaylistSelectionScreenState();
}

class _PlaylistSelectionScreenState extends State<PlaylistSelectionScreen> {
  Future<List<Playlist>>? get playlistsFuture => null;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: CustomAppBar(titleKey: 'selectPlaylist'),
      body: FutureBuilder<List<Playlist>>(
        future: playlistsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(appLocalizations.errorLoadingPlaylists));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            Future.microtask(() {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => SwipeScreen()),
              );
            });
            return SizedBox.shrink();
          }

          final playlists = snapshot.data!;
          return ListView.builder(
            itemCount: playlists.length,
            itemBuilder: (context, index) {
              final playlist = playlists[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: playlist.imageUrl != null
                      ? Image.network(playlist.imageUrl!, width: 56, height: 56, fit: BoxFit.cover)
                      : Icon(Icons.music_note, size: 56),
                  title: Text(playlist.name),
                  subtitle: Text('${playlist.tracks.length} ${appLocalizations.tracks}'),
                  trailing: ElevatedButton(
                    child: Text(appLocalizations.select),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SwipeScreen(),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}