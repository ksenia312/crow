import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/models/auth_model.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/pages/tabs_page/tabs_page.dart';
import 'package:frontend/services/user/auth_service.dart';
import 'package:frontend/services/user/user_database.dart';
import 'package:frontend/widgets/app_bar_children.dart';
import 'package:frontend/widgets/label.dart';
import 'package:frontend/widgets/statuses/loading.dart';
import 'package:frontend/widgets/statuses/toast.dart';
import 'package:frontend/widgets/text_buttons.dart';
import 'package:frontend/widgets/text_field/text_field.dart';
import 'package:frontend/widgets/text_field/types.dart';
import 'package:frontend/widgets/text_field/validators.dart';
import 'package:provider/provider.dart';

class AcquaintancePage extends StatefulWidget {
  const AcquaintancePage({Key? key}) : super(key: key);

  @override
  State<AcquaintancePage> createState() => _AcquaintancePageState();
}

class _AcquaintancePageState extends State<AcquaintancePage> {
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

  void _updateUserNameAndAge(
      AuthService authService, UserDatabase userDatabase) async {
    _toggleLoading();
    if (validateFields() == null) {
      var nameRes = await authService
          .updateUserDisplayName(_fieldsValues[SignUpFieldType.name]!);
      var ageRes = await userDatabase.updateUserAge(
        age: int.parse(_fieldsValues[SignUpFieldType.age]!),
      );
      if (nameRes is FirebaseAuthException || ageRes is FirebaseAuthException) {
        nameRes is FirebaseAuthException &&
            AppToast.showError(nameRes, context);
        ageRes is FirebaseAuthException && AppToast.showError(ageRes, context);
      } else {
        Navigator.pop(context);
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) {
          return const TabsPage(
            showInitDialog: true,
            dialogTitle: 'Вы создали аккаунт! Чем теперь займемся?',
          );
        }), (Route<dynamic> route) => false);
      }
    }
    _toggleLoading();
  }

  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<AuthModel?>(context);
    var userDatabase = UserDatabase(uid: auth?.uid ?? '');
    AuthService authService = AuthService();
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
        padding: const EdgeInsets.only(top: 50),
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
                              _updateUserNameAndAge(authService, userDatabase);
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
