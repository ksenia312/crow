import 'package:flutter/material.dart';
import 'package:frontend/models/auth_model.dart';
import 'package:frontend/services/user/user_database.dart';
import 'package:provider/provider.dart';

import '../levels/level1.dart';
import '../levels/level2.dart';
import '../levels/level3.dart';

class Levels {
  static int _availableLevelsCount = 1;

  static void updateAvailableLevels(levels) {
    _availableLevelsCount = levels;
  }

  final List<Widget> _levels = [const Level1(), const Level2(), const Level3()];

  List<Widget> get widgets => _levels;

  int get maxLevel => _levels.length;

  void nextLevel(context) {
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    int newLevelId = arguments['id'] + 1;
    final auth = Provider.of<AuthModel>(context, listen: false);
    if (_availableLevelsCount < newLevelId) {
      UserDatabase(uid: auth.uid).updateUserAvailableLevels(levels: newLevelId);
      updateAvailableLevels(newLevelId);
    }
    Navigator.pushReplacementNamed(context, '/level', arguments: {
      "id": arguments['id'],
    }); //restart
    Navigator.pushNamed(context, '/pass-page', arguments: {"id": newLevelId});
  }
}
