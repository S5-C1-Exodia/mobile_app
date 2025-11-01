import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_bar.dart';
import '../widgets/search_screen_body.dart';

/// A stateless widget representing the search screen.
///
/// Displays a custom app bar, the search screen body, and a custom bottom navigation bar.
/// The background color is set according to the current theme.
class SearchScreen extends StatelessWidget {
  /// Creates a [SearchScreen] widget.
  ///
  /// [key] An optional key for the widget.
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const CustomAppBar(titleKey: 'search'),
      body: const SearchScreenBody(),
      bottomNavigationBar: CustomBottomBar(currentIndex: 0, onTap: (_) {}),
    );
  }
}