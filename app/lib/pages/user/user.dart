import 'package:flutter/material.dart';
import 'package:frontend/uikit/title.dart';
import 'package:frontend/utils/theme.dart';

class User extends StatefulWidget {
  const User({Key? key}) : super(key: key);

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('user', style: AppTheme.bodyText(context)));
  }
}
