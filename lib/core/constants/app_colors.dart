import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF4A6BDF); 
  static const Color primaryDark = Color(0xFF3A56B3);
  static const Color primaryLight = Color(0xFF7B94EC); 
 
  static const Color accent = Color(0xFF00BCD4);
  static const Color accentDark = Color(0xFF00838F);
  static const Color accentLight = Color(0xFFB2EBF2);

  
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textOnPrimary = Colors.white;
  static const Color textOnAccent = Colors.black;

  
  static const Color background = Colors.white;
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surface = Color(0xFFF5F5F5);

  
  static const Color border = Color(0xFFBDBDBD);
  static const Color divider = Color(0xFFEEEEEE);
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388E3C);
  static const Color warning = Color(0xFFFFA000);

 
  static const Color calendarSelected = Color(0xFFE3F2FD);
  static const Color calendarEventMarker = primary;
  
  static const Color textFieldBackground = Color(0xFFF0F0F0);

  static const Color cardBackground = Colors.white;
  static const Color cardShadow = Color(0x1A000000);


  static Color withOpacity(Color color, double opacity) {
    return color.withValues(alpha: opacity);
  }

  static Color darken(Color color, [double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }

  static Color lighten(Color color, [double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    return hslLight.toColor();
  }
}
