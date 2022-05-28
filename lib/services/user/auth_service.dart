import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/models/auth_model.dart';
import 'package:frontend/services/user/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthModel? _user(User? user) =>
      user != null ? AuthModel(uid: user.uid) : null;

  Stream<AuthModel?> get user {
    return _auth.authStateChanges().map(_user);
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential res = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return _user(res.user);
    } catch (e) {
      return e;
    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential res = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await UserService(uid: res.user!.uid)
          .setUserData(name: '', email: res.user!.email, age: 0);
      return _user(res.user);
    } catch (e) {
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
}
