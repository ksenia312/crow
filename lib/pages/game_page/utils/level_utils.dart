import 'package:flutter/material.dart';
import 'package:frontend/models/auth_model.dart';
import 'package:frontend/services/user/user_database.dart';
import 'package:provider/provider.dart';

import '../pages/levels/level1.dart';
import '../pages/levels/level2.dart';
import '../pages/levels/level3.dart';
import '../pages/levels/level4.dart';
import '../pages/levels/level5.dart';
import '../pages/levels/level6.dart';

class LevelUtils {
  static int _availableLevelsCount = 1;

  static void updateAvailableLevels(levels) {
    _availableLevelsCount = levels;
  }

   static List<Widget> get levels => [
    const Level1(),
    const Level2(),
    const Level3(),
    const Level4(),
    const Level5(),
    const Level6()
  ];

  static int get maxLevel => levels.length;

  static void nextLevel(context) {
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
