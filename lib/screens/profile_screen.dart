import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme/palettes.dart';
import '../providers/app_provider.dart';
import '../L10n/app_localizations.dart';
import 'login_screen.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_bar.dart';
import 'settings_screen.dart';

/// A stateless widget that displays the user's profile screen.
///
/// The screen includes:
/// - A custom app bar with a localized title.
/// - Two main buttons: one for connecting to another API (currently disabled),
///   and one for logging out, which navigates to the login screen.
/// - A custom bottom navigation bar with the profile tab selected.
///
/// The appearance adapts to the current theme and localization.
///
/// Usage:
/// ```dart
/// ProfileScreen()
/// ```
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    final bool isDark = appProvider.themeMode == ThemeMode.dark;
    final AppPalette palette = isDark ? paletteDark : paletteLight;
    final appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: CustomAppBar(titleKey: appLocalizations?.profile ?? 'Profil'),
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
            const SizedBox(height: 16),

            // Nouveau bouton Paramètres
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: palette.accentGreen,
                foregroundColor: palette.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsScreen()),
                );
              },
              icon: const Icon(Icons.settings),
              label: Text(appLocalizations?.settings ?? 'Paramètres'),
            ),

            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return LoginScreen();
                  }),
                );
              },
              child: Text(appLocalizations?.logout ?? 'Se déconnecter'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomBar(
        currentIndex: 3,
        onTap: (int value) {},
      ),
    );
  }
}
