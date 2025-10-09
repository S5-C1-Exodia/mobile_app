/*import'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../L10n/app_localizations.dart';
import '../core/theme/palettes.dart';
import '../widgets/custom_app_bar.dart';
import 'swipe_screen.dart';

class LoginTracksScreen extends StatefulWidget {
  const LoginTracksScreen({Key? key}) : super(key: key);

  @override
  State<LoginTracksScreen> createState() => _LoginTracksScreenState();
}

class _LoginTracksScreenState extends State<LoginTracksScreen> {
  bool _showAnimation = true;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _showAnimation = false;
        });
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const SwipeScreen(playlistVM: playlistVM)),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final bool isDark = appProvider.themeMode == ThemeMode.dark;
    final palette = isDark ? paletteDark : paletteLight;
    final appLocalizations =
        AppLocalizations.of(context) ?? AppLocalizations(appProvider.locale);

    return Scaffold(
      appBar: CustomAppBar(titleKey: appLocalizations.login),
      backgroundColor: palette.background,
      body: Center(
        child: _showAnimation
            ? Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              'assets/animations/nyan_cat.json',
              width: 220,
              height: 220,
              repeat: true,
            ),
            const SizedBox(height: 24),
            Text(
              appLocalizations.loadingTracks,
              style: TextStyle(
                color: palette.accentGreen,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        )
            : Text(
          appLocalizations.login,
          style: TextStyle(
            color: palette.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}*/