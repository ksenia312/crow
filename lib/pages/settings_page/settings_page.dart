import 'package:flutter/material.dart';
import 'package:frontend/pages/settings_page/widgets/color_choice_panel.dart';
import 'package:frontend/services/user/auth_service.dart';
import 'package:frontend/services/user/user_stream_builder.dart';
import 'package:frontend/utils/indents.dart';
import 'package:frontend/utils/theme.dart';
import 'package:frontend/widgets/app_bar_children.dart';
import 'package:frontend/widgets/text_buttons.dart';
import 'package:frontend/widgets/list_tile.dart';
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
              _drawEmailEdit(email),
              _drawButtons(),
              ColorChoicePanel(pressed: _pressed, toggle: _toggleColorChoice),
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

  _drawEmailEdit(email) {
    return Container(
      margin: AppIndents.all5ExceptBottom,
      child: email != null
          ? AppListTile(
              headline2: '$email',
              bodyText: null,
              height: 60,
              textColor: Theme.of(context).colorScheme.onPrimary,
              color: Theme.of(context).colorScheme.primary,
              trailing: Icon(
                Icons.edit,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            )
          : const AppLoading(
              height: 60,
            ),
    );
  }
}
