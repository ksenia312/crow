import 'package:flutter/material.dart';
import 'package:frontend/widgets/cards/announcement_card.dart';
import 'package:frontend/widgets/statuses/loading.dart';

class MeditationPage extends StatefulWidget {


  const MeditationPage({ Key? key}) : super(key: key);

  @override
  State<MeditationPage> createState() => _MeditationPageState();
}

class _MeditationPageState extends State<MeditationPage> {
  @override
  Widget build(BuildContext context) {
    return AppLoading(); /*const AnnouncementCard(
      headline2: 'Бесконечная лента',
      bodyText: "Листай сколько хочешь",
    );*/
  }
}
