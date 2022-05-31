import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frontend/models/user_model.dart';

class UserService {
  final String uid;

  UserService({required this.uid});

  UserService.withoutUID() : uid = '';

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future setUserData({name, email, age}) async {
    userCollection.doc(uid).set({'name': name, 'age': age, 'email': email});
  }

  UserModel _userDataFromSnapshots(DocumentSnapshot snapshot) {
    return UserModel(
        uid: uid,
        email: snapshot.get('email') ?? '',
        name: snapshot.get('name') ?? '',
        age: snapshot.get('age') ?? 0);
  }

  Stream<UserModel>? get userData {
    print('getUserData $uid');
    return uid != ''
        ? userCollection.doc(uid).snapshots().map(_userDataFromSnapshots)
        : null;
  }
}

String getAge(int age) {
  if (age % 10 == 0 || (age % 10 >= 5 && age % 10 <= 9)) {
    return '$age лет';
  } else if (age % 10 == 1) {
    return '$age год';
  } else {
    return '$age года';
  }
}
