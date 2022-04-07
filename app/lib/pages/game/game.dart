import 'package:flutter/material.dart';
import 'package:frontend/utils/theme.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('game', style: AppTheme.bodyText(context)));
  }
}

