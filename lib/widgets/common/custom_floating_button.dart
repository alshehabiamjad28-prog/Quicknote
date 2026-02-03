import 'package:flutter/material.dart';

class CustomFloatingButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final double size;
  final Color? backgroundColor;
  final Color? iconColor;

  const CustomFloatingButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.size = 56.0,
    this.backgroundColor,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(size / 2),
        ),
        backgroundColor: backgroundColor,
        onPressed: onPressed,
        child: Icon(
          icon,
          size: size * 0.5,
          color: iconColor,
        ),
      ),
    );
  }
}