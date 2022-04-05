import 'package:flutter/material.dart';

import 'colors.dart';

class AppButtonStyle {
  static title() => ButtonStyle(
        elevation: MaterialStateProperty.all<double>(0),
        padding:
            MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.only(right: 10)
            ),
        backgroundColor: MaterialStateProperty.all<Color>(
          AppColors.transparent(),
        ),
      );
}
