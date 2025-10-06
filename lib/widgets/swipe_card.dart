import 'package:flutter/material.dart';

/// A swipeable card widget that displays an image and triggers callbacks
/// when swiped left or right.
///
/// The card can be dragged horizontally. If the drag distance exceeds a
/// threshold, the corresponding callback is called.
///
/// Parameters:
/// - [imageUrl]: The URL of the image to display.
/// - [onSwipeLeft]: Callback triggered when the card is swiped left.
/// - [onSwipeRight]: Callback triggered when the card is swiped right.
class SwipeCard extends StatefulWidget {
  final String imageUrl;
  final VoidCallback onSwipeLeft;
  final VoidCallback onSwipeRight;

  /// Creates a [SwipeCard].
  ///
  /// [imageUrl]: The image to display.
  /// [onSwipeLeft]: Called on left swipe.
  /// [onSwipeRight]: Called on right swipe.
  const SwipeCard({
    super.key,
    required this.imageUrl,
    required this.onSwipeLeft,
    required this.onSwipeRight,
  });

  @override
  State<SwipeCard> createState() => _SwipeCardState();
}

/// State for [SwipeCard], manages the card's position and rotation.
class _SwipeCardState extends State<SwipeCard> {
  Offset _position = Offset.zero;
  double _rotation = 0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onPanStart: (details) {},
      onPanUpdate: (details) {
        setState(() {
          _position += details.delta;
          _rotation = _position.dx / screenWidth * 0.5;
        });
      },
      onPanEnd: (details) {
        if (_position.dx.abs() > 100) {
          if (_position.dx > 0) {
            widget.onSwipeRight();
          } else {
            widget.onSwipeLeft();
          }
          _resetPosition();
        } else {
          _resetPosition();
        }
      },
      child: Transform.translate(
        offset: _position,
        child: Transform.rotate(
          angle: _rotation,
          child: Container(
            width: screenWidth * 0.8,
            height: screenWidth * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                widget.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFF1DB954),
                    child: const Center(
                      child: Icon(
                        Icons.music_note,
                        size: 80,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Resets the card's position and rotation to their initial values.
  void _resetPosition() {
    setState(() {
      _position = Offset.zero;
      _rotation = 0;
    });
  }
}
