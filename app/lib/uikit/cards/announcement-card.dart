import 'package:flutter/material.dart';
import 'package:frontend/uikit/list_tile.dart';
import 'package:frontend/utils/colors.dart';

import '../../utils/indents.dart';

class AnnouncementCard extends StatelessWidget {
  final String headline2;
  final String bodyText;
  final double height;

  const AnnouncementCard({
    Key? key,
    required this.headline2,
    required this.bodyText,
    this.height=120
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: AppIndents.basicMargin(),
        color: AppColors.secondary(),
        child: AppListTile(
          headline2: headline2,
          bodyText: bodyText,
          height: height,
          textColor: AppColors.basicLight(),
          color: AppColors.secondary(),
        ));
  }
}
