import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/utils/assets_variables.dart';

class AppLoading extends StatefulWidget {
  final double height;

  const AppLoading({Key? key, this.height = 70.0}) : super(key: key);

  @override
  State<AppLoading> createState() => _AppLoadingState();
}

class _AppLoadingState extends State<AppLoading> with TickerProviderStateMixin {
  late String _pic;
  late AnimationController _controller;
  final Tween<double> turnsTween = Tween<double>(
    begin: 0,
    end: 1,
  );
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
    _addListeners(_controller);
    _controller.repeat();
  }

  _addListeners(AnimationController controller) {
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _pic = getAsset(AppAssets.loading);
    });
    return Center(child: _buildAnimation());
  }

  AnimatedBuilder _buildAnimation() => AnimatedBuilder(
      animation: _animation as Listenable,
      builder: (ctx, ch) => RotationTransition(
          turns: turnsTween.animate(_controller),
          child: SizedBox(
            height: widget.height,
            width: widget.height / 1.43,
            child: SvgPicture.asset(_pic),
          )));
}
