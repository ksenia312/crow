import 'package:flutter/material.dart';

class AppIndents {
  static get all5ExceptBottom => const EdgeInsets.only(left: 5, right: 5, top: 5);

  static get vertical10Horizontal20 =>
      const EdgeInsets.symmetric(vertical: 10, horizontal: 20);

  static get horizontal20 => const EdgeInsets.symmetric(horizontal: 20);
  static get vertical15 => const EdgeInsets.symmetric(vertical: 15);
  static get all15 => const EdgeInsets.all(15);
}
