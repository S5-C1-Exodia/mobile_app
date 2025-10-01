import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/action_buttons.dart';
import '../widgets/custom_bottom_bar.dart';
import '../L10n/app_localizations.dart';
import '../widgets/custom_app_bar.dart';
import '../core/theme/palettes.dart';
import '../providers/app_provider.dart';
import 'profile_screen.dart';

class SwipeScreen extends StatefulWidget {
  const SwipeScreen({super.key});

  @override
  State<SwipeScreen> createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {
  int _cardIndex = 0;
  int _navIndex = 1;
  final GlobalKey<State> _dismissibleKey = GlobalKey<State>();

  final List<String> profileImages = [
    'assets/profilepictures/profile_1.jpg',
    'assets/profilepictures/profile_2.jpg',
    'assets/profilepictures/profile_3.jpg',
    'assets/profilepictures/profile_4.jpg',
    'assets/profilepictures/profile_5.jpg',
    'assets/profilepictures/profile_6.jpg',
  ];

  void _handleNavigation(int index) {
    if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfileScreen()),
      );
    } else {
      setState(() {
        _navIndex = index;
      });
    }
  }

  void _goToNextCard() {
    if (_cardIndex < profileImages.length - 1) {
      setState(() {
        _cardIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final appLocalizations = AppLocalizations.of(context) ?? AppLocalizations(appProvider.locale);
    final bool isDark = appProvider.themeMode == ThemeMode.dark;

    debugPrint('SwipeScreen.build: locale=${appProvider.locale}, theme=${appProvider.themeMode}, cardIndex=$_cardIndex, navIndex=$_navIndex');
    final palette = isDark ? paletteDark : paletteLight;

    return Scaffold(
      appBar: CustomAppBar(titleKey: 'appTitle'),
      backgroundColor: palette.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      appLocalizations.playlists,
                      style: TextStyle(
                        color: palette.white70,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: 200,
                    height: 300,
                    child: _cardIndex < profileImages.length
                        ? Dismissible(
                      key: ValueKey('card_$_cardIndex'),
                      direction: DismissDirection.horizontal,
                      onDismissed: (direction) {
                        _goToNextCard();
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          profileImages[_cardIndex],
                          width: 200,
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                        : Container(
                      decoration: BoxDecoration(
                        color: palette.card,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          'Aucune carte disponible',
                          style: TextStyle(
                            color: palette.white60,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      appLocalizations.outsideInTheNight,
                      style: TextStyle(
                        color: palette.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      appLocalizations.laylow,
                      style: TextStyle(
                        color: palette.white60,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 40),
                  ActionButtons(
                    onDislike: _handleDislike,
                    onFavorite: _handleFavorite,
                    onLike: _handleLike,
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
            CustomBottomBar(
              currentIndex: _navIndex,
              onTap: _handleNavigation,
            ),
          ],
        ),
      ),
    );
  }

  void _handleDislike() {
    debugPrint('Dislike!');
    _goToNextCard();
  }

  void _handleLike() {
    debugPrint('Like!');
    _goToNextCard();
  }

  void _handleFavorite() {
    debugPrint('Favorite!');
    _goToNextCard();
  }
}