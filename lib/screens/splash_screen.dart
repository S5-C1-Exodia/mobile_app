import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../core/theme/palettes.dart';
import 'login_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:audioplayers/audioplayers.dart';

/// SplashScreen is a stateful widget that displays an animated splash screen
/// with a logo, animated text, a loading indicator, and a sound effect.
/// After a short delay, it navigates to the login screen.
///
/// Parameters:
/// - [palette]: The color palette to use for theming.
/// - [onToggleTheme]: Callback to toggle the app theme.
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

/// State for [SplashScreen], manages animations, audio, and navigation.
class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  final AudioPlayer _audioPlayer = AudioPlayer();
  String _displayedText = 'S';

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    _audioPlayer.play(AssetSource('sounds/openingSound.mp3'));


    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.3, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.3, curve: Curves.easeOutBack),
      ),
    );

    _controller.forward();

    // Animation du texte qui se déploie
    Future.delayed(const Duration(milliseconds: 800), () {
      _animateText();
    });

    // Navigation vers l'écran de connexion après l'animation
    Future.delayed(const Duration(milliseconds: 5000), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const LoginScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      }
    });
  }

  /// Animates the logo text by revealing one character at a time.
  void _animateText() async {
    const fullText = 'SwipeZ';
    for (int i = 1; i < fullText.length; i++) {
      await Future.delayed(const Duration(milliseconds: 100));
      if (mounted) {
        setState(() {
          _displayedText = fullText.substring(0, i + 1);
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _audioPlayer.stop();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final bool isDark = appProvider.themeMode == ThemeMode.dark;
    final AppPalette palette = isDark ? paletteDark : paletteLight;

    return Scaffold(
      backgroundColor: palette.background,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo animé
                    ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [
                          palette.accentGreen,
                          palette.accentGreen.withAlpha(179),
                        ],
                      ).createShader(bounds),
                      child: Text(
                        _displayedText,
                        style: const TextStyle(
                          fontSize: 80,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Indicateur de chargement
                    SizedBox(
                      width: 240,
                      height: 240,
                      child: Lottie.asset(
                        'assets/animations/turning_cat.json',
                        repeat: true,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}