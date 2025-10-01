import 'package:flutter/material.dart';
import '../widgets/action_buttons.dart';
import '../widgets/custom_bottom_bar.dart';
import '../L10n/app_localizations.dart';

class SwipeScreen extends StatefulWidget {
  const SwipeScreen({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(appLocalizations),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      appLocalizations.playlists,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.white,
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
                      appLocalizations.outsideInTheNight,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.white,
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
                        color: Theme.of(context).textTheme.bodyMedium?.color ?? const Color(0xFF9E9E9E),
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

  Widget _buildTopBar(AppLocalizations appLocalizations) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            appLocalizations.appTitle,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.menu,
              color: Theme.of(context).iconTheme.color,
              size: 28,
            ),
            onPressed: () {
              _showSettingsPopup(context, appLocalizations);
            },
          ),
        ],
      ),
    );
  }

  void _showSettingsPopup(
    BuildContext context,
    AppLocalizations appLocalizations,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(appLocalizations.theme),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Ajoutez ici le switch/slider pour le thème et la langue
              Text(appLocalizations.language),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(appLocalizations.close),
            ),
          ],
        );
      },
    );
  }

  void _handleDislike() {
    print('Dislike!');
  }

  void _handleLike() {
    print('Like!');
  }

  void _handleFavorite() {
    print('Favorite!');
  }
}
