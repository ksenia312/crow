import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/pages/auth/pages/reset_password_page.dart';
import 'package:frontend/pages/wrapper/wrapper.dart';
import 'package:frontend/services/user/auth_service.dart';
import 'package:frontend/utils/styles.dart';
import 'package:frontend/widgets/app_bar_children.dart';
import 'package:frontend/widgets/text_buttons.dart';
import 'package:frontend/widgets/text_field/label.dart';
import 'package:frontend/widgets/statuses/toast.dart';
import 'package:frontend/utils/types.dart';
import 'package:frontend/widgets/text_field/text_field.dart';
import 'package:frontend/widgets/text_field/validators.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  final Function toggleAuthView;

  const SignInPage({required this.toggleAuthView, Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  final Map<SignInFieldType, String> _fieldsValues = {
    SignInFieldType.email: '',
    SignInFieldType.password: ''
  };
  late FToast fToast;
  bool _disabled = true;
  bool _prefsEmailLoading = true;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    _initPrefs().then((value) {
      _onFieldChanged(value.getString('email') ?? '', SignInFieldType.email);
      setState(() {
        _prefsEmailLoading = false;
      });
    });
  }

  Future<SharedPreferences> _initPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  _onFieldChanged(String value, SignInFieldType type) {
    setState(() {
      _fieldsValues[type] = value;
    });
  }

  void _signIn() async {
    if (validateFields() == null) {
      var res = await _authService.signInWithEmailAndPassword(
          _fieldsValues[SignInFieldType.email]!,
          _fieldsValues[SignInFieldType.password]!);
      if (res is FirebaseAuthException) {
        AppToast.showError(res, context);
      } else {
        await SharedPreferences.getInstance().then((value) {
          value.setString('email', _fieldsValues[SignInFieldType.email]!);
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return const Wrapper(
              showInitDialog: true,
              dialogTitle: 'Вы вошли в аккаунт! Чем теперь займемся?',
            );
          }),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_fieldsValues[SignInFieldType.email] != '' &&
        _fieldsValues[SignInFieldType.password] != '') {
      setState(() {
        _disabled = false;
      });
    } else {
      setState(() {
        _disabled = true;
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
                  widget.toggleAuthView();
                }),
            const AppLabel(
              text: 'почта',
            ),
            _prefsEmailLoading
                ? Container()
                : _drawTextField(
                    'crow@example.com', false, SignInFieldType.email),
            const AppLabel(
              text: 'пароль',
              textAlign: TextAlign.end,
            ),
            _drawTextField('петр1234', true, SignInFieldType.password),
            _drawSignInButton(),
            _drawForgetPasswordLink()
          ]),
        ),
      ),
    );
  }

  _drawTextField(
      String hintText, bool obscuringCharacter, SignInFieldType type) {
    return AppTextField(
        hintText: hintText,
        obscuringCharacter: obscuringCharacter,
        initialValue: _fieldsValues[type],
        onChanged: (value) {
          _onFieldChanged(value, type);
        });
  }

  SizedBox _drawSignInButton() => SizedBox(
        height: 80,
        child: Row(
          children: [
            AppTextButton(
                buttonText: 'Войти',
                type: AppTextButtonType.primary,
                size: AppTextButtonSize.medium,
                showLoading: true,
                onPressed: _signIn,
                disabled: _disabled)
          ],
        ),
      );

  _drawForgetPasswordLink() => Padding(
        padding: AppIndents.vertical15,
        child: InkWell(
          child: Text(
            'Забыли пароль?',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .apply(color: Theme.of(context).colorScheme.onBackground),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ResetPasswordPage(
                        email: _fieldsValues[SignInFieldType.email]!)));
          },
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
