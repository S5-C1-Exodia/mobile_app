import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_bar.dart';
import '../widgets/recent_playlists.dart';
import '../core/theme/palettes.dart';
import '../providers/app_provider.dart';

/// A stateless widget that displays the user's listening history screen.
///
/// The screen includes:
/// - A custom app bar with a localized title for history.
/// - A list of recently played playlists, displayed via the [RecentPlaylists] widget.
/// - A custom bottom navigation bar with the history tab selected.
///
/// The appearance adapts to the current theme (light or dark).
///
/// Usage:
/// ```dart
/// HistoryScreen()
/// ```
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final bool isDark = appProvider.themeMode == ThemeMode.dark;
    final AppPalette palette = isDark ? paletteDark : paletteLight;

    return Scaffold(
      backgroundColor: palette.background,
      appBar: const CustomAppBar(titleKey: 'history'),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: RecentPlaylists(),
      ),
      bottomNavigationBar: CustomBottomBar(currentIndex: 2, onTap: (i) {}),
    );
  }
}
