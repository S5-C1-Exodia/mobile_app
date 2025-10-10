import 'package:flutter/material.dart';
import '../viewmodels/playlist_vm.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_bar.dart';
import '../widgets/swipe_screen_body.dart';

/// A stateful widget representing the swipe screen.
///
/// Displays a custom app bar, the swipe screen body, and a custom bottom navigation bar.
/// The background color is set according to the current theme.
/// The [SwipeScreen] is typically used to show swipeable content related to a playlist.
class SwipeScreen extends StatefulWidget {
  /// The playlist view model used to provide data to the screen.
  final PlaylistVM playlistVM;

  /// Creates a [SwipeScreen] widget.
  ///
  /// [playlistVM] The playlist view model to use.
  const SwipeScreen({Key? key, required this.playlistVM}) : super(key: key);

  @override
  State<SwipeScreen> createState() => _SwipeScreenState();
}

/// The state for the [SwipeScreen] widget.
///
/// Manages the navigation index for the bottom navigation bar.
class _SwipeScreenState extends State<SwipeScreen> {
  /// The current index of the bottom navigation bar.
  int _navIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleKey: 'appTitle'),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SwipeScreenBody(playlistVM: widget.playlistVM),
      bottomNavigationBar: CustomBottomBar(
        currentIndex: _navIndex,
        onTap: (index) => setState(() => _navIndex = index),
      ),
    );
  }
}