import 'package:flutter/material.dart';
import '../core/theme/palettes.dart';

class NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final bool isActive;
  final AppPalette palette;
  final ValueChanged<int> onTap;

  const NavItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.index,
    required this.isActive,
    required this.palette,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color activeColor = palette.accentGreen;
    final Color inactiveColor = palette.white;

    return InkWell(
      onTap: () => onTap(index),
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        width: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isActive ? activeColor : inactiveColor, size: 28),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isActive ? activeColor : inactiveColor,
                fontSize: 12,
              ),
            ),
            if (isActive)
              Container(
                width: 30,
                height: 3,
                margin: const EdgeInsets.only(top: 4),
                decoration: BoxDecoration(
                  color: activeColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
