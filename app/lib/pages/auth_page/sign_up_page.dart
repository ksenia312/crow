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

class SignUpPage extends StatefulWidget {
  final Function? toggleAuthView;

  const SignUpPage({required this.toggleAuthView, Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  final Map<StatusType, bool> _statuses = {
    StatusType.loading: false,
    StatusType.error: false
  };

  final Map<SignUpFieldType, String> _fieldsValues = {
    SignUpFieldType.email: '',
    SignUpFieldType.password: '',
    SignUpFieldType.repeatedPassword: ''
  };

  _onFieldChanged(String value, SignUpFieldType type) => setState(() {
        _fieldsValues[type] = value;
      });

  _toggleStatuses(StatusType type, bool value) => setState(() {
        _statuses[type] = value;
      });

  void _signUp() async {
    _toggleStatuses(StatusType.loading, true);
    if (_fieldsValues[SignUpFieldType.password] !=
        _fieldsValues[SignUpFieldType.repeatedPassword]) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Пароли не совпадают',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ));
    } else if (_formKey.currentState!.validate()) {
      var res = await _authService.signUpWithEmailAndPassword(
          _fieldsValues[SignUpFieldType.email]!,
          _fieldsValues[SignUpFieldType.password]!);
      if (res == null) {
        _toggleStatuses(StatusType.error, true);
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('error')));
      } else {
        Navigator.pushNamed(context, '/tabs');
      }
      _toggleStatuses(StatusType.loading, false);
    }
    _toggleStatuses(StatusType.loading, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(text: 'Создание учетной записи'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const AppLabel(text: 'email'),
              _drawTextField('crow@example.com', false, SignUpFieldType.email,
                  emailTextFieldValidator),
              const AppLabel(text: 'password'),
              _drawTextField('password', true, SignUpFieldType.password,
                  passwordTextFieldValidator),
              const AppLabel(text: 'repeat password'),
              _drawTextField('password', true, SignUpFieldType.repeatedPassword,
                  repeatedPasswordTextFieldValidator),
              _drawSignInButton(),
              AppTextButton(
                buttonText: 'Вернуться к входу в аккаунт',
                type: AppTextButtonType.tertiary,
                onPressed: () {
                  widget.toggleAuthView!();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _drawTextField(String hintText, bool obscuringCharacter, SignUpFieldType type,
          Function validator) =>
      AppTextField(
          obscuringCharacter: obscuringCharacter,
          hintText: hintText,
          onChanged: (value) {
            _onFieldChanged(value, type);
          },
          validator: (value) {
            return validator(value);
          });

  Column _drawSignInButton() => Column(
        children: [
          AppTextButton(
            buttonText: 'Зарегистрироваться',
            type: AppTextButtonType.primary,
            size: AppTextButtonSize.large,
            onPressed: _signUp,
          ),
          if (_statuses[StatusType.loading] == true)
            const SizedBox(height: 50, child: AppLoading())
        ],
      );
}
