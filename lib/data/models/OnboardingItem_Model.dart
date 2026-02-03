import 'package:flutter/material.dart';

class PageModel {
  final Image image;
  final String title;
  final String subtitle;
  final Color bgColor;
  final Color textColor;
  final IconData icon;

  PageModel(this.image, {
    required this.title,
    required this.subtitle,
    required this.bgColor,
    required this.textColor,
    required this.icon,
  });
}
