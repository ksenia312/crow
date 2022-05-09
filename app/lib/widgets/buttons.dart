import 'package:flutter/material.dart';
import 'package:frontend/utils/button_style.dart';
import 'package:frontend/utils/indents.dart';

enum AppTextButtonType { primary, secondary, tertiary, custom, warning }
enum AppTextButtonSize { large, medium, small }
enum AppTextButtonShape { basic, circle }

class AppTextButton extends StatelessWidget {
  final AppTextButtonType type;
  final AppTextButtonSize size;
  final AppTextButtonShape shape;
  final Function()? onPressed;
  final String buttonText;
  final Color customBackgroundColor;
  final Color customForegroundColor;
  final bool selected;

  const AppTextButton(
      {Key? key,
      this.type = AppTextButtonType.primary,
      this.size = AppTextButtonSize.large,
      this.shape = AppTextButtonShape.basic,
      required this.buttonText,
      this.onPressed,
      this.customBackgroundColor = const Color(0xFFFFFFFF),
      this.customForegroundColor = const Color(0xFFFFFFFF),
      this.selected = false})
      : super(key: key);

  bool _isCurrentSmall() => size == AppTextButtonSize.small;

  bool _isCurrentMedium() => size == AppTextButtonSize.medium;

  bool _isCurrentCircle() => shape == AppTextButtonShape.circle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _isCurrentMedium() ? 200 : double.infinity,
      margin: AppIndents.basicMargin,
      /*decoration: type == AppTextButtonType.pressed
          ? _outlinedDecoration(context)
          : const BoxDecoration(),*/
      child: ClipRRect(
        borderRadius: BorderRadius.circular(_isCurrentCircle() ? 30 : 15),
        child: _drawTextButton(context),
      ),
    );
  }

/*  BoxDecoration _outlinedDecoration(context) => BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).colorScheme.primary,
                spreadRadius: 2,
                blurRadius: 3)
          ],
          border: Border.all(
              color: Theme.of(context).colorScheme.primary, width: 1.5),
          borderRadius: BorderRadius.circular(20.0));*/

  TextButton _drawTextButton(context) => TextButton(
      onPressed: onPressed,
      style:
          AppButtonStyle.basic.merge(getColors(context)).merge(changePadding()),
      child: Text(
        buttonText,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: _isCurrentSmall() ? 16.0 : null),
      ));

  ButtonStyle changePadding() {
    return ButtonStyle(
        padding:
            overrideButtonStyle<EdgeInsetsGeometry?>(const EdgeInsets.all(20)));
  }

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
      case AppTextButtonType.tertiary:
        return ButtonStyle(
          backgroundColor: overrideButtonStyle<Color?>(
              Theme.of(context).colorScheme.tertiary),
          foregroundColor: overrideButtonStyle<Color?>(
              Theme.of(context).colorScheme.onTertiary),
        );
      case AppTextButtonType.custom:
        return ButtonStyle(
          backgroundColor: overrideButtonStyle<Color?>(customBackgroundColor),
          foregroundColor: overrideButtonStyle<Color?>(customForegroundColor),
        );
      case AppTextButtonType.warning:
        return ButtonStyle(
          backgroundColor:
              overrideButtonStyle<Color?>(Theme.of(context).colorScheme.error),
          foregroundColor: overrideButtonStyle<Color?>(
              Theme.of(context).colorScheme.onError),
        );
    }
  }
}
