import 'dart:math';
import 'package:flutter/material.dart';
import 'package:frontend/pages/game_page/widgets/level_title.dart';
import 'package:frontend/widgets/text_buttons.dart';

import '../../utils/level_utils.dart';

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
    squareColors = getNewSquareColors(isFirst: true);
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

  List<Color> getNewSquareColors({bool isFirst = false}) {
    List<Color> _list = List.generate(4, (i) => i).map((i) {
      return Color(_random.nextInt(0xfffffff)).withOpacity(1.0);
    }).toList();
    if (isFirst) {
      _list = _list.map((c) => isRed(c) ? Colors.black : c).toList();
    }
    return _list;
  }

  bool isRed(Color color) =>
      color.red > 100 && color.green < 100 && color.blue < 100;

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
                LevelUtils.nextLevel(context);
              },
              size: AppTextButtonSize.medium,
              type: AppTextButtonType.custom,
              customBackgroundColor: Colors.red,
            ),
            duration: const Duration(milliseconds: 100),
            curve: Curves.fastOutSlowIn,
          ),
          LevelTitle(
              text: (isFakeButtonHidden == true && isPassButtonHidden == true)
                  ? 'Я потеряла кнопку \n"Пройти уровень".\nВы убили мой красный кубик.. \nСделайте что-нибудь!'
                  : (isFakeButtonHidden == true && isPassButtonHidden == false)
                      ? 'Ура ура это точно она!'
                      : 'Я потеряла кнопку \n"Пройти уровень".\nПомню только, что с ней \nкак-то связан красный цвет..'),
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
      return -50;
    } else {
      return _random
          .nextInt(MediaQuery.of(context).size.height ~/ 2)
          .toDouble();
    }
  }

  double _getRight() {
    if (levelProgress == 0) {
      return -100;
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
            bool _isRed = isRed(squareColors[i]);
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
