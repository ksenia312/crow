import 'package:flutter/material.dart';
import 'package:frontend/widgets/app_bar_children.dart';

class ActionTextWithIcon extends StatelessWidget {
  final int textPos;
  final String text;
  final TextAlign textAlign;
  final IconData iconData;
  final Function() onPressed;

  const ActionTextWithIcon(
      {required this.textPos,
      required this.text,
      required this.textAlign,
      required this.iconData,
      required this.onPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _rowChildren = [
      IconButton(
          onPressed:onPressed,
          icon: Icon(
            iconData,
            color: Theme.of(context).colorScheme.onSurface,
          )),
    ];
    _rowChildren.insert(textPos, _navigationText(text, textAlign));
    return Row(children: _rowChildren);
  }

  AppBarTitle _navigationText(String text, TextAlign textAlign) => AppBarTitle(
        text: text,
        isSmall: true,
        textAlign: textAlign,
      );
}
