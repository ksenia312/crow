import 'package:flutter/material.dart';
import 'package:frontend/widgets/text_buttons.dart';

import 'feed_page/feed_page.dart';
import 'random_page/random_page.dart';

class MeditationPage extends StatefulWidget {
  const MeditationPage({Key? key}) : super(key: key);

  @override
  State<MeditationPage> createState() => _MeditationPageState();
}

class _MeditationPageState extends State<MeditationPage>
    with TickerProviderStateMixin {
  bool _hidden = true;

  late Animation<double> _animation;
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true, min: 0.6);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: _hidden ? 300 : MediaQuery.of(context).size.height,
      width: _hidden ? 300 : MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          /* boxShadow: [
            BoxShadow(
                color: Theme.of(context).colorScheme.shadow, blurRadius: 50)
          ],*/
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          gradient: LinearGradient(begin: Alignment.topLeft, colors: [
            Theme.of(context).colorScheme.background,
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.tertiary,
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.tertiary,
            Theme.of(context).colorScheme.primary,
          ])),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppTextButton(
              buttonText: 'Выбрать опцию',
              type: AppTextButtonType.primary,
              onPressed: () {
                setState(() {
                  _hidden = !_hidden;
                });
              },
            ),
            drawOption(text: 'Смотреть карточки', widget: const FeedPage()),
            drawOption(text: 'Что-то неожиданное', widget: const RandomPage()),
          ],
        ),
      ),
    );
  }

  drawOption({required String text, required Widget widget}) {
    return ScaleTransition(
      scale: _animation,
      child: AnimatedContainer(
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 300),
          height: _hidden ? 0 : 60,
          width: _hidden ? 0 : MediaQuery.of(context).size.width - 100,
          child: AppTextButton(
              buttonText: text,
              type: AppTextButtonType.secondary,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return widget;
                  }),
                );
              })),
    );
  }
}
