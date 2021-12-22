import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _userFromFirebase(User? user) {
    return user ?? null;
  }

  Stream<User?> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user!;
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<User?> signupWithMailAndPass(String mail,String pass) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: mail, password: pass);
      User user = result.user!;
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak');
      }
      else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email');
      }
    } catch (e) {
      print(e);
    }
    // TODO: add function sign out for the feed view

    Future loginWithMailAndPass(String mail, String pass) async {
      try {
        UserCredential result = await _auth.signInWithEmailAndPassword(
            email: mail, password: pass);
        User user = result.user!;
        return _userFromFirebase(user);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          signupWithMailAndPass(mail, pass);
        }
      } catch (e) {
        print(e.toString());
        return null;
      }
    }

    Future signOut() async {
      try {
        return await _auth.signOut();
      } catch (e) {
        print(e.toString());
        return null;
      }
    }
  }
}