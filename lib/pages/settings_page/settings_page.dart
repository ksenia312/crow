import 'package:flutter/material.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/pages/settings_page/widgets/color_choice_panel.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/utils/theme.dart';
import 'package:frontend/widgets/app_bar_children.dart';
import 'package:frontend/widgets/buttons.dart';
import 'package:frontend/widgets/cards/announcement_card.dart';
import 'package:frontend/widgets/statuses/loading.dart';
import 'package:provider/provider.dart';

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
    Navigator.pushNamed(context, '/home');
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const AppBarTitle(text: 'Настройки'),
          leading: AppBarLeading(iconBack: true),
        ),
        body: ListView(
          children: <Widget>[
            Consumer<UserModel?>(builder: (context, UserModel? user, child) {
              var email = user?.email ?? '';
              return AnnouncementCard(
                headline2: 'Настройки',
                bodyText: 'email: ' + email,
                showCloseButton: false,
              );
            }),
            _drawButtons(),
            ColorChoicePanel(pressed: _pressed, toggle: _toggleColorChoice),
            AppTextButton(
                buttonText: 'выйти из аккаунта',
                type: AppTextButtonType.warning,
                onPressed: _signOut),
            if (_loading == true)
              SizedBox(height: 50, child: AppLoading())
          ],
        ));
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
                  buttonText: 'цвет: выбрать',
                  type: _pressed
                      ? AppTextButtonType.tertiary
                      : AppTextButtonType.primary,
                  size: AppTextButtonSize.medium,
                  onPressed: _toggleColorChoice))
        ],
      );
}
