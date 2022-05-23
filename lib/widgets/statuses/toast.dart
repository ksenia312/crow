import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/widgets/statuses/types.dart';

class AppToast {
  static showError(FirebaseAuthException e, context) {
    var text = '';
    for (var err in ErrorType.values) {
      if (errorsText[err] == e.message) {
        text = errorsPrintText[err]!;
      } else {
        text = e.message != null ? e.message! : 'Неизвестная ошибка';
      }
    }
    FToast fToast = FToast();
    Widget toast = Container(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Theme.of(context).colorScheme.error.withOpacity(0.8),
        ),
        child: ListTile(
          leading:
              Icon(Icons.error, color: Theme.of(context).colorScheme.onError),
          title: Text(text,
              softWrap: true,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .apply(color: Theme.of(context).colorScheme.onError)),
        ));
    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: const Duration(seconds: 3),
    );
  }

  static showWarning(text, context) {
    FToast fToast = FToast();
    Widget toast = Container(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
        ),
        child: ListTile(
          leading:
              Icon(Icons.error, color: Theme.of(context).colorScheme.onError),
          title: Text(text,
              softWrap: true,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .apply(color: Theme.of(context).colorScheme.onError)),
        ));
    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: const Duration(seconds: 3),
    );
  }
}
