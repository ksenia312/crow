import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/pages/auth/pages/verify_email_page.dart';
import 'package:frontend/pages/game_page/widgets/hint_dialog.dart';
import 'package:frontend/pages/settings_page/widgets/email_block.dart';
import 'package:frontend/services/user/auth_service.dart';
import 'package:frontend/utils/indents.dart';
import 'package:frontend/widgets/app_bar_children.dart';
import 'package:frontend/widgets/list_tile.dart';
import 'package:frontend/widgets/statuses/dialog.dart';
import 'package:frontend/widgets/text_buttons.dart';
import 'package:frontend/widgets/label.dart';
import 'package:frontend/widgets/statuses/toast.dart';
import 'package:frontend/widgets/statuses/loading.dart';
import 'package:frontend/widgets/statuses/types.dart';
import 'package:frontend/widgets/text_field/text_field.dart';
import 'package:frontend/widgets/text_field/types.dart';
import 'package:frontend/widgets/text_field/validators.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeEmailPage extends StatefulWidget {
  final String? email;

  const ChangeEmailPage({required this.email, Key? key}) : super(key: key);

  @override
  State<ChangeEmailPage> createState() => _ChangeEmailPageState();
}

class _ChangeEmailPageState extends State<ChangeEmailPage>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final Map<StatusesTypes, bool> _statusesValues = {
    StatusesTypes.error: false,
    StatusesTypes.loading: false,
  };
  final Map<ChangeEmailFieldType, String> _fieldsValues = {
    ChangeEmailFieldType.email: '',
    ChangeEmailFieldType.password: ''
  };
  late FToast fToast;
  bool disabled = true;
  bool showWarning = false;
  bool accepted = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    fToast = FToast();
    fToast.init(context);
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.ease,
    );
    _controller.addListener(() {
      if (_animation.value > 0.95 &&
          _controller.status == AnimationStatus.reverse) {
        _controller.stop();
      }
    });
  }

  _onFieldChanged(String value, ChangeEmailFieldType type) => setState(() {
        _fieldsValues[type] = value;
      });

  _toggleStatuses(bool value, StatusesTypes type) {
    setState(() {
      _statusesValues[type] = value;
    });
  }

  void _updateEmail() async {
    if (!accepted) {
      setState(() {
        showWarning = true;
      });
      _animateAcceptButton();
      return;
    }
    _toggleStatuses(true, StatusesTypes.loading);
    if (validateFields() == null) {
      User? _user = FirebaseAuth.instance.currentUser;
      AuthService()
          .updateEmail(
              _user?.email ?? '',
              _fieldsValues[ChangeEmailFieldType.password]!,
              _fieldsValues[ChangeEmailFieldType.email]!)
          .then((res) async {
        if (res is FirebaseAuthException) {
          _toggleStatuses(true, StatusesTypes.error);
          _toggleStatuses(false, StatusesTypes.loading);
          AppToast.showError(res, context);
        } else {
          _toggleStatuses(false, StatusesTypes.loading);
          AppToast.showSuccess(
              'Почта изменена на ${_fieldsValues[ChangeEmailFieldType.email]!}',
              context);
          await SharedPreferences.getInstance().then((value) {
            value.setString('email', _fieldsValues[ChangeEmailFieldType.email]!);
          });
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const VerifyEmailPage(
                        isInitPage: true,
                      )));
        }
      });
    }
  }

  _animateAcceptButton() {
    _controller.repeat(reverse: true, min: 0.5);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_fieldsValues[ChangeEmailFieldType.email] != '' &&
        _fieldsValues[ChangeEmailFieldType.password] != '') {
      setState(() {
        disabled = false;
      });
    } else {
      setState(() {
        disabled = true;
      });
    }
    return Scaffold(
      appBar:
          AppBar(title: const AppBarTitle(text: 'Изменение почты'), actions: [
        IconButton(
            onPressed: () {
              AppDialog.showCustomDialog(context,
                  child: const HintDialog(
                    text:
                        'После изменения почты вы выйдите из аккаунта. Для входа вам нужно будет подтвердить новую почту.',
                  ));
            },
            icon: Icon(
              Icons.lightbulb,
              color: Theme.of(context).colorScheme.onSurface,
            ))
      ]),
      body: Form(
        key: _formKey,
        child: ListView(children: [
          EmailBlock(text: 'Старая почта: ${widget.email}', showDialog: false),
          const AppLabel(text: 'новая почта'),
          _drawTextField('crow@example.com', false, ChangeEmailFieldType.email),
          const AppLabel(
            text: 'пароль',
            textAlign: TextAlign.end,
          ),
          _drawTextField('петя1234', true, ChangeEmailFieldType.password),
          showWarning ? _drawWarning() : Container(),
          showWarning ? _drawAcceptButton() : Container(),
          _drawEmailSendingButton(),
        ]),
      ),
    );
  }

  _drawTextField(String hintText, bool obscuringCharacter,
          ChangeEmailFieldType type) =>
      AppTextField(
          hintText: hintText,
          obscuringCharacter: obscuringCharacter,
          onChanged: (value) {
            _onFieldChanged(value, type);
          });

  Column _drawEmailSendingButton() => Column(
        children: [
          AppTextButton(
            buttonText: 'Подтвердить новую почту',
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

  _drawAcceptButton() => ScaleTransition(
        scale: _animation,
        child: AppTextButton(
            buttonText: 'Нажмите, если проверили почту',
            disabled: accepted,
            onPressed: () {
              setState(() {
                accepted = true;
              });
            },
            type: AppTextButtonType.warning),
      );

  _drawWarning() => Opacity(
        opacity: accepted ? 0.4 : 1.0,
        child: Padding(
          padding: AppIndents.all5ExceptBottom,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            child: AppListTile(
              headline2:
                  'Проверьте корректность новой почты! \nПосле нажатия кнопки "Подтвердить новую почту" почта будет изменена, и вам нужно будет ее подтвердить. \nВы сможете вернуть старую почту только случае, если у вас есть к ней доступ.',
              bodyText: null,
              textColor: Theme.of(context).colorScheme.onError,
              maxHeight: 300,
              color: Theme.of(context).colorScheme.error,
              padding: 5,
            ),
          ),
        ),
      );

  String? validateFields() {
    var _validateEmail =
        emailTextFieldValidator(_fieldsValues[ChangeEmailFieldType.email]!);
    var _validatePassword = passwordTextFieldValidator(
        _fieldsValues[ChangeEmailFieldType.password]!);
    if (_validateEmail == null && _validatePassword == null) {
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
      _toggleStatuses(false, StatusesTypes.loading);
      setState(() {
        accepted = false;
      });
      _animateAcceptButton();
    }
    return '';
  }
}
