import 'package:flutter/material.dart';

class AppColorScheme {
  static ColorScheme get light {
    const Color _light = Color(0xFFF4F4F4);
    const Color _main = Color(0xFF3D2CAA);
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF3E3BBE),
      surface: Color(0xFF3D29BD),
      onPrimary: _light,
      onSurface: _light,
      onError: _light,
      onBackground: _light,
      secondary: _light,
      tertiary: Color(0xFF7573FC),
      error: Color(0xFFFF974C),
      background: Color(0xFF6663FF),
      onSecondary: Color(0xFF100B2D),
      onTertiary: Color(0xFF241869),
      shadow: Color(0x80000000),
    );
  }

  static ColorScheme get dark {
    const Color _light = Color(0xFFDBDBF3);
    return const ColorScheme(
      brightness: Brightness.light,
      onPrimary: _light,
      onSecondary: _light,
      onSurface: _light,
      onBackground: _light,
      onError: _light,
      primary: Color(0xFF30207E),
      secondary: Color(0xCC202052),
      surface: Color(0xFF1E1652),
      background: Color(0xFF160F3A),
      tertiary: Color(0xFF1A1575),
      onTertiary: Color(0xFF7270C0),
      error: Color(0xFFFF974C),
      shadow: Color(0x80000000),
    );
  }
}
