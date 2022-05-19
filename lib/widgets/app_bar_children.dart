import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/utils/assets_variables.dart';
import 'package:frontend/utils/button_style.dart';

class AppBarLeading extends StatefulWidget {
  final bool iconBack;
  final Function? onPressed;

  AppBarLeading({
    Key? key,
    this.iconBack = false,
    this.onPressed()?,
  }) : super(key: key);

  @override
  State<AppBarLeading> createState() => _AppBarLeadingState();
}

class _AppBarLeadingState extends State<AppBarLeading> {
  late String _icon;

  @override
  Widget build(BuildContext context) {
    setState(() {
      _icon = getAsset(AppAssets.icons);
    });
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: overrideButtonStyle<Color>(
              Theme
                  .of(context)
                  .colorScheme
                  .surface)),
      onPressed: () {
        widget.onPressed == null ? Navigator.of(context).pop() : widget
            .onPressed!();
      },
      child: widget.iconBack
          ? Icon(
        Icons.arrow_back,
        color: Theme
            .of(context)
            .colorScheme
            .onSurface,
      )
          : Padding(
        padding: const EdgeInsets.all(8),
        child: SvgPicture.asset(_icon),
      ),
    );
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
