import 'package:flutter/material.dart';
import 'package:frontend/pages/game_page/game_home/game_home.dart';
import 'package:frontend/pages/game_page/level_router.dart';
import 'package:frontend/pages/settings_page/settings_page.dart';
import 'package:frontend/pages/splash_page/splash_page.dart';
import 'package:frontend/pages/statistics_page/statistics_page.dart';
import 'package:frontend/utils/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: currentTheme.currentTheme,
      routes: {
        '/': (context) => SplashPage(),
        '/statistics': (context) => const StatisticsPage(),
        '/settings': (context) => const SettingsPage(),
        '/level': (context) => const LevelRouter(),
        '/game-home': (context) => const GameHome()
      },
    );
  }
}
