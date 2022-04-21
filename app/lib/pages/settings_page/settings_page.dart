import 'package:flutter/material.dart';
import 'package:frontend/uikit/cards/announcement-card.dart';
import '../../uikit/app_bar_children.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const AppBarTitle(text: 'Настройки'),
          leading: AppBarLeading(iconBack: true),
        ),
        body: const AnnouncementCard(
          headline2: 'Настройки',
          bodyText: '',
          height: 50,
        ));
  }
}
