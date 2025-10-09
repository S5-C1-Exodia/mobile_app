import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/playlists_vm.dart';
import '../widgets/playlists_list.dart';
import '../widgets/custom_app_bar.dart';
import '../core/theme/palettes.dart';

class PlaylistScreen extends StatelessWidget {
  final VoidCallback onToggleTheme;
  final AppPalette palette;

  const PlaylistScreen({
    super.key,
    required this.onToggleTheme,
    required this.palette,
  });

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<PlaylistsVM>(context);

    return Scaffold(
      backgroundColor: palette.background,
      appBar: CustomAppBar(titleKey: 'appTitle'),
      body: Builder(
        builder: (_) {
          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (vm.errorMessage != null) {
            return Center(child: Text(vm.errorMessage!));
          }
          return PlaylistsList(
            playlists: vm.playlists,
            palette: palette,
          );
        },
      ),
    );
  }
}
