import 'package:flutter/material.dart';
import 'package:frontend/widgets/text_buttons.dart';

import '../utils/levels.dart';

class Level2 extends StatefulWidget {
  const Level2({Key? key}) : super(key: key);

  @override
  State<Level2> createState() => _Level2State();
}

class _Level2State extends State<Level2> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppTextButton(
            buttonText: 'пройти уровень',
            onPressed: () {
              Levels().nextLevel(context);
            }),
      ],
    );
  }
}
