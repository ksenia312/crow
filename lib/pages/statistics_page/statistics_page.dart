import 'package:flutter/material.dart';
import 'package:frontend/widgets/app_bar_children.dart';
import 'package:frontend/widgets/cards/announcement_card.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const AppBarTitle(text: 'Статистика'),
          leading: AppBarLeading(iconBack: true),
        ),
        body: const AnnouncementCard(
          headline2: 'Ваша статистика',
          bodyText: 'Уникальные параметры вашей активности',
          showCloseButton: false
        ));
  }
}
