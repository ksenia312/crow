import 'package:flutter/material.dart';
import 'package:frontend/utils/theme.dart';
import 'package:frontend/widgets/app_bar_children.dart';
import 'package:frontend/widgets/buttons.dart';
import 'package:frontend/widgets/cards/announcement_card.dart';

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
        body: ListView(
          children: <Widget>[
            const AnnouncementCard(
              headline2: 'Настройки',
              bodyText: 'Редактировать что-нибудь',
            ),
            AppTextButton(
              buttonText:
                  'тема: ${Theme.of(context).brightness == Brightness.dark ? 'темная' : 'светлая'}',
              type: AppTextButtonType.secondary,
              onPressed: () {
                currentTheme.toggleTheme();
              },
            )
          ],
        ));
  }
}
