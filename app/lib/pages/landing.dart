import 'package:flutter/material.dart';
import 'package:frontend/uikit/app-bar-children.dart';
import 'package:frontend/utils/colors.dart';

import 'feed/feed.dart';
import 'game/game.dart';
import 'questions/questions.dart';
import 'user/user.dart';

class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  int _current = 0;
  final List<Widget> _screens = const [User(), Game(), Feed(), Questions()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBarTitle(),
        leading: appBarLeading(),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
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
          backgroundColor: AppColors.extraLight(),
          currentIndex: _current,
          //selected
          showSelectedLabels: false,
          selectedIconTheme: const IconThemeData(size: 35),
          selectedItemColor: AppColors.darkBlue(),
          iconSize: 30,
          //unselected
          showUnselectedLabels: false,
          unselectedItemColor: AppColors.lightBlue(),
          //toggle
          onTap: (index) => setState(() => _current = index),
          items: [
            _item(Icons.person_outline, 'Профиль'),
            _item(Icons.play_circle_outline, 'Играть'),
            _item(Icons.burst_mode_outlined, 'Лента'),
            _item(Icons.question_mark_outlined, 'Вопросы'),
          ]);
}
