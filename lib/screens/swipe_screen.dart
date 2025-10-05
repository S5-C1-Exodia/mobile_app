import 'package:flutter/material.dart';
import 'package:mobile_app/viewmodels/playlistVM.dart';
import 'package:provider/provider.dart';
import '../widgets/action_buttons.dart';
import '../widgets/custom_bottom_bar.dart';
import '../L10n/app_localizations.dart';
import '../widgets/custom_app_bar.dart';
import '../core/theme/palettes.dart';
import '../providers/app_provider.dart';

class SwipeScreen extends StatefulWidget {
  const SwipeScreen({super.key});

  @override
  State<SwipeScreen> createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {
  int _currentIndex = 0;

  final List<String> profileImages = [
    'assets/profilepictures/profile_1.jpg',
    'assets/profilepictures/profile_2.jpg',
    'assets/profilepictures/profile_3.jpg',
    'assets/profilepictures/profile_4.jpg',
    'assets/profilepictures/profile_5.jpg',
    'assets/profilepictures/profile_6.jpg',
  ];

  final PlaylistVM playlistVM;

  _SwipeScreenState(this.playlistVM);

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final appLocalizations = AppLocalizations.of(context) ?? AppLocalizations(appProvider.locale);
    final bool isDark = appProvider.themeMode == ThemeMode.dark;

    // Trace pour vérifier que SwipeScreen rebuild quand la locale/theme change
    debugPrint('SwipeScreen.build: locale=${appProvider.locale}, theme=${appProvider.themeMode}, index=$_currentIndex');
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
                    child: _currentIndex < profileImages.length
                        ? Dismissible(
                            key: ValueKey(profileImages[_currentIndex]),
                            direction: DismissDirection.horizontal,
                            onDismissed: (direction) {
                              setState(() {
                                _currentIndex++;
                              });
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                profileImages[_currentIndex],
                                width: 200,
                                height: 300,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : Container(),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      playlistVM.current.model.title,
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
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  void _handleDislike() {
    debugPrint('Dislike!');
  }

  void _handleLike() {
    debugPrint('Like!');
  }

  void _handleFavorite() {
    debugPrint('Favorite!');
  }
}
