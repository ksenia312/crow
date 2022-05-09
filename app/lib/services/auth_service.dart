import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel? _user(User? user) =>
      user != null ? UserModel(uid: user.uid, email: user.email) : null;

  Stream<UserModel?> get user {
    return _auth.authStateChanges().map(_user);
  }
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential res = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return _user(res.user);
    } catch (e) {
      return null;
    }
  }
  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential res = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
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
