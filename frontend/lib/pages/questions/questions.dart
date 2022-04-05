import 'package:flutter/material.dart';
import 'package:frontend/utils/theme.dart';

class Questions extends StatefulWidget {
  const Questions({Key? key}) : super(key: key);

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('qаааue', style: AppTheme.bodyText(context)));
  }
}

