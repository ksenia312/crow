import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class AppDialog {
  static showCustomDialog(context,
      {required Widget child, barrierDismissible = true}) {
    SchedulerBinding.instance?.addPostFrameCallback((_) => showDialog(
          context: context,
          builder: (BuildContext context) => child,
          barrierDismissible: barrierDismissible,
        ));
  }
}
