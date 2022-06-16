import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:frontend/utils/indents.dart';
import 'package:frontend/widgets/text_buttons.dart';

import '../../utils/level_utils.dart';
import '../../widgets/spinner.dart';

class Level2 extends StatefulWidget {
  const Level2({Key? key}) : super(key: key);

  @override
  State<Level2> createState() => _Level2State();
}

class _Level2State extends State<Level2> with TickerProviderStateMixin {
  double _scaleTopRight = 1.0;
  double _scaleBottomRight = 1.0;
  bool _stopRight = false;
  bool _hiddenLeft = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: AppIndents.all15,
            child: Text(
              _hiddenLeft & _stopRight
                  ? 'Ой, исчезли \nЛадно, так тоже можно!!'
                  : 'Крутятся.. \nСделайте так, чтобы \nвсе спиннеры на экране \nбыли остановлены',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .apply(color: Theme.of(context).colorScheme.onSecondary),
            ),
          ),
          LayoutGrid(
            columnSizes: [
              (1).fr,
              (1).fr,
            ],
            rowSizes: [
              (150).px,
              (150).px,
            ],
            columnGap: 10,
            rowGap: 10,
            children: List.generate(4, (index) => index)
                .map((index) => index == 1 || index == 3
                    ? _drawScaleSpinner(index: index)
                    : !_hiddenLeft
                        ? const Spinner(
                            size: 100,
                            color: SpinnerColors.red,
                          )
                        : Container())
                .toList(),
          ),
          if (_hiddenLeft & _stopRight)
            AppTextButton(
              buttonText: 'Пройти уровень',
              onPressed: () {
                LevelUtils().nextLevel(context);
              },
              size: AppTextButtonSize.medium,
              type: AppTextButtonType.custom,
              customBackgroundColor: Colors.green,
            ),
        ],
      ),
    );
  }

  Widget _drawScaleSpinner({index}) => GestureDetector(
      onScaleUpdate: (details) {
        var _scale = details.scale;
        setState(() {
          if (index == 1) {
            _scaleTopRight = _scale;
          } else {
            _scaleBottomRight = _scale;
          }
          if (_scaleTopRight > 3.0) {
            _stopRight = true;
          }
          if (_scaleBottomRight > 3.0) {
            _hiddenLeft = true;
          }
          //_controller.forward();
        });
      },
      child: Transform.scale(
          scale: index == 1 ? _scaleTopRight : _scaleBottomRight,
          child: Spinner(
            size: 100,
            stop: _stopRight,
            color: _stopRight ? SpinnerColors.green : SpinnerColors.red,
          )));
}
