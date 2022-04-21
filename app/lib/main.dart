import 'package:flutter/material.dart';
import 'package:frontend/pages/settings_page/settings_page.dart';
import 'package:frontend/pages/splash_page/splash_page.dart';
import 'package:frontend/pages/statistics_page/statistics_page.dart';
import 'package:frontend/utils/theme.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.blue,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashPage(),
        '/statistics': (context) => const StatisticsPage(),
        '/settings': (context) => const SettingsPage(),
      },
    );
  }
}

