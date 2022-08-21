import 'package:flutter/material.dart';
import 'package:frontend/widgets/app_bar_children.dart';

class RandomPage extends StatefulWidget {
  const RandomPage({Key? key}) : super(key: key);

  @override
  State<RandomPage> createState() => _RandomPageState();
}

class _RandomPageState extends State<RandomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(
          text: 'ААААААААА',
        ),
      ),
      body: Center(
        child: Text(
          'я крутой',
          style: Theme.of(context)
              .textTheme
              .headline2!
              .apply(color: Theme.of(context).colorScheme.onBackground),
        ),
      ),
    );
  }
}
