import 'package:flutter/material.dart';
import 'package:frontend/utils/styles.dart';
import 'package:frontend/widgets/list_tile.dart';

class LevelIntroductionDialog extends StatefulWidget {
  const LevelIntroductionDialog({Key? key}) : super(key: key);

  @override
  State<LevelIntroductionDialog> createState() =>
      _LevelIntroductionDialogState();
}

class _LevelIntroductionDialogState extends State<LevelIntroductionDialog> {
  int _step = 1;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
        title: Text(
          'Добро пожаловать в игру!',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline2!.apply(
                color: Theme.of(context).colorScheme.onSecondary,
              ),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        children: [
          Padding(
            padding: AppIndents.all15,
            child: Text(
              _step == 1
                  ? 'Вы будете проходить игру от моего лица. \n\nВы забывчивы и рассеяны, однако очень любопытны.\n\nВы часто будете что-то терять, а также сталкиваться с непонятными штуками, на которые очень хочется нажать.'
                  : 'Иногда решение не очень логичное. \n\nПробуйте разные действия и жесты. \n\nБывает, что нужно подумать. Если не помогает, то обязательно перестаньте думать!',
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.subtitle1!.apply(
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (_step == 1) {
                setState(() {
                  _step++;
                });
              } else {
                Navigator.pop(context);
              }
            },
            child: AppListTile(
              headline2: _step == 1 ? 'Продолжить' : 'Начать игру',
              bodyText: null,
              textColor: Theme.of(context).colorScheme.onSecondary,
              color: Colors.transparent,
              trailing: Icon(Icons.double_arrow,
                  color: Theme.of(context).colorScheme.onSecondary),
            ),
          )
        ]);
  }
}
