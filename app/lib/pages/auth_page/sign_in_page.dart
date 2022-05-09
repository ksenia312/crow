import 'package:flutter/material.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/widgets/app_bar_children.dart';
import 'package:frontend/widgets/buttons.dart';
import 'package:frontend/widgets/label.dart';
import 'package:frontend/widgets/statuses/loading.dart';
import 'package:frontend/widgets/statuses/types.dart';
import 'package:frontend/widgets/text_field/text_field.dart';
import 'package:frontend/widgets/text_field/types.dart';
import 'package:frontend/widgets/text_field/validators.dart';

class SignInPage extends StatefulWidget {
  final Function? toggleAuthView;

  const SignInPage({required this.toggleAuthView, Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  final Map<StatusType, bool> _statuses = {
    StatusType.loading: false,
    StatusType.error: false
  };

  final Map<SignInFieldType, String> _fieldsValues = {
    SignInFieldType.email: '',
    SignInFieldType.password: ''
  };

  _onFieldChanged(String value, SignInFieldType type) => setState(() {
        _fieldsValues[type] = value;
      });

  _toggleStatuses(StatusType type, bool value) => setState(() {
        _statuses[type] = value;
      });

  void _signIn() async {
    _toggleStatuses(StatusType.loading, true);
    if (_formKey.currentState!.validate()) {
      var res = await _authService.signInWithEmailAndPassword(
          _fieldsValues[SignInFieldType.email]!,
          _fieldsValues[SignInFieldType.password]!);
      if (res == null) {
        _toggleStatuses(StatusType.error, true);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Введен неверный email или пароль',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ));
      } else {
        Navigator.pushNamed(context, '/tabs');
      }
      _toggleStatuses(StatusType.loading, false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const AppBarTitle(text: 'Вход в аккаунт')),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              AppTextButton(
                buttonText: 'Нет аккаунта? Зарегистрируйтесь!',
                type: AppTextButtonType.primary,
                onPressed: () {
                  widget.toggleAuthView!();
                },
              ),
              const AppLabel(text: 'email'),
              _drawTextField('crow@example.com', false, SignInFieldType.email,
                  emailTextFieldValidator),
              const AppLabel(
                text: 'password',
                textAlign: TextAlign.end,
              ),
              _drawTextField('password', true, SignInFieldType.password,
                  passwordTextFieldValidator),
              _drawSignInButton()
            ],
          ),
        ),
      ),
    );
  }

  _drawTextField(String hintText, bool obscuringCharacter, SignInFieldType type,
          Function? validator) =>
      AppTextField(
        hintText: hintText,
        obscuringCharacter: obscuringCharacter,
        onChanged: (value) {
          _onFieldChanged(value, type);
        },
        validator: validator,
      );

  SizedBox _drawSignInButton() => SizedBox(
        height: 80,
        child: Row(
          children: [
            AppTextButton(
              buttonText: 'Войти',
              type: AppTextButtonType.primary,
              size: AppTextButtonSize.medium,
              onPressed: _signIn,
            ),
            if (_statuses[StatusType.loading] == true)
              const Center(
                child: SizedBox(height: 200, child: AppLoading()),
              )
          ],
        ),
      );
}
