import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:frontend/pages/auth/auth_wrapper.dart';
import 'package:frontend/utils/types.dart';
import 'package:frontend/widgets/dialogs/exit_dialog.dart';
import 'package:frontend/widgets/app_bar_children.dart';
import 'package:frontend/utils/dialog.dart';
import 'package:frontend/widgets/text_buttons.dart';
import 'package:frontend/widgets/cards/image_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
      AppDialog.showCustomDialog(context,
            child: const ExitDialog(
              text: 'Вы уверены, что хотите выйти из приложения?',
              exitFromApp: true,
            ));
        setState(() {});
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
                        return const AuthWrapper();
                      }),
                    );
                  },
                ),
              ),
            ],
          ),
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
            height: 400,
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
                  listTileHeight: 150,
                  headline2: i.value.first,
                  bodyText: i.value.last,
                  initImageNum: getRandomImageNum() //Random().nextInt(4)+1,
                  );
            },
          );
        }).toList(),
      );
}
