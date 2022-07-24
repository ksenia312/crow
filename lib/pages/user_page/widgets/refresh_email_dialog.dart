import 'package:flutter/material.dart';
import 'package:frontend/utils/styles.dart';
import 'package:frontend/widgets/list_tile.dart';

class RefreshEmailDialog extends StatefulWidget {
  final String? authEmail;
  final String? databaseEmail;

  const RefreshEmailDialog(
      {Key? key, required this.authEmail, required this.databaseEmail})
      : super(key: key);

  @override
  State<RefreshEmailDialog> createState() => _RefreshEmailDialogState();
}

class _RefreshEmailDialogState extends State<RefreshEmailDialog> {
  @override
  Widget build(BuildContext context) {
    ColorScheme _colorScheme = Theme.of(context).colorScheme;
    return SimpleDialog(
      backgroundColor: _colorScheme.secondary,
      title:Text(
       'Вы недавно меняли вашу почту. Нажмите для обновления данных',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.subtitle1!.apply(
          color: _colorScheme.onSecondary,
        ),
      ) ,
      contentPadding: AppIndents.all15,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: AppIndents.horizontal20,
            child: AppListTile(
              headline2: 'Обновить данные',
              bodyText: null,
              textColor: Theme.of(context).colorScheme.onPrimary,
              color: Theme.of(context).colorScheme.primary,
              trailing: Icon(Icons.check,
                  color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
        )
      ],
    );
  }
}
