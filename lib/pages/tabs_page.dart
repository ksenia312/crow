import 'package:flutter/material.dart';
import 'package:frontend/pages/game_page/game_page.dart';
import 'package:frontend/pages/questions_page/questions_page.dart';
import 'package:frontend/pages/randomizer_page/randomizer_page.dart';
import 'package:frontend/pages/settings_page/settings_page.dart';
import 'package:frontend/pages/user_page/user_page.dart';
import 'package:frontend/widgets/app_bar_children.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({Key? key}) : super(key: key);

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  int _current = 0;
  final List<Widget> _screens = const [
    UserPage(),
    GamePage(),
    RandomizerPage(),
    QuestionsPage()
  ];

  _getTitle() {
    switch (_current) {
      case 0:
        return 'Личный кабинет';
      case 1:
        return 'Сломай мозг';
      case 2:
        return 'Рандомайзер';
      case 3:
        return 'Вопрос';
    }
  }

  void onAppBarIconPressed() {
    setState(() {
      _current = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: AppBarTitle(text: _getTitle()),
          leading: AppBarLeading(onPressed: onAppBarIconPressed),
          actions: [
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const SettingsPage();
                  }),
                );
              },
            ),
          ],
        ),
        bottomNavigationBar: _bar(),
        body: Center(
          child: _screens.elementAt(_current),
        ),
      ),
    );
  }

  SizedBox _bar() => SizedBox(
        height: 50,
        child: Row(mainAxisSize: MainAxisSize.max, children: _generateItems()),
      );

  List<Widget> _generateItems() => List.generate(4, (int n) => n)
      .map((n) => Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _current = n;
                });
              },
              child: Container(
                  color: Theme.of(context).colorScheme.primary,
                  height: double.infinity,
                  child: _icons()[n]),
            ),
          ))
      .toList();

  List _iconNames() => [
        Icons.person_outline,
        Icons.play_circle_outline,
        Icons.burst_mode_outlined,
        Icons.question_mark_outlined,
      ];

  List _selectedIconNames() => [
        Icons.person,
        Icons.play_circle,
        Icons.burst_mode,
        Icons.question_mark,
      ];

  List<Icon> _icons() => List.generate(
      4,
      (index) => Icon(
            _current == index
                ? _selectedIconNames()[index]
                : _iconNames()[index],
            size: _current == index ? 35 : 25,
            color: Theme.of(context).colorScheme.onSurface,
          )).toList();
}
