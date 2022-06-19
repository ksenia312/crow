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
    setState(() {
      if (_counter.toString() == _value.trim()) {
        _showPassButton = true;
      } else {
        _showPassButton = false;
      }
    });
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          LevelTitle(
            text: _showPassButton
                ? 'Ушла.. Гордая!'
                : _counter == 20
                    ? 'Что-то не так.. Как сложно выполнить желание этой женщины..'
                    : 'Какая красивая кнопочка. Интересно, что произойдет, если мы выполним ее желание',
            textAlign: TextAlign.center,
            padding: false,
          ),
          Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            _showPassButton
                ? const LevelTitle(
                    text: ' - Я устала, и я ухожу!',
                    textAlign: TextAlign.right,
                    padding: false)
                : _drawTextField(),
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
                : _drawMainButton()
          ]),
          Text(
            'Нажато: $_counter',
            style: Theme.of(context)
                .textTheme
                .headline1!
                .apply(color: Theme.of(context).colorScheme.onBackground),
          ),
        ],
      ),
    );
  }

  _drawTextField() => SizedBox(
        width: 240,
        child: TextFormField(
          initialValue: _value,
          onChanged: (value) {
            setValue(value);
          },
          style: Theme.of(context).textTheme.headline2!.apply(
                color: Theme.of(context).colorScheme.onBackground,
              ),
          decoration: InputDecoration(
            border:  InputBorder.none,
            prefixText: '- Нажми на меня ',
            prefixStyle:Theme.of(context)
                .textTheme
                .headline2!
                .apply(color: Theme.of(context).colorScheme.onBackground),
            suffixText: 'раз',
            suffixStyle: Theme.of(context)
                .textTheme
                .headline2!
                .apply(color: Theme.of(context).colorScheme.onBackground),
          ),
          cursorColor: Theme.of(context).colorScheme.onBackground,
        ),
      );

  _drawMainButton() => Padding(
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
                  color:
                      _pressed ? _buttonColor.withOpacity(0.8) : _buttonColor,
                  boxShadow: [
                    _pressed
                        ? BoxShadow(
                            color: Theme.of(context).colorScheme.background)
                        : BoxShadow(
                            blurRadius: 10,
                            color: Theme.of(context).colorScheme.shadow)
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(100))),
            ),
          ),
        ),
      );
}
