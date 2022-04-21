import 'package:flutter/material.dart';
import 'colors.dart';

class AppButtonStyle {
  static transparent() => ButtonStyle(
        elevation: _overrideButtonStyle<double>(0.0),
        padding: _overrideButtonStyle<EdgeInsets>(EdgeInsets.zero),
        backgroundColor: _overrideButtonStyle<Color>(AppColors.transparent()),
      );

  static _basic(Color color) => ButtonStyle(
      elevation: _overrideButtonStyle<double>(4.0),
      shadowColor: _overrideButtonStyle<Color>(AppColors.basicDark()),
      padding: _overrideButtonStyle<EdgeInsets>(const EdgeInsets.all(20)),
      backgroundColor: _overrideButtonStyle<Color>(color));

  static primary() => _basic(AppColors.primary());

  static secondary() => _basic(AppColors.secondary());

  static light() => _basic(AppColors.basicLight());

  static _overrideButtonStyle<T>(property) {
    return MaterialStateProperty.all<T>(property);
  }
}
