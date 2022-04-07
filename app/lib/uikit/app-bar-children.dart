import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/utils/button-style.dart';

Widget appBarLeading({onPressed, icon = './assets/files/icons/icon_small.svg'}) {
  return ElevatedButton(
      onPressed: onPressed,
      style: AppButtonStyle.withIcon(),
      child: SvgPicture.asset(icon));
}

Widget appBarTitle({text = 'crow'}) {
  return Text(text);
}
