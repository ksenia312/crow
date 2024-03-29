import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/pages/auth/pages/verify_email_page.dart';
import 'package:frontend/services/user/auth_service.dart';
import 'package:frontend/utils/types.dart';
import 'package:frontend/widgets/app_bar_children.dart';
import 'package:frontend/widgets/text_buttons.dart';
import 'package:frontend/widgets/text_field/label.dart';
import 'package:frontend/widgets/statuses/toast.dart';
import 'package:frontend/widgets/text_field/text_field.dart';
import 'package:frontend/widgets/text_field/validators.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  final Function? toggleAuthView;

  const SignUpPage({required this.toggleAuthView, Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool disabled = true;
  late FToast fToast;

  final Map<SignUpFieldType, String> _fieldsValues = {
    SignUpFieldType.email: '',
    SignUpFieldType.password: '',
    SignUpFieldType.repeatedPassword: '',
    SignUpFieldType.name: '',
    SignUpFieldType.age: ''
  };

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  Future<SharedPreferences> _initPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  _onFieldChanged(String value, SignUpFieldType type) => setState(() {
        _fieldsValues[type] = value.trim();
      });

  void _continue() async {
    if (validateFields() == null) {
      var res = await _authService.signUpWithEmailAndPassword(
        _fieldsValues[SignUpFieldType.email]!,
        _fieldsValues[SignUpFieldType.password]!,
      );
      if (res is FirebaseAuthException) {
        AppToast.showError(res, context);
      } else {
        _initPrefs().then((value) {
          value.setString('email', _fieldsValues[SignUpFieldType.email]!);
        });
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const VerifyEmailPage()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_fieldsValues[SignUpFieldType.email] != '' &&
        _fieldsValues[SignUpFieldType.password] != '' &&
        _fieldsValues[SignUpFieldType.repeatedPassword] != '') {
      setState(() {
        disabled = false;
      });
    } else {
      setState(() {
        disabled = true;
      });
    }
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
              const AppLabel(text: 'почта'),
              _drawTextField('crow@example.com', false, SignUpFieldType.email,
                  emailTextFieldValidator),
              const AppLabel(text: 'пароль'),
              _drawTextField('петр1234', true, SignUpFieldType.password,
                  passwordTextFieldValidator),
              const AppLabel(text: 'повтор пароля'),
              _drawTextField('петр1234', true, SignUpFieldType.repeatedPassword,
                  repeatedPasswordTextFieldValidator),
              _drawSignUpButton(),
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
      Function validator) {
    return AppTextField(
        obscuringCharacter: obscuringCharacter,
        hintText: hintText,
        onChanged: (value) {
          _onFieldChanged(value, type);
        },
        validator: (value) {
          return validator(value);
        });
  }

  Column _drawSignUpButton() => Column(
        children: [
          AppTextButton(
            buttonText: 'Продолжить',
            type: AppTextButtonType.primary,
            size: AppTextButtonSize.large,
            onPressed: _continue,
            disabled: disabled,
            showLoading: true,
          )
        ],
      );

  String? validateFields() {
    var _validateEmail =
        emailTextFieldValidator(_fieldsValues[SignUpFieldType.email]!);
    var _validatePassword =
        passwordTextFieldValidator(_fieldsValues[SignUpFieldType.password]!);

    var _passwordsAreSame = _fieldsValues[SignUpFieldType.password] ==
        _fieldsValues[SignUpFieldType.repeatedPassword];
    if (_validatePassword == null &&
        _validateEmail == null &&
        _passwordsAreSame) {
      return null;
    } else {
      var _warning = '';
      if (_validateEmail != null) {
        _warning += _validateEmail;
      }
      if (_validatePassword != null) {
        if (_warning != '') _warning += '\n';
        _warning += _validatePassword;
      }
      if (!_passwordsAreSame && _validatePassword == null) {
        if (_warning != '') _warning += '\n';
        _warning += 'Пароли не совпадают';
      }
      AppToast.showWarning(_warning, context);
    }
    return '';
  }
}
