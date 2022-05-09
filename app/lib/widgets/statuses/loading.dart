import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoadingFlipping.circle(
      borderColor: Theme.of(context).colorScheme.primary,
      size: 30.0,
      backgroundColor: Theme.of(context).colorScheme.primary,
    );
  }
}
