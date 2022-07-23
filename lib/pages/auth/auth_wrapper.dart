import 'package:flutter/material.dart';
import 'package:frontend/pages/auth/pages/sign_in_page.dart';
import 'package:frontend/pages/auth/pages/sign_up_page.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
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
