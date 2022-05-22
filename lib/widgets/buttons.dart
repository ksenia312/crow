import 'package:flutter/material.dart';
import 'package:frontend/utils/button_style.dart';
import 'package:frontend/utils/indents.dart';

enum AppTextButtonType { primary, secondary, tertiary, custom, warning }
enum AppTextButtonSize { large, medium, scrollable }
enum AppTextButtonShape { basic }

class AppTextButton extends StatefulWidget {
  final AppTextButtonType type;
  final AppTextButtonSize size;
  final AppTextButtonShape shape;
  final Function()? onPressed;
  final String buttonText;
  final Color customBackgroundColor;
  final Color customForegroundColor;
  final bool disabled;

  const AppTextButton(
      {Key? key,
      this.type = AppTextButtonType.primary,
      this.size = AppTextButtonSize.large,
      this.shape = AppTextButtonShape.basic,
      required this.buttonText,
      this.onPressed,
      this.customBackgroundColor = const Color(0xFFFFFFFF),
      this.customForegroundColor = const Color(0xFFFFFFFF),
      this.disabled = false})
      : super(key: key);

  @override
  State<AppTextButton> createState() => _AppTextButtonState();
}

class _AppTextButtonState extends State<AppTextButton> {
  bool _isCurrentScrollable() => widget.size == AppTextButtonSize.scrollable;

  bool _isCurrentMedium() => widget.size == AppTextButtonSize.medium;
  bool _isCurrentCustom() => widget.size == AppTextButtonSize.medium;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _isCurrentMedium() ? 200 : double.infinity,
      decoration: widget.disabled ? const BoxDecoration() : _activeDecoration(),
      margin: _isCurrentScrollable() ? EdgeInsets.zero : AppIndents.basicMargin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: _drawTextButton(),
      ),
    );
  }

  BoxDecoration _activeDecoration() => _isCurrentScrollable()
      ? const BoxDecoration()
      : BoxDecoration(borderRadius: BorderRadius.circular(5), boxShadow: [
          BoxShadow(
              offset: const Offset(0, 2),
              color: Theme.of(context).colorScheme.shadow,
              blurRadius: 3),
        ]);

  TextButton _drawTextButton() => TextButton(
      onPressed: widget.disabled ? null : widget.onPressed,
      style: AppButtonStyle.basic.merge(getColors()),
      child: Text(
        widget.buttonText,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: _isCurrentScrollable() ? 8.0 : null),
      ));

  ButtonStyle getColors() {
    switch (widget.type) {
      case AppTextButtonType.primary:
        return ButtonStyle(
          backgroundColor: overrideButtonStyle<Color?>(widget.disabled
              ? Theme.of(context).colorScheme.primary.withOpacity(0.4)
              : Theme.of(context).colorScheme.primary),
          foregroundColor: overrideButtonStyle<Color?>(
              Theme.of(context).colorScheme.onPrimary),
        );
      case AppTextButtonType.secondary:
        return ButtonStyle(
          backgroundColor: overrideButtonStyle<Color?>(widget.disabled
              ? Theme.of(context).colorScheme.secondary.withOpacity(0.4)
              : Theme.of(context).colorScheme.secondary),
          foregroundColor: overrideButtonStyle<Color?>(
              Theme.of(context).colorScheme.onSecondary),
        );
      case AppTextButtonType.tertiary:
        return ButtonStyle(
          backgroundColor: overrideButtonStyle<Color?>(widget.disabled
              ? Theme.of(context).colorScheme.tertiary.withOpacity(0.4)
              : Theme.of(context).colorScheme.tertiary),
          foregroundColor: overrideButtonStyle<Color?>(
              Theme.of(context).colorScheme.onTertiary),
        );
      case AppTextButtonType.custom:
        return ButtonStyle(
          backgroundColor: overrideButtonStyle<Color?>(widget.disabled
              ? widget.customBackgroundColor.withOpacity(0.4)
              : widget.customBackgroundColor),
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
