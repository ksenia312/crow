import 'package:flutter/material.dart';

overrideButtonStyle<T>(property) {
  return MaterialStateProperty.all<T>(property);
}

class AppButtonStyle {
  static ButtonStyle get basic {
    return ButtonStyle(

        //splashFactory: InkSplash.splashFactory,
        padding:
            overrideButtonStyle<EdgeInsetsGeometry?>(const EdgeInsets.all(15)));
  }
}
