import 'package:flutter/material.dart';
import 'package:frontend/utils/button_style.dart';
import 'package:frontend/utils/indents.dart';

import '../utils/colors.dart';

enum AppTextButtonType { primary, secondary, light }
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
        return _drawTextButtonBox(context, AppButtonStyle.primary());
      case AppTextButtonType.secondary:
        return _drawTextButtonBox(context, AppButtonStyle.secondary());
      case AppTextButtonType.light:
        return _drawTextButtonBox(context, AppButtonStyle.light());
    }
  }

  Container _drawTextButtonBox(context, buttonStyle) => Container(
      width: size == AppTextButtonSize.small ? 200 : double.infinity,
      margin: AppIndents.basicMargin(),
      child: _drawTextButton(context, buttonStyle));

  TextButton _drawTextButton(context, buttonStyle) => TextButton(
      onPressed: onPressed,
      style: buttonStyle,
      child: Text(
        buttonText,
        style: _drawTextStyle(context),
        textAlign: TextAlign.center,
      ));

  TextStyle _drawTextStyle(context) =>
      Theme.of(context).textTheme.headline2!.apply(
          color: type == AppTextButtonType.light ? AppColors.primary() : null);
}
