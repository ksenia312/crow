import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/pages/tabs_page/tabs_page.dart';
import 'package:frontend/services/user/auth_service.dart';
import 'package:frontend/widgets/label.dart';
import 'package:frontend/widgets/statuses/loading.dart';
import 'package:frontend/widgets/statuses/toast.dart';
import 'package:frontend/widgets/text_buttons.dart';
import 'package:frontend/widgets/text_field/text_field.dart';
import 'package:frontend/widgets/text_field/types.dart';
import 'package:frontend/widgets/text_field/validators.dart';

class SignUpDialog extends StatefulWidget {
  final Function(String value, SignUpFieldType type) onFieldChanged;
  final Map fieldsValues;

  const SignUpDialog(
      {required this.fieldsValues, required this.onFieldChanged, Key? key})
      : super(key: key);

  @override
  State<SignUpDialog> createState() => _SignUpDialogState();
}

class _SignUpDialogState extends State<SignUpDialog> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  bool disabled = true;
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  _toggleLoading() {
    setState(() {
      _loading = !_loading;
    });
  }

  void _signUp() async {
    _toggleLoading();
    if (validateFields() == null) {
      var res = await _authService.signUpWithEmailAndPassword(
        widget.fieldsValues[SignUpFieldType.email]!,
        widget.fieldsValues[SignUpFieldType.password]!,
        widget.fieldsValues[SignUpFieldType.name]!,
        int.parse(widget.fieldsValues[SignUpFieldType.age]!),
      );
      if (res is FirebaseAuthException) {
        AppToast.showError(res, context);
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) {
            return const TabsPage(
              showInitDialog: true,
              dialogTitle: 'Вы создали аккаунт! Чем теперь займемся?',
            );
          }),
        );
      }
    }
    _toggleLoading();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.fieldsValues[SignUpFieldType.name] != '' &&
        widget.fieldsValues[SignUpFieldType.age] != '') {
      setState(() {
        disabled = false;
      });
    } else {
      setState(() {
        disabled = true;
      });
    }
    return SimpleDialog(
        contentPadding: const EdgeInsets.only(bottom: 5),
        backgroundColor: Theme.of(context).colorScheme.background,
        children: [
          SizedBox(
              height: 70,
              child: Center(
                  child: Text('Давайте знакомиться!',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline2!.apply(
                            color: Theme.of(context).colorScheme.onSecondary,
                          )))),
          SizedBox(
            height: 350,
            width: MediaQuery.of(context).size.width,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AppLabel(text: 'Имя'),
                  AppTextField(
                    obscuringCharacter: false,
                    hintText: 'Петя',
                    onChanged: (value) {
                      widget.onFieldChanged(value, SignUpFieldType.name);
                    },
                  ),
                  const AppLabel(text: 'Возраст'),
                  AppTextField(
                    obscuringCharacter: false,
                    hintText: '25',
                    onChanged: (value) {
                      widget.onFieldChanged(value, SignUpFieldType.age);
                    },
                  ),
                  if (!_loading)
                    AppTextButton(
                      buttonText: 'Продолжить',
                      type: AppTextButtonType.primary,
                      size: AppTextButtonSize.large,
                      onPressed: _signUp,
                      disabled: disabled,
                    ),
                  if (_loading) const SizedBox(height: 61, child: AppLoading())
                ],
              ),
            ),
          )
        ]);
  }

  String? validateFields() {
    var _validateAge =
        ageTextFieldValidator(widget.fieldsValues[SignUpFieldType.age]!);
    var _validateName =
        nameTextFieldValidator(widget.fieldsValues[SignUpFieldType.name]!);
    var warning = '';
    if (_validateAge == null && _validateName == null) {
      return null;
    } else if (_validateName != null) {
      warning += _validateName;
    } else if (_validateAge != null) {
      warning += _validateAge;
    } else {
      AppToast.showWarning(warning, context);
    }
    return '';
  }
}
