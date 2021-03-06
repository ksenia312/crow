import 'package:flutter/material.dart';

class AppColorScheme {
  static ColorScheme get lightGrey {
    const Color _light = Color(0xFFF4F4F4);
    return const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFF606C8D),
        surface: Color(0xFF49526C),
        onPrimary: _light,
        onSurface: _light,
        onError: _light,
        secondary: _light,
        onBackground: Color(0xFF48526B),
        tertiary: Color(0xFFCBD1E0),
        error: Color(0xFFFD3F55),
        background: Color(0xFFDAE0EF),
        onSecondary: Color(0xFF363E52),
        onTertiary: Color(0xFF363E52),
        shadow: Color(0x80000000),
        secondaryContainer: Color(0xFFF7F9FF));
  }
  static ColorScheme get darkGrey {
    const Color _light = Color(0xFFDBDBF3);
    return const ColorScheme(
        brightness: Brightness.dark,
        onPrimary: _light,
        onSecondary: _light,
        onSurface: _light,
        onError: _light,
        onBackground: Color(0xFFB8B8DA),
        primary: Color(0xFF363A54),
        secondary: Color(0xFF252738),
        surface: Color(0xFF3F4364),
        background: Color(0xFF474C70),
        tertiary: Color(0xFF4D5479),
        onTertiary: Color(0xFFC3C2C7),
        error: Color(0xFFA92B3A),
        shadow: Color(0x80000000),
        secondaryContainer: Color(0xFF5C6193));
  }

  static ColorScheme get lightBlue {
    const Color _light = Color(0xFFF4F4F4);
    return const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFF6060AD),
        surface: Color(0xFF6B6BBD),
        onPrimary: _light,
        onSurface: _light,
        onError: _light,
        onBackground: Color(0xFF364770),
        secondary: _light,
        tertiary: Color(0xFFC5C4F1),
        error: Color(0xFFFD3F55),
        background: Color(0xFFD3D2FF),
        onSecondary: Color(0xFF100B2D),
        onTertiary: Color(0xFF0C0C36),
        shadow: Color(0x80000000),
        secondaryContainer: Color(0xFFF7F9FF));
  }

  static ColorScheme get darkBlue {
    const Color _light = Color(0xFFDBDBF3);
    return const ColorScheme(
        brightness: Brightness.dark,
        onPrimary: _light,
        onSecondary: _light,
        onSurface: _light,
        onBackground: Color(0xFFBAB4DA),
        onError: _light,
        primary: Color(0xFF3C3079),
        secondary: Color(0xFF292946),
        surface: Color(0xFF322864),
        background: Color(0xFF221C3A),
        tertiary: Color(0xFF1B162D),
        onTertiary: Color(0xFFC2C3C7),
        error: Color(0xFFA92B3A),
        shadow: Color(0x80000000),
        secondaryContainer: Color(0xFF463A75));
  }

  static ColorScheme get lightPink {
    const Color _light = Color(0xFFF4F4F4);
    return const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFF9A60AD),
        surface: Color(0xFFA96BBD),
        onPrimary: _light,
        onSurface: _light,
        onError: _light,
        onBackground: Color(0xFF563670),
        secondary: _light,
        tertiary: Color(0xFFE6C4F1),
        error: Color(0xFFFD3F55),
        background: Color(0xFFF5D2FF),
        onSecondary: Color(0xFF260B2D),
        onTertiary: Color(0xFF2E0C36),
        shadow: Color(0x80000000),
        secondaryContainer: Color(0xFFFEF7FF));
  }

  static ColorScheme get darkPink {
    const Color _light = Color(0xFFF0DBF3);
    return const ColorScheme(
        brightness: Brightness.dark,
        onPrimary: _light,
        onSecondary: _light,
        onSurface: _light,
        onBackground: Color(0xFFD1B4DA),
        onError: _light,
        primary: Color(0xFF693079),
        secondary: Color(0xFF402947),
        surface: Color(0xFF552864),
        background: Color(0xFF331C3A),
        tertiary: Color(0xFF28162D),
        onTertiary: Color(0xFFC5C2C7),
        error: Color(0xFFA92B3A),
        shadow: Color(0x80000000),
        secondaryContainer: Color(0xFF6F3A75));
  }

  static ColorScheme get lightGreen {
    const Color _light = Color(0xFFF4F4F4);
    return const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFF60AD8D),
        surface: Color(0xFF6BBD8F),
        onPrimary: _light,
        onSurface: _light,
        onError: _light,
        onBackground: Color(0xFF367048),
        secondary: _light,
        tertiary: Color(0xFFC4F1D9),
        error: Color(0xFFFD3F55),
        background: Color(0xFFD2FFDF),
        onSecondary: Color(0xFF0B2D19),
        onTertiary: Color(0xFF0C361B),
        shadow: Color(0x80000000),
        secondaryContainer: Color(0xFFF7FFF8));
  }

  static ColorScheme get darkGreen {
    const Color _light = Color(0xFFDFF3DB);
    return const ColorScheme(
        brightness: Brightness.dark,
        onPrimary: _light,
        onSecondary: _light,
        onSurface: _light,
        onBackground: Color(0xFFB4DABD),
        onError: _light,
        primary: Color(0xFF307947),
        secondary: Color(0xFF2A4635),
        surface: Color(0xFF286439),
        background: Color(0xFF1C3A26),
        tertiary: Color(0xFF162D1B),
        onTertiary: Color(0xFFC2C7C3),
        error: Color(0xFFA92B3A),
        shadow: Color(0x80000000),
        secondaryContainer: Color(0xFF3A7542));
  }

  static ColorScheme get lightOrange {
    const Color _light = Color(0xFFF4F4F4);
    return const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFFAD7760),
        surface: Color(0xFFBD846B),
        onPrimary: _light,
        onSurface: _light,
        onError: _light,
        onBackground: Color(0xFF704E36),
        secondary: _light,
        tertiary: Color(0xFFF1D4C4),
        error: Color(0xFFFD3F55),
        background: Color(0xFFFFE0D2),
        onSecondary: Color(0xFF2D150B),
        onTertiary: Color(0xFF36170C),
        shadow: Color(0x80000000),
        secondaryContainer: Color(0xFFFFFAF7));
  }

  static ColorScheme get darkOrange {
    const Color _light = Color(0xFFF3E3DB);
    return const ColorScheme(
        brightness: Brightness.dark,
        onPrimary: _light,
        onSecondary: _light,
        onSurface: _light,
        onBackground: Color(0xFFDABFB4),
        onError: _light,
        primary: Color(0xFF794C30),
        secondary: Color(0xFF453229),
        surface: Color(0xFF643D28),
        background: Color(0xFF3A261C),
        tertiary: Color(0xFF2D1F16),
        onTertiary: Color(0xFFC7C4C2),
        error: Color(0xFFA92B3A),
        shadow: Color(0x80000000),
        secondaryContainer: Color(0xFF75513A));
  }
}
