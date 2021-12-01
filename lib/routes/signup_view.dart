import 'package:cinaddict/utils/colors.dart';
import 'package:cinaddict/utils/styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({Key? key, required this.analytics, required this.observer}) : super(key: key);
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(30),
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
                                borderRadius: BorderRadius.all(Radius.circular(0)),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
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
                                borderRadius: BorderRadius.all(Radius.circular(0)),
                              ),
                            ),
                            keyboardType: TextInputType.text,
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
                                borderRadius: BorderRadius.all(Radius.circular(0)),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
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
                                borderRadius: BorderRadius.all(Radius.circular(0)),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
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
                            onPressed: () {},
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12.0),
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
                      onPressed:() {
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
    );
  }
}
