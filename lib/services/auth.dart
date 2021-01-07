import 'package:brew_crew/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum authProblems { UserNotFound, PasswordNotValid, NetworkError }

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on FirebaseUser
  UserModel _userFromFirebaseUser(User user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<UserModel> get user {
    return _auth
        .authStateChanges()
        // .map((User user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email & password

  // register in with email & password
  Future<Map> registerWithEmailAndPassword(String email, String pasword) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: pasword);
      User user = result.user;
      return {
        'data': _userFromFirebaseUser(user),
        'isError': false,
      };
    } catch (e) {
      print(e);
      return {
        'isError': true,
        'errMess': e.message,
      };
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
