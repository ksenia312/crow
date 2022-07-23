import 'package:flutter/material.dart';
import 'package:frontend/utils/indents.dart';
import 'package:frontend/widgets/list_tile.dart';
import 'package:frontend/widgets/statuses/dialog.dart';
import 'package:frontend/widgets/statuses/loading.dart';

import 'email_dialog.dart';

class EmailBlock extends StatelessWidget {
  final String? text;
  final bool showDialog;

  const EmailBlock({required this.text, this.showDialog = true, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppIndents.all5ExceptBottom,
      child: text != null
          ? GestureDetector(
              onTap: () {
                if (showDialog) {
                  AppDialog.showCustomDialog(context,
                      child: EmailDialog(
                        email: text,
                      ));
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(0, 2),
                          color: Theme.of(context).colorScheme.shadow,
                          blurRadius: 3),
                    ]),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  child: AppListTile(
                    headline2: '$text',
                    bodyText: null,
                    //height: 60,
                    textColor: Theme.of(context).colorScheme.onPrimary,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            )
          : const AppLoading(
              height: 60,
            ),
    );
  }
}
