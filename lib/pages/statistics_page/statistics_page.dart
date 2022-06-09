import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:frontend/utils/count_wrapper.dart';
import 'package:frontend/utils/indents.dart';
import 'package:frontend/widgets/app_bar_children.dart';
import 'package:frontend/widgets/cards/announcement_card.dart';

class StatisticsPage extends StatefulWidget {
  final DateTime? startDate;

  const StatisticsPage({required this.startDate, Key? key}) : super(key: key);

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color onSecondary = Theme.of(context).colorScheme.onSecondary;
    TextStyle headline1 = Theme.of(context).textTheme.headline1!;
    DateTime now = DateTime.now();
    Duration difference = now.difference(widget.startDate!);
    int months = (difference.inDays / 30).round();
    int days = difference.inDays;
    int hours = difference.inHours;
    int minutes = difference.inMinutes;
    return Scaffold(
        appBar: AppBar(
          title: const AppBarTitle(text: 'Статистика'),
          leading: AppBarLeading(iconBack: true),
        ),
        body: ListView(
          children: [
            const AnnouncementCard(
                headline2: 'Уникальные параметры вашей активности',
                bodyText: null,
                showCloseButton: false),
            Text('Вы с нами',
                textAlign: TextAlign.center,
                style: headline1.apply(color: onSecondary)),
            Padding(
              padding: AppIndents.vertical10Horizontal20,
              child: LayoutGrid(
                  gridFit: GridFit.expand,
                  columnSizes: [3.fr, 1.fr, 3.fr],
                  rowSizes: [
                    (90).px,
                    (45).px,
                    (90).px,
                    (45).px,
                  ],
                  columnGap: 5,
                  rowGap: 5,
                  children: [
                    _drawDateBlock(
                        isOutline: false,
                        value: '$months',
                        unit: countWrapper(
                            count: months,
                            variants: ['месяцев', "месяц", "месяца"])),
                    _drawOrBlock(),
                    _drawDateBlock(
                        isOutline: true,
                        value: '$days',
                        unit: countWrapper(
                            count: days, variants: ['дней', "день", "дня"])),
                    _drawOrBlock(),
                    Container(),
                    _drawOrBlock(),
                    _drawDateBlock(
                        isOutline: true,
                        value: '$hours',
                        unit: countWrapper(
                            count: hours, variants: ['часов', "час", "часа"])),
                    _drawOrBlock(),
                    _drawDateBlock(
                        isOutline: false,
                        value: '$minutes',
                        unit: countWrapper(
                            count: minutes,
                            variants: ['минут', "минута", "минуты"])),
                    _drawOrBlock(),
                    Container(),
                    _drawOrBlock(),
                  ]),
            ),
            _drawLargeDateBlock(
                isOutline: false,
                value: '${difference.inSeconds}',
                unit: countWrapper(
                    count: difference.inSeconds,
                    variants: ['секунд', "секунда", "секунды"])),
            _drawHeadline2(text: 'Вы зарегистрировались ↓'),
            _drawLargeDateBlock(
                isOutline: true,
                value: wrapDateDay(widget.startDate!) +
                    wrapDateMonth(widget.startDate!) +
                    '${widget.startDate!.year}',
                unit: null,
                height: 70),
            _drawHeadline2(text: 'Сегодня ↓'),
            _drawLargeDateBlock(
                isOutline: false,
                value: wrapDateDay(now) + wrapDateMonth(now) + '${now.year}',
                unit: 'Такой день бывает \n раз в жизни!!',
                height: 130),
          ],
        ));
  }

  String wrapDateDay(DateTime dateTime) {
    return '${dateTime.day < 10 ? '0' : ''}${dateTime.day}.';
  }

  String wrapDateMonth(DateTime dateTime) {
    return '${dateTime.month < 10 ? '0' : ''}${dateTime.month}.';
  }

  Center _drawOrBlock() => Center(
        child: Text(
          'или',
          style: Theme.of(context)
              .textTheme
              .headline2!
              .copyWith(fontWeight: FontWeight.w900),
        ),
      );

  _drawDateBlock({
    required bool isOutline,
    required String value,
    required String? unit,
  }) {
    Color onSecondary = Theme.of(context).colorScheme.onSecondary;
    Color background = Theme.of(context).colorScheme.background;
    return Container(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(value,
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .apply(color: isOutline ? onSecondary : background)),
              unit != null
                  ? Text(unit,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .apply(color: isOutline ? onSecondary : background))
                  : Container()
            ],
          ),
        ),
        decoration: isOutline
            ? BoxDecoration(border: Border.all(color: onSecondary, width: 3))
            : BoxDecoration(color: onSecondary));
  }

  Padding _drawLargeDateBlock({
    required bool isOutline,
    required String value,
    required String? unit,
    double height = 200,
  }) =>
      Padding(
        padding: AppIndents.horizontal20,
        child: SizedBox(
          height: height,
          width: double.infinity,
          child: Center(
              child: _drawDateBlock(
                  isOutline: isOutline, value: value, unit: unit)),
        ),
      );

  SizedBox _drawHeadline2({required String text}) => SizedBox(
        height: 60,
        child: Center(
          child: Text(text,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .apply(color: Theme.of(context).colorScheme.onSecondary)),
        ),
      );
}
