import 'package:flutter/material.dart';
import 'package:frontend/pages/questions/questions.dart';
import 'package:frontend/utils/theme.dart';

import 'pages/feed/feed.dart';
import 'pages/game/game.dart';
import 'pages/landing.dart';
import 'pages/user/user.dart';

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
        '/': (context) => const Landing(),
        '/user': (context) => const User(),
        '/game': (context) => const Game(),
        '/feed': (context) => const Feed(),
        '/questions': (context) => const Questions(),
      },
    );
  }
}
