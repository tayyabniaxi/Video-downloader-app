import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Color color;
  final Text text;
  final Widget? icon; //  optional icon
  final Color? borderColor;

  const Button({
    super.key,
    required this.color,
    required this.text,
    this.icon, //  not required anymore
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 328,
      height: 50,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: borderColor != null ? Border.all(
          width: 1.0,
          color: borderColor!,
        ):null,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) icon!, //  show only if icon provided
            if (icon != null) const SizedBox(width: 20), // spacing only if icon exists
            text,
          ],
        ),
      ),
    );
  }
}