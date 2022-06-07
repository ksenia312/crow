import 'package:flutter/material.dart';
import 'package:frontend/widgets/text_buttons.dart';

import '../utils/levels.dart';

class Level3 extends StatefulWidget {
  const Level3({Key? key}) : super(key: key);

  @override
  State<Level3> createState() => _Level3State();
}

class _Level3State extends State<Level3> {
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
