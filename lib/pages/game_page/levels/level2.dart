import 'package:flutter/material.dart';
import 'package:frontend/widgets/buttons.dart';
import 'package:frontend/widgets/cards/announcement_card.dart';

class Level2 extends StatefulWidget {
  const Level2({Key? key}) : super(key: key);

  @override
  State<Level2> createState() => _Level2State();
}

class _Level2State extends State<Level2> {
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
