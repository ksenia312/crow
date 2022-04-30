import 'package:flutter/material.dart';
import 'package:frontend/utils/button_style.dart';
import 'package:frontend/utils/color_schemes.dart';
import 'package:frontend/utils/text_style.dart';

enum ColorfulThemeType { pink, green, orange }

class AppTheme with ChangeNotifier {
  static bool _isDarkTheme = false;

  ThemeMode get currentTheme {
    return _isDarkTheme ? ThemeMode.dark : ThemeMode.light;
  }

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  static _basicThemeData(
          ColorScheme colorScheme) =>
      ThemeData(
        elevatedButtonTheme: _elevatedButtonThemeData(),
        textTheme: _textTheme(),
        primaryTextTheme: _textTheme(),
        appBarTheme: _appBarTheme(colorScheme.surface),
        fontFamily: "Lexend",
        colorScheme: colorScheme,
        scaffoldBackgroundColor: colorScheme.background,
      );

  static _elevatedButtonThemeData() => ElevatedButtonThemeData(
        style: ButtonStyle(
          padding: overrideButtonStyle<EdgeInsetsGeometry>(EdgeInsets.zero),
          elevation: overrideButtonStyle<double>(0.0),
        ),
      );

  static _textTheme() {
    return TextTheme(
      headline1: AppTextStyle.headline1,
      headline2: AppTextStyle.headline2,
      bodyText1: AppTextStyle.bodyText,
      button: AppTextStyle.button,
      subtitle1: AppTextStyle.subtitle,
    );
  }

  static _appBarTheme(backgroundColor) {
    return AppBarTheme(
      titleTextStyle: AppTextStyle.title,
      elevation: 3,
      backgroundColor: backgroundColor
    );
  }

  static ThemeData get light {
    return _basicThemeData(AppColorScheme.light);
  }

  static ThemeData get dark {
    return _basicThemeData(AppColorScheme.dark);
  }
}

AppTheme currentTheme = AppTheme();
