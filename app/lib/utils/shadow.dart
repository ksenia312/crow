import 'package:flutter/material.dart';

import 'colors.dart';

class AppShadow {
  static normal(Color color) =>
      Shadow(color: color, offset: const Offset(0, 2), blurRadius: 4);

  static appBar() => normal(AppColors.basicDark());

  static title() => normal(AppColors.basicShadow());
}

class AppBoxShadow {
  static normal(Color color) =>
      BoxShadow(color: color, offset: const Offset(0, 3), blurRadius: 4);

  static appBar() => normal(AppColors.basicDark());

  static title() => normal(AppColors.basicShadow());
}