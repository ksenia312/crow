import 'package:flutter/material.dart';
import 'package:frontend/utils/indents.dart';

class AppLabel extends StatefulWidget {
  final String text;
  final TextAlign textAlign;
  final bool isFieldFilled;

  const AppLabel(
      {required this.text,
      this.textAlign = TextAlign.start,
      this.isFieldFilled = false,
      Key? key})
      : super(key: key);

  @override
  State<AppLabel> createState() => _AppLabelState();
}

class _AppLabelState extends State<AppLabel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppIndents.labelMargin,
      child: Text(
        widget.text,
        style: Theme.of(context).textTheme.headline1?.apply(
            color: Theme.of(context).colorScheme.secondaryContainer,
            decoration: widget.isFieldFilled
                ? TextDecoration.lineThrough
                : TextDecoration.none),
        textAlign: widget.textAlign,
      ),
    );
  }
}
