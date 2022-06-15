import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/services/user/user_stream_builder.dart';
import 'package:frontend/utils/assets_variables.dart';
import 'package:frontend/widgets/statuses/loading.dart';
import 'package:frontend/widgets/text_buttons.dart';
import 'package:frontend/widgets/cards/announcement_card.dart';

import '../utils/levels.dart';

class GameHome extends StatefulWidget {
  const GameHome({Key? key}) : super(key: key);

  @override
  State<GameHome> createState() => _GameHomeState();
}

class _GameHomeState extends State<GameHome> with TickerProviderStateMixin {
  late String _bigCrow;
  late AnimationController _controllerPink;
  late List<Widget> levels;
  late int maxLevel;
  Animation<double>? _animationPink;

  @override
  void initState() {
    super.initState();
    _controllerPink = _initializeController();
    _animationPink = _initializeAnimation(70.0, 20.0, _controllerPink);
    _addListeners(_controllerPink);
    _controllerPink.forward();
    levels = Levels().widgets;
    maxLevel = Levels().maxLevel;
  }

  _initializeController() {
    return AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2500));
  }

  _initializeAnimation(double begin, double end, AnimationController controller,
      {curve = Curves.fastLinearToSlowEaseIn}) {
    return Tween(begin: begin, end: end)
        .animate(CurvedAnimation(curve: curve, parent: controller));
  }

  _addListeners(AnimationController controller) {
    controller.addListener(() {
      setState(() {});
    });
    controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controllerPink.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _bigCrow = getAsset(AppAssets.figures, 'purple_down.svg');
    });
    return UserStreamBuilder(
      builder: (context, userSnapshot) => Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/tabs');
                },
                icon: const Icon(Icons.arrow_back)),
          ),
          body: ListView(children: _buildListViewChildren(userSnapshot))),
    );
  }

  _buildListViewChildren(userSnapshot) {
    int? availableLevels = userSnapshot.data?.availableLevels;
    availableLevels != null
        ? Levels.updateAvailableLevels(availableLevels)
        : null;
    var _list = <Widget>[
      SizedBox(
          height: 250,
          width: double.infinity,
          child: Stack(children: [
            availableLevels != null
                ? _buildAnimation(_animationPink)
                : Container(),
            availableLevels != null
                ? AnnouncementCard(
                    headline2: 'Выбери уровень',
                    bodyText: availableLevels <= maxLevel
                        ? 'Доступно уровней: $availableLevels'
                        : 'Вы прошли все уровни!',
                    showCloseButton: false,
                  )
                : const AppLoading()
          ]))
    ];
    availableLevels != null
        ? _list.addAll(List.generate(maxLevel, (int n) => n + 1).map(
            (n) => AppTextButton(
              disabled: n <= availableLevels ? false : true,
              buttonText: 'уровень $n',
              type: AppTextButtonType.tertiary,
              onPressed: () {
                Navigator.pushNamed(context, '/level', arguments: {"id": n});
              },
            ),
          ))
        : null;
    return _list;
  }

  AnimatedBuilder _buildAnimation(anim) => AnimatedBuilder(
      animation: anim,
      builder: (ctx, ch) => Positioned(
          top: _animationPink?.value,
          right: 50,
          child: SvgPicture.asset(_bigCrow)));
}
