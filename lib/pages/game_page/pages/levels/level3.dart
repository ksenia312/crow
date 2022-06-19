import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/pages/game_page/widgets/level_title.dart';
import 'package:frontend/widgets/text_buttons.dart';

import '../../utils/level_utils.dart';

class Level3 extends StatefulWidget {
  const Level3({Key? key}) : super(key: key);

  @override
  State<Level3> createState() => _Level3State();
}

class _Level3State extends State<Level3> {
  String _value = '21';
  bool _pressed = false;
  bool _disabled = false;
  bool _showPassButton = false;
  int _counter = 0;
  final _random = Random();
  late Color _buttonColor;

  @override
  void initState() {
    _buttonColor = Color(_random.nextInt(0xffffffff)).withOpacity(1.0);
    super.initState();
  }

  void setValue(value) {
    setState(() {
      _value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_counter.toString() == _value.trim()) {
      _showPassButton = true;
    } else {
      _showPassButton = false;
    }
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            const LevelTitle(
              text: 'Нажмите на кнопку',
              padding: false,
            ),
            SizedBox(
              width: 90,
              child: TextFormField(
                initialValue: '21',
                onChanged: (value) {
                  setValue(value);
                },
                style: Theme.of(context).textTheme.headline2!.apply(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixText: 'раз',
                  suffixStyle: Theme.of(context)
                      .textTheme
                      .headline2!
                      .apply(color: Theme.of(context).colorScheme.onBackground),
                  fillColor: Theme.of(context).colorScheme.background,
                  filled: true,
                ),
                cursorColor: Theme.of(context).colorScheme.onBackground,
              ),
            )
          ]),
          Text(
            'Нажато: $_counter',
            style: Theme.of(context)
                .textTheme
                .headline1!
                .apply(color: Theme.of(context).colorScheme.onBackground),
          ),
          _showPassButton
              ? AppTextButton(
                  buttonText: 'Пройти уровень',
                  onPressed: () {
                    LevelUtils().nextLevel(context);
                  },
                  size: AppTextButtonSize.medium,
                  type: AppTextButtonType.custom,
                  customBackgroundColor: Colors.blue,
                )
              : Padding(
                  padding: EdgeInsets.symmetric(vertical: _pressed ? 10 : 0),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 10),
                    child: GestureDetector(
                      onTapDown: (v) {
                        setState(() {
                          if (!_disabled) {
                            _pressed = true;
                          }
                        });
                      },
                      onTapUp: (v) {
                        setState(() {
                          if (!_disabled) {
                            _pressed = false;
                          }
                        });
                      },
                      onTap: () {
                        setState(() {
                          if (!_disabled) {
                            _counter++;
                          }
                          if (_counter == 20) {
                            _disabled = true;
                          }
                        });
                      },
                      child: Container(
                        height: _pressed ? 180 : 200,
                        width: _pressed ? 180 : 200,
                        decoration: BoxDecoration(
                            color: _pressed
                                ? _buttonColor.withOpacity(0.8)
                                : _buttonColor,
                            boxShadow: [
                              _pressed
                                  ? BoxShadow(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background)
                                  : BoxShadow(
                                      blurRadius: 10,
                                      color:
                                          Theme.of(context).colorScheme.shadow)
                            ],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(100))),
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
