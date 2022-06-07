import 'package:flutter/material.dart';
import 'package:frontend/pages/game_page/widgets/action_text_with_icon.dart';
import 'package:frontend/services/user/user_stream_builder.dart';
import 'utils/levels.dart';

class LevelRouter extends StatefulWidget {
  const LevelRouter({Key? key}) : super(key: key);

  @override
  State<LevelRouter> createState() => _LevelRouterState();
}

class _LevelRouterState extends State<LevelRouter> {
  bool lastAvailable = false;
  late List<Widget> levels;

  @override
  void initState() {
    levels = Levels().widgets;
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
            leading: ActionTextWithIcon(
                text: 'Выбор \nуровня',
                textPos: 1,
                onPressed: _onBackPressed,
                iconData: Icons.arrow_back,
                textAlign: TextAlign.left),
            actions: [
              (arguments['id'] != availableLevels &&
                      arguments['id'] != availableLevels - 1)
                  ? ActionTextWithIcon(
                      text: 'Следующий \nуровень',
                      textPos: 0,
                      onPressed: () {
                        _onForwardPressed(arguments);
                      },
                      iconData: Icons.arrow_forward,
                      textAlign: TextAlign.right)
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
    Navigator.pushReplacementNamed(context, '/game-home');
  }
}
