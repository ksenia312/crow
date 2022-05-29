import 'package:flutter/material.dart';
import 'package:frontend/pages/questions_page/widgets/question.dart';
import 'package:frontend/utils/indents.dart';
import 'package:frontend/widgets/buttons.dart';
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
              'Топ вопросов',
          bodyText: 'Самые просматриваемые',
          showCloseButton: false,
          height: 70,
        ),
        Padding(
          padding: AppIndents.allMargin,
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  blurRadius: 5,
                  color: Theme.of(context).colorScheme.tertiary,
                  offset: Offset(0, 3)),
            ]),
            child: Column(
              children: [
                Question(
                  headline2: 'Почему небо голубое',
                  bodyText1: 'Потому что ты дебил голубой блять',
                  countViews: _handleCountViews(1212),
                ),
                Question(
                  headline2: 'Почему ',
                  bodyText1: 'Потому что ты дебил голубой блять',
                  countViews: _handleCountViews(121112),
                ),
                Question(
                  headline2: 'Почему a',
                  bodyText1: 'Потому что ты дебил голубой блять',
                  countViews: _handleCountViews(12112),
                ),
                Question(
                  headline2: 'Почему d',
                  bodyText1: 'Потому что ты дебил голубой блять',
                  countViews: _handleCountViews(1211112),
                ),
                Question(
                  headline2: 'Почему f',
                  bodyText1: 'Потому что ты дебил голубой блять',
                  countViews: _handleCountViews(1211551212),
                ),
              ],
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: AppTextButton(
                buttonText: 'все вопросы',
                size: AppTextButtonSize.medium,
                onPressed: () {},
              ),
            ),
            Expanded(
                child: AppTextButton(
              buttonText: 'рандом',
              size: AppTextButtonSize.medium,
              type: AppTextButtonType.secondary,
              onPressed: () {},
              margin: const EdgeInsets.only(right: 5, top: 5),
            ))
          ],
        )
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
