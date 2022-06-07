import 'package:flutter/material.dart';
import 'package:frontend/widgets/text_buttons.dart';

import '../utils/levels.dart';

class Level1 extends StatefulWidget {
  const Level1({Key? key}) : super(key: key);

  @override
  State<Level1> createState() => _Level1State();
}

class _Level1State extends State<Level1> {
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
