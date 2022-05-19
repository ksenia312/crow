import 'package:flutter/material.dart';

class AppColorScheme {
  static ColorScheme get lightGrey {
    const Color _light = Color(0xFFF4F4F4);
    return const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFF757A8F),
        surface: Color(0xFF646A80),
        onPrimary: _light,
        onSurface: _light,
        onError: _light,
        onBackground: _light,
        secondary: _light,
        tertiary: Color(0xFFC6BFCC),
        error: Color(0xFFFD3F55),
        background: Color(0xFFD2CBDA),
        onSecondary: Color(0xFF313131),
        onTertiary: Color(0xFF4E4854),
        shadow: Color(0x80000000),
        secondaryContainer: Color(0xCCF4F4F4));
  }
  static ColorScheme get darkGrey {
    const Color _light = Color(0xFFDBDBF3);
    return const ColorScheme(
        brightness: Brightness.dark,
        onPrimary: _light,
        onSecondary: _light,
        onSurface: _light,
        onBackground: _light,
        onError: _light,
        primary: Color(0xFF5F5F69),
        secondary: Color(0xCC34343B),
        surface: Color(0xFF32323A),
        background: Color(0xFF434349),
        tertiary: Color(0xFF6D6B77),
        onTertiary: Color(0xFFC3C2C7),
        error: Color(0xFFA92B3A),
        shadow: Color(0x80000000),
        secondaryContainer: Color(0xFF6A6A73));
  }

  static ColorScheme get lightBlue {
    const Color _light = Color(0xFFF4F4F4);
    return const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFF3E3BBE),
        surface: Color(0xFF3D29BD),
        onPrimary: _light,
        onSurface: _light,
        onError: _light,
        onBackground: _light,
        secondary: _light,
        tertiary: Color(0xFF9D9AFF),
        error: Color(0xFFFD3F55),
        background: Color(0xFF6663FF),
        onSecondary: Color(0xFF100B2D),
        onTertiary: Color(0xFF0C0C36),
        shadow: Color(0x80000000),
        secondaryContainer: Color(0xCCF4F4F4));
  }

  static ColorScheme get darkBlue {
    const Color _light = Color(0xFFDBDBF3);
    return const ColorScheme(
        brightness: Brightness.dark,
        onPrimary: _light,
        onSecondary: _light,
        onSurface: _light,
        onBackground: _light,
        onError: _light,
        primary: Color(0xFF30207E),
        secondary: Color(0xCC202052),
        surface: Color(0xFF1E1652),
        background: Color(0xFF160F3A),
        tertiary: Color(0xFF260A52),
        onTertiary: Color(0xFF7270C0),
        error: Color(0xFFA92B3A),
        shadow: Color(0x80000000),
        secondaryContainer: Color(0xFF26266E));
  }

  static ColorScheme get lightPink {
    const Color _light = Color(0xFFF4F4F4);
    return const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFFA23BBE),
        surface: Color(0xFF9D29BD),
        onPrimary: _light,
        onSurface: _light,
        onError: _light,
        onBackground: _light,
        secondary: _light,
        tertiary: Color(0xFFF29AFF),
        error: Color(0xFFFD3F55),
        background: Color(0xFFEA63FF),
        onSecondary: Color(0xFF270B2D),
        onTertiary: Color(0xFF350C36),
        shadow: Color(0x80000000),
        secondaryContainer: Color(0xCCF4F4F4));
  }

  static ColorScheme get darkPink {
    const Color _light = Color(0xFFF0DBF3);
    return const ColorScheme(
        brightness: Brightness.dark,
        onPrimary: _light,
        onSecondary: _light,
        onSurface: _light,
        onBackground: _light,
        onError: _light,
        primary: Color(0xFF6A207E),
        secondary: Color(0xCC492052),
        surface: Color(0xFF471652),
        background: Color(0xFF310F3A),
        tertiary: Color(0xFF4D0A52),
        onTertiary: Color(0xFFAC70C0),
        error: Color(0xFFA92B3A),
        shadow: Color(0x80000000),
        secondaryContainer: Color(0xFF5A266E));
  }

  static ColorScheme get lightGreen {
    const Color _light = Color(0xFFF4F4F4);
    return const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFF48BE3B),
        surface: Color(0xFF4EBD29),
        onPrimary: _light,
        onSurface: _light,
        onError: _light,
        onBackground: _light,
        secondary: _light,
        tertiary: Color(0xFFBCFF9A),
        error: Color(0xFFFD3F55),
        background: Color(0xFF6AE149),
        onSecondary: Color(0xFF142D0B),
        onTertiary: Color(0xFF18360C),
        shadow: Color(0x80000000),
        secondaryContainer: Color(0xCCF4F4F4));
  }

  static ColorScheme get darkGreen {
    const Color _light = Color(0xFFDFF3DB);
    return const ColorScheme(
        brightness: Brightness.dark,
        onPrimary: _light,
        onSecondary: _light,
        onSurface: _light,
        onBackground: _light,
        onError: _light,
        primary: Color(0xFF347E20),
        secondary: Color(0xCC315220),
        surface: Color(0xFF275216),
        background: Color(0xFF1D3A0F),
        tertiary: Color(0xFF1E520A),
        onTertiary: Color(0xFF8DC070),
        error: Color(0xFFA92B3A),
        shadow: Color(0x80000000),
        secondaryContainer: Color(0xFF366E26));
  }

  static ColorScheme get lightOrange {
    const Color _light = Color(0xFFF4F4F4);
    return const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFFBE693B),
        surface: Color(0xFFBD6229),
        onPrimary: _light,
        onSurface: _light,
        onError: _light,
        onBackground: _light,
        secondary: _light,
        tertiary: Color(0xFFFFC19A),
        error: Color(0xFFFD3F55),
        background: Color(0xFFFF9263),
        onSecondary: Color(0xFF2D170B),
        onTertiary: Color(0xFF361C0C),
        shadow: Color(0x80000000),
        secondaryContainer: Color(0xCCF4F4F4));
  }

  static ColorScheme get darkOrange {
    const Color _light = Color(0xFFF3E3DB);
    return const ColorScheme(
        brightness: Brightness.dark,
        onPrimary: _light,
        onSecondary: _light,
        onSurface: _light,
        onBackground: _light,
        onError: _light,
        primary: Color(0xFF7E4120),
        secondary: Color(0xCC522F20),
        surface: Color(0xFF522B16),
        background: Color(0xFF3A1E0F),
        tertiary: Color(0xFF52230A),
        onTertiary: Color(0xFFC08C70),
        error: Color(0xFFA92B3A),
        shadow: Color(0x80000000),
        secondaryContainer: Color(0xFF6E3F26));
  }
}
