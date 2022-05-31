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

  Future updateUserData({name, email, age}) async {
    userCollection.doc(uid).update({'name': name, 'age': age, 'email': email});
  }

  UserModel _userDataFromSnapshots(DocumentSnapshot snapshot) {
    return UserModel(
        uid: uid,
        email: snapshot.get('email') ?? '',
        name: snapshot.get('name') ?? '',
        age: snapshot.get('age') ?? 0);
  }

  Stream<UserModel>? get userData {
    return uid != ''
        ? userCollection.doc(uid).snapshots().map(_userDataFromSnapshots)
        : null;
  }
}

String getAge(int age) {
  var endNum = age % 10;
  if (endNum == 0 || (endNum >= 5 && endNum <= 9) || (age >= 11 && age <= 15)) {
    return '$age лет';
  } else if (endNum == 1) {
    return '$age год';
  } else {
    return '$age года';
  }
}
