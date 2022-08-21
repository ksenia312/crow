import 'package:flutter/material.dart';
import 'package:frontend/pages/game_page/game_page.dart';
import 'package:frontend/pages/meditation_page/meditation_page.dart';
import 'package:frontend/pages/questions_page/questions_page.dart';
import 'package:frontend/pages/settings_page/settings_page.dart';
import 'package:frontend/widgets/dialogs/exit_dialog.dart';
import 'package:frontend/pages/tabs_page/widgets/init_dialog.dart';
import 'package:frontend/pages/user_page/user_page.dart';
import 'package:frontend/widgets/app_bar_children.dart';
import 'package:frontend/utils/dialog.dart';

class TabsPage extends StatefulWidget {
  final bool showInitDialog;
  final String dialogTitle;

  const TabsPage(
      {this.dialogTitle = 'Что вы хотите?',
      this.showInitDialog = false,
      Key? key})
      : super(key: key);

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  int _current = 0;
  bool showDialog = false;
  final List<Widget> _screens = const [
    UserPage(),
    GamePage(),
    MeditationPage()
  ];

  void setCurrent(current) {
    setState(() {
      _current = current;
    });
  }

  _getTitle() {
    switch (_current) {
      case 0:
        return 'Личный кабинет';
      case 1:
        return 'Сломай мозг';
      case 2:
        return 'Медитация';
    }
  }

  @override
  void initState() {
    if (widget.showInitDialog) {
      AppDialog.showCustomDialog(context,
          child: InitDialog(title: widget.dialogTitle, setCurrent: setCurrent));
      super.initState();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_current == 0) {
          AppDialog.showCustomDialog(context,
              child: const ExitDialog(
                  text: 'Вы уверены, что хотите выйти из аккаунта?'));
          setState(() {});
        }
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: AppBarTitle(text: _getTitle()),
          leading: AppBarLeading(onPressed: () {
            setCurrent(0);
          }),
          actions: [
            IconButton(
              icon: Icon(
                Icons.keyboard_double_arrow_down,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              onPressed: () {
                AppDialog.showCustomDialog(context,
                    child: InitDialog(
                        title: 'Что вы хотите?', setCurrent: setCurrent));
              },
            ),
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

  List<Widget> _generateItems() => List.generate(3, (int n) => n)
      .map((n) => Expanded(
            child: GestureDetector(
              onTap: () {
                setCurrent(n);
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
        Icons.emoji_emotions_outlined
      ];

  List _selectedIconNames() => [
        Icons.person,
        Icons.play_circle,
        Icons.emoji_emotions,
      ];

  List<Icon> _icons() => List.generate(
      3,
      (index) => Icon(
            _current == index
                ? _selectedIconNames()[index]
                : _iconNames()[index],
            size: _current == index ? 35 : 25,
            color: Theme.of(context).colorScheme.onSurface,
          )).toList();
}
