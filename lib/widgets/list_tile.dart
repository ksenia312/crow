import 'package:flutter/material.dart';

class AppListTile extends StatelessWidget {
  final String? headline2;
  final String? bodyText;
  final Color textColor;
  final Color? color;
  final double? height;
  final double padding;
  final bool softWrap;
  final TextOverflow overflow;
  final Widget? trailing;

  const AppListTile(
      {Key? key,
      required this.headline2,
      required this.bodyText,
      required this.textColor,
      this.color,
      this.height,
      this.softWrap = true,
      this.overflow = TextOverflow.fade,
      this.padding = 0.0,
      this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: color,
      padding: EdgeInsets.all(padding),
      child: Center(
        child: ListTile(
          title: headline2 != null
              ? _drawListTileText(
                  context, headline2, Theme.of(context).textTheme.subtitle1!)
              : null,
          subtitle: bodyText != null
              ? _drawListTileText(
                  context, bodyText, Theme.of(context).textTheme.bodyText1!)
              : null,
          trailing: trailing,
        ),
      ),
    );
  }

  Text _drawListTileText(context, text, TextStyle theme) => Text(
        text,
        style: theme.merge(TextStyle(color: textColor)),
        softWrap: softWrap,
        overflow: overflow,
      );
}
