import 'package:cinaddict/utils/app_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'routes/login_view.dart';
import 'routes/signup_view.dart';
import 'routes/walkthrough_view.dart';
import 'routes/welcome_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSharedPreferences.init();
  String initialRoute = await decideInitialRoute();
  runApp(MaterialApp(
    initialRoute: initialRoute,
    routes: {
      '/walkthrough': (context) => WalkthroughView(),
      '/welcome': (context) => WelcomeView(),
      '/login': (context) => LoginView(),
      '/signup': (context) => SignUpView(),
    },
    theme: ThemeData.dark(),
  ));
}

Future<String> decideInitialRoute() async {
  bool isFirstLaunched = AppSharedPreferences.getIsFirstLaunch();
  return isFirstLaunched ? '/walkthrough': '/welcome';
}