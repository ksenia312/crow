import 'package:flutter/material.dart';
import 'package:frontend/uikit/cards/image-card.dart';

import 'widgets/statistics.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ImageCard(
          headline2: 'Василиса',
          bodyText: 'статус: дикая львица',
          imageHeight: 150,
          listTileHeight: 100,
        ),
        Statistics(),
      ]
    );
  }
}
