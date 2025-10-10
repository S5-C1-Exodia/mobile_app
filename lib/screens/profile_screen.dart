import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_bar.dart';
import '../widgets/profile_screen_body.dart';
import '../L10n/app_localizations.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: CustomAppBar(titleKey: appLocalizations?.profile ?? 'Profil'),
      body: const ProfileScreenBody(),
      bottomNavigationBar: CustomBottomBar(
        currentIndex: 3,
        onTap: (int value) {},
      ),
    );
  }
}