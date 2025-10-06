import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_app/providers/app_provider.dart';
import '../L10n/app_localizations.dart';
import '../core/theme/palettes.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleKey;

  const CustomAppBar({super.key, required this.titleKey});

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final appLocalizations = AppLocalizations.of(context) ?? AppLocalizations(appProvider.locale);

    final bool isDark = appProvider.themeMode == ThemeMode.dark;
    final AppPalette currentPalette = isDark ? paletteDark : paletteLight;

    final Color titleColor = currentPalette.accentGreen;

    return AppBar(
      backgroundColor: currentPalette.background,
      elevation: 0,
      centerTitle: false,
      toolbarHeight: 120,
      title: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          appLocalizations.appTitle,
          style: TextStyle(
            color: titleColor,
            fontSize: 40,
            fontFamily: 'ArchivoBlack',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      iconTheme: IconThemeData(color: Theme.of(context).iconTheme.color),
      actions: [], // actions removed: language/theme selection moved to SettingsScreen
    );
  }


  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}