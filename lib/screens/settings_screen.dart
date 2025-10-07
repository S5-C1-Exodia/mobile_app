import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../L10n/app_localizations.dart';
import '../core/theme/palettes.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_bar.dart';

/// A stateless widget that displays the settings screen of the application.
///
/// This screen allows the user to:
/// - Change the application language (French or English)
/// - Switch between light and dark themes
/// - Close the settings screen
///
/// The screen uses [AppProvider] for state management and localization,
/// and adapts its appearance based on the current theme.
class SettingsScreen extends StatelessWidget {
  /// Creates a [SettingsScreen] widget.
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final bool isDark = appProvider.themeMode == ThemeMode.dark;
    final AppPalette palette = isDark ? paletteDark : paletteLight;
    final appLocalizations =
        AppLocalizations.of(context) ?? AppLocalizations(appProvider.locale);

    return Scaffold(
      appBar: CustomAppBar(titleKey: appLocalizations.settings),
      backgroundColor: palette.background,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appLocalizations.language,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: palette.white,
              ),
            ),
            const SizedBox(height: 8),
            Card(
              color: palette.card,
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 4.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<Locale>(
                          value: appProvider.locale,
                          dropdownColor: palette.card,
                          iconEnabledColor: palette.white,
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
                          onChanged: (Locale? newLocale) {
                            if (newLocale != null)
                              appProvider.setLocale(newLocale);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              appLocalizations.theme,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: palette.white,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                IconButton(
                  onPressed: () => appProvider.setThemeMode(ThemeMode.light),
                  icon: const Icon(Icons.wb_sunny),
                  color: isDark ? palette.white : palette.accentGreen,
                  tooltip: appLocalizations.light,
                ),
                IconButton(
                  onPressed: () => appProvider.setThemeMode(ThemeMode.dark),
                  icon: const Icon(Icons.nights_stay),
                  color: isDark ? palette.accentGreen : palette.white,
                  tooltip: appLocalizations.dark,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    isDark ? appLocalizations.dark : appLocalizations.light,
                    style: TextStyle(color: palette.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: palette.accentGreen,
                foregroundColor: palette.white,
              ),
              onPressed: () => Navigator.pop(context),
              child: Text(appLocalizations.close),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomBar(currentIndex: 3, onTap: (_) {}),
    );
  }
}
