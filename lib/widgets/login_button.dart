import 'package:flutter/material.dart';

/// A customizable login button widget with an icon and text.
///
/// The button displays an image (icon) and a label, and provides visual feedback
/// when pressed. It can be enabled or disabled, and its appearance adapts accordingly.
///
/// Parameters:
/// - [text]: The label to display on the button.
/// - [color]: The background color of the button when enabled.
/// - [onPressed]: Callback triggered when the button is pressed.
/// - [imageAsset]: The asset path for the icon image.
/// - [enabled]: Whether the button is enabled or disabled.
class LoginButton extends StatefulWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;
  final String imageAsset;
  final bool enabled;

  const LoginButton({
    required this.text,
    required this.color,
    required this.onPressed,
    required this.imageAsset,
    required this.enabled,
    Key? key,
  }) : super(key: key);

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

/// State for [LoginButton], manages pressed state for visual feedback.
class _LoginButtonState extends State<LoginButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.enabled ? (_) => setState(() => _pressed = true) : null,
      onTapUp: widget.enabled
          ? (_) {
              setState(() => _pressed = false);
              widget.onPressed();
            }
          : null,
      onTapCancel: widget.enabled
          ? () => setState(() => _pressed = false)
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: 350,
        height: 60,
        decoration: BoxDecoration(
          color: widget.enabled ? widget.color : Colors.grey[400],
          borderRadius: BorderRadius.circular(20),
          boxShadow: _pressed
              ? [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(2, 2),
                    blurRadius: 2,
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black38,
                    offset: Offset(4, 4),
                    blurRadius: 8,
                  ),
                ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(widget.imageAsset, width: 32, height: 32),
            const SizedBox(width: 16),
            Text(
              widget.text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
