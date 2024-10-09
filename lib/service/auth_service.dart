import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutalk/function/datetime_now.dart';
import 'package:nutalk/model/user/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserModel? _userFromFirebaseUser(User? user, String email) {
    return user != null
        ? UserModel(
            uid: user.uid,
            email: email,
            userId: 'nu${dateTimeNowCode()}',
          )
        : null;
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      return _userFromFirebaseUser(user, email);
    } catch (e) {
      return null;
    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      return _userFromFirebaseUser(user, email);
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
