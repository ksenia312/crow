import 'package:flutter/material.dart';
import 'package:frontend/utils/functions.dart';
import 'package:frontend/utils/styles.dart';
import 'package:frontend/widgets/statuses/loading.dart';

enum AppTextButtonType { primary, secondary, tertiary, custom, warning }
enum AppTextButtonSize { large, medium }
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
  final bool? loading;
  final bool showLoading;
  final EdgeInsets? margin;

  const AppTextButton(
      {Key? key,
      this.type = AppTextButtonType.primary,
      this.size = AppTextButtonSize.large,
      this.shape = AppTextButtonShape.basic,
      required this.buttonText,
      this.onPressed,
      this.customBackgroundColor = const Color(0xFFFFFFFF),
      this.customForegroundColor = const Color(0xFFFFFFFF),
      this.disabled = false,
      this.loading,
      this.showLoading = false,
      this.margin})
      : super(key: key);

  @override
  State<AppTextButton> createState() => _AppTextButtonState();
}

class _AppTextButtonState extends State<AppTextButton> {
  bool _isCurrentMedium() => widget.size == AppTextButtonSize.medium;
  bool _loading = false;
  Size? buttonSize;
  final _key = GlobalKey();

  _onPressed() async {
    setState(() {
      _loading = true;
      buttonSize = _key.currentContext?.size;
    });

    if (!widget.disabled && widget.onPressed != null) {
      widget.onPressed!();
    }

    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _isCurrentMedium() ? 200 : double.infinity,
      decoration:
          widget.disabled || (widget.loading ?? _loading) && widget.showLoading
              ? const BoxDecoration()
              : _activeDecoration(),
      margin: widget.margin ?? AppIndents.all5ExceptBottom,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: (widget.loading ?? _loading) && widget.showLoading
            ? Container(
                height: buttonSize?.height ?? 50,
                width: buttonSize?.width ?? 200,
                color: getColors().backgroundColor?.resolve({}),
                child: AppLoading(
                    height: 26,
                    color: getColors().foregroundColor?.resolve({}) ??
                        Theme.of(context).colorScheme.onBackground))
            : _drawTextButton(),
      ),
    );
  }

  BoxDecoration _activeDecoration() =>
      BoxDecoration(borderRadius: BorderRadius.circular(5), boxShadow: [
        BoxShadow(
            offset: const Offset(0, 2),
            color: Theme.of(context).colorScheme.shadow,
            blurRadius: 3),
      ]);

  TextButton _drawTextButton() {
    TextButton _button = TextButton(
        key: _key as LabeledGlobalKey<State<StatefulWidget>>,
        onPressed: _onPressed,
        style: ButtonStyle(
          padding: overrideButtonStyle<EdgeInsetsGeometry?>(
              const EdgeInsets.all(15)),
        ).merge(getColors()),
        child: Text(
          widget.buttonText,
          textAlign: TextAlign.center,
        ));
    return _button;
  }

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
            foregroundColor:
                overrideButtonStyle<Color?>(widget.customForegroundColor));
      case AppTextButtonType.warning:
        return ButtonStyle(
          backgroundColor: overrideButtonStyle<Color?>(widget.disabled
              ? Theme.of(context).colorScheme.error.withOpacity(0.4)
              : Theme.of(context).colorScheme.error),
          foregroundColor: overrideButtonStyle<Color?>(
              Theme.of(context).colorScheme.onError),
        );
    }
  }
}
