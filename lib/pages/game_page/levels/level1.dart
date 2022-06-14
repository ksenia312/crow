import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:frontend/utils/indents.dart';

import '../utils/levels.dart';

class Level1 extends StatefulWidget {
  const Level1({Key? key}) : super(key: key);

  @override
  State<Level1> createState() => _Level1State();
}

class _Level1State extends State<Level1> {
  int levelProgress = 0;
  final _random = Random();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(children: [
          Padding(
            padding: AppIndents.all15,
            child: Text(
              'Поможет цвет крови',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .apply(color: Theme.of(context).colorScheme.onBackground),
            ),
          ),
          _drawRowOfSquare(),
          AnimatedPositioned(
              width: _getWidth(),
              height: _getHeight(),
              top: _getTop(),
              right: _getRight(),
              duration: const Duration(milliseconds: 100),
              curve: Curves.fastOutSlowIn,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    levelProgress += 1;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color:
                          Color(_random.nextInt(0x00000ff0)).withOpacity(1.0),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                            color: Theme.of(context).colorScheme.shadow)
                      ]),
                  child: Center(
                      child: Text(
                    levelProgress != 0 ? 'Пройти уровень' : '',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .apply(color: Theme.of(context).colorScheme.onPrimary),
                  )),
                ),
              )),
        ]),
      ),
    );
  }

  double _getWidth() {
    if (levelProgress.isEven) {
      return 100;
    } else {
      return _random.nextInt(50) + 100;
    }
  }

  double _getHeight() {
    if (levelProgress.isEven) {
      return 100;
    } else {
      return _random.nextInt(50) + 100;
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
      return -50;
    } else {
      return _random.nextInt(MediaQuery.of(context).size.width ~/ 2).toDouble();
    }
  }

  Center _drawRowOfSquare() => Center(
        child: SizedBox(
          width: 240,
          height: 60,
          child: Row(
              children: List.generate(4, (i) => i).map((e) {
            Color _color = Color(_random.nextInt(0xfffffff)).withOpacity(1.0);
            bool _isRed = Color(_color.value).red > 100 &&
                Color(_color.value).green < 100 &&
                Color(_color.value).blue < 100;
            return Expanded(
              child: Container(
                color: _color,
                child: _isRed
                    ? GestureDetector(
                        onLongPress: () {
                          Levels().nextLevel(context);
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
