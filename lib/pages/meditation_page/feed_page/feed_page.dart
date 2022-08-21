import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/widgets/app_bar_children.dart';

import 'package:frontend/widgets/text_buttons.dart';

import 'descriptions.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  int _screenIndex = 0;

  get _calculateRandom => Random().nextInt(descriptions.length);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const AppBarTitle(
        text: 'Карточки',
      )),
      body: AnimatedSwitcher(
        child: Center(
          key: Key(_screenIndex.toString()),
          child: SizedBox(
            height: 300,
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              color: Theme.of(context)
                  .colorScheme
                  .primary
                  .withRed(((_screenIndex + 1) * 40) % 255),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        descriptions[_screenIndex],
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline2!.apply(
                            color: Theme.of(context).colorScheme.onPrimary),
                      ),
                    ),
                    AppTextButton(
                      buttonText: 'Следующий',
                      type: AppTextButtonType.secondary,
                      size: AppTextButtonSize.medium,
                      onPressed: () {
                        var _random = _calculateRandom;
                        while (_screenIndex == _random) {
                          _random = _calculateRandom;
                        }
                        setState(() {
                          _screenIndex = _random;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        duration: const Duration(milliseconds: 500),
        switchInCurve: Curves.fastOutSlowIn,
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(
            scale: animation,
            child: child,
          );
        },
      ),
    );
  }
}
