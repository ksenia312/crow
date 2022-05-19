import 'package:flutter/material.dart';
import 'package:frontend/widgets/cards/announcement_card.dart';
import 'package:frontend/widgets/statuses/loading.dart';

class FeedPage extends StatefulWidget {


  const FeedPage({ Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return AppLoading(); /*const AnnouncementCard(
      headline2: 'Бесконечная лента',
      bodyText: "Листай сколько хочешь",
    );*/
  }
}
