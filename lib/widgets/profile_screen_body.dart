import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme/palettes.dart';
import '../providers/app_provider.dart';
import '../L10n/app_localizations.dart';
import '../viewmodels/connexion_vm.dart';
import '../screens/settings_screen.dart';

class ProfileScreenBody extends StatelessWidget {
  const ProfileScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    final connexionVM = context.watch<ConnexionVM>();
    final bool isDark = appProvider.themeMode == ThemeMode.dark;
    final AppPalette palette = isDark ? paletteDark : paletteLight;
    final appLocalizations = AppLocalizations.of(context);

    return Center(
      child: connexionVM.isLoading
          ? const CircularProgressIndicator()
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
