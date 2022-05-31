import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/models/auth_model.dart';
import 'package:frontend/services/user/user_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthModel? _user(User? user) =>
      user != null ? AuthModel(uid: user.uid) : null;

  Stream<AuthModel?> get authResult {
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
          .setUserData(name: 'Мариночька', email: res.user!.email, age: 47);
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
