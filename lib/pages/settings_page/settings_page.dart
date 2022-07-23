import 'package:flutter/material.dart';
import 'package:frontend/pages/auth/pages/change_email_page.dart';
import 'package:frontend/pages/settings_page/widgets/color_choice_panel.dart';
import 'package:frontend/pages/settings_page/widgets/email_block.dart';
import 'package:frontend/pages/settings_page/widgets/support_developer.dart';
import 'package:frontend/services/user/auth_service.dart';
import 'package:frontend/services/user/user_stream_builder.dart';
import 'package:frontend/utils/theme.dart';
import 'package:frontend/widgets/app_bar_children.dart';
import 'package:frontend/widgets/support_dialog.dart';
import 'package:frontend/widgets/statuses/dialog.dart';
import 'package:frontend/widgets/text_buttons.dart';
import 'package:frontend/widgets/statuses/loading.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _pressed = false;
  bool _loading = false;
  final AuthService _auth = AuthService();

  void _toggleColorChoice() {
    setState(() {
      _pressed = !_pressed;
    });
  }

  void _signOut() async {
    setState(() {
      _loading = true;
    });
    await _auth.signOut();
    Navigator.pushNamedAndRemoveUntil(
        context, '/home', (Route<dynamic> route) => false);
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return UserStreamBuilder(builder: (context, userSnapshot) {
      var email = userSnapshot.data?.email;
      return Scaffold(
          appBar: AppBar(
            title: const AppBarTitle(text: 'Настройки'),
            leading: AppBarLeading(iconBack: true),
          ),
          body: ListView(
            children: <Widget>[
              const SupportDeveloper(),
             EmailBlock(text: '$email'),
              _drawButtons(),
              ColorChoicePanel(pressed: _pressed, toggle: _toggleColorChoice),
              AppTextButton(
                buttonText: 'изменить почту',
                type: AppTextButtonType.tertiary,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>  ChangeEmailPage(email: email)));
                },
              ),
              AppTextButton(
                buttonText: 'задать вопрос',
                type: AppTextButtonType.tertiary,
                onPressed: () {
                  AppDialog.showCustomDialog(context,
                      child: const SupportDialog(text: 'Как с нами связаться?'));
                },
              ),
              _loading == true
                  ? const SizedBox(height: 60, child: AppLoading())
                  : AppTextButton(
                      buttonText: 'выйти из аккаунта',
                      type: AppTextButtonType.warning,
                      onPressed: _signOut),
            ],
          ));
    });
  }

  Row _drawButtons() => Row(
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
}
