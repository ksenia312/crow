import 'package:flutter/material.dart';
import 'package:frontend/widgets/text_buttons.dart';
import 'package:frontend/widgets/cards/announcement_card.dart';

class Level1 extends StatefulWidget {
  const Level1({Key? key}) : super(key: key);

  @override
  State<Level1> createState() => _Level1State();
}

class _Level1State extends State<Level1> {
  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    _nextLevel() {
      Navigator.pushNamed(context, '/pass-page',
          arguments: {"id": arguments['id'] + 1});
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AnnouncementCard(
          headline2: 'Уровень ${arguments['id']}',
          bodyText: 'название',
          showCloseButton: false,
        ),
        AppTextButton(buttonText: 'пройти уровень', onPressed: _nextLevel),
      ],
    );
  }
}
