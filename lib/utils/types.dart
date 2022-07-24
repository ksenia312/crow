import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/utils/theme.dart';

enum StatusesTypes { loading, error }

enum ErrorType { wrongPassword, noSuchUser, noInternet, tooManyAttempts }

const Map<ErrorType, String> errorsText = {
  ErrorType.wrongPassword:
      'The password is invalid or the user does not have a password.',
  ErrorType.noSuchUser:
      'There is no user record corresponding to this identifier. The user may have been deleted.',
  ErrorType.noInternet:
      'A network error (such as timeout, interrupted connection or unreachable host) has occurred.',
  ErrorType.tooManyAttempts:
      'We have blocked all requests from this device due to unusual activity. Try again later.',
};
const Map<ErrorType, String> errorsPrintText = {
  ErrorType.wrongPassword: 'Пароль недействителен',
  ErrorType.noSuchUser: 'Введен неверный email',
  ErrorType.noInternet: 'Ошибка интернет-соединения',
  ErrorType.tooManyAttempts:
      'Мы заблокировали все запросы с этого устройства из-за необычной активности. Попробуйте позже.',
};

enum SignInFieldType { email, password }
enum ChangeEmailFieldType { email, password }
enum SignUpFieldType { email, password, repeatedPassword, name, age }
enum ResetPasswordFieldType { email }

enum AppAssets { images, icons, figures, loading, spinner }

String getAsset(AppAssets folder, [String fileName = '']) {
  var theme = AppTheme();
  switch (folder) {
    case AppAssets.images:
      return 'assets/images/' + fileName;
    case AppAssets.icons:
      return theme.currentTheme == ThemeMode.light
          ? 'assets/svg/icons/icon_light.svg'
          : 'assets/svg/icons/icon_dark.svg';
    case AppAssets.figures:
      return theme.currentTheme == ThemeMode.light
          ? 'assets/svg/figures_light_theme/' + fileName
          : 'assets/svg/figures_dark_theme/' + fileName;
    case AppAssets.loading:
      return 'assets/svg/loading/loading.svg';
    case AppAssets.spinner:
      return theme.currentTheme == ThemeMode.light
          ? 'assets/svg/spinners/spinner_light.svg'
          : 'assets/svg/spinners/spinner_dark.svg';
  }
}

getRandomImageNum() => Random().nextInt(36) + 1;
