import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/models/user_statuses_model.dart';
import 'package:frontend/services/user/user_database.dart';
import 'package:frontend/services/user/user_stream_builder.dart';
import 'package:frontend/services/user_statuses/user_statuses_service.dart';
import 'package:frontend/widgets/cards/image_card.dart';
import 'package:frontend/widgets/statuses/loading.dart';
import 'widgets/statistics_card.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return UserStreamBuilder(
      builder: (context, userSnapshot) {
        return StreamBuilder<UserStatusesModel>(
            stream: UserStatusesService().userStatuses,
            builder: (context, statusesSnapshot) {
              List _statuses =
                  statusesSnapshot.data?.statuses ?? ['дикая львица'];
              String _status = _statuses[Random().nextInt(_statuses.length)];
              return ListView(children: [
                userSnapshot.hasData
                    ? ImageCard(
                        headline2:
                            '${userSnapshot.data!.name}, ${getAge(userSnapshot.data!.age)}',
                        bodyText: 'статус: $_status',
                        imageHeight: 100,
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
      },
    );
  }
}
