import 'package:flutter/material.dart';

import 'levels/level1.dart';
import 'levels/level2.dart';

class LevelRouter extends StatelessWidget {
  const LevelRouter({Key? key}) : super(key: key);
  final List<Widget> _levels = const [Level1(), Level2()];

  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    return Scaffold(appBar: AppBar(), body: _levels.elementAt(arguments['id']));
  }
}
