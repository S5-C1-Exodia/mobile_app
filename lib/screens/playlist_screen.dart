import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/playlists_vm.dart';
import '../widgets/playlists_list.dart';
import '../widgets/custom_app_bar.dart';
import '../core/theme/palettes.dart';

/// A stateless widget that displays the playlist screen.
///
/// Shows a list of playlists, a custom app bar, and handles loading and error states.
/// Allows toggling the theme via [onToggleTheme].
class PlaylistScreen extends StatelessWidget {
  /// Callback to toggle the app's theme.
  final VoidCallback onToggleTheme;

  /// The color palette used for theming the screen.
  final AppPalette palette;

  /// Creates a [PlaylistScreen] widget.
  ///
  /// [onToggleTheme] The callback to toggle the theme.
  /// [palette] The color palette to use.
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