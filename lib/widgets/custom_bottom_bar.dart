import 'package:flutter/material.dart';
import 'package:mobile_app/L10n/app_localizations.dart';

class CustomBottomBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Theme
            .of(context)
            .bottomAppBarTheme
            .color,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            context: context,
            icon: Icons.search,
            label: appLocalizations.playlists,
            index: 0,
          ),
          _buildNavItem(
            context: context,
            icon: Icons.music_note,
            label: appLocalizations.songs,
            index: 1,
          ),
          _buildNavItem(
            context: context,
            icon: Icons.history,
            label: appLocalizations.history,
            index: 2,
          ),
          _buildNavItem(
            context: context,
            icon: Icons.person,
            label: appLocalizations.profile,
            index: 3,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required int index,
  }) {
    final isActive = currentIndex == index;
    return InkWell(
      onTap: () => onTap(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isActive ? const Color(0xFF1DB954) : const Color(0xFF9E9E9E),
            size: 28,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive ? const Color(0xFF1DB954) : const Color(
                  0xFF9E9E9E),
              fontSize: 12,
            ),
          ),
          if (isActive)
            Container(
              width: 30,
              height: 3,
              decoration: BoxDecoration(
                color: const Color(0xFF1DB954),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
        ],
      ),
    );
  }
}