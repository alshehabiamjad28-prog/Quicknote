import 'package:flutter/material.dart';

class BadgeIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final double size;
  final Color? iconColor;
  final int? badgeCount; // ⬅️ اسم أوضح

  const BadgeIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.size = 24.0,
    this.iconColor,
    this.badgeCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        IconButton(
          icon: Icon(icon, size: size, color: iconColor),
          onPressed: onPressed,
        ),

        if (badgeCount != null && badgeCount! > 0)
          Positioned(
            right: 8,
            top: 8,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8),
              ),
              constraints: BoxConstraints(minWidth: 16, minHeight: 16),
              child: Text(
                badgeCount! > 99 ? '99+' : badgeCount.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}