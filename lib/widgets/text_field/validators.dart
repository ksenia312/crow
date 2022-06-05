import 'package:email_validator/email_validator.dart';

String? emailTextFieldValidator(String value) {
  if (value.isEmpty) {
    return 'Пожалуйста, введите email';
  } else if (!EmailValidator.validate(value)) {
    return 'Такого email не существует';
  } else if (value.isNotEmpty && EmailValidator.validate(value)) {
    return null;
  } else {
    return 'Что-то пошло не так';
  }
}

String? passwordTextFieldValidator(String value) {
  if (value.isEmpty) {
    return 'Пожалуйста, введите пароль';
  } else if (value.length <= 5) {
    return 'Пароль должен содержать больше 5 символов';
  } else if (value.isNotEmpty && value.length > 5) {
    return null;
  } else {
    return 'Что-то пошло не так';
  }
}

String? repeatedPasswordTextFieldValidator(String value) {
  if (value.isEmpty) {
    return 'Пожалуйста, повторите пароль';
  } else if (value.length <= 5) {
    return 'Пароль должен содержать больше 5 символов';
  } else if (value.isNotEmpty && value.length > 5) {
    return null;
  } else {
    return 'Что-то пошло не так';
  }
}

String? ageTextFieldValidator(String value) {
  try {
    int.parse(value);
    return null;
  } catch (e) {
    return 'Некорректный возраст';
  }
}


String? nameTextFieldValidator(String value) {
  if (value.isEmpty) {
    return 'Пожалуйста, введите имя';
  }
  return null;
}
