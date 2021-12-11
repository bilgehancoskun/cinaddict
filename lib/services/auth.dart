import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final FirebaseAuth _auth=FirebaseAuth.instance;

  Future signupWithMailAndPass(String mail,String pass) async{
    try{
      UserCredential result= await _auth.createUserWithEmailAndPassword(email: mail, password: pass);
      User user= result.user!;
    } on FirebaseAuthException catch(e){
      if (e.code=='weak-password'){
        print('The password provided is too weak');
      }
      else if (e.code=='email-already-in-use'){
        print('The account already exists for that email');
      }
    } catch(e){
      print(e);
    }
    // TODO: add function sign out for the feed view

  }
}