import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/widgets/list_tile.dart';

class InitDialog extends StatelessWidget {
  final Function(int current) setCurrent;
  final String title;

  const InitDialog({required this.title, required this.setCurrent, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline2!.apply(
                color: Theme.of(context).colorScheme.onSecondary,
              ),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        children: _drawChildren(
            context,
            Theme.of(context).colorScheme.secondary,
            Theme.of(context).colorScheme.onSecondary));
  }

  List<Widget> _drawChildren(context, color, textColor) => [
        _drawItem(context, 'Хочу играть', textColor, 1),
        _drawItem(context, 'Хочу почитать', textColor, 3),
        _drawItem(context, 'Я не знаю..', textColor, 2),
      ];

  GestureDetector _drawItem(
          context, String text, Color textColor, int current) =>
      GestureDetector(
        onTap: () {
          setCurrent(current);
          Navigator.pop(context);
        },
        child: AppListTile(
            headline2: text,
            bodyText: null,
            textColor: Theme.of(context).colorScheme.onSecondary,
            color: Colors.transparent,
            trailing: const Icon(Icons.double_arrow)),
      );
}
