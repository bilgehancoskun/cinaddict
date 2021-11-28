import 'package:flutter/material.dart';
import 'routes/login_view.dart';
import 'routes/signup_view.dart';
import 'routes/walkthrough_view.dart';
import 'routes/welcome_view.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/walkthrough',
    routes: {
      '/walkthrough': (context) => WalkthroughView(),
      '/welcome': (context) => WelcomeView(),
      '/login': (context) => LoginView(),
      '/signup': (context) => SignUpView(),
    },
    theme: ThemeData.dark(),
  ));
}
