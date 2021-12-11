import 'package:cinaddict/utils/colors.dart';
import 'package:cinaddict/utils/styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
//TODO
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:cinaddict/services/auth.dart';

//login branch test

class LoginView extends StatefulWidget {
  const LoginView({Key? key, required this.analytics, required this.observer}) : super(key: key);
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  String mail = "";
  String password = "";
  late int count;
  String _message = '';

  void setmessage(String msg) {
    setState(() {
      _message = msg;
    });
  }

  AuthService auth = AuthService();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    count = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(30.0), //TODO DIMENSIONS
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                ),
                SizedBox(
                  height: 200,
                  child: Image(
                    image: AssetImage('lib/assets/cinaddict_logo.png'),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 48.0,
                        child: TextFormField(
                          decoration: InputDecoration(
                            fillColor: AppColors.darkGrey,
                            filled: true,
                            hintText: 'Username or email',
                            hintStyle: AppTextStyle.lightTextStyle,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.midGrey,
                                width: 2.0,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0)),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null) {
                              return 'E-mail field cannot be empty';
                            } else {
                              String trimmedValue = value.trim();
                              if (trimmedValue.isEmpty) {
                                return 'E-mail field cannot be empty';
                              }
                              if(!EmailValidator.validate(trimmedValue)) {//TODO ADD email_validator 2.0.1 from pub.dev
                                return 'Please enter a valid email';
                               }
                            }
                            return null;
                          },
                          onSaved: (value) {
                            if (value != null) {
                              mail = value;
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 48.0,
                        child: TextFormField(
                          decoration: InputDecoration(
                            fillColor: AppColors.darkGrey,
                            filled: true,
                            hintText: 'Password',
                            hintStyle: AppTextStyle.lightTextStyle,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.midGrey,
                                width: 2.0,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0)),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          validator: (value) {
                            if (value == null) {
                              return 'Password field cannot be empty';
                            } else {
                              String trimmedValue = value.trim();
                              if (trimmedValue.isEmpty) {
                                return 'Password field cannot be empty';
                              }
                              if (trimmedValue.length < 8) {
                                return 'Password must be at least 8 characters long';
                              }
                            }
                            return null;
                          },
                          onSaved: (value) {
                            if (value != null) {
                              password = value;
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),

                //  SizedBox(height: 0,),
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            //TODO
                            if (_formKey.currentState!.validate()) {
                              print(
                                  'Mail: ' + mail + "\nPassword: " + password);
                              _formKey.currentState!.save();
                              auth.loginWithMailAndPass(mail, password);
                              print(
                                  'Mail: ' + mail + "\nPassword: " + password);
                              //TODO  getUser();
                            } else {
                              setState(() {
                                count += 1;
                                // showAlertDialog('Error', 'You have tried your luck $count times');
                              });
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Text(
                              'Login',
                              style: AppTextStyle.darkTextStyle,
                            ),
                          ),
                          style: AppButtonStyle.primaryYellowButton,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {

                            Future<UserCredential> signInWithGoogle() async {
                              // Trigger the authentication flow
                              final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

                              // Obtain the auth details from the request
                              final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

                              // Create a new credential
                              final credential = GoogleAuthProvider.credential(
                                accessToken: googleAuth?.accessToken,
                                idToken: googleAuth?.idToken,
                              );

                              // Once signed in, return the UserCredential
                              return await FirebaseAuth.instance.signInWithCredential(credential);
                            }
                            signInWithGoogle();


                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child:Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                SizedBox(
                                  height: 18,
                                  child: Image(
                                    image: AssetImage('lib/assets/Google_Logo.png'),
                                  ),

                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(85, 0, 0, 0),
                                  child: Text(
                                    'Login with Google',
                                    style: AppTextStyle.lighterbiggerTextStyle,
                                  ),
                                ),
                              ],
                            )

                          ),
                          style: AppButtonStyle.primaryGreyButton,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(
                        context, '/signup'); //TODO change to go to  help?
                  },
                  child: Text(
                    "Forgot password? Click here to get help.",
                    style: AppTextStyle.lighterTextStyle,
                  ),
                ),

                SizedBox(
                  height: 100,
                ),

                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: Text(
                    "Sign Up",
                    style: AppTextStyle.lighterTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
