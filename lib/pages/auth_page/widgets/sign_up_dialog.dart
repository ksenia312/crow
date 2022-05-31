import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/pages/tabs_page/tabs_page.dart';
import 'package:frontend/services/user/user_service.dart';
import 'package:frontend/widgets/app_bar_children.dart';
import 'package:frontend/widgets/label.dart';
import 'package:frontend/widgets/statuses/loading.dart';
import 'package:frontend/widgets/statuses/toast.dart';
import 'package:frontend/widgets/text_buttons.dart';
import 'package:frontend/widgets/text_field/text_field.dart';
import 'package:frontend/widgets/text_field/types.dart';
import 'package:frontend/widgets/text_field/validators.dart';
import 'package:provider/provider.dart';

class SignUpDialog extends StatefulWidget {
  const SignUpDialog({Key? key}) : super(key: key);

  @override
  State<SignUpDialog> createState() => _SignUpDialogState();
}

class _SignUpDialogState extends State<SignUpDialog> {
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  bool disabled = true;
  late FToast fToast;

  final Map<SignUpFieldType, String> _fieldsValues = {
    SignUpFieldType.name: '',
    SignUpFieldType.age: ''
  };

  _onFieldChanged(String value, SignUpFieldType type) => setState(() {
        _fieldsValues[type] = value;
      });

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

  void _signUp(UserService userDatabase, UserModel? userModel) async {
    _toggleLoading();
    if (validateFields() == null) {
      var res = await userDatabase.updateUserData(
          name: _fieldsValues[SignUpFieldType.name]!,
          age: int.parse(_fieldsValues[SignUpFieldType.age]!),
          email: userModel?.name != null ? userModel!.email : 'Add email');

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
    var userModel = Provider.of<UserModel?>(context);
    var userDatabase = UserService(uid: userModel?.uid ?? '');
    if (_fieldsValues[SignUpFieldType.name] != '' &&
        _fieldsValues[SignUpFieldType.age] != '') {
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
        title: const AppBarTitle(text: 'Давайте знакомиться!'),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.only(top:50),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const AppLabel(text: 'Имя'),
              AppTextField(
                obscuringCharacter: false,
                hintText: 'Петя',
                onChanged: (value) {
                  _onFieldChanged(value, SignUpFieldType.name);
                },
              ),
              const AppLabel(text: 'Возраст'),
              AppTextField(
                obscuringCharacter: false,
                hintText: '25',
                onChanged: (value) {
                  _onFieldChanged(value, SignUpFieldType.age);
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    _loading
                        ? const SizedBox(height: 61, child: AppLoading())
                        : AppTextButton(
                            buttonText: 'Продолжить',
                            type: AppTextButtonType.primary,
                            size: AppTextButtonSize.large,
                            onPressed: () {
                              _signUp(userDatabase, userModel);
                            },
                            disabled: disabled,
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? validateFields() {
    var _validateAge =
        ageTextFieldValidator(_fieldsValues[SignUpFieldType.age]!);
    var _validateName =
        nameTextFieldValidator(_fieldsValues[SignUpFieldType.name]!);
    var warning = '';
    if (_validateAge == null && _validateName == null) {
      return null;
    }
    if (_validateName != null) {
      warning += _validateName;
    }
    if (_validateAge != null) {
      warning += _validateAge;
    }
    AppToast.showWarning(warning, context);
    return '';
  }
}
