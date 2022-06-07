import 'package:flutter/material.dart';
import 'package:frontend/models/auth_model.dart';
import 'package:frontend/services/user/user_database.dart';
import 'package:provider/provider.dart';

import '../levels/level1.dart';
import '../levels/level2.dart';
import '../levels/level3.dart';

class Levels {
  static int _availableLevels = 1;

  static void updateAvailableLevels(levels) {
    _availableLevels = levels;
  }

  final List<Widget> _levels = [const Level1(), const Level2(), const Level3()];

  List<Widget> get widgets => _levels;

  int get maxLevel => _levels.length;

  void nextLevel(context) {
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    int newLevel = arguments['id'] + 1;
    final auth = Provider.of<AuthModel>(context, listen: false);
    if (_availableLevels < newLevel) {
      UserDatabase(uid: auth.uid).updateUserAvailableLevels(levels: newLevel);
      updateAvailableLevels(newLevel);
    }
    Navigator.pushNamed(context, '/pass-page', arguments: {"id": newLevel});
  }
}
