import 'package:flutter/material.dart';
import 'package:frontend/utils/colors.dart';
import 'package:loading_animations/loading_animations.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.secondary(),
      child: Center(
        child: LoadingFlipping.square(
          borderColor: Colors.cyan,
          size: 30.0,
        ),
      ),
    );
  }
}
