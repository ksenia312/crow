import 'package:flutter/material.dart';
import 'package:frontend/pages/feed_page/feed-page.dart';
import 'package:frontend/pages/game_page/game_page.dart';
import 'package:frontend/pages/questions_page/questions_page.dart';
import 'package:frontend/pages/user_page/user_page.dart';
import 'package:frontend/widgets/app_bar_children.dart';

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

  _getTitle() {
    switch (_current) {
      case 0:
        return 'Личный кабинет';
      case 1:
        return 'Сломай мозг';
      case 2:
        return 'Бесконечная лента';
      case 3:
        return 'Вопросы';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle(text: _getTitle()),
        leading: AppBarLeading(),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Theme.of(context).colorScheme.onSurface,
            ),
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
          backgroundColor: Theme.of(context).colorScheme.secondary,
          currentIndex: _current,
          //selected
          showSelectedLabels: false,
          selectedIconTheme: const IconThemeData(size: 35),
          selectedItemColor: Theme.of(context).colorScheme.onSecondary,
          iconSize: 30,
          //unselected
          showUnselectedLabels: false,
          unselectedItemColor: Theme.of(context).colorScheme.onTertiary,
          //tap
          onTap: (index) => setState(() => _current = index),
          items: [
            _item(Icons.person_outline, ''),
            _item(Icons.play_circle_outline, ''),
            _item(Icons.burst_mode_outlined, ''),
            _item(Icons.question_mark_outlined, ''),
          ]);
}
