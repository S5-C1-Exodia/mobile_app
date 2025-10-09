import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme/palettes.dart';
import '../models/playlist.dart';
import '../providers/app_provider.dart';
import '../viewmodels/playlists_vm.dart';
import '../models/daos/api_playlist_dao.dart';
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
class PlaylistScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final AppPalette palette;

  const PlaylistScreen({
    super.key,
    required this.onToggleTheme,
    required this.palette,
  });


  @override
  State<PlaylistScreen> createState() => _PlaylistsScreenState();
}

class _PlaylistsScreenState extends State<PlaylistScreen> {
  bool _loadTriggered = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _tryLoadPlaylists();
  }

  @override
  void didUpdateWidget(covariant PlaylistScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    _tryLoadPlaylists();
  }

  void _tryLoadPlaylists() {
    final vm = Provider.of<PlaylistsVM>(context, listen: false);
    final dao = Provider.of<APIPlaylistDAO?>(context);

    // Lancer le chargement dès que le DAO est disponible, une seule fois
    if (!_loadTriggered && dao != null) {
      _loadTriggered = true;
      print('[PlaylistsScreen] DAO dispo → lancement loadPlaylists()');
      vm.loadPlaylists();
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<PlaylistsVM>(context);
    final dao = Provider.of<APIPlaylistDAO?>(context);

    if (dao == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (vm.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (vm.errorMessage != null) {
      return Scaffold(
        body: Center(child: Text(vm.errorMessage!)),
      );
    }

    return Scaffold(
      backgroundColor: widget.palette.background,
      appBar: CustomAppBar(titleKey: 'appTitle'),
      body: PlaylistsList(
        playlists: vm.playlists,
        palette: widget.palette,
      ),
    );

  }
}
