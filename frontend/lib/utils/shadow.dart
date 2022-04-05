import 'package:flutter/material.dart';

import 'colors.dart';

class AppShadow {
  static normal(Color color) =>
      Shadow(color: color, offset: const Offset(0, 2), blurRadius: 4);

  static appBar() => normal(AppColors.darkGrey());

  static title() => normal(AppColors.grey());
}
