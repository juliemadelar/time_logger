import 'package:flutter/material.dart';

class SquareIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final double size;
  final String text;
  final TextStyle? textStyle;
  final Color? color;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;

  const SquareIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.text,
    this.textStyle,
    this.size = 100.0, // Default size
    this.color,
    this.backgroundColor,
    this.borderRadius,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: padding ?? EdgeInsets.zero, // Use provided padding or none
            // backgroundColor:
            // backgroundColor ?? Colors.blue, // Use provided color or default
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius ??
                  BorderRadius.zero, // Use provided radius or none
            ),
            minimumSize: Size
                .zero, // Important: Allows the size to be defined by SizedBox
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(
              icon,
              size: size * 0.5, // Reduced icon size to make space for text
              // color: color ?? Colors.white,
            ),
            const SizedBox(height: 4), // Spacing between icon and text
            Text(
              text,
              style: textStyle ??
                  const TextStyle(
                    // color: Colors.white,
                    fontSize: 12,
                  ),
              textAlign: TextAlign.center,
            ),
          ])),
    );
  }
}
