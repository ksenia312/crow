import 'package:flutter/material.dart';
import 'package:frontend/utils/styles.dart';

class EmailDialog extends StatefulWidget {
  final String? email;

  const EmailDialog({Key? key, required this.email}) : super(key: key);

  @override
  State<EmailDialog> createState() => _EmailDialogState();
}

class _EmailDialogState extends State<EmailDialog> {
  @override
  Widget build(BuildContext context) {
    ColorScheme _colorScheme = Theme.of(context).colorScheme;
    return SimpleDialog(
      backgroundColor: _colorScheme.secondary,
      contentPadding: AppIndents.all15,
      children: [
        Center(
          child: Text(
            widget.email ?? '',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1!.apply(
                  color: _colorScheme.onSecondary,
                ),
          ),
        ),
      ],
    );
  }
}
