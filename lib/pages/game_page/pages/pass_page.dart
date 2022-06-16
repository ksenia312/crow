import 'package:flutter/material.dart';
import 'package:frontend/pages/game_page/utils/level_utils.dart';
import 'package:frontend/widgets/text_buttons.dart';
import 'package:frontend/widgets/cards/announcement_card.dart';

class PassPage extends StatefulWidget {
  const PassPage({Key? key}) : super(key: key);

  @override
  State<PassPage> createState() => _PassPageState();
}

class _PassPageState extends State<PassPage> {
  late int maxLevel;

  @override
  void initState() {
    maxLevel = LevelUtils().maxLevel;
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
          children: [
            const AnnouncementCard(
              bodyText: 'Вы прошли уровень!',
              headline2: 'Ура!',
              showCloseButton: false,
            ),
            arguments['id'] <= maxLevel
                ? AppTextButton(
                    buttonText: 'Следующий уровень',
                    onPressed: _nextLevel,
                  )
                : const AnnouncementCard(
                    bodyText: null,
                    headline2: 'Уровни закончились((',
                    showCloseButton: false,
                  ),
          ],
        ),
      ),
    );
  }
}
