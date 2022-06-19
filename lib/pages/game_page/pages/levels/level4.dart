import 'package:flutter/material.dart';
import 'package:frontend/widgets/text_buttons.dart';

import '../../utils/level_utils.dart';


class Level4 extends StatefulWidget {
  const Level4({Key? key}) : super(key: key);

  @override
  State<Level4> createState() => _Level4State();
}

class _Level4State extends State<Level4> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppTextButton(
            buttonText: 'пройти уровень',
            onPressed: () {
              LevelUtils().nextLevel(context);
            }),
      ],
    );
  }
}
