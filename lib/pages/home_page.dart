import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:frontend/pages/auth_page/auth_page.dart';
import 'package:frontend/widgets/app_bar_children.dart';
import 'package:frontend/widgets/text_buttons.dart';
import 'package:frontend/widgets/cards/image_card.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(text: 'Добро пожаловать!!'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(child: _drawCarousel()),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: AppTextButton(
                margin: EdgeInsets.zero,
                buttonText: 'Войти',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return const AuthPage();
                    }),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  final List<List<String>> _items = [
    ['Развлекайтесь каждый день', 'Ну или не каждый, как хотите'],
    ['Игра, которая сломает тебе мозг', 'Попробуй пройти (:'],
    ['Уникальный раздел “Рандомайзер', 'От него неизвестно, что ожидать'],
    ['Ответы на самые странные вопросы', 'Вы не ждали, а мы пришла'],
  ];

  CarouselSlider _drawCarousel() => CarouselSlider(
        options: CarouselOptions(
            height: 400.0,
            autoPlayInterval: const Duration(seconds: 2),
            viewportFraction: 0.9,
            autoPlay: true,
            autoPlayCurve: Curves.fastOutSlowIn,
            pauseAutoPlayOnTouch: true,
            autoPlayAnimationDuration: const Duration(seconds: 1)),
        items: _items.asMap().entries.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return ImageCard(
                imageHeight: 200,
                  headline2: i.value.first,
                  bodyText: i.value.last,
                  initImageNum: i.key + 1 //Random().nextInt(4)+1,
                  );
            },
          );
        }).toList(),
      );
}
