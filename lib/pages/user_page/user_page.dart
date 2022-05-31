import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/models/user_statuses_model.dart';
import 'package:frontend/services/user/user_service.dart';
import 'package:frontend/services/user_statuses/user_statuses_service.dart';
import 'package:frontend/widgets/cards/image_card.dart';
import 'package:frontend/widgets/statuses/loading.dart';
import 'package:provider/provider.dart';
import 'widgets/statistics_card.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserModel?>(context);
    return StreamBuilder(
        stream: UserStatusesService().userStatuses,
        builder:
            (BuildContext context, AsyncSnapshot<UserStatusesModel> snapshot) {
          List _statusesData = snapshot.data?.data ?? ['дикая львица'];
          String _status =
              _statusesData[Random().nextInt(_statusesData.length)];
          return ListView(children: [
            user != null
                ? ImageCard(
                    headline2: '${user.name}, ${getAge(user.age)}',
                    bodyText: 'статус: $_status',
                    imageHeight: 100,
                    listTileHeight: 70,
                  )
                : Container(
                    color: Theme.of(context).colorScheme.tertiary,
                    height: 180,
                    child: const Center(
                      child: AppLoading(),
                    ),
                  ),
            const StatisticsCard(),
          ]);
        });
  }
}
