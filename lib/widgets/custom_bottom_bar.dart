import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_app/L10n/app_localizations.dart';
import '../providers/app_provider.dart';
import '../core/theme/palettes.dart';
import 'nav_item.dart';

class CustomBottomBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

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
            label: appLocalizations.playlists,
            index: 0,
            isActive: currentIndex == 0,
            palette: palette,
            onTap: onTap,
          ),
          NavItem(
            icon: Icons.music_note,
            label: appLocalizations.songs,
            index: 1,
            isActive: currentIndex == 1,
            palette: palette,
            onTap: onTap,
          ),
          NavItem(
            icon: Icons.history,
            label: appLocalizations.history,
            index: 2,
            isActive: currentIndex == 2,
            palette: palette,
            onTap: onTap,
          ),
          NavItem(
            icon: Icons.person,
            label: appLocalizations.profile,
            index: 3,
            isActive: currentIndex == 3,
            palette: palette,
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}
