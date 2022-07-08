import 'package:flutter/material.dart';
import 'package:frontend/utils/indents.dart';
import 'package:frontend/widgets/statuses/dialog.dart';

import 'hint_dialog.dart';

class LevelTitle extends StatefulWidget {
  final String text;
  final TextAlign textAlign;
  final bool padding;
  final Color? textColor;

  const LevelTitle(
      {required this.text,
      this.textAlign = TextAlign.left,
      this.padding = true,
      this.textColor,
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
        style: Theme.of(context).textTheme.headline2!.apply(
            color:
                widget.textColor ?? Theme.of(context).colorScheme.onBackground),
      ),
    );
  }
}

class LevelTitleWithHint extends StatefulWidget {
  final String text;
  final String hintText;
  final TextAlign textAlign;
  final bool padding;
  final Color? textColor;
  final Color? iconColor;

  const LevelTitleWithHint(
      {required this.text,
      required this.hintText,
      this.textAlign = TextAlign.left,
      this.padding = true,
      this.textColor,
      this.iconColor,
      Key? key})
      : super(key: key);

  @override
  State<LevelTitleWithHint> createState() => _LevelTitleWithHintState();
}

class _LevelTitleWithHintState extends State<LevelTitleWithHint> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: widget.padding ? AppIndents.all15 : EdgeInsets.zero,
            child: Text(
              widget.text,
              textAlign: widget.textAlign,
              style: Theme.of(context).textTheme.headline2!.apply(
                  color: widget.textColor ??
                      Theme.of(context).colorScheme.onBackground),
            ),
          ),
        ),
        IconButton(
            onPressed: onPressed,
            icon: Icon(
              Icons.lightbulb,
              color: widget.iconColor ??
                  Theme.of(context).colorScheme.onBackground,
            ))
      ],
    );
  }

  onPressed() {
    AppDialog.showCustomDialog(context,
        child: HintDialog(
          text: widget.hintText,
        ));
  }
}
