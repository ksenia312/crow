import 'package:flutter/material.dart';

class AppFontSize {
  static extraLarge() => 36.0;

  static large() => 24.0;

  static normal() => 20.0;

  static small() => 16.0;

  static extraSmall() => 12.0;
}

class AppTextStyle {
  static _text(size, {shadow = false, bold = true}) => TextStyle(
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        fontSize: size,
        letterSpacing: 1.1,
      );

  static get headline1 => _text(AppFontSize.extraLarge(), shadow: true); //welcome

  static get headline2 => _text(AppFontSize.normal()); //headline2

  static get title => _text(AppFontSize.normal(), shadow: true);

  static get button => _text(AppFontSize.normal());

  static get bodyText => _text(AppFontSize.small(), bold: false);

  static get subtitle => _text(AppFontSize.normal(), bold: false);
}
