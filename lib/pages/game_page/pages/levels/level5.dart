import 'package:flutter/material.dart';
import 'package:frontend/pages/game_page/utils/level_utils.dart';
import 'package:frontend/pages/game_page/widgets/level_title.dart';
import 'package:frontend/utils/indents.dart';
import 'package:frontend/widgets/text_buttons.dart';
import '../../widgets/level_painters.dart';
import 'package:frontend/utils/theme.dart';

class Level5 extends StatefulWidget {
  const Level5({Key? key}) : super(key: key);

  @override
  State<Level5> createState() => _Level5State();
}

class _Level5State extends State<Level5> with TickerProviderStateMixin {
  bool _isColorModeCorrect = false;
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward();
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (appTheme.currentColorModeNum == 3) {
      setState(() {
        _isColorModeCorrect = true;
      });
    }
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: 10, color: Theme.of(context).colorScheme.shadow)
            ],
            color: Colors.indigo[900],
          ),
          child: CustomPaint(
            size: const Size(double.infinity, double.infinity),
            painter: GlassPainter(
                strokeColor: Theme.of(context).colorScheme.surface),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LevelTitle(
                text: _isColorModeCorrect
                    ? 'Ночь... \nТрава зеленая, небо синее, все логично! '
                    : 'Ночь... \nПрирода, кажется, выглядит странно..',
                textColor: Colors.white),
            _isColorModeCorrect
                ? ScaleTransition(
                    scale: _animation,
                    child: Padding(
                      padding: AppIndents.bottom5,
                      child: AppTextButton(
                        buttonText: 'Пройти уровень',
                        type: AppTextButtonType.secondary,
                        onPressed: () {
                          LevelUtils.nextLevel(context);
                        },
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ],
    );
  }
}
