import 'package:flutter/material.dart';
import 'package:frontend/models/auth_model.dart';
import 'package:frontend/pages/home_page.dart';
import 'package:frontend/pages/tabs_page/tabs_page.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var authResult = Provider.of<AuthModel?>(context);
    if (authResult == null) {
      return HomePage();
    } else {
      return const TabsPage();
    }
  }
}
