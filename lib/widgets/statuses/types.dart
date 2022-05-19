enum StatusesTypes { loading, error }

enum ErrorType { wrongPassword, noSuchUser, noInternet, tooManyAttempts }

const Map<ErrorType, String> errorsText = {
  ErrorType.wrongPassword:
      'The password is invalid or the user does not have a password.',
  ErrorType.noSuchUser: 'There is no user record corresponding to this identifier. The user may have been deleted.',
  ErrorType.noInternet: 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.',
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
