import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/utils/assets_variables.dart';
import 'package:frontend/utils/button_style.dart';

class AppBarLeading extends StatelessWidget {
  final bool iconBack;
  final String _icon = getAsset(AppAssets.icons, 'icon_small.svg');

  AppBarLeading({
    Key? key,
    this.iconBack = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        style: AppButtonStyle.transparent(),
        child:
            iconBack ? const Icon(Icons.arrow_back) : SvgPicture.asset(_icon));
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
