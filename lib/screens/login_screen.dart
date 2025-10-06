import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_app/L10n/app_localizations.dart';
import '../core/theme/palettes.dart';
import 'playlist_screen.dart';
import '../widgets/custom_app_bar.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: CustomAppBar(titleKey: appLocalizations?.login ?? 'Connexion'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animations/cat_login.json',
              width: 180,
              height: 180,
              repeat: true,
            ),
            const SizedBox(height: 32),
            _LoginButton(
              text: appLocalizations?.loginSpotify ?? 'Connexion à Spotify',
              color: Colors.green,
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PlaylistsScreen(),
                  ),
                );
              },
              imageAsset: 'assets/images/logo_spotify.png',
              enabled: true,
            ),
            const SizedBox(height: 24),
            _LoginButton(
              text:
                  appLocalizations?.loginAppleMusic ??
                  'Connexion à Apple Music',
              color: Colors.grey,
              onPressed: () {},
              imageAsset: 'assets/images/logo_apple.png',
              enabled: false,
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginButton extends StatefulWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;
  final String imageAsset;
  final bool enabled;

  const _LoginButton({
    required this.text,
    required this.color,
    required this.onPressed,
    required this.imageAsset,
    required this.enabled,
  });

  @override
  State<_LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<_LoginButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.enabled ? (_) => setState(() => _pressed = true) : null,
      onTapUp: widget.enabled
          ? (_) {
              setState(() => _pressed = false);
              widget.onPressed();
            }
          : null,
      onTapCancel: widget.enabled
          ? () => setState(() => _pressed = false)
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: 320,
        height: 60,
        decoration: BoxDecoration(
          color: widget.enabled ? widget.color : Colors.grey[400],
          borderRadius: BorderRadius.circular(20),
          boxShadow: _pressed
              ? [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(2, 2),
                    blurRadius: 2,
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black38,
                    offset: Offset(4, 4),
                    blurRadius: 8,
                  ),
                ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(widget.imageAsset, width: 32, height: 32),
            const SizedBox(width: 16),
            Text(
              widget.text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
