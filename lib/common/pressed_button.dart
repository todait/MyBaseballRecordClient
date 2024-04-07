import 'package:flutter/material.dart';

class PressedButton extends StatefulWidget {
  final Color borderColor;
  final Color backgroundColor;
  final Widget child;
  final VoidCallback onTap;
  final double borderWidth;
  final BorderRadiusGeometry? borderRadius;

  const PressedButton({
    super.key,
    required this.borderColor,
    required this.backgroundColor,
    required this.child,
    required this.onTap,
    required this.borderWidth,
    this.borderRadius,
  });

  @override
  State<PressedButton> createState() => _PressedButtonState();
}

class _PressedButtonState extends State<PressedButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius ?? BorderRadius.circular(32.0),
          border: Border.all(
            width: widget.borderWidth,
            color: _isPressed
                ? widget.borderColor.withOpacity(0.8)
                : widget.borderColor.withOpacity(1.0),
          ),
          color: _isPressed
              ? widget.backgroundColor.withOpacity(0.8)
              : widget.backgroundColor,
        ),
        child: Opacity(
          opacity: _isPressed ? 0.8 : 1.0,
          child: widget.child,
        ),
      ),
    );
  }
}
