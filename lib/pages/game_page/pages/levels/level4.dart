import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend/pages/game_page/utils/level_utils.dart';
import 'package:frontend/pages/game_page/widgets/level_title.dart';
import 'package:frontend/utils/styles.dart';
import 'package:frontend/widgets/text_buttons.dart';

import '../../widgets/level_painters.dart';

class Level4 extends StatefulWidget {
  const Level4({Key? key}) : super(key: key);

  @override
  State<Level4> createState() => _Level4State();
}

class _Level4State extends State<Level4> {
  late Timer _timer;
  bool _isCurveDisabled = true;
  bool _isButtonHidden = true;
  List<bool> isPartHidden = List.generate(6, (index) => true);
  final List _steps = [
    FirstStepWavePainter(),
    SecondStepWavePainter(),
    ThirdStepWavePainter()
  ];
  int _step = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 500), (_) {
      if (!_isCurveDisabled) {
        setState(() {
          _step == 2 ? _step = 0 : _step++;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isPartHidden.every((e) => e == false)) {
      setState(() {
        _isButtonHidden = false;
      });
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        LevelTitle(
            text: _isCurveDisabled
                ? 'Волна.. Включите ее, обожаю волны!'
                : 'Двигается..'),
        _isCurveDisabled
            ? _drawTurnOnButton()
            : Padding(
                padding: AppIndents.all15,
                child: AppTextButton(
                  buttonText: 'Пройти уровень',
                  onPressed: () {
                    LevelUtils.nextLevel(context);
                  },
                ),
              ),
        Container(
          margin: AppIndents.all15,
          decoration: BoxDecoration(
            boxShadow: const [BoxShadow(blurRadius: 5)],
            color: Theme.of(context).colorScheme.tertiary,
          ),
          child: AnimatedSwitcher(
            switchInCurve: Curves.ease,
            duration: const Duration(milliseconds: 500),
            child: CustomPaint(
              key: ValueKey<int>(_step),
              size: const Size(double.infinity, 300),
              painter: _steps[_step],
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _customPaints() => List.generate(
      6,
      (index) => CustomPaint(
          size: const Size(300, 100),
          painter: Level4PassButtonPainter(
              paintingStyle: PaintingStyle.fill,
              strokeColor: isPartHidden[index]
                  ? Colors.transparent
                  : Theme.of(context)
                      .colorScheme
                      .secondary
                      .withOpacity(index / 10 + 0.1),
              part: index))).toList();

  Positioned _turnOnButtonText() => Positioned(
      top: 35,
      right: 70,
      child: Text(
        'Включить волну',
        style: Theme.of(context).textTheme.headline2!.apply(
            color: _isButtonHidden
                ? Colors.transparent
                : Theme.of(context).colorScheme.onPrimary),
      ));

  Container _gestureDetector() => Container(
        height: 100,
        color: Colors.transparent,
        child: GestureDetector(
          onTap: () {
            if (!_isButtonHidden) {
              setState(() {
                _isCurveDisabled = false;
              });
            }
          },
          onPanUpdate: (details) {
            double xPos = details.localPosition.dx;
            double yPos = details.localPosition.dy;
            double width = 300;
            double height = 100;
            if (xPos > 0 && yPos > 0 && xPos < width && yPos < height) {
              if (xPos < width / 3) {
                setState(() {
                  isPartHidden[xPos < yPos ? 0 : 1] = false;
                });
              } else if (xPos < 2 * width / 3 && xPos > width / 3) {
                setState(() {
                  isPartHidden[xPos - width / 3 < yPos ? 2 : 3] = false;
                });
              } else {
                setState(() {
                  isPartHidden[xPos - 2 * width / 3 < yPos ? 4 : 5] = false;
                });
              }
            }
          },
        ),
      );

  Container _drawTurnOnButton() {
    List<Widget> blocks = [];
    blocks += _customPaints();
    blocks += [_turnOnButtonText(), _gestureDetector()];
    return Container(
        margin: AppIndents.all15,
        width: 300,
        decoration: _isButtonHidden
            ? null
            : const BoxDecoration(
                boxShadow: [BoxShadow(blurRadius: 10)],
                color: Colors.deepPurple,
              ),
        child: Stack(children: blocks));
  }
}
