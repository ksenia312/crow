import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:frontend/utils/button_style.dart';
import 'package:frontend/utils/indents.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: AppIndents.basicMargin,
      elevation: 0,
      color: Theme.of(context).colorScheme.background,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: ElevatedButton(
            style: _statisticsButtonStyle(),
            onPressed: () {
              Navigator.pushNamed(context, '/statistics');
            },
            child:
                Stack(children: [_drawGridBackground(context), _drawText()])),
      ),
    );
  }

  ButtonStyle _statisticsButtonStyle() => ButtonStyle(
        backgroundColor: overrideButtonStyle<Color>(
            Theme.of(context).colorScheme.background),
        foregroundColor: overrideButtonStyle<Color>(
            Theme.of(context).colorScheme.onBackground),
      );

  _drawGridBackground(context) => LayoutGrid(
        areas: '''
          box1 box1 box4
          box2 box3 box4
          box2 box3 box5
        ''',
        columnSizes: [1.fr, 1.fr, 1.fr],
        rowSizes: [(200 / 3).px, (200 / 3).px, (200 / 3).px],
        columnGap: 10,
        rowGap: 10,
        children: _drawBackgroundBoxes(context),
      );

  _drawBackgroundBoxes(context) {
    return List.generate(5, (int n) => n + 1)
        .map((n) => Container(
              child: null,
              color: Theme.of(context).colorScheme.primary,
            ).inGridArea('box' + n.toString()))
        .toList();
  }

  Widget _drawText() => const Positioned(
        child: Text('Ваша статистика'),
        bottom: 30,
        left: 30,
      );
}
