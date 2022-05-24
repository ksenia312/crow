import 'package:flutter/material.dart';
import 'package:frontend/pages/game_page/widgets/action_text_with_icon.dart';
import 'package:frontend/widgets/app_bar_children.dart';

import 'levels/level1.dart';
import 'levels/level2.dart';
import 'levels/level3.dart';

class LevelRouter extends StatefulWidget {
  const LevelRouter({Key? key}) : super(key: key);

  @override
  State<LevelRouter> createState() => _LevelRouterState();
}

class _LevelRouterState extends State<LevelRouter> {
  final List<Widget> _levels = const [Level1(), Level2(), Level3()];
  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    if (arguments['id'] == 3) {
      setState(() {
        isLast = true;
      });
    }
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 150,
          leading: ActionTextWithIcon(
              text: 'Выбор \nуровня',
              textPos: 1,
              onPressed: _onBackPressed,
              iconData: Icons.arrow_back,
              textAlign: TextAlign.left),
          actions: [
            isLast
                ? Container()
                : ActionTextWithIcon(
                    text: 'Следующий \nуровень',
                    textPos: 0,
                    onPressed: () {
                      _onForwardPressed(arguments);
                    },
                    iconData: Icons.arrow_forward,
                    textAlign: TextAlign.right)
          ],
        ),
        body: _levels.elementAt(arguments['id'] - 1));
  }

  void _onForwardPressed(arguments) {
    Navigator.pushNamed(context, '/level', arguments: {
      "id": arguments['id'] + 1,
    });
  }

  void _onBackPressed() {
    Navigator.pushNamed(context, '/game-home');
  }
}
