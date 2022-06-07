import 'package:flutter/material.dart';
import 'package:frontend/models/auth_model.dart';
import 'package:frontend/models/user_model.dart';
import 'package:provider/provider.dart';

import 'user_database.dart';

class UserStreamBuilder extends StatelessWidget {
  final Widget Function(BuildContext, AsyncSnapshot<UserModel?>) builder;

  const UserStreamBuilder({required this.builder, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<AuthModel?>(context);
    return StreamBuilder<UserModel>(
        stream: UserDatabase(uid: user?.uid ?? '').userData, builder: builder);
  }
}
