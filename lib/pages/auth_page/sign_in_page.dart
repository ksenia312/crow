import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/widgets/app_bar_children.dart';
import 'package:frontend/widgets/buttons.dart';
import 'package:frontend/widgets/label.dart';
import 'package:frontend/widgets/statuses/toast.dart';
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
  final Map<StatusesTypes, bool> _statusesValues = {
    StatusesTypes.error: false,
    StatusesTypes.loading: false,
  };
  final Map<SignInFieldType, String> _fieldsValues = {
    SignInFieldType.email: '',
    SignInFieldType.password: ''
  };
  late FToast fToast;
  bool disabled = true;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  _onFieldChanged(String value, SignInFieldType type) => setState(() {
        _fieldsValues[type] = value;
      });

  _toggleStatuses(bool value, StatusesTypes type) {
    setState(() {
      _statusesValues[type] = value;
    });
  }

  void _signIn() async {
    _toggleStatuses(true, StatusesTypes.loading);
    if (validateFields() == null) {
      var res = await _authService.signInWithEmailAndPassword(
          _fieldsValues[SignInFieldType.email]!,
          _fieldsValues[SignInFieldType.password]!);
      if (res is FirebaseAuthException) {
        _toggleStatuses(true, StatusesTypes.error);
        AppToast.showError(res, context);
      } else {
        Navigator.pushNamed(context, '/tabs');
      }
    }
    _toggleStatuses(false, StatusesTypes.loading);
  }

  @override
  Widget build(BuildContext context) {
    if (_fieldsValues[SignInFieldType.email] != '' &&
        _fieldsValues[SignInFieldType.password] != '') {
      setState(() {
        disabled = false;
      });
    } else {
      setState(() {
        disabled = true;
      });
    }
    return Scaffold(
      appBar: AppBar(title: const AppBarTitle(text: 'Вход в аккаунт')),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Form(
          key: _formKey,
          child: ListView(children: [
            AppTextButton(
                buttonText: 'Нет аккаунта? Зарегистрируйтесь!',
                type: AppTextButtonType.primary,
                onPressed: () {
                  widget.toggleAuthView!();
                }),
            const AppLabel(
              text: 'почта',
            ),
            _drawTextField('crow@example.com', false, SignInFieldType.email),
            const AppLabel(
              text: 'пароль',
              textAlign: TextAlign.end,
            ),
            _drawTextField('петя1234', true, SignInFieldType.password),
            _drawSignInButton(),
          ]),
        ),
      ),
    );
  }

  _drawTextField(
          String hintText, bool obscuringCharacter, SignInFieldType type) =>
      AppTextField(
          hintText: hintText,
          obscuringCharacter: obscuringCharacter,
          onChanged: (value) {
            _onFieldChanged(value, type);
          });

  SizedBox _drawSignInButton() => SizedBox(
        height: 80,
        child: Row(
          children: [
            AppTextButton(
              buttonText: 'Войти',
              type: AppTextButtonType.primary,
              size: AppTextButtonSize.medium,
              onPressed: _signIn,
              disabled: disabled,
            ),
            if (_statusesValues[StatusesTypes.loading] == true)
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: AppLoading(),
                ),
              )
          ],
        ),
      );

  String? validateFields() {
    var _validateEmail =
        emailTextFieldValidator(_fieldsValues[SignInFieldType.email]!);
    var _validatePassword =
        passwordTextFieldValidator(_fieldsValues[SignInFieldType.password]!);
    if (_validatePassword == null && _validateEmail == null) {
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
      AppToast.showWarning(_warning, context);
    }
    return '';
  }
}
