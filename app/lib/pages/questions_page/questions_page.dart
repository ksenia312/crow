import 'package:flutter/material.dart';
import 'package:frontend/pages/questions_page/widgets/question.dart';
import 'package:frontend/widgets/cards/announcement_card.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({Key? key}) : super(key: key);

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const AnnouncementCard(
            headline2: ''
                'Вопросы',
            bodyText: 'Здесь будут рандомные вопросы и ответы на них'),
        Question(
          headline2: 'Почему небо голубое',
          bodyText1: 'Потому что ты дебил голубой блять',
          countViews: _handleCountViews(1212),
        ),
        Question(
          headline2: 'Почему ',
          bodyText1: 'Потому что ты дебил голубой блять',
          countViews: _handleCountViews(121112),
        ), Question(
          headline2: 'Почему a',
          bodyText1: 'Потому что ты дебил голубой блять',
          countViews: _handleCountViews(12112),
        ), Question(
          headline2: 'Почему d',
          bodyText1: 'Потому что ты дебил голубой блять',
          countViews: _handleCountViews(1211112),
        ),
        Question(
          headline2: 'Почему f',
          bodyText1: 'Потому что ты дебил голубой блять',
          countViews: _handleCountViews(12111212),
        ),
      ],
    );
  }

  String _handleCountViews(int countViews) {
    if (countViews.toString().length > 9) {
      return (countViews ~/ 1000000000).toString() + "B";
    } else if (countViews.toString().length > 6) {
      return (countViews ~/ 1000000).toString() + "M";
    } else if (countViews.toString().length > 3) {
      return (countViews ~/ 1000).toString() + "К";
    } else {
      return countViews.toString();
    }
  }
}
