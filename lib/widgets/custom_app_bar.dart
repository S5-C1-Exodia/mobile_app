import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_app/providers/app_provider.dart';
import '../L10n/app_localizations.dart';
import '../core/theme/palettes.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleKey;

  // Utiliser super.key pour le paramètre key
  const CustomAppBar({super.key, required this.titleKey});

  @override
  Widget build(BuildContext context) {
    // Récupérer d'abord le provider pour connaître la locale actuelle
    final appProvider = Provider.of<AppProvider>(context);
    // fallback : si Localizations.of retourne null, construire AppLocalizations
    // avec la locale courante du provider pour garantir un rendu cohérent
    final appLocalizations = AppLocalizations.of(context) ?? AppLocalizations(appProvider.locale);

    // Trace pour vérifier que CustomAppBar rebuild quand la locale/theme change
    debugPrint('CustomAppBar.build: locale=${appProvider.locale}, theme=${appProvider.themeMode}');

    final bool isDark = appProvider.themeMode == ThemeMode.dark;
    final AppPalette currentPalette = isDark ? paletteDark : paletteLight;

    final Color titleColor = currentPalette.accentGreen;

    return AppBar(
      backgroundColor: currentPalette.background,
      elevation: 0,
      centerTitle: false,
      toolbarHeight: 120,
      // Titre aligné à gauche, grosse taille (logo texte)
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
      actions: [
        // Sélecteur de langue inline
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<Locale>(
              value: appProvider.locale,
              dropdownColor: currentPalette.background,
              onChanged: (Locale? newLocale) {
                if (newLocale != null) {
                  appProvider.setLocale(newLocale);
                }
              },
              items: [
                DropdownMenuItem(
                  value: const Locale('fr'),
                  child: Text(appLocalizations.french, style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color)),
                ),
                DropdownMenuItem(
                  value: const Locale('en'),
                  child: Text(appLocalizations.english, style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color)),
                ),
              ],
              iconEnabledColor: Theme.of(context).iconTheme.color,
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: IconButton(
            icon: Icon(appProvider.themeMode == ThemeMode.dark ? Icons.nightlight_round : Icons.wb_sunny),
            color: currentPalette.accentGreen,
            onPressed: () {
              appProvider.toggleTheme();
            },
            tooltip: appLocalizations.theme,
          ),
        ),

      ],
    );
  }


  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}