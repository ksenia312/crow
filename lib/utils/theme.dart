import 'package:flutter/material.dart';
import 'package:frontend/utils/color_schemes.dart';
import 'package:frontend/utils/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'functions.dart';

enum ColorfulThemeType { grey, blue, pink, green, orange }

class AppTheme with ChangeNotifier {
  static bool _isDarkTheme = false;
  static int _colorModeNum = 0;

  static _basicThemeData(ColorScheme colorScheme) => ThemeData(
        elevatedButtonTheme: _elevatedButtonThemeData(),
        textTheme: _textTheme(),
        primaryTextTheme: _textTheme(),
        appBarTheme: _appBarTheme(colorScheme.surface, colorScheme.onSurface),
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

  static _appBarTheme(backgroundColor, foregroundColor) {
    return AppBarTheme(
        titleTextStyle: AppTextStyle.title,
        elevation: 3,
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
        iconTheme: IconThemeData(color:foregroundColor),
    );
  }

  static setTheme({required bool isDark, required int colorNum}) {
    _isDarkTheme = isDark;
    _colorModeNum = colorNum;
  }

  ThemeMode get currentTheme {
    return _isDarkTheme ? ThemeMode.dark : ThemeMode.light;
  }

  int get currentColorModeNum => _colorModeNum;

  void toggleTheme() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    _isDarkTheme = !_isDarkTheme;
    _prefs.setBool('isDarkTheme', _isDarkTheme);
    notifyListeners();
  }

  void toggleColorMode(int colorNum) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    _colorModeNum = colorNum;
    _prefs.setInt('colorModeNum', _colorModeNum);
    notifyListeners();
  }

  ThemeData get light {
    switch (ColorfulThemeType.values[_colorModeNum]) {
      case ColorfulThemeType.grey:
        return _basicThemeData(AppColorScheme.lightGrey);
      case ColorfulThemeType.blue:
        return _basicThemeData(AppColorScheme.lightBlue);
      case ColorfulThemeType.pink:
        return _basicThemeData(AppColorScheme.lightPink);
      case ColorfulThemeType.green:
        return _basicThemeData(AppColorScheme.lightGreen);
      case ColorfulThemeType.orange:
        return _basicThemeData(AppColorScheme.lightOrange);
    }
  }

  ThemeData get dark {
    switch (ColorfulThemeType.values[_colorModeNum]) {
      case ColorfulThemeType.grey:
        return _basicThemeData(AppColorScheme.darkGrey);
      case ColorfulThemeType.blue:
        return _basicThemeData(AppColorScheme.darkBlue);
      case ColorfulThemeType.pink:
        return _basicThemeData(AppColorScheme.darkPink);
      case ColorfulThemeType.green:
        return _basicThemeData(AppColorScheme.darkGreen);
      case ColorfulThemeType.orange:
        return _basicThemeData(AppColorScheme.darkOrange);
    }
  }
}

AppTheme appTheme = AppTheme();
