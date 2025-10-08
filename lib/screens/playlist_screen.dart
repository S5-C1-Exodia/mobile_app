import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme/palettes.dart';
import '../viewmodels/playlistsVM.dart';
import '../models/daos/api_playlist_dao.dart';
import '../widgets/playlists_list.dart';
import '../widgets/custom_app_bar.dart';

class PlaylistsScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final AppPalette palette;

  const PlaylistsScreen({
    super.key,
    required this.onToggleTheme,
    required this.palette,
  });

  @override
  State<PlaylistsScreen> createState() => _PlaylistsScreenState();
}

class _PlaylistsScreenState extends State<PlaylistsScreen> {
  bool _loadTriggered = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _tryLoadPlaylists();
  }

  @override
  void didUpdateWidget(covariant PlaylistsScreen oldWidget) {
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
