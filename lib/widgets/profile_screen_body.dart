import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme/palettes.dart';
import '../providers/app_provider.dart';
import '../L10n/app_localizations.dart';
import '../viewmodels/connexion_vm.dart';
import '../screens/settings_screen.dart';

/// Stateless widget representing the body of the profile screen.
///
/// Displays connection and settings options, adapts colors to the current theme,
/// and shows a loading indicator during connection operations.
class ProfileScreenBody extends StatelessWidget {
  /// Creates a [ProfileScreenBody] widget.
  const ProfileScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the app provider for theme information.
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    // Watch the connection view model for loading state.
    final connexionVM = context.watch<ConnexionVM>();
    // Determine if the current theme is dark.
    final bool isDark = appProvider.themeMode == ThemeMode.dark;
    // Select the appropriate color palette.
    final AppPalette palette = isDark ? paletteDark : paletteLight;
    // Get localized strings.
    final appLocalizations = AppLocalizations.of(context);

    return Center(
      child: connexionVM.isLoading
          // Show a loading indicator if a connection is in progress.
          ? const CircularProgressIndicator()
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Button to connect to another API (currently disabled).
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: null,
                  child: Text(
                    appLocalizations?.connectToAnotherApi ??
                        'Se connecter à une autre API',
                  ),
                ),
                const SizedBox(height: 16),
                // Button to navigate to the settings screen.
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: palette.accentGreen,
                    foregroundColor: palette.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.settings),
                  label: Text(appLocalizations?.settings ?? 'Paramètres'),
                ),
                const SizedBox(height: 16),
              ],
            ),
    );
  }
}