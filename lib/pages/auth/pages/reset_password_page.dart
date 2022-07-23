import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/pages/wrapper/wrapper.dart';
import 'package:frontend/services/user/auth_service.dart';
import 'package:frontend/widgets/app_bar_children.dart';
import 'package:frontend/widgets/text_buttons.dart';
import 'package:frontend/widgets/label.dart';
import 'package:frontend/widgets/statuses/toast.dart';
import 'package:frontend/widgets/statuses/loading.dart';
import 'package:frontend/widgets/statuses/types.dart';
import 'package:frontend/widgets/text_field/text_field.dart';
import 'package:frontend/widgets/text_field/types.dart';
import 'package:frontend/widgets/text_field/validators.dart';

class ResetPasswordPage extends StatefulWidget {
  final String email;

  const ResetPasswordPage({required this.email, Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final Map<StatusesTypes, bool> _statusesValues = {
    StatusesTypes.error: false,
    StatusesTypes.loading: false,
  };
  final Map<ResetPasswordFieldType, String> _fieldsValues = {
    ResetPasswordFieldType.email: '',
  };
  late FToast fToast;
  bool disabled = true;

  @override
  void initState() {
    fToast = FToast();
    fToast.init(context);
    _onFieldChanged(widget.email, ResetPasswordFieldType.email);
    super.initState();
  }

  _onFieldChanged(String value, ResetPasswordFieldType type) => setState(() {
        _fieldsValues[type] = value;
      });

  _toggleStatuses(bool value, StatusesTypes type) {
    setState(() {
      _statusesValues[type] = value;
    });
  }

  void _updateEmail() async {
    _toggleStatuses(true, StatusesTypes.loading);
    if (validateFields() == null) {
      AuthService()
          .resetPassword(_fieldsValues[ResetPasswordFieldType.email]!)
          .then((res) {
        if (res is FirebaseAuthException) {
          _toggleStatuses(true, StatusesTypes.error);
          _toggleStatuses(false, StatusesTypes.loading);
          AppToast.showError(res, context);
        } else {
          _toggleStatuses(false, StatusesTypes.loading);
          AppToast.showSuccess(
              'Ссылка для сброса пароля отправлена на почту ${_fieldsValues[ResetPasswordFieldType.email]!}',
              context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const Wrapper(
                        showInitDialog: true,
                        dialogTitle: 'Добро пожаловать!',
                      )));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_fieldsValues[ResetPasswordFieldType.email] != '') {
      setState(() {
        disabled = false;
      });
    } else {
      setState(() {
        disabled = true;
      });
    }
    return Scaffold(
      appBar: AppBar(title: const AppBarTitle(text: 'Восстановление пароля')),
      body: Form(
        key: _formKey,
        child: ListView(children: [
          const AppLabel(text: 'почта'),
          _drawTextField(
              'crow@example.com', false, ResetPasswordFieldType.email),
          _drawPasswordResetButton(),
        ]),
      ),
    );
  }

  _drawTextField(String hintText, bool obscuringCharacter,
          ResetPasswordFieldType type) =>
      AppTextField(
          hintText: hintText,
          obscuringCharacter: obscuringCharacter,
          initialValue: widget.email,
          onChanged: (value) {
            _onFieldChanged(value, type);
          });

  Column _drawPasswordResetButton() => Column(
        children: [
          AppTextButton(
            buttonText: 'Восстановить пароль',
            type: AppTextButtonType.primary,
            size: AppTextButtonSize.large,
            onPressed: _updateEmail,
            disabled: disabled,
          ),
          if (_statusesValues[StatusesTypes.loading] == true)
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: SizedBox(height: 50, child: AppLoading()),
            ),
        ],
      );

  String? validateFields() {
    var _validateEmail =
        emailTextFieldValidator(_fieldsValues[ResetPasswordFieldType.email]!);

    if (_validateEmail == null) {
      return null;
    } else {
      var _warning = '';

      _warning += _validateEmail;
      AppToast.showWarning(_warning, context);
      _toggleStatuses(false, StatusesTypes.loading);
    }
    return '';
  }
}
