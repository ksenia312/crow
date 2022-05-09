import 'package:flutter/material.dart';

overrideButtonStyle<T>(property) {
  return MaterialStateProperty.all<T>(property);
}
class AppButtonStyle {
  static ButtonStyle get basic {
    return ButtonStyle(
        elevation: overrideButtonStyle<double>(0.0),
      splashFactory: InkSplash.splashFactory
    );

  }
}
