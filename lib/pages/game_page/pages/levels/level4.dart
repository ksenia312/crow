import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend/pages/game_page/utils/level_utils.dart';
import 'package:frontend/pages/game_page/widgets/level_title.dart';
import 'package:frontend/utils/indents.dart';
import 'package:frontend/widgets/text_buttons.dart';

import '../../widgets/curved_painter.dart';

class Level4 extends StatefulWidget {
  const Level4({Key? key}) : super(key: key);

  @override
  State<Level4> createState() => _Level4State();
}

class _Level4State extends State<Level4> {
  late Timer _timer;
  double _startFingerPosition = 0;
  double _buttonRight = -300;
  bool _isCurveDisabled = true;
  final List _steps = [
    CurvedPainterStep1(),
    CurvedPainterStep2(),
    CurvedPainterStep3()
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        LevelTitle(
            text: _isCurveDisabled
                ? 'Волна.. Включите ее, обожаю волны!'
                : 'Двигается..'),
        Expanded(
            child: GestureDetector(
          onHorizontalDragStart: (details) {
            setState(() {
              _startFingerPosition = details.localPosition.dx;
            });
          },
          onHorizontalDragUpdate: (details) {
            if (details.localPosition.dx < _startFingerPosition) {
              setState(() {
                _buttonRight = 15;
              });
            }
          },
          child: Container(
            color: Theme.of(context).colorScheme.background,
          ),
        )),
        SizedBox(
          width: double.infinity,
          height: 70,
          child: Stack(
            children: [
              AnimatedPositioned(
                child: AppTextButton(
                  buttonText:
                      !_isCurveDisabled ? 'Пройти уровень' : 'Включить волну',
                  size: AppTextButtonSize.medium,
                  onPressed: () {
                    if (!_isCurveDisabled) {
                      LevelUtils().nextLevel(context);
                    }
                    setState(() {
                      _isCurveDisabled = false;
                    });
                  },
                ),
                duration: const Duration(milliseconds: 500),
                right: _buttonRight,
              )
            ],
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
}
