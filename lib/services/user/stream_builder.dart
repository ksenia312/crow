import 'package:flutter/material.dart';
import 'package:frontend/models/auth_model.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/services/user/database.dart';
import 'package:provider/provider.dart';

class UserStreamBuilder extends StatelessWidget {
  final Widget Function(BuildContext, AsyncSnapshot<UserModel>) drawChild;

  const UserStreamBuilder({required this.drawChild, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<AuthModel?>(context);
    return StreamBuilder<UserModel>(
        stream: UserService(uid: user!.uid).userData,
        builder: drawChild);
  }
}
