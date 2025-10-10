import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/playlist_vm.dart';
import '../widgets/action_buttons.dart';
import '../L10n/app_localizations.dart';
import '../core/theme/palettes.dart';
import '../providers/app_provider.dart';

/// Stateful widget representing the body of the swipe screen.
///
/// Displays the current track from a playlist, allows swiping through profile images,
/// and provides action buttons for liking, disliking, or favoriting a track.
/// Adapts colors to the current theme.
class SwipeScreenBody extends StatefulWidget {
  /// The playlist view model containing track data and navigation logic.
  final PlaylistVM playlistVM;

  /// Creates a [SwipeScreenBody] widget.
  ///
  /// [playlistVM] is required and provides the playlist data.
  const SwipeScreenBody({Key? key, required this.playlistVM}) : super(key: key);

  @override
  State<SwipeScreenBody> createState() => _SwipeScreenBodyState();
}

/// State class for [SwipeScreenBody].
///
/// Manages the current index for profile images and handles swipe and action events.
class _SwipeScreenBodyState extends State<SwipeScreenBody> {
  /// The current index of the displayed profile image.
  int _currentIndex = 0;

  /// List of profile image asset paths.
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

    return SafeArea(
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
                _buildProfileImage(playlistVM, palette),
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
        ],
      ),
    );
  }

  /// Builds the profile image widget with swipe (dismiss) functionality.
  ///
  /// When swiped, advances to the next image and track in the playlist.
  Widget _buildProfileImage(PlaylistVM playlistVM, AppPalette palette) {
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

  /// Handles the dislike action.
  void _handleDislike() => debugPrint('Dislike!');

  /// Handles the like action.
  void _handleLike() => debugPrint('Like!');

  /// Handles the favorite action.
  void _handleFavorite() => debugPrint('Favorite!');
}