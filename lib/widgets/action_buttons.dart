import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback onDislike;
  final VoidCallback onFavorite;
  final VoidCallback onLike;

  const ActionButtons({
    super.key,
    required this.onDislike,
    required this.onFavorite,
    required this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildActionButton(
          icon: Icons.close,
          color: const Color(0xFFFF4458),
          size: 60,
          onPressed: onDislike,
        ),
        const SizedBox(width: 32),
        _buildActionButton(
          icon: Icons.star,
          color: const Color(0xFFFFD700),
          size: 70,
          onPressed: onFavorite,
        ),
        const SizedBox(width: 32),
        _buildActionButton(
          icon: Icons.favorite,
          color: const Color(0xFF1DB954),
          size: 60,
          onPressed: onLike,
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required double size,
    required VoidCallback onPressed,
  }) {
    // Utiliser color.withAlpha pour définir l'opacité du bord
    final borderColor = color.withAlpha((0.3 * 255).round());

    return Material(
      color: const Color(0xFF282828),
      borderRadius: BorderRadius.circular(size / 2),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(size / 2),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: borderColor,
              width: 2,
            ),
          ),
          child: Icon(
            icon,
            color: color,
            size: size * 0.5,
          ),
        ),
      ),
    );
  }
}