import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/services/user/auth_service.dart';
import 'package:frontend/utils/styles.dart';
import 'package:frontend/widgets/list_tile.dart';

class ExitDialog extends StatefulWidget {
  final String text;
  final bool exitFromApp;

  const ExitDialog({Key? key, this.exitFromApp = false, required this.text})
      : super(key: key);

  @override
  State<ExitDialog> createState() => _ExitDialogState();
}

class _ExitDialogState extends State<ExitDialog> {
  @override
  Widget build(BuildContext context) {
    ColorScheme _colorScheme = Theme.of(context).colorScheme;

    return SimpleDialog(
        title: Text(
          widget.text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.subtitle1!.apply(
                color: _colorScheme.onSecondary,
              ),
        ),
        backgroundColor: _colorScheme.secondary,
        children: [
          _drawButton(
              onTap: () async {
                if (!widget.exitFromApp) {
                  final AuthService _auth = AuthService();
                  await _auth.signOut();
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/home', (Route<dynamic> route) => false);
                } else {
                  SystemNavigator.pop();
                }
              },
              headline2: 'Выйти',
              onBackground: _colorScheme.onError,
              background: _colorScheme.error.withOpacity(0.8),
              iconData: Icons.clear),
          _drawButton(
              onTap: () {
                Navigator.of(context).pop();
              },
              headline2: 'Остаться',
              onBackground: const Color(0xFFFFFFFF),
              background: const Color(0xFF36D33E).withOpacity(0.8),
              iconData: Icons.emoji_emotions_outlined),
        ]);
  }

  _drawButton(
          {required Function() onTap,
          required String headline2,
          required Color onBackground,
          required Color background,
          IconData? iconData}) =>
      GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: AppIndents.bottom10Horizontal20,
          child: AppListTile(
            headline2: headline2,
            bodyText: null,
            textColor: onBackground,
            color: background,
            padding: 5,
            trailing:
                iconData != null ? Icon(iconData, color: onBackground) : null,
          ),
        ),
      );
}
