import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/pages/game_page/widgets/level_painters.dart';
import 'package:frontend/utils/types.dart';

class PassAnimation1 extends StatefulWidget {
  const PassAnimation1({Key? key}) : super(key: key);

  @override
  State<PassAnimation1> createState() => _PassAnimation1State();
}

class _PassAnimation1State extends State<PassAnimation1>
    with TickerProviderStateMixin {
  final String _img = getAsset(AppAssets.spinner);
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  late AnimationController _rotationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    _scaleController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true, min: 0.3);
    _scaleAnimation = CurvedAnimation(
      parent: _scaleController,
      curve: Curves.fastOutSlowIn,
    );
    _rotationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    _rotationAnimation = CurvedAnimation(
      parent: _rotationController,
      curve: Curves.fastOutSlowIn,
    );
    super.initState();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _rotationAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(200)),
              color: Theme.of(context).colorScheme.background,
              boxShadow: [
                BoxShadow(
                    blurRadius: 30,
                    color: Theme.of(context).colorScheme.primary)
              ]),
          padding: const EdgeInsets.all(30),
          height: 230,
          width: 230,
          child: SvgPicture.asset(_img),
        ),
      ),
    );
  }
}

class PassAnimation2 extends StatefulWidget {
  const PassAnimation2({Key? key}) : super(key: key);

  @override
  State<PassAnimation2> createState() => _PassAnimation2State();
}

class _PassAnimation2State extends State<PassAnimation2>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    _rotationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    _rotationAnimation = CurvedAnimation(
      parent: _rotationController,
      curve: Curves.fastOutSlowIn,
    );
    super.initState();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _rotationAnimation,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(200)),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
              ],
            ),
            boxShadow: [
              BoxShadow(
                  blurRadius: 30, color: Theme.of(context).colorScheme.primary)
            ]),
        height: 300,
        width: 300,
        child: Center(
            child: Text(
          'ура!',
          style: Theme.of(context)
              .textTheme
              .headline2!
              .apply(color: Theme.of(context).colorScheme.onPrimary),
        )),
      ),
    );
  }
}

class PassAnimation3 extends StatefulWidget {
  const PassAnimation3({Key? key}) : super(key: key);

  @override
  State<PassAnimation3> createState() => _PassAnimation3State();
}

class _PassAnimation3State extends State<PassAnimation3>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(3, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticIn,
    ));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SlideTransition(
        position: _animation,
        child: Container(
          height: 100,
          width: 200,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              border: Border.all(
                  width: 3, color: Theme.of(context).colorScheme.onBackground),
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              boxShadow: [
                BoxShadow(
                    blurRadius: 30,
                    color: Theme.of(context).colorScheme.primary)
              ]),
          child: Center(
              child: Text(
            'молодец',
            style: Theme.of(context)
                .textTheme
                .headline2!
                .apply(color: Theme.of(context).colorScheme.onBackground),
          )),
        ),
      ),
    );
  }
}

class PassAnimation4 extends StatefulWidget {
  const PassAnimation4({Key? key}) : super(key: key);

  @override
  State<PassAnimation4> createState() => _PassAnimation4State();
}

class _PassAnimation4State extends State<PassAnimation4>
    with TickerProviderStateMixin {
  late AnimationController _colorController;
  late Future<Animation<Color?>> _colorAnimation;
  late AnimationController _rotationController;
  late Animation<double> _rotationAnimation;
  Color _color = Colors.black;

  @override
  void initState() {
    _colorController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this)
          ..repeat(reverse: true);

    _colorAnimation = getColorTween();
    _rotationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    _rotationAnimation = CurvedAnimation(
      parent: _rotationController,
      curve: Curves.fastOutSlowIn,
    );
    super.initState();
  }

  Future<Animation<Color?>> getColorTween() {
    return Future.delayed(Duration.zero, () {
      return ColorTween(
              begin: Theme.of(context).colorScheme.primary,
              end: Theme.of(context).colorScheme.primary.withAlpha(0))
          .animate(_colorController)
        ..addListener(() {
          setState(() {});
        });
    });
  }

  @override
  void dispose() {
    _colorController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _colorAnimation.then((color) {
      setState(() {
        _color = color.value!;
      });
    });
    return RotationTransition(
      turns: _rotationAnimation,
      child: SizedBox(
        width: 300,
        height: 350,
        child: Stack(
          children: [
            Positioned(
              top: 25,
              right: 25,
              child: CustomPaint(
                  size: const Size(250, 225),
                  painter: TrianglePainter(
                      strokeColor: _color, paintingStyle: PaintingStyle.fill)),
            ),
            Center(
              child: Container(
                height: 140,
                width: 140,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: const BorderRadius.all(Radius.circular(100))),
                child: Center(
                  child: Text(
                    'хорошо!',
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .apply(color: Colors.white.withOpacity(0.8)),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
