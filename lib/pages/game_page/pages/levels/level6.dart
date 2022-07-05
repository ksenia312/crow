import 'package:flutter/material.dart';
import 'package:frontend/widgets/text_buttons.dart';

import '../../utils/level_utils.dart';

class Level6 extends StatefulWidget {
  const Level6({Key? key}) : super(key: key);

  @override
  State<Level6> createState() => _Level6State();
}

class _Level6State extends State<Level6> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppTextButton(
            buttonText: 'пройти уровень',
            onPressed: () {
              LevelUtils.nextLevel(context);
            }),
      ],
    );
  }
}
