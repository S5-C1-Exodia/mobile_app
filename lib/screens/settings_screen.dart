import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_bar.dart';
import '../widgets/settings_screen_body.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titleKey: 'settings'),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: const SettingsScreenBody(),
      bottomNavigationBar: CustomBottomBar(currentIndex: 3, onTap: (_) {}),
    );
  }
}
