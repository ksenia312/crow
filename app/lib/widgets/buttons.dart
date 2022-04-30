import 'package:flutter/material.dart';
import 'package:frontend/utils/button_style.dart';
import 'package:frontend/utils/indents.dart';

enum AppTextButtonType { primary, secondary, outlined }
enum AppTextButtonSize { large, small }

class AppTextButton extends StatelessWidget {
  final AppTextButtonType type;
  final AppTextButtonSize size;
  final Function()? onPressed;
  final String buttonText;

  const AppTextButton(
      {Key? key,
      this.type = AppTextButtonType.primary,
      this.size = AppTextButtonSize.large,
      required this.buttonText,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case AppTextButtonType.primary:
        return _drawTextButtonBox(context);
      case AppTextButtonType.secondary:
        return _drawTextButtonBox(context);
      case AppTextButtonType.outlined:
        return _drawTextButtonBox(context);
    }
  }

  Container _drawTextButtonBox(context) => Container(
        width: size == AppTextButtonSize.small ? 200 : double.infinity,
        margin: AppIndents.basicMargin,
        decoration: type == AppTextButtonType.outlined
            ? _outlinedDecoration(context)
            : const BoxDecoration(),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: _drawTextButton(context),
        ),
      );

  BoxDecoration _outlinedDecoration(context) => BoxDecoration(
      border: Border.all(
          color: Theme.of(context).colorScheme.onTertiary, width: 3.0),
      borderRadius: BorderRadius.circular(10.0));

  TextButton _drawTextButton(context) => TextButton(
      onPressed: onPressed,
      style: AppButtonStyle.basic.merge(getColors(context)),
      child: Text(
        buttonText,
        textAlign: TextAlign.center,
        //style: Theme.of(context).textTheme.headline2,
      ));

  ButtonStyle getColors(context) {
    switch (type) {
      case AppTextButtonType.primary:
        return ButtonStyle(
          backgroundColor: overrideButtonStyle<Color?>(
              Theme.of(context).colorScheme.primary),
          foregroundColor: overrideButtonStyle<Color?>(
              Theme.of(context).colorScheme.onPrimary),
        );
      case AppTextButtonType.secondary:
        return ButtonStyle(
          backgroundColor: overrideButtonStyle<Color?>(
              Theme.of(context).colorScheme.secondary),
          foregroundColor: overrideButtonStyle<Color?>(
              Theme.of(context).colorScheme.onSecondary),
        );
      case AppTextButtonType.outlined:
        return ButtonStyle(
          backgroundColor: overrideButtonStyle<Color?>(
              Theme.of(context).colorScheme.tertiary),
          foregroundColor: overrideButtonStyle<Color?>(
              Theme.of(context).colorScheme.onTertiary),
          animationDuration: const Duration(seconds: 2),
        );
    }
  }
}
