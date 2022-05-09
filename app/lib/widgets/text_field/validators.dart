import 'package:flutter/material.dart';

String? emailTextFieldValidator(String value) {
  final _emailTemplate = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  if (value.isEmpty) {
    return 'Пожалуйста, введите email';
  } else if (!_emailTemplate.hasMatch(value)) {
    return 'Такого email не существует';
  } else if (value.isNotEmpty && _emailTemplate.hasMatch(value)) {
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
