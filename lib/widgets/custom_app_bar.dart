import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_app/providers/app_provider.dart';
import '../L10n/app_localizations.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleKey;

  const CustomAppBar({required this.titleKey});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return AppBar(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      title: Text(appLocalizations.appTitle),
      iconTheme: IconThemeData(color: Theme.of(context).iconTheme.color),
      elevation: 0,
      actions: [
        IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _showSettingsMenu(context);
          },
        ),
      ],
    );
  }

  void _showSettingsMenu(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    final appLocalizations = AppLocalizations.of(context)!;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.language),
                title: Text(appLocalizations.language),
                trailing: DropdownButton<Locale>(
                  value: appProvider.locale,
                  onChanged: (Locale? newLocale) {
                    if (newLocale != null) {
                      appProvider.setLocale(newLocale);
                      Navigator.pop(context);
                    }
                  },
                  items: const [
                    DropdownMenuItem(
                      value: Locale('fr'),
                      child: Text('Français'),
                    ),
                    DropdownMenuItem(
                      value: Locale('en'),
                      child: Text('English'),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.brightness_6),
                title: Text(appLocalizations.theme),
                trailing: Switch(
                  value: appProvider.themeMode == ThemeMode.dark,
                  onChanged: (bool value) {
                    appProvider.setThemeMode(
                      value ? ThemeMode.dark : ThemeMode.light,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}