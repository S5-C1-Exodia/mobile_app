import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme/palettes.dart';
import '../viewmodels/playlistsVM.dart';
import '../widgets/playlists_list.dart';
import '../widgets/custom_app_bar.dart';

class PlaylistsScreen extends StatelessWidget {
  final VoidCallback onToggleTheme;
  final AppPalette palette;

  const PlaylistsScreen({
    super.key,
    required this.onToggleTheme,
    required this.palette,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistsVM>(
      builder: (context, vm, child) {
        if (vm.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (vm.errorMessage != null) {
          return Center(child: Text(vm.errorMessage!));
        }

        return Scaffold(
          backgroundColor: palette.background,
          appBar: CustomAppBar(titleKey: 'appTitle'),
          body: PlaylistsList(
            playlists: vm.playlists,
            palette: palette,
          ),
        );
      },
    );
  }
}
