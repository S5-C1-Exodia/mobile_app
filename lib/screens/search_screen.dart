import 'package:flutter/material.dart';
import '../core/theme/palettes.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_bar.dart';
import '../widgets/search_screen_body.dart';

class SearchScreen extends StatelessWidget {
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
