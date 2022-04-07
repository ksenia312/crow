import 'package:flutter/material.dart';
import 'package:frontend/utils/shadow.dart';

import 'colors.dart';

class AppFontSize {
  static extraLarge() => 36.0;

  static large() => 24.0;

  static normal() => 20.0;

  static small() => 16.0;

  static extraSmall() => 12.0;
}

class AppTextStyle {
  static _text(size, {shadow = false, bold = true, dark=false}) => TextStyle(
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        color: dark ? AppColors.darkGrey() : AppColors.extraLight(),
        fontSize: size,
        shadows: shadow ? [AppShadow.title()] : null,
        letterSpacing: 1.2
      );

  static headline1() => _text(AppFontSize.extraLarge(), shadow: true); //welcome

  static headline2({dark=false}) => _text(AppFontSize.normal(), dark:dark); //headline2

  static title() => _text(AppFontSize.normal(), shadow: true);

  static button() => _text(AppFontSize.large());

  static bodyText() => _text(AppFontSize.normal(), bold: false);

  static subtitle() => _text(AppFontSize.small(), bold: false);



}

