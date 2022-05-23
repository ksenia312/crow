import 'package:flutter/material.dart';
import 'package:frontend/pages/feed_page/feed-page.dart';
import 'package:frontend/pages/game_page/game_page.dart';
import 'package:frontend/pages/randomizer_page/randomizer_page.dart';
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
    FeedPage(),
    RandomizerPage()
  ];

  _getTitle() {
    switch (_current) {
      case 0:
        return 'Личный кабинет';
      case 1:
        return 'Сломай мозг';
      case 2:
        return 'Медитация';
      case 3:
        return 'Рандомайзер';
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
                Navigator.pushNamed(context, '/settings');
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

  Container _bar() => Container(
        height: 50,
        color: Theme.of(context).colorScheme.primary,
        padding: const EdgeInsets.all(0.0),
        child: Row(mainAxisSize: MainAxisSize.min, children: _generateItems()),
      );

  List<Widget> _generateItems() => List.generate(4, (int n) => n)
      .map((n) => Expanded(
              child: ElevatedButton(
            onPressed: () {
              setState(() {
                _current = n;
              });
            },
            child: _current == n ? _selectedIcons()[n] : _icons()[n],
          )))
      .toList();

  List _icons({double size = 25.0}) => [
        Icon(Icons.person_outline, size: size),
        Icon(Icons.play_circle_outline, size: size),
        Icon(Icons.burst_mode_outlined, size: size),
        Icon(Icons.question_mark_outlined, size: size),
      ];

  List _selectedIcons({double size = 30.0}) => [
        Icon(Icons.person, size: size),
        Icon(Icons.play_circle, size: size),
        Icon(Icons.burst_mode, size: size),
        Icon(Icons.question_mark, size: size),
      ];
}
