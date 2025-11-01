import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_app/L10n/app_localizations.dart';
import '../providers/app_provider.dart';
import '../core/theme/palettes.dart';
import 'nav_item.dart';

/// A custom bottom navigation bar widget for the application.
///
/// Displays four navigation items (Search, Playlists, History, Profile) and highlights
/// the currently selected one. Handles navigation between screens using named routes.
/// The bar adapts its colors to the current theme using [AppPalette].
///
/// Parameters:
/// - [currentIndex]: The index of the currently selected navigation item.
/// - [onTap]: Callback triggered when a navigation item is tapped.
class CustomBottomBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  /// Handles tap events on navigation items and performs navigation if needed.
  ///
  /// Navigates to the corresponding screen using named routes if the tapped index
  /// is different from the current one. Otherwise, calls the [onTap] callback.
  void _handleTap(BuildContext context, int index) {
    if (index == 0) {
      if (currentIndex != 0) {
        Navigator.pushReplacementNamed(context, '/search');
      }
    } else if (index == 1) {
      if (currentIndex != 1) {
        Navigator.pushReplacementNamed(context, '/playlists');
      }
    } else if (index == 2) {
      if (currentIndex != 2) {
        Navigator.pushReplacementNamed(context, '/history');
      }
    } else if (index == 3) {
      if (currentIndex != 3) {
        Navigator.pushReplacementNamed(context, '/profile');
      }
    } else {
      onTap(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final appLocalizations =
        AppLocalizations.of(context) ?? AppLocalizations(appProvider.locale);
    final bool isDark = appProvider.themeMode == ThemeMode.dark;
    final AppPalette palette = isDark ? paletteDark : paletteLight;

    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: palette.card,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          NavItem(
            icon: Icons.search,
            label: appLocalizations.search,
            index: 0,
            isActive: currentIndex == 0,
            palette: palette,
            onTap: (i) => _handleTap(context, i),
          ),
          NavItem(
            icon: Icons.music_note,
            label: appLocalizations.playlists,
            index: 1,
            isActive: currentIndex == 1,
            palette: palette,
            onTap: (i) => _handleTap(context, i),
          ),
          NavItem(
            icon: Icons.history,
            label: appLocalizations.history,
            index: 2,
            isActive: currentIndex == 2,
            palette: palette,
            onTap: (i) => _handleTap(context, i),
          ),
          NavItem(
            icon: Icons.person,
            label: appLocalizations.profile,
            index: 3,
            isActive: currentIndex == 3,
            palette: palette,
            onTap: (i) => _handleTap(context, i),
          ),
        ],
      ),
    );
  }
}
