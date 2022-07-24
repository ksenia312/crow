import 'dart:async';
import 'package:flutter/material.dart';
import 'package:frontend/pages/wrapper/wrapper.dart';
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
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return const Wrapper();
        }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('crow',
                style: Theme.of(context).textTheme.headline1!.apply(
                      color: Theme.of(context).colorScheme.onBackground,
                    )),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: AppLoading(
                height: 100,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
