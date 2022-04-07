import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/utils/button_style.dart';

class AppTitle {
  static textWithIcon(text) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
      SizedBox(
        width: 50,
        child: ElevatedButton(
          onPressed: () {},
          style: AppButtonStyle.title(),
          child: SvgPicture.asset(
            './assets/files/icons/icon_small.svg',
          ),
        ),
      ),
      const Text('crow'),
    ]);
  }

  static icon() {
    return SizedBox(
      width: 50,
      child: ElevatedButton(
        onPressed: () {},
        style: AppButtonStyle.title(),
        child: SvgPicture.asset(
          './assets/files/icons/icon_small.svg',
        ),
      ),
    );
  }
  static text() {
    return const Text('crow');
  }
}
