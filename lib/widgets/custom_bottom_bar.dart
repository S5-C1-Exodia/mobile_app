import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_app/L10n/app_localizations.dart';
import '../providers/app_provider.dart';
import '../core/theme/palettes.dart';

class CustomBottomBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final appLocalizations = AppLocalizations.of(context) ?? AppLocalizations(appProvider.locale);
    final bool isDark = appProvider.themeMode == ThemeMode.dark;
    final AppPalette currentPalette = isDark ? paletteDark : paletteLight;

    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: currentPalette.card,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            context: context,
            icon: Icons.search,
            label: appLocalizations.playlists,
            index: 0,
            currentPalette: currentPalette,
          ),
          _buildNavItem(
            context: context,
            icon: Icons.music_note,
            label: appLocalizations.songs,
            index: 1,
            currentPalette: currentPalette,
          ),
          _buildNavItem(
            context: context,
            icon: Icons.history,
            label: appLocalizations.history,
            index: 2,
            currentPalette: currentPalette,
          ),
          _buildNavItem(
            context: context,
            icon: Icons.person,
            label: appLocalizations.profile,
            index: 3,
            currentPalette: currentPalette,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required int index,
    required AppPalette currentPalette,
  }) {
    final isActive = currentIndex == index;
    final Color activeColor = currentPalette.accentGreen;
    final Color inactiveColor = currentPalette.white;

    return InkWell(
      onTap: () => onTap(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isActive ? activeColor : inactiveColor,
            size: 28,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive ? activeColor : inactiveColor,
              fontSize: 12,
            ),
          ),
          if (isActive)
            Container(
              width: 30,
              height: 3,
              decoration: BoxDecoration(
                color: activeColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
        ],
      ),
    );
  }
}