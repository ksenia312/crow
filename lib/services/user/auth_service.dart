import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/models/auth_model.dart';
import 'package:frontend/services/user/user_database.dart';

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
      await UserDatabase(uid: res.user!.uid)
          .setUserData(name: 'Мариночька', email: res.user!.email, age: 47);
      return _user(res.user);
    } catch (e) {
      return null;
    }
  }

  Future updateUserDisplayName(String name) async {
    try {
      User? user = _auth.currentUser;
      await user?.updateDisplayName(name);
      user?.reload();
      await UserDatabase(uid: user!.uid).updateUserName(name: name);
      return _user(user);
    } catch (e) {
      return null;
    }
  }

  Future deleteUser(String email, String password) async {
    try {
      User? user = _auth.currentUser;
      AuthCredential credentials =
          EmailAuthProvider.credential(email: email, password: password);
      UserCredential? result =
          await user?.reauthenticateWithCredential(credentials);
      await UserDatabase(uid: result?.user?.uid ?? '')
          .deleteUser(); // called from database class
      await result?.user?.delete();
      return true;
    } catch (e) {
      print(e.toString());
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
