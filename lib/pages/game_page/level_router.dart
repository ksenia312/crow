import 'package:flutter/material.dart';

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
    Color _onAppBarColor = Theme.of(context).colorScheme.onSurface;
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    if (arguments['id'] == 3) {
      setState(() {
        isLast = true;
      });
    }
    return Scaffold(
        appBar: AppBar(
          leading: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/game-home');
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: _onAppBarColor,
                  )),
              _navigationText('s', _onAppBarColor)
            ],
          ),
          actions: [
            isLast
                ? Container()
                : Row(
                    children: [
                      _navigationText('s', _onAppBarColor),
                      IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/level', arguments: {
                              "id": arguments['id'] + 1,
                            });
                          },
                          icon: Icon(
                            Icons.arrow_forward,
                            color: _onAppBarColor,
                          )),
                    ],
                  )
          ],
        ),
        body: _levels.elementAt(arguments['id'] - 1));
  }

  Text _navigationText(text, color) => Text(
        text,
        style: TextStyle(color: color),
      );
}
