import 'package:flutter/material.dart';
import '../viewmodels/playlist_vm.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_bar.dart';
import '../widgets/swipe_screen_body.dart';
import '../core/theme/palettes.dart';

class SwipeScreen extends StatefulWidget {
  final PlaylistVM playlistVM;

  const SwipeScreen({Key? key, required this.playlistVM}) : super(key: key);

  @override
  State<SwipeScreen> createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {
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
