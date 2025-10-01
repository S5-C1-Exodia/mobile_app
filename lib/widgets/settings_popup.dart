import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import 'package:mobile_app/L10n/app_localizations.dart';

class SettingsPopup extends StatelessWidget {
  // Ajout d'un constructeur public avec key
  const SettingsPopup({super.key});

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final appLocalizations = AppLocalizations.of(context) ?? AppLocalizations(appProvider.locale);

    return AlertDialog(
      title: Text(appLocalizations.settings),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(appLocalizations.language),
            trailing: DropdownButton<Locale>(
              value: appProvider.locale,
              onChanged: (Locale? newLocale) {
                if (newLocale != null) {
                  appProvider.setLocale(newLocale);
                }
              },
              items: [
                DropdownMenuItem(
                  value: Locale('fr'),
                  child: Text(appLocalizations.french),
                ),
                DropdownMenuItem(
                  value: Locale('en'),
                  child: Text(appLocalizations.english),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text(appLocalizations.theme),
            trailing: DropdownButton<ThemeMode>(
              value: appProvider.themeMode,
              onChanged: (ThemeMode? newThemeMode) {
                if (newThemeMode != null) {
                  appProvider.setThemeMode(newThemeMode);
                }
              },
              items: [
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text(appLocalizations.light),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text(appLocalizations.dark),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text(appLocalizations.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}