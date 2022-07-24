import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/pages/auth/pages/acquaintance_page.dart';
import 'package:frontend/pages/auth/pages/verify_email_page.dart';
import 'package:frontend/pages/home_page.dart';
import 'package:frontend/pages/tabs_page/tabs_page.dart';

class Wrapper extends StatefulWidget {
  final bool showInitDialog;
  final String dialogTitle;

  const Wrapper({this.showInitDialog = false, this.dialogTitle = '', Key? key})
      : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void didUpdateWidget(covariant Wrapper oldWidget) {
    setState(() {});
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && !user.emailVerified) {
      return const VerifyEmailPage();
    } else if (user != null &&
        user.emailVerified &&
        (user.displayName == null || user.displayName?.isEmpty == true)) {
      return const AcquaintancePage();
    } else if (user != null &&
        user.emailVerified &&
        user.displayName?.isNotEmpty == true) {
      return widget.showInitDialog
          ? TabsPage(
              showInitDialog: widget.showInitDialog,
              dialogTitle: widget.dialogTitle,
            )
          : const TabsPage();
    } else {
      return const HomePage();
    }
  }
}
