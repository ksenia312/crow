import 'package:flutter/material.dart';

class AppIndents {
  static get all5ExceptBottom => const EdgeInsets.only(left: 5, right: 5, top: 5);

  static get bottom10Horizontal20 =>
      const EdgeInsets.only(left: 20, right: 20, bottom: 10);

  static get bottom5 => const EdgeInsets.only(bottom: 5);

  static get vertical10Horizontal20 =>
      const EdgeInsets.symmetric(vertical: 10, horizontal: 20);

  static get horizontal20 => const EdgeInsets.symmetric(horizontal: 20);
  static get vertical15 => const EdgeInsets.symmetric(vertical: 15);
  static get all15 => const EdgeInsets.all(15);
}



class AppFontSize {
  static get extraLarge => 36.0;

  static get large => 24.0;

  static get normal => 18.0;

  static get small => 14.0;

  static get extraSmall => 12.0;
}

class AppTextStyle {
  static _text(size, {shadow = false, bold = true}) => TextStyle(
    fontWeight: bold ? FontWeight.bold : FontWeight.normal,
    fontSize: size,
    letterSpacing: 1.1,
  );

  static get headline1 => _text(AppFontSize.extraLarge, shadow: true); //welcome

  static get headline2 => _text(AppFontSize.normal); //headline2

  static get title => _text(AppFontSize.normal, shadow: true);

  static get button => _text(AppFontSize.normal);

  static get bodyText => _text(AppFontSize.small, bold: false);

  static get subtitle => _text(AppFontSize.normal, bold: false);
}

