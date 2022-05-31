import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/pages/game_page/game_home/game_home.dart';
import 'package:frontend/utils/assets_variables.dart';
import 'package:frontend/widgets/text_buttons.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with TickerProviderStateMixin {
  late String _smallCrow;
  late String _bigCrow;
  late AnimationController _controllerPink;
  late AnimationController _controllerPurple;
  Animation<double>? _animationPink;
  Animation<double>? _animationPurple;

  @override
  void initState() {
    super.initState();

    _controllerPink = _initializeController();
    _controllerPurple = _initializeController();

    _animationPink = _initializeAnimation(50.0, 25.0, _controllerPink);
    _animationPurple = _initializeAnimation(25.0, 0.0, _controllerPurple,
        curve: Curves.easeInCubic);

    _addListeners(_controllerPink);
    _addListeners(_controllerPurple);
    _controllerPink.forward();
    _controllerPurple.forward();
  }

  _initializeController() {
    return AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
  }

  _initializeAnimation(double begin, double end, AnimationController controller,
      {curve = Curves.elasticIn}) {
    return Tween(begin: begin, end: end)
        .animate(CurvedAnimation(curve: curve, parent: controller));
  }

  _awaitForwardController(AnimationController controller, int mc) async {
    await Future.delayed(Duration(milliseconds: mc));
    if (mounted) controller.forward();
  }

  _addListeners(AnimationController controller) {
    controller.addListener(() {
      setState(() {});
    });
    controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _awaitForwardController(controller, 3000);
      }
    });
  }

  @override
  void dispose() {
    _controllerPink.dispose();
    _controllerPurple.dispose();
    super.dispose();
  }

  onPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return const GameHome();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _smallCrow = getAsset(AppAssets.figures, 'pink_up.svg');
      _bigCrow = getAsset(AppAssets.figures, 'purple_up.svg');
    });
    return SizedBox(
        height: 350,
        width: 200,
        child: LayoutBuilder(builder: (context, BoxConstraints constraints) {
          return Stack(
            alignment: Alignment.center,
            children: [
              _buildAnimation(
                  _animationPurple!, constraints.maxWidth - 180, _bigCrow),
              _buildAnimation(
                  _animationPink!, constraints.maxWidth - 105, _smallCrow),
              AppTextButton(
                  buttonText: 'Играть',
                  type: AppTextButtonType.primary,
                  size: AppTextButtonSize.medium,
                  onPressed: onPressed),
            ],
          );
        }));
  }

  AnimatedBuilder _buildAnimation(
          Animation _animation, double right, String figure) =>
      AnimatedBuilder(
          animation: _animation,
          builder: (ctx, ch) => Positioned(
              top: _animation.value,
              right: right,
              child: SvgPicture.asset(figure)));
}
