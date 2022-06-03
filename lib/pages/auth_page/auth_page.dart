import 'package:flutter/material.dart';
import 'package:frontend/pages/auth_page/pages/sign_in_page.dart';
import 'package:frontend/pages/auth_page/pages/sign_up_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _registered = true;

  void toggleAuthView() {
    setState(() {
      _registered = !_registered;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_registered) {
      return SignInPage(toggleAuthView: toggleAuthView);
    } else {
      return SignUpPage(toggleAuthView: toggleAuthView);
    }
  }
}
