import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';
import 'package:mobile_app/L10n/app_localizations.dart';

class SettingsPopup extends StatelessWidget {
  // Ajout d'un constructeur public avec key
  const SettingsPopup({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.settings),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(AppLocalizations.of(context)!.language),
            trailing: DropdownButton<Locale>(
              value: settings.locale,
              onChanged: (Locale? newLocale) {
                if (newLocale != null) {
                  settings.setLocale(newLocale);
                }
              },
              items: [
                DropdownMenuItem(
                  value: Locale('fr'),
                  child: Text(AppLocalizations.of(context)!.french),
                ),
                DropdownMenuItem(
                  value: Locale('en'),
                  child: Text(AppLocalizations.of(context)!.english),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.theme),
            trailing: DropdownButton<ThemeMode>(
              value: settings.themeMode,
              onChanged: (ThemeMode? newThemeMode) {
                if (newThemeMode != null) {
                  settings.setThemeMode(newThemeMode);
                }
              },
              items: [
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text(AppLocalizations.of(context)!.light),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text(AppLocalizations.of(context)!.dark),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text(AppLocalizations.of(context)!.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}