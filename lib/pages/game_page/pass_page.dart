import 'package:flutter/material.dart';
import 'package:frontend/widgets/text_buttons.dart';
import 'package:frontend/widgets/cards/announcement_card.dart';

class PassPage extends StatelessWidget {
  const PassPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    _nextLevel() {
      Navigator.pushReplacementNamed(context, '/level',
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
            AppTextButton(
              buttonText: 'Следующий уровень',
              onPressed: _nextLevel,
            ),
          ],
        ),
      ),
    );
  }
}
