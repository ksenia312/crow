import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/services/user/auth_service.dart';
import 'package:frontend/widgets/dialogs/support_dialog.dart';
import 'package:frontend/utils/styles.dart';
import 'package:frontend/widgets/app_bar_children.dart';
import 'package:frontend/utils/dialog.dart';
import 'package:frontend/widgets/statuses/toast.dart';
import 'package:frontend/widgets/text_buttons.dart';

import '../../wrapper/wrapper.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
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
      _checkVerificationTimer.cancel();
      _showTicksTimer.cancel();
      AppToast.showSuccess('Почта подтверждена', context);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Wrapper()));
    }
  }

  _getButtonText() {
    if (_timerTicks < 60 && _emailSent) {
      return 'Отправить заново через ${60 - _timerTicks}';
    } else {
      if (_emailSent) {
        return 'Отправить заново';
      } else if (_timerTicks < 60) {
        return 'Попробовать еще раз через ${60 - _timerTicks}';
      } else {
        return 'Попробовать еще раз';
      }
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
    final AuthService _auth = AuthService();
    return Scaffold(
        appBar: AppBar(
          title: const AppBarTitle(text: 'Подтвердите email'),
          automaticallyImplyLeading: false,
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppTextButton(
                  disabled: true,
                  loading: _loading,
                  showLoading: true,
                  buttonText: _emailSent
                      ? 'Сообщение отправлено на почту ${_user?.email}'
                      : 'Сообщение не отправлено'),
              AppTextButton(
                buttonText: _getButtonText(),
                type: AppTextButtonType.secondary,
                disabled: _timerTicks < 60,
                loading: _loading,
                showLoading: true,
                onPressed: () {
                  if (_timerTicks >= 60) {
                    _sendEmailVerification();
                  }
                },
              ),
              AppTextButton(
                buttonText: 'Домой',
                type: AppTextButtonType.tertiary,
                showLoading: true,
                onPressed: () async {
                  await _auth.signOut();
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/home', (Route<dynamic> route) => false);
                },
              ),
              Padding(
                padding: AppIndents.vertical15,
                child: InkWell(
                  child: Text(
                    'Не приходит письмо или какие-то проблемы?',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle1!.apply(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                  onTap: () {
                    AppDialog.showCustomDialog(context,
                        child: SupportDialog(
                          isVerifyEmail: true,
                          email: _user?.email,
                          text:
                              '1. Проверьте корректность введенного электронного адреса \n(Если почта неверная, нажмите на "Изменить почту" или создайте новый аккаунт с другой почтой). \n2. Проверьте папку "Спам". \n3. Попробуйте отправить письмо заново.  \n\nВ ином случае - обратитесь в поддержку.',
                        ));
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
