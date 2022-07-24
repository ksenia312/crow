import 'package:flutter/material.dart';
import 'package:frontend/widgets/list_tile.dart';
import '../../../utils/styles.dart';

class Question extends StatefulWidget {
  final String headline2;
  final String bodyText1;
  final String countViews;

  const Question(
      {Key? key,
      required this.headline2,
      required this.bodyText1,
      required this.countViews})
      : super(key: key);

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppIndents.all5ExceptBottom,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4.0),
        child: AppListTile(
          headline2: widget.headline2,
          bodyText: widget.bodyText1,
          color: Theme.of(context).colorScheme.secondary,
          textColor: Theme.of(context).colorScheme.onSecondary,
          softWrap: false,
          overflow: TextOverflow.ellipsis,
          trailing: _buildTrailing(
              Theme.of(context).colorScheme.onSecondary, widget.countViews),
        ),
      ),
    );
  }

  SizedBox _buildTrailing(color, viewsCount) => SizedBox(
        width: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.remove_red_eye_outlined, color: color),
            Text(
              viewsCount,
              style: Theme.of(context).textTheme.bodyText1!.apply(color: color),
              softWrap: false,
              overflow: TextOverflow.fade,
            )
          ],
        ),
      );
}
