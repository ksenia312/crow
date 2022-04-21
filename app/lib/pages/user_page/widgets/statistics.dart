import 'package:flutter/material.dart';
import 'package:frontend/utils/assets_variables.dart';
import 'package:frontend/utils/indents.dart';
import '../../../utils/colors.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  final url = getAsset(AppAssets.images, 'stats_bg.png');

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: AppIndents.basicMargin(),
      elevation: 0,
      color: AppColors.transparent(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/statistics');
            },
            child: Stack(children: [
              Container(
                  height: 200,
                  width: double.infinity,
                  child: null,
                  decoration: _boxDecoration()),
              _drawText()
            ])),
      ),
    );
  }

  Widget _drawText() => const Positioned(
        child: Text('Ваша статистика'),
        bottom: 30,
        left: 30,
      );

  BoxDecoration _boxDecoration() => BoxDecoration(
        image: DecorationImage(
            image: AssetImage(url),
            fit: BoxFit.cover,
            alignment: Alignment.topRight),
      );
}
