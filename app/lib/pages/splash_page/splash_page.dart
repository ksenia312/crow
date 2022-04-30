import 'package:flutter/material.dart';
import 'package:frontend/utils/assets_variables.dart';
import 'package:splashscreen/splashscreen.dart';
import '../landing.dart';

class SplashPage extends StatelessWidget {
  SplashPage({Key? key}) : super(key: key);
  final String _image = getAsset(AppAssets.icons, 'icon_large.png');
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds: const Landing(),
      backgroundColor: Theme.of(context).colorScheme.background,
      title: Text('crow', style: Theme.of(context).textTheme.headline1),
      image: Image.asset(_image),
      photoSize: 50.0,
      loaderColor: Theme.of(context).colorScheme.secondary,
    );
  }
}
