import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/pages/auth/pages/change_email_page.dart';
import 'package:frontend/pages/settings_page/widgets/color_choice_panel.dart';
import 'package:frontend/pages/settings_page/widgets/email_block.dart';
import 'package:frontend/pages/settings_page/widgets/support_developer.dart';
import 'package:frontend/services/user/auth_service.dart';
import 'package:frontend/services/user/user_database.dart';
import 'package:frontend/services/user/user_stream_builder.dart';
import 'package:frontend/utils/theme.dart';
import 'package:frontend/widgets/app_bar_children.dart';
import 'package:frontend/widgets/dialogs/support_dialog.dart';
import 'package:frontend/utils/dialog.dart';
import 'package:frontend/widgets/statuses/loading.dart';
import 'package:frontend/widgets/text_buttons.dart';

import '../../models/user_model.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _pressed = false;
  bool _emailUpdated = false;
  final AuthService _auth = AuthService();
  final User? _firebaseUser = FirebaseAuth.instance.currentUser;

  void updateEmail(
      {required User? firebaseUser, required UserModel? databaseUser}) async {
    if (firebaseUser?.email != databaseUser?.email) {
      await UserDatabase(uid: databaseUser!.uid)
          .updateUserEmail(email: firebaseUser!.email);
    }
    _emailUpdated = true;
  }

  void _toggleColorChoice() {
    setState(() {
      _pressed = !_pressed;
    });
  }

  void _signOut() async {
    await _auth.signOut();
    Navigator.pushNamedAndRemoveUntil(
        context, '/home', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return UserStreamBuilder(builder: (context, userSnapshot) {
      var email = userSnapshot.data?.email;
      if (!_emailUpdated &&
          userSnapshot.data?.email != null && // if user restored his previous email
          _firebaseUser?.email != null) {
        updateEmail(
            firebaseUser: _firebaseUser, databaseUser: userSnapshot.data);
      }
      return Scaffold(
          appBar: AppBar(
            title: const AppBarTitle(text: 'Настройки'),
            leading: const AppBarLeading(iconBack: true),
          ),
          body: ListView(
            children: <Widget>[
              const SupportDeveloper(),
              _emailUpdated
                  ? EmailBlock(text: '$email')
                  : _drawEmailUpdating(),
              _drawThemeButtons(),
              ColorChoicePanel(pressed: _pressed, toggle: _toggleColorChoice),
              AppTextButton(
                buttonText: 'изменить почту',
                type: AppTextButtonType.tertiary,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ChangeEmailPage(email: email)));
                },
              ),
              AppTextButton(
                buttonText: 'задать вопрос',
                type: AppTextButtonType.tertiary,
                onPressed: () {
                  AppDialog.showCustomDialog(context,
                      child:
                          const SupportDialog(text: 'Как с нами связаться?'));
                },
              ),
              AppTextButton(
                  buttonText: 'выйти из аккаунта',
                  type: AppTextButtonType.warning,
                  showLoading: true,
                  onPressed: _signOut),
            ],
          ));
    });
  }

  Row _drawThemeButtons() => Row(
        children: [
          Expanded(
            child: AppTextButton(
              buttonText:
                  'тема:\n ${Theme.of(context).brightness == Brightness.dark ? 'темная' : 'светлая'}',
              type: AppTextButtonType.secondary,
              size: AppTextButtonSize.medium,
              onPressed: () {
                appTheme.toggleTheme();
              },
            ),
          ),
          Expanded(
              child: AppTextButton(
                  buttonText: 'цвет: \nвыбрать',
                  type: _pressed
                      ? AppTextButtonType.tertiary
                      : AppTextButtonType.primary,
                  size: AppTextButtonSize.medium,
                  margin: const EdgeInsets.only(right: 5, top: 5),
                  onPressed: _toggleColorChoice))
        ],
      );

  SizedBox _drawEmailUpdating() => SizedBox(
    height: 100,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Обновление...',
          style: Theme.of(context).textTheme.headline2!.apply(
              color:
              Theme.of(context).colorScheme.onBackground),
        ),
        AppLoading(
            height: 30,
            color:
            Theme.of(context).colorScheme.onBackground),
      ],
    ),
  );
}
