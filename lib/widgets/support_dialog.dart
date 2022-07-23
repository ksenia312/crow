import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/utils/indents.dart';
import 'package:frontend/widgets/list_tile.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../pages/auth/pages/change_email_page.dart';

class SupportDialog extends StatefulWidget {
  final String text;
  final bool isVerifyEmail;
  final String? email;

  const SupportDialog(
      {Key? key, required this.text, this.isVerifyEmail = false, this.email})
      : super(key: key);

  @override
  State<SupportDialog> createState() => _SupportDialogState();
}

class _SupportDialogState extends State<SupportDialog> {
  bool _copied = false;

  @override
  Widget build(BuildContext context) {
    ColorScheme _colorScheme = Theme.of(context).colorScheme;
    Color _onCopyColor =
        _copied ? _colorScheme.onTertiary : _colorScheme.onPrimary;
    Color _copyColor = _copied ? _colorScheme.tertiary : _colorScheme.primary;
    return SimpleDialog(
        title: Text(
          widget.text,
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.subtitle1!.apply(
                color: Theme.of(context).colorScheme.onSecondary,
              ),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        children: [
          widget.isVerifyEmail
              ? _drawButton(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ChangeEmailPage(email: widget.email)));
                  },
                  headline2: 'Изменить почту',
                  onBackground: const Color(0xFFFFFFFF),
                  background: const Color(0xFF36D33E).withOpacity(0.8))
              : Container(),
          _drawButton(
              onTap: () {
                Clipboard.setData(
                    const ClipboardData(text: 'nikitina3619@mail.ru'));
                setState(() {
                  _copied = true;
                });
              },
              headline2:
                  _copied ? 'Скопировано!' : 'Скопировать email поддержки',
              onBackground: _onCopyColor,
              background: _copyColor,
              iconData: _copied ? Icons.check_outlined : Icons.copy_outlined),
          _drawButton(
              onTap: () {
                launchUrlString('https://t.me/xenikii',
                    mode: LaunchMode.externalNonBrowserApplication);
                Navigator.pop(context);
              },
              headline2: 'Написать в Telegram',
              onBackground: const Color(0xFFFFFFFF),
              background: const Color(0xFF36A0D3).withOpacity(0.8),
              iconData: Icons.telegram_outlined),
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
