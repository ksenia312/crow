import 'package:flutter/material.dart';
import 'package:frontend/services/user/database.dart';
import 'package:frontend/services/user/stream_builder.dart';
import 'package:frontend/widgets/cards/image_card.dart';
import 'package:frontend/widgets/statuses/loading.dart';
import 'widgets/statistics.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return UserStreamBuilder(drawChild: (context, snapshot) {
      return ListView(children: [
        snapshot.hasData
            ? ImageCard(
                headline2:
                    '${snapshot.data!.name}, ${getAge(snapshot.data!.age)}',
                bodyText: 'статус: дикая львица',
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
        const Statistics(),
      ]);
    });
  }
}
