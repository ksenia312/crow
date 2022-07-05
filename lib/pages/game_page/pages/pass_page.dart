import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/pages/game_page/utils/level_utils.dart';
import 'package:frontend/pages/game_page/widgets/level_pass_animations.dart';
import 'package:frontend/utils/indents.dart';
import 'package:frontend/widgets/text_buttons.dart';
import 'package:frontend/widgets/cards/announcement_card.dart';

class PassPage extends StatefulWidget {
  const PassPage({Key? key}) : super(key: key);

  @override
  State<PassPage> createState() => _PassPageState();
}

class _PassPageState extends State<PassPage> {
  late int maxLevel;
  late int _animationIndex;
  final List _animations = [
    const PassAnimation1(),
    const PassAnimation2(),
    const PassAnimation3()
  ];

  @override
  void initState() {
    maxLevel = LevelUtils.maxLevel;
    _animationIndex = Random().nextInt(_animations.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    _nextLevel() {
      Navigator.pushNamed(context, '/level',
          arguments: {"id": arguments['id']});
    }

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Вы прошли \nуровень!',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .apply(color: Theme.of(context).colorScheme.onBackground)),
            _animations[_animationIndex],
            arguments['id'] <= maxLevel
                ? AppTextButton(
                    buttonText: 'Следующий уровень',
                    onPressed: _nextLevel,
                    size: AppTextButtonSize.medium,
                  )
                : Padding(
                    padding: AppIndents.horizontal20,
                    child: const AnnouncementCard(
                      bodyText: null,
                      headline2: 'Уровни закончились ((\nСкоро появятся новые!',
                      showCloseButton: false,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
