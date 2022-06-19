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
  final Map<String, bool> _wrapSuffix = {
    'month': true,
    "day": true,
    "hour": true,
    "minute": true
  };

  _setNoWrapping(String duration) {
    setState(() {
      _wrapSuffix[duration] = false;
    });
  }

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
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .apply(color: Theme.of(context).colorScheme.onBackground)),
            Padding(
              padding: AppIndents.vertical10Horizontal20,
              child: LayoutGrid(
                  gridFit: GridFit.expand,
                  columnSizes: [3.fr, 1.fr, 3.fr],
                  rowSizes: [
                    (90).px,
                    (30).px,
                    (90).px,
                    (30).px,
                  ],
                  columnGap: 5,
                  rowGap: 5,
                  children: [
                    _drawDateBlock(
                        isOutline: false,
                        value: wrapNumValue(months, 'month'),
                        unit: _wrapSuffix['month'] == true
                            ? countSuffixWrapper(
                                count: months,
                                variants: ['месяцев', "месяц", "месяца"])
                            : 'месяцев'),
                    _drawOrBlock(),
                    _drawDateBlock(
                        isOutline: true,
                        value: wrapNumValue(days, 'day'),
                        unit: _wrapSuffix['day'] == true
                            ? countSuffixWrapper(
                                count: days, variants: ['дней', "день", "дня"])
                            : 'дней'),
                    _drawOrBlock(),
                    Container(),
                    _drawOrBlock(),
                    _drawDateBlock(
                        isOutline: true,
                        value: wrapNumValue(hours, 'hour'),
                        unit: _wrapSuffix['hour'] == true
                            ? countSuffixWrapper(
                                count: hours,
                                variants: ['часов', "час", "часа"])
                            : 'часов'),
                    _drawOrBlock(),
                    _drawDateBlock(
                        isOutline: false,
                        value: wrapNumValue(minutes, 'minute'),
                        unit: _wrapSuffix['minute'] == true
                            ? countSuffixWrapper(
                                count: minutes,
                                variants: ['минут', "минуту", "минуты"])
                            : 'минут'),
                    _drawOrBlock(),
                    Container(),
                    _drawOrBlock(),
                  ]),
            ),
            _drawLargeDateBlock(
                isOutline: false,
                value: '${difference.inSeconds}',
                unit: countSuffixWrapper(
                    count: difference.inSeconds,
                    variants: ['секунд', "секунду", "секунды"])),
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

  String wrapNumValue(int value, String duration) {
    if (value > 99999) {
      _setNoWrapping(duration);
      if (value.toString().length > 9) {
        return (value ~/ 1000000000).toString() + "B";
      } else if (value.toString().length > 6) {
        return (value ~/ 1000000).toString() + "M";
      } else if (value.toString().length > 3) {
        return (value ~/ 1000).toString() + "К";
      } else {
        return value.toString();
      }
    } else {
      return value.toString();
    }
  }

  Center _drawOrBlock() => Center(
        child: Text(
          'или',
          style: Theme.of(context).textTheme.headline2!.copyWith(
              fontWeight: FontWeight.w900,
              color: Theme.of(context).colorScheme.onBackground),
        ),
      );

  _drawDateBlock({
    required bool isOutline,
    required String value,
    required String? unit,
  }) {
    Color onBackground = Theme.of(context).colorScheme.onBackground;
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
                      .apply(color: isOutline ? onBackground : background)),
              unit != null
                  ? Text(unit,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .apply(color: isOutline ? onBackground : background))
                  : Container()
            ],
          ),
        ),
        decoration: isOutline
            ? BoxDecoration(border: Border.all(color: onBackground, width: 3))
            : BoxDecoration(color: onBackground));
  }

  Padding _drawLargeDateBlock({
    required bool isOutline,
    required String value,
    required String? unit,
    double height = 135,
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
                  .apply(color: Theme.of(context).colorScheme.onBackground)),
        ),
      );
}
