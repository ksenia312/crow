import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/utils/assets_variables.dart';
import 'package:frontend/utils/button_style.dart';

class AppBarLeading extends StatelessWidget {
  final bool iconBack;
  final Function? onPressed;
  final String _icon = getAsset(AppAssets.icons, 'icon_small.svg');

  AppBarLeading({
    Key? key,
    this.iconBack = false,
    this.onPressed()?,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: overrideButtonStyle<Color>(
                Theme.of(context).colorScheme.surface)),
        onPressed: () {
          onPressed == null ? Navigator.of(context).pop() : onPressed!();
        },
        child: iconBack
            ? Icon(
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.onSurface,
              )
            : SvgPicture.asset(_icon));
  }
}

class AppBarTitle extends StatelessWidget {
  final String text;

  const AppBarTitle({Key? key, this.text = 'crow'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}
