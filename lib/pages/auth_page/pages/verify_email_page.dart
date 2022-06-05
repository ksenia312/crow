import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/pages/auth_page/pages/acquaintance_page.dart';
import 'package:frontend/services/user/user_database.dart';
import 'package:frontend/widgets/app_bar_children.dart';
import 'package:frontend/widgets/cards/announcement_card.dart';
import 'package:frontend/widgets/statuses/loading.dart';
import 'package:frontend/widgets/statuses/toast.dart';
import 'package:frontend/widgets/text_buttons.dart';

class VerifyEmailDialog extends StatefulWidget {
  const VerifyEmailDialog({Key? key}) : super(key: key);

  @override
  State<VerifyEmailDialog> createState() => _VerifyEmailDialogState();
}

class _VerifyEmailDialogState extends State<VerifyEmailDialog> {
  late User? _user;
  late Timer _checkVerificationTimer;
  late Timer _showTicksTimer;
  int _timerTicks = 0;
  bool _loading = true;
  bool _emailSent = false;
  late FToast fToast;

  @override
  void initState() {
    fToast = FToast();
    fToast.init(context);
    _user = FirebaseAuth.instance.currentUser;
    _sendEmailVerification();
    _checkVerificationTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      _checkEmailVerification();
    });
    _showTicksTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _timerTicks += 1;
      });
    });
    super.initState();
  }

  Future _sendEmailVerification() async {
    setState(() {
      _timerTicks = 0;
      _loading = true;
      _emailSent = false;
    });
    await _user?.sendEmailVerification().then((value) {
      setState(() {
        _loading = false;
        _emailSent = true;
      });
    }).onError((error, stackTrace) {
      setState(() {
        _loading = false;
        _emailSent = false;
      });
      AppToast.showError(error, context);
    });
  }

  void _checkEmailVerification() {
    User? user = FirebaseAuth.instance.currentUser;
    user?.reload();
    if (user?.emailVerified == true) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const AcquaintancePage()));
    }
  }

  @override
  void dispose() {
    _checkVerificationTimer.cancel();
    _showTicksTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            title: const AppBarTitle(text: 'Подтвердите email'),
            automaticallyImplyLeading: false,
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _loading
                    ? const AppLoading()
                    : AnnouncementCard(
                        headline2: _emailSent
                            ? 'Сообщение отправлено на почту ${_user?.email}'
                            : 'Не получилось отправить письмо',
                        bodyText: null,
                        showCloseButton: false,
                        height: null,
                      ),
                _emailSent
                    ? AppTextButton(
                        buttonText: _timerTicks < 60
                            ? 'Отправить заново через ${60 - _timerTicks}'
                            : 'Отправить заново',
                        type: AppTextButtonType.secondary,
                        disabled: _timerTicks < 60,
                        onPressed: () {
                          if (_timerTicks >= 60) {
                            _sendEmailVerification();
                          }
                        },
                      )
                    : Container(),
                AppTextButton(
                  buttonText: 'Назад',
                  type: AppTextButtonType.tertiary,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          )),
    );
  }
}
