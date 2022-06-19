import 'package:flutter/material.dart';
import 'package:frontend/utils/indents.dart';

class LevelTitle extends StatefulWidget {
  final String text;
  final TextAlign textAlign;
  final bool padding;

  const LevelTitle(
      {required this.text,
      this.textAlign = TextAlign.left,
      this.padding = true,
      Key? key})
      : super(key: key);

  @override
  State<LevelTitle> createState() => _LevelTitleState();
}

class _LevelTitleState extends State<LevelTitle> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ? AppIndents.all15 : EdgeInsets.zero,
      child: Text(
        widget.text,
        textAlign: widget.textAlign,
        style: Theme.of(context)
            .textTheme
            .headline2!
            .apply(color: Theme.of(context).colorScheme.onBackground),
      ),
    );
  }
}
