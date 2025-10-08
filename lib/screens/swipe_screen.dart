import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mobile_app/viewmodels/playlistVM.dart';
import 'package:provider/provider.dart';
import '../widgets/action_buttons.dart';
import '../widgets/custom_bottom_bar.dart';
import '../L10n/app_localizations.dart';
import '../widgets/custom_app_bar.dart';
import '../core/theme/palettes.dart';
import '../providers/app_provider.dart';

/// A screen that allows users to swipe through a series of profile images,
/// similar to a card stack. Each card can be liked, disliked, or marked as favorite
/// using action buttons. The screen also includes a custom app bar and bottom navigation bar.
///
/// The displayed card advances when the user swipes it away or presses an action button.
/// The navigation bar allows switching between different main screens.
///
/// State:
/// - [_cardIndex]: The index of the currently displayed card.
/// - [_navIndex]: The index of the currently selected navigation item.
///
/// Widgets:
/// - [CustomAppBar]: Displays the app title and controls.
/// - [ActionButtons]: Provides Dislike, Favorite, and Like actions.
/// - [CustomBottomBar]: Navigation bar for switching screens.
class SwipeScreen extends StatefulWidget {
  final PlaylistVM playlistVM;
  const SwipeScreen({
    Key? key,
    required this.playlistVM,
  }) : super(key: key);

  @override
  State<SwipeScreen> createState() => _SwipeScreenState();
}

/// State for [SwipeScreen], manages card and navigation indices,
/// and handles user interactions.
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

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final appLocalizations =
        AppLocalizations.of(context) ?? AppLocalizations(appProvider.locale);
    final bool isDark = appProvider.themeMode == ThemeMode.dark;
    final palette = isDark ? paletteDark : paletteLight;
    final playlistVM = widget.playlistVM;

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
                  Text(
                    appLocalizations.playlists,
                    style: TextStyle(
                      color: palette.white70,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildProfileImage(),
                  const SizedBox(height: 24),
                  Text(
                    playlistVM.current?.model.title ?? "Aucun titre",
                    style: TextStyle(
                      color: palette.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    playlistVM.current?.model.artist ?? "Artiste inconnu",
                    style: TextStyle(
                      color: palette.white60,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
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
              onTap: (index) => setState(() => _currentIndex = index),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    final playlistVM = widget.playlistVM;

    return SizedBox(
      width: 200,
      height: 300,
      child: _currentIndex < profileImages.length
          ? Dismissible(
        key: ValueKey(profileImages[_currentIndex]),
        direction: DismissDirection.horizontal,
        onDismissed: (_) {
          setState(() {
            _currentIndex++;
            playlistVM.nextTrack();
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
    );
  }


  void _handleDislike() => debugPrint('Dislike!');
  void _handleLike() => debugPrint('Like!');
  void _handleFavorite() => debugPrint('Favorite!');
}
