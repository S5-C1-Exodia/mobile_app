import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme/palettes.dart';
import '../providers/app_provider.dart';
import '../L10n/app_localizations.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    final bool isDark = appProvider.themeMode == ThemeMode.dark;
    final AppPalette palette = isDark ? paletteDark : paletteLight;
    final appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(appLocalizations?.profile ?? 'Profil')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: null,
              child: Text(
                appLocalizations?.connectToAnotherApi ??
                    'Se connecter à une autre API',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(
                      palette: palette,
                      onToggleTheme: appProvider.toggleTheme,
                    ),
                  ),
                );
              },
              child: Text(appLocalizations?.logout ?? 'Se déconnecter'),
            ),
          ],
        ),
      ),
    );
  }
}
