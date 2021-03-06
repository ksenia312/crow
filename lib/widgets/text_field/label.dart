import 'package:flutter/material.dart';
import 'package:frontend/utils/styles.dart';

class AppLabel extends StatefulWidget {
  final String text;
  final TextAlign textAlign;
  final bool isFieldSubmitted;

  const AppLabel(
      {required this.text,
      this.textAlign = TextAlign.start,
      this.isFieldSubmitted = false,
      Key? key})
      : super(key: key);

  @override
  State<AppLabel> createState() => _AppLabelState();
}

class _AppLabelState extends State<AppLabel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppIndents.horizontal20,
      child: Text(
        widget.text,
        style: Theme.of(context).textTheme.headline1?.apply(
            color: Theme.of(context).colorScheme.secondaryContainer,
            decoration: widget.isFieldSubmitted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
        ).copyWith(letterSpacing: 5),
        textAlign: widget.textAlign,
      ),
    );
  }
}
