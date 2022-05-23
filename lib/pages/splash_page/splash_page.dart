import 'dart:async';
import 'package:flutter/material.dart';
import 'package:frontend/widgets/statuses/loading.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushNamed('/wrapper');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'crow',
              style: Theme.of(context).textTheme.headline1!.apply(
                  color: Theme.of(context).brightness == Brightness.light
                      ? const Color(0xFF111111)
                      : const Color(0xFFDDDCFF)),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 30),
              child: AppLoading(
                height: 100,
              ),
            ),
          ],
        ),
      ),
    );

    /*  SplashScreen(
      seconds: 5,
      navigateAfterSeconds: const Wrapper(),
      backgroundColor: Theme.of(context).colorScheme.background,
      title: Text('crow', style: Theme.of(context).textTheme.headline1),
      image: Image.asset(_image),
      useLoader: true,
      photoSize: 50.0,
      loaderColor: Theme.of(context).colorScheme.surface,
    );*/
  }
}
