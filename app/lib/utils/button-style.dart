import 'package:flutter/material.dart';

import 'colors.dart';

class AppButtonStyle {
  static withIcon() => ButtonStyle(
        elevation: _overrideButtonStyle<double>(0.0),
        padding: _overrideButtonStyle<EdgeInsets>(EdgeInsets.zero),
        backgroundColor: _overrideButtonStyle<Color>(AppColors.transparent()),
      );

  static _overrideButtonStyle<T>(property) {
    return MaterialStateProperty.all<T>(property);
  }
}
