import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_bar.dart';
import '../widgets/profile_screen_body.dart';
import '../L10n/app_localizations.dart';

/// A stateless widget representing the profile screen.
///
/// Displays a custom app bar with a localized title, the profile screen body,
/// and a custom bottom navigation bar.
///
/// The [ProfileScreen] is typically used to show user profile information.
class ProfileScreen extends StatelessWidget {
  /// Creates a [ProfileScreen] widget.
  ///
  /// [key] An optional key for the widget.
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieves the localized strings for the app.
    final appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      // Displays a custom app bar with the localized profile title.
      appBar: CustomAppBar(titleKey: appLocalizations?.profile ?? 'Profil'),
      // Displays the body of the profile screen.
      body: const ProfileScreenBody(),
      // Displays a custom bottom navigation bar, with the profile tab selected.
      bottomNavigationBar: CustomBottomBar(
        currentIndex: 3,
        onTap: (int value) {},
      ),
    );
  }
}