import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/pages/auth_page/pages/acquaintance_page.dart';
import 'package:frontend/pages/home_page.dart';
import 'package:frontend/pages/tabs_page/tabs_page.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && user.emailVerified && user.displayName == null) {
      return const AcquaintancePage();
    } else if (user != null && user.emailVerified) {
      return const TabsPage();
    } else {
      return HomePage();
    }
  }
}
