import 'dart:math';
import 'package:flutter/material.dart';
import 'package:frontend/utils/indents.dart';
import 'package:frontend/widgets/text_buttons.dart';

import '../utils/levels.dart';

class Level1 extends StatefulWidget {
  const Level1({Key? key}) : super(key: key);

  @override
  State<Level1> createState() => _Level1State();
}

class _Level1State extends State<Level1> with TickerProviderStateMixin {
  int levelProgress = 0;
  bool isPassButtonHidden = true;
  bool isFakeButtonHidden = false;
  bool isSquarePressed = false;
  final _random = Random();
  late List<Color> squareColors;
  late Animation<Color?> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    squareColors = getNewSquareColors();
    controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    animation =
        ColorTween(begin: Colors.red, end: Colors.black).animate(controller)
          ..addListener(() {
            setState(() {});
          });
  }

  void animateColor() {
    controller.forward();
  }

  List<Color> getNewSquareColors() => List.generate(4, (i) => i).map((i) {
        return Color(_random.nextInt(0xfffffff)).withOpacity(1.0);
      }).toList();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(children: [
          AnimatedPositioned(
            bottom: 20,
            right: isPassButtonHidden ? -300 : 20,
            child: AppTextButton(
              buttonText: 'Пройти уровень',
              onPressed: () {
                Levels().nextLevel(context);
              },
              size: AppTextButtonSize.medium,
              type: AppTextButtonType.custom,
              customBackgroundColor: Colors.red,
            ),
            duration: const Duration(milliseconds: 100),
            curve: Curves.fastOutSlowIn,
          ),
          Padding(
            padding: AppIndents.all15,
            child: Text(
              (isFakeButtonHidden == true && isPassButtonHidden == true)
                  ? 'Вам нужно найти кнопку \n"Пройти уровень".\nВы убили красный кубик.. Придумайте что-нибудь)'
                  : (isFakeButtonHidden == true && isPassButtonHidden == false)
                      ? 'Осталось только нажать..'
                      : 'Вам нужно найти кнопку \n"Пройти уровень".\nПоможет красный цвет',
              textAlign: TextAlign.left,
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .apply(color: Theme.of(context).colorScheme.onSecondary),
            ),
          ),
          _drawRowOfSquare(),
          AnimatedPositioned(
              width: _getWidth(),
              height: _getHeight(),
              top: _getTop(),
              right: isFakeButtonHidden ? -300 : _getRight(),
              duration: const Duration(milliseconds: 100),
              curve: Curves.fastOutSlowIn,
              child: AppTextButton(
                buttonText: levelProgress != 0 ? 'Пройти уровень' : '',
                onPressed: () {
                  setState(() {
                    levelProgress += 1;
                    squareColors = getNewSquareColors();
                  });
                },
                type: AppTextButtonType.custom,
                customBackgroundColor:
                    Color(_random.nextInt(0x00000ff0)).withOpacity(1.0),
              )),
        ]),
      ),
    );
  }

  double _getWidth() {
    if (levelProgress.isEven) {
      return 150;
    } else {
      return _random.nextInt(100) + 150;
    }
  }

  double _getHeight() {
    if (levelProgress.isEven) {
      return 100;
    } else {
      return _random.nextInt(30) + 100;
    }
  }

  double _getTop() {
    if (levelProgress == 0) {
      return -70;
    } else {
      return _random
          .nextInt(MediaQuery.of(context).size.height ~/ 2)
          .toDouble();
    }
  }

  double _getRight() {
    if (levelProgress == 0) {
      return -120;
    } else {
      return _random.nextInt(MediaQuery.of(context).size.width ~/ 2).toDouble();
    }
  }

  Center _drawRowOfSquare() => Center(
        child: SizedBox(
          width: 240,
          height: 60,
          child: Row(
              children: List.generate(4, (i) => i).map((i) {
            //Color _color = Color(_random.nextInt(0xfffffff)).withOpacity(1.0);
            bool _isRed = Color(squareColors[i].value).red > 100 &&
                Color(squareColors[i].value).green < 100 &&
                Color(squareColors[i].value).blue < 100;
            return Expanded(
              child: Container(
                color: _isRed ? animation.value : squareColors[i],
                child: _isRed
                    ? GestureDetector(
                        onTapDown: (e) {
                          animateColor();
                          isFakeButtonHidden = true;
                        },
                        onDoubleTap: () {
                          setState(() {
                            controller.reverse();
                            isFakeButtonHidden = true;
                            isPassButtonHidden = false;
                          });
                        },
                      )
                    : null,
                // child: _color.value,
              ),
            );
          }).toList()),
        ),
      );
}
