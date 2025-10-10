import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_app/viewmodels/connexion_vm.dart';
import 'package:mobile_app/screens/splash_screen.dart';
import '../providers/app_provider.dart';
import '../core/theme/palettes.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final connexionVM = Provider.of<ConnexionVM>(context, listen: false);
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    final bool isDark = appProvider.themeMode == ThemeMode.dark;
    final AppPalette palette = isDark ? paletteDark : paletteLight;

    return ElevatedButton.icon(
      icon: const Icon(Icons.logout),
      label: const Text('Déconnexion'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      onPressed: () async {
        await connexionVM.disconnect();
        if (context.mounted) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (_) =>
                  SplashScreen(palette: palette, onToggleTheme: () {}),
            ),
            (route) => false,
          );
        }
      },
    );
  }
}
