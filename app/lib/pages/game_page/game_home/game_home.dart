import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/utils/assets_variables.dart';
import 'package:frontend/widgets/buttons.dart';
import 'package:frontend/widgets/cards/announcement_card.dart';

class GameHome extends StatefulWidget {
  const GameHome({Key? key}) : super(key: key);

  @override
  State<GameHome> createState() => _GameHomeState();
}

class _GameHomeState extends State<GameHome> with TickerProviderStateMixin {
  final String _pinkFigure =
      getAsset(AppAssets.figures, 'purple_face_large_down.svg');
  late AnimationController _controllerPink;
  Animation<double>? _animationPink;

  @override
  void initState() {
    super.initState();
    _controllerPink = _initializeController();
    _animationPink = _initializeAnimation(100.0, 30.0, _controllerPink);
    _addListeners(_controllerPink);
    _controllerPink.forward();
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
    return Scaffold(
        appBar: AppBar(), body: ListView(children: _buildListViewChildren()));
  }

  _buildListViewChildren() {
    var _list = <Widget>[
      SizedBox(
          height: 250,
          width: double.infinity,
          child: Stack(children: [
            _buildAnimation(_animationPink),
            const AnnouncementCard(
              headline2: 'Выбери уровень',
              bodyText: 'Вам доступно 3 уровня',
              showCloseButton: false,
            )
          ]))
    ];

    _list.addAll(List.generate(12, (int n) => n + 1).map(
      (n) => AppTextButton(
        buttonText: 'уровень $n',
        type: AppTextButtonType.tertiary,
        onPressed: () {
          Navigator.pushNamed(context, '/level', arguments: {"id": n - 1});
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
          child: SvgPicture.asset(_pinkFigure)));
}
