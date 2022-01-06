import 'package:cinaddict/services/firestore.dart';
import 'package:cinaddict/utils/colors.dart';
import 'package:cinaddict/utils/styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cinaddict/services/auth.dart';
import 'package:email_validator/email_validator.dart';

class SignUpView extends StatefulWidget {
  SignUpView({Key? key, required this.analytics, required this.observer})
      : super(key: key);
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();

  String mail = "";
  String password = "";
  String passwordCheck = "";
  String username = "";
  final validCharacters = RegExp(r'^[a-zA-Z0-9]+$');

  AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(30),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                        child: Image.asset(
                          'lib/assets/cinaddict_logo.png',
                          width: MediaQuery.of(context).size.width / 2.2,
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              decoration: InputDecoration(
                                fillColor: AppColors.darkGrey,
                                filled: true,
                                hintText: 'E-mail',
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
                              style: TextStyle(
                                color: AppColors.white,
                              ),
                              validator: (value) {
                                if (value == null) {
                                  return 'E-mail field cannot be empty';
                                } else {
                                  String trimmedValue = value.trim();
                                  if (trimmedValue.isEmpty) {
                                    return 'E-mail field cannot be empty';
                                  }
                                  if (!EmailValidator.validate(trimmedValue)) {
                                    return 'Please enter a valid email';
                                  }
                                }
                                return null;

                                // TODO: Account already exists durumu için yine yukardan uyarı bildirimi (popup) gelecek (2)
                              },
                              onSaved: (value) {
                                if (value != null) {
                                  mail = value;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              decoration: InputDecoration(
                                fillColor: AppColors.darkGrey,
                                filled: true,
                                hintText: 'Username',
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
                              style: TextStyle(
                                color: AppColors.white,
                              ),
                              validator: (value) {
                                if (value == null) {
                                  return 'Username field cannot be empty';
                                } else {
                                  String trimmedValue = value.trim();
                                  if (trimmedValue.isEmpty) {
                                    return 'Username field cannot be empty';
                                  }
                                  if (trimmedValue.length < 3) {
                                    return 'Username must be at least 3 characters long';
                                  }
                                  if (!validCharacters.hasMatch(trimmedValue)) {
                                    return 'Username can only contains alphanumerical characters';
                                  }
                                  //passwordCheck=trimmedValue;
                                }
                              },
                              onSaved: (value) {
                                if (value != null) {
                                  username = value;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
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
                              style: TextStyle(
                                color: AppColors.white,
                              ),
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
                                  passwordCheck = trimmedValue;
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
                          SizedBox(width: 8.0),
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              decoration: InputDecoration(
                                fillColor: AppColors.darkGrey,
                                filled: true,
                                hintText: 'Password (Repeat)',
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
                              style: TextStyle(
                                color: AppColors.white,
                              ),
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
                                  if (trimmedValue != passwordCheck) {
                                    return "Password is not the same";
                                  }
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: OutlinedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  if (await AppFirestore.userExists(username)) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text('Username already in use', textAlign: TextAlign.center,),
                                      backgroundColor: AppColors.primaryRed,
                                    ));
                                  } else {
                                    User? result = await auth
                                        .signupWithMailAndPass(mail, password);
                                    if (result != null) {
                                      await result.updateDisplayName(username);
                                      await AppFirestore.addUserToFirestore(uid: result.uid,
                                          username: username);
                                      Navigator.pushReplacementNamed(context, '/login');
                                    }
                                  }
                                  // TODO: If person cannot create the account then pop up a message. (1)
                                }
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              style: AppButtonStyle.primaryRedButton,
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: Text(
                          "Already have an account? Click here to login.",
                          style: AppTextStyle.lighterTextStyle,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
