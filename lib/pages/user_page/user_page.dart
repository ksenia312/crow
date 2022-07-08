import 'dart:math';
import 'package:flutter/material.dart';
import 'package:frontend/models/user_statuses_model.dart';
import 'package:frontend/services/user/user_stream_builder.dart';
import 'package:frontend/services/user_statuses/user_statuses_service.dart';
import 'package:frontend/utils/assets_variables.dart';
import 'package:frontend/utils/count_wrapper.dart';
import 'package:frontend/utils/indents.dart';
import 'package:frontend/widgets/cards/image_card.dart';
import 'package:frontend/widgets/list_tile.dart';
import 'package:frontend/widgets/statuses/loading.dart';
import 'widgets/statistics_card.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final List<String> ageVariants = ['лет', 'год', 'года'];
  String? _status;
  bool _isButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    return UserStreamBuilder(
      builder: (context, userSnapshot) {
        return StreamBuilder<UserStatusesModel>(
            stream: UserStatusesService().userStatuses,
            builder: (context, statusesSnapshot) {
              List _statuses = statusesSnapshot.data?.statuses ?? [];
              if (_status == null && _statuses.isNotEmpty) {
                _status = _statuses[Random().nextInt(_statuses.length)];
              }
              return ListView(children: [
                userSnapshot.hasData
                    ? ImageCard(
                        headline2:
                            '${userSnapshot.data!.name}, ${userSnapshot.data!.age} '
                            '${countSuffixWrapper(count: userSnapshot.data!.age, variants: ageVariants)}',
                        bodyText: 'случайная цитата: ${_status ?? '..'}',
                        imageHeight: 130,
                        listTileHeight: 100,
                        initImageNum: getRandomImageNum(),
                      )
                    : Container(
                        color: Theme.of(context).colorScheme.tertiary,
                        height: 200,
                        child: const Center(
                          child: AppLoading(),
                        ),
                      ),
                StatisticsCard(startDate: userSnapshot.data?.startDate),
                userSnapshot.hasData
                    ? _drawUpdateButton(_statuses)
                    : Container(),
              ]);
            });
      },
    );
  }

  _drawUpdateButton(statuses) => Card(
        color: Theme.of(context).colorScheme.background,
        margin: _isButtonPressed
            ? const EdgeInsets.only(top: 5, right: 10, left: 10)
            : AppIndents.all5ExceptBottom,
        elevation: 2,
        child: Listener(
            onPointerDown: (details) {
              setState(() {
                _isButtonPressed = true;
              });
            },
            onPointerUp: (details) {
              setState(() {
                _isButtonPressed = false;
                _status = statuses[Random().nextInt(statuses.length)];
              });
            },
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              child: AppListTile(
                  headline2: 'обновить цитату',
                  trailing: Icon(Icons.refresh_sharp,
                      color: Theme.of(context).colorScheme.onTertiary),
                  color: _isButtonPressed
                      ? Theme.of(context).colorScheme.tertiary
                      : Theme.of(context).colorScheme.tertiary.withOpacity(0.6),
                  textColor: Theme.of(context).colorScheme.onTertiary,
                  bodyText: null),
            )),
      );
}
