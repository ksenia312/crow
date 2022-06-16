import 'package:flutter/material.dart';
import 'package:frontend/services/user/user_stream_builder.dart';
import 'package:frontend/widgets/app_bar_children.dart';
import 'level_utils.dart';

class LevelSwitch extends StatefulWidget {
  const LevelSwitch({Key? key}) : super(key: key);

  @override
  State<LevelSwitch> createState() => _LevelSwitchState();
}

class _LevelSwitchState extends State<LevelSwitch> {
  bool lastAvailable = false;
  late List<Widget> levels;

  @override
  void initState() {
    levels = LevelUtils().widgets;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    return UserStreamBuilder(builder: (context, userSnapshot) {
      int availableLevels = userSnapshot.data?.availableLevels ?? 1;
      return Scaffold(
          appBar: AppBar(
            leadingWidth: 150,
            centerTitle: true,
            title: Text(
              '${arguments['id']}',
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .apply(color: Theme.of(context).colorScheme.onSurface),
            ),
            leading: Row(children: [
              IconButton(
                  onPressed: _onBackPressed,
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).colorScheme.onSurface,
                  )),
              const AppBarTitle(
                text: 'Выбор \nуровня',
                isSmall: true,
                textAlign: TextAlign.left,
              )
            ]),
            actions: [
              IconButton(
                  onPressed: () {
                    _restartLevel(arguments);
                  },
                  icon: const Icon(Icons.refresh_sharp),
                  color: Theme.of(context).colorScheme.onSurface),
              (arguments['id'] != availableLevels &&
                      arguments['id'] != availableLevels - 1)
                  ? IconButton(
                      onPressed: () {
                        _onForwardPressed(arguments);
                      },
                      icon: const Icon(Icons.arrow_forward),
                      color: Theme.of(context).colorScheme.onSurface)
                  : Container()
            ],
          ),
          body: levels.elementAt(arguments['id'] - 1));
    });
  }

  void _onForwardPressed(arguments) {
    Navigator.pushReplacementNamed(context, '/level', arguments: {
      "id": arguments['id'] + 1,
    });
  }

  void _onBackPressed() {
    Navigator.pushReplacementNamed(context, '/levels-preview-page');
  }

  void _restartLevel(arguments) {
    Navigator.pushReplacementNamed(context, '/level', arguments: {
      "id": arguments['id'],
    });
  }
}
