import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:frontend/pages/game_page/widgets/level_title.dart';
import 'package:frontend/widgets/text_buttons.dart';

import '../../utils/level_utils.dart';
import '../../widgets/level_spinner.dart';

class Level2 extends StatefulWidget {
  const Level2({Key? key}) : super(key: key);

  @override
  State<Level2> createState() => _Level2State();
}

class _Level2State extends State<Level2> with TickerProviderStateMixin {
  double _scaleTopRight = 1.0;
  double _scaleBottomRight = 1.0;
  bool _stopRight = false;
  bool _isLeftHidden = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          LevelTitle(
              textAlign: TextAlign.center,
              text: _isLeftHidden & _stopRight
                  ? 'О, теперь отлично видно! Спасибо!'
                  : _isLeftHidden
                      ? 'Мы потеряли два спиннера.. \nНу ладно, давайте хоть эти рассмотрим'
                      : _stopRight
                          ? 'Какие-то сломанные.. Мы трогали один, а остановилось два'
                          : 'Какие маленькие.. \nи крутятся… Хочется увидеть \nспиннеры получше, давайте \nувеличим их и остановим.'),
          LayoutGrid(
            gridFit: GridFit.expand,
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
                    : !_isLeftHidden
                        ? const SizedBox(
                            height: 150,
                            width: double.infinity,
                            child: Center(
                              child: LevelSpinner(
                                size: 30,
                                color: SpinnerColors.red,
                              ),
                            ),
                          )
                        : Container())
                .toList(),
          ),
          if (_isLeftHidden & _stopRight)
            AppTextButton(
              buttonText: 'Пройти уровень',
              onPressed: () {
                LevelUtils.nextLevel(context);
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
            _isLeftHidden = true;
          }
          //_controller.forward();
        });
      },
      child: Container(
        height: 150,
        width: double.infinity,
        color: Colors.transparent,
        child: Center(
          child: Transform.scale(
              scale: index == 1 ? _scaleTopRight : _scaleBottomRight,
              child: LevelSpinner(
                size: 30,
                stop: _stopRight,
                color: _stopRight ? SpinnerColors.green : SpinnerColors.red,
              )),
        ),
      ));
}
