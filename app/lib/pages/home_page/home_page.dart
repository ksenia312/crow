import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:frontend/widgets/buttons.dart';
import 'package:frontend/widgets/cards/announcement_card.dart';
import 'package:frontend/widgets/cards/image_card.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            const AnnouncementCard(
              headline2: 'Добро пожаловать!',
              bodyText: 'Пожалуйста, войдите в аккаунт',
              showCloseButton: false,
            ),
            _drawCarousel(),
            Row(children: [
              AppTextButton(
                buttonText: 'Войти',
                size: AppTextButtonSize.medium,
                onPressed: () {
                  Navigator.pushNamed(context, '/auth');
                },
              )
            ])
          ],
        ),
      ),
    );
  }

  final List<List<String>> _items = [
    ['Развлекайтесь каждый день', 'Ну или не каждый, как хотите'],
    ['Игра, которая сломает тебе мозг', 'Попробуй пройти (:'],
    ['Бесконечная лента для медитации', 'Листай сколько хочешь'],
    ['Уникальный раздел “Рандомайзер”', 'От него неизвестно, что ожидать'],
  ];

  CarouselSlider _drawCarousel() => CarouselSlider(
        options: CarouselOptions(
            height: 400.0,
            autoPlayInterval: const Duration(seconds: 5),
            viewportFraction: 0.9,
            autoPlay: true,
            autoPlayCurve: Curves.fastOutSlowIn,
            pauseAutoPlayOnTouch: true,
            autoPlayAnimationDuration: const Duration(seconds: 1)),
        items: _items.asMap().entries.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return ImageCard(
                  headline2: i.value.first,
                  bodyText: i.value.last,
                  listTileHeight: 150,
                  initImageNum: i.key + 1 //Random().nextInt(4)+1,
                  );
            },
          );
        }).toList(),
      );
}
