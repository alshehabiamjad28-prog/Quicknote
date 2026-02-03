import 'package:flutter/material.dart';

class AppColors {

  static final lightScheme = ColorScheme.light(
    primary: Color(0xFF6366F1),
    onPrimary: Colors.white,
    secondary: Color(0xFFF59E0B),
    onSecondary: Colors.white,
    background: Color(0xFFF8FAFC),
    onBackground: Color(0xFF1E293B),
    surface: Colors.white,
    onSurface: Color(0xFF1E293B),
    surfaceVariant: Color(0xFFF1F5F9),
    error: Color(0xFFEF4444),
  );

  static final darkScheme = ColorScheme.dark(
    primary: Color(0xFF818CF8),
    onPrimary: Color(0xFF0F172A),
    secondary: Color(0xFFF59E0B),
    onSecondary: Color(0xFF0F172A),
    background: Color(0xFF0F172A),
    onBackground: Color(0xFFF1F5F9),
    surface: Color(0xFF1E293B),
    onSurface: Color(0xFFF1F5F9),
    surfaceVariant: Color(0xFF334155),
    error: Color(0xFFF87171),
  );

}