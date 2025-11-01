import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_bar.dart';
import '../widgets/settings_screen_body.dart';

/// A stateless widget representing the settings screen.
///
/// Displays a custom app bar with the 'settings' title, the settings screen body,
/// and a custom bottom navigation bar. The background color is set according to the current theme.
///
/// The [SettingsScreen] is typically used to show and manage user settings.
class SettingsScreen extends StatelessWidget {
  /// Creates a [SettingsScreen] widget.
  ///
  /// [key] An optional key for the widget.
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