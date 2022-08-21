import 'package:flutter/material.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({Key? key}) : super(key: key);

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [Text('d')],
    );
  }

  /*String _handleCountViews(int countViews) {
    if (countViews.toString().length > 9) {
      return (countViews ~/ 1000000000).toString() + "B";
    } else if (countViews.toString().length > 6) {
      return (countViews ~/ 1000000).toString() + "M";
    } else if (countViews.toString().length > 3) {
      return (countViews ~/ 1000).toString() + "К";
    } else {
      return countViews.toString();
    }
  }*/
}
