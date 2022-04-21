import 'package:flutter/material.dart';

class AppListTile extends StatelessWidget {
  final String headline2;
  final String bodyText;
  final Color textColor;
  final Color color;
  final double height;

  const AppListTile(
      {Key? key,
      required this.headline2,
      required this.bodyText,
      this.textColor = const Color(0xBF000000),
      this.color = const Color(0xFFF4F4F4),
        this.height=120,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      color: color,
      child: Center(
        child: ListTile(
          title: Text(
            headline2,
            style: Theme.of(context).textTheme.headline2?.apply(
                  color: textColor,
                ),
            textAlign: TextAlign.start,
            softWrap: true,
            overflow: TextOverflow.fade,
          ),
          subtitle: Text(
            bodyText,
            style: Theme.of(context).textTheme.bodyText1?.apply(color: textColor),
            softWrap: true,
            overflow: TextOverflow.fade,
          ),
        ),
      ),
    );
  }
}
