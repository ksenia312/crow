import 'package:flutter/material.dart';
import 'package:frontend/utils/indents.dart';
import 'package:frontend/widgets/list_tile.dart';

class HintDialog extends StatelessWidget {
  final String text;

  const HintDialog({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
        title: Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline2!.apply(
                color: Theme.of(context).colorScheme.onSecondary,
              ),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: AppIndents.horizontal20,
              child: AppListTile(
                headline2: 'Понятно',
                bodyText: null,
                textColor: Theme.of(context).colorScheme.onPrimary,
                color: Theme.of(context).colorScheme.primary,
                trailing: Icon(Icons.check,
                    color: Theme.of(context).colorScheme.onPrimary),
              ),
            ),
          )
        ]);
  }
}
