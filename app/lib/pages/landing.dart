import 'package:flutter/material.dart';
import 'package:frontend/pages/feed_page/feed-page.dart';
import 'package:frontend/pages/game_page/game_page.dart';
import 'package:frontend/pages/questions_page/questions_page.dart';
import 'package:frontend/pages/user_page/user_page.dart';
import 'package:frontend/uikit/app_bar_children.dart';
import 'package:frontend/utils/colors.dart';

class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  int _current = 0;
  final List<Widget> _screens = const [
    UserPage(),
    GamePage(),
    FeedPage(),
    QuestionsPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(),
        leading: AppBarLeading(),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      bottomNavigationBar: _bar(),
      body: Center(
        child: _screens.elementAt(_current),
      ),
    );
  }

  BottomNavigationBarItem _item(icon, text) =>
      BottomNavigationBarItem(icon: Icon(icon), label: text);

  BottomNavigationBar _bar() => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.basicLight(),
          currentIndex: _current,
          //selected
          showSelectedLabels: false,
          selectedIconTheme: const IconThemeData(size: 35),
          selectedItemColor: AppColors.primary(),
          iconSize: 30,
          //unselected
          showUnselectedLabels: false,
          unselectedItemColor: AppColors.scaffold(),
          //toggle
          onTap: (index) => setState(() => _current = index),
          items: [
            _item(Icons.person_outline, 'Профиль'),
            _item(Icons.play_circle_outline, 'Играть'),
            _item(Icons.burst_mode_outlined, 'Лента'),
            _item(Icons.question_mark_outlined, 'Вопросы'),
          ]);
}
