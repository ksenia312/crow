import 'package:flutter/material.dart';
import 'package:frontend/utils/colors.dart';
import 'package:frontend/utils/text-style.dart';

class AppTheme {
  static ThemeData get blue {
    return ThemeData(
      primaryColor: AppColors.darkBlue(),
      scaffoldBackgroundColor: AppColors.lightBlue(),
      textTheme: _textTheme(),
      primaryTextTheme: _textTheme(),
      appBarTheme: _appBarTheme(),
      fontFamily: "Lexend",
    );
  }

  static _appBarTheme() {
    return AppBarTheme(
      shadowColor: AppColors.darkGrey(),
      backgroundColor: AppColors.extraDarkBlue(),
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

  static headline1(context) => Theme.of(context).textTheme.headline1;

  static headline2(context) => Theme.of(context).textTheme.headline2;

  static darkHeadline2(context) => AppTextStyle.headline2(dark: true);

  static bodyText(context) => Theme.of(context).textTheme.bodyText1;

  static buttonText(context) => Theme.of(context).textTheme.button;

  static subtitle(context) => Theme.of(context).textTheme.subtitle1;
}
