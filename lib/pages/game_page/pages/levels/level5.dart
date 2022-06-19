import 'package:flutter/material.dart';
import 'package:frontend/widgets/text_buttons.dart';

import '../../utils/level_utils.dart';


class Level5 extends StatefulWidget {
  const Level5({Key? key}) : super(key: key);

  @override
  State<Level5> createState() => _Level5State();
}

class _Level5State extends State<Level5> {
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
