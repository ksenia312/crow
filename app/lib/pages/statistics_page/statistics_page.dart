import 'package:flutter/material.dart';
import 'package:frontend/uikit/cards/announcement-card.dart';
import '../../uikit/app_bar_children.dart';

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
          leading:  AppBarLeading(iconBack: true),
        ),
        body: Container(
            child: AnnouncementCard(
          headline2: 'Ваша статистика',
          bodyText: 'Уникальные параметры вашей активности',
        )));
  }
}
