import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:frontend/pages/statistics_page/statistics_page.dart';
import 'package:frontend/utils/button_style.dart';
import 'package:frontend/utils/indents.dart';

class StatisticsCard extends StatefulWidget {
  final DateTime? startDate;

  const StatisticsCard({required this.startDate, Key? key}) : super(key: key);

  @override
  State<StatisticsCard> createState() => _StatisticsCardState();
}

class _StatisticsCardState extends State<StatisticsCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: AppIndents.all5ExceptBottom,
      elevation: 0,
      color: Theme.of(context).colorScheme.background,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: ElevatedButton(
            style: _statisticsButtonStyle(),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return StatisticsPage(startDate: widget.startDate);
                }),
              );
            },
            child: Stack(
                children: [_drawGridBackground(context), _drawText(context)])),
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
        rowSizes: [(150 / 3).px, (150 / 3).px, (150 / 3).px],
        columnGap: 5,
        rowGap: 5,
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

  Widget _drawText(context) => Positioned(
        child: Text(
          'Ваша статистика',
          style: TextStyle(shadows: [
            Shadow(
                offset: const Offset(2, 1),
                color: Theme.of(context).colorScheme.shadow,
                blurRadius: 15)
          ]),
        ),
        bottom: 20,
        left: 30,
      );
}
