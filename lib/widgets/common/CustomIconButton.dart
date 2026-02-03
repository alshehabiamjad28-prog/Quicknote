import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final double size;
  final Color? iconColor;

  const CustomIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.size = 24.0,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,
        size: size,
        color: iconColor,
      ),
      onPressed: onPressed,
    );
  }
}