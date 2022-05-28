import 'package:flutter/material.dart';

class AppListTile extends StatelessWidget {
  final String headline2;
  final String? bodyText;
  final Color textColor;
  final Color color;
  final double height;
  final bool softWrap;
  final TextOverflow overflow;
  final Widget? trailing;

  const AppListTile(
      {Key? key,
      required this.headline2,
      required this.bodyText,
      required this.textColor,
      required this.color,
      this.height = 80,
      this.softWrap = true,
      this.overflow = TextOverflow.fade,
      this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      color: color,
      child: Center(
        child: ListTile(
          title: _drawListTileText(
              context, headline2, Theme.of(context).textTheme.headline2!),
          subtitle: bodyText!=null ? _drawListTileText(
              context, bodyText, Theme.of(context).textTheme.bodyText1!) : null,
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
