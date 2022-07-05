import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/pages/game_page/widgets/level_introduction_dialog.dart';
import 'package:frontend/services/user/user_stream_builder.dart';
import 'package:frontend/utils/assets_variables.dart';
import 'package:frontend/widgets/statuses/dialog.dart';
import 'package:frontend/widgets/statuses/loading.dart';
import 'package:frontend/widgets/text_buttons.dart';
import 'package:frontend/widgets/cards/announcement_card.dart';

import '../utils/level_utils.dart';

class LevelsPreviewPage extends StatefulWidget {
  const LevelsPreviewPage({Key? key}) : super(key: key);

  @override
  State<LevelsPreviewPage> createState() => _LevelsPreviewPageState();
}

class _LevelsPreviewPageState extends State<LevelsPreviewPage>
    with TickerProviderStateMixin {
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
    levels = LevelUtils.levels;
    maxLevel = LevelUtils.maxLevel;
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
      builder: (context, AsyncSnapshot<UserModel?> userSnapshot) => Scaffold(
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

  _buildListViewChildren(AsyncSnapshot<UserModel?> userSnapshot) {
    int availableLevels = userSnapshot.data?.availableLevels ?? 1;
    LevelUtils.updateAvailableLevels(availableLevels);
    var _list = <Widget>[
      SizedBox(
          height: 250,
          width: double.infinity,
          child: Stack(children: [
            userSnapshot.hasData
                ? _buildAnimation(_animationPink)
                : Container(),
            userSnapshot.hasData
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
    _list.addAll(List.generate(maxLevel, (int n) => n + 1).map(
      (n) => AppTextButton(
        disabled: n <= availableLevels ? false : true,
        buttonText: 'уровень $n',
        type: AppTextButtonType.tertiary,
        onPressed: () {
          if (availableLevels == 1) {
            AppDialog.showCustomDialog(context,
                child: const LevelIntroductionDialog());
          }
          Navigator.pushNamed(context, '/level', arguments: {"id": n});
        },
      ),
    ));
    return _list;
  }

  AnimatedBuilder _buildAnimation(anim) => AnimatedBuilder(
      animation: anim,
      builder: (ctx, ch) => Positioned(
          top: _animationPink?.value,
          right: 50,
          child: SvgPicture.asset(_bigCrow)));
}
