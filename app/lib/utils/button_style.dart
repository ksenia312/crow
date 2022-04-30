import 'package:flutter/material.dart';

overrideButtonStyle<T>(property) {
  return MaterialStateProperty.all<T>(property);
}
class AppButtonStyle {
  static ButtonStyle get basic {
    return ButtonStyle(
        elevation: overrideButtonStyle<double>(2.0),
        padding: overrideButtonStyle<EdgeInsets>(const EdgeInsets.all(20)),
    );

  }
}
