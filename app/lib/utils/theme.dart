import 'package:flutter/material.dart';
import 'package:frontend/utils/button_style.dart';
import 'package:frontend/utils/colors.dart';
import 'package:frontend/utils/text_style.dart';

class AppTheme {
  static ThemeData get blue {
    return ThemeData(
      //primaryColor: AppColors.blue60(),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: AppButtonStyle.transparent()),
      scaffoldBackgroundColor: AppColors.scaffold(),
      textTheme: _textTheme(),
      primaryTextTheme: _textTheme(),
      appBarTheme: _appBarTheme(),
      fontFamily: "Lexend",
    );
  }

  static _appBarTheme() {
    return AppBarTheme(
      shadowColor: AppColors.basicDark(),
      backgroundColor: AppColors.primary(),
      titleTextStyle: AppTextStyle.title(),
      elevation: 3,
    );
  }

  static _textTheme() {
    return TextTheme(
      headline1: AppTextStyle.headline1(),
      headline2: AppTextStyle.headline2(),
      bodyText1: AppTextStyle.bodyText(),
      button: AppTextStyle.button(),
      subtitle1: AppTextStyle.subtitle(),
    );
  }
}
