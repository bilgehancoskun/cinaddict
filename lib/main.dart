import 'dart:async';
import 'dart:ffi';
import 'package:cinaddict/routes/feed_view.dart';
import 'package:cinaddict/routes/structure.dart';
import 'package:cinaddict/utils/colors.dart';
import 'package:cinaddict/utils/shared_preferences.dart';
import 'package:cinaddict/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'models/user.dart';
import 'routes/login_view.dart';
import 'routes/signup_view.dart';
import 'routes/walkthrough_view.dart';
import 'routes/welcome_view.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

Future<void> main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await AppSharedPreferences.init();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    runApp(App());
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  static String initialRoute = decideInitialRoute();
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [
        observer,
      ],
      initialRoute: decideInitialRoute(),
      routes: {
        '/walkthrough': (context) => WalkthroughView(
              analytics: analytics,
              observer: observer,
            ),
        '/welcome': (context) => WelcomeView(
              analytics: analytics,
              observer: observer,
            ),
        '/login': (context) => LoginView(
              analytics: analytics,
              observer: observer,
            ),
        '/signup': (context) => SignUpView(
              analytics: analytics,
              observer: observer,
            ),
        '/structure': (context) => Structure(user: getUser())

      },
      theme: ThemeData(
        canvasColor: Color(0xFF393E46),//0xFF1A374D0xFF406882
          bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Color(
              0xFFFFFFFF), selectedItemColor: Color(0xFF000000), unselectedItemColor: Color(
              0x66FF0000)) ,
          appBarTheme: AppBarTheme(backgroundColor: Color(
          0xFF222831)),
          buttonTheme: ButtonThemeData(
            buttonColor: Color(0xFFFFFFFF),
          ),
         // primaryColor: Colors.white,

      ),
    );
  }
}

String decideInitialRoute() {
  bool isFirstLaunched = AppSharedPreferences.getIsFirstLaunch();
  if (isFirstLaunched) {
    return '/walkthrough';
  }
  bool isLoggedIn = AppSharedPreferences.getLoggedIn();
  User? user = AppSharedPreferences.getLocalUser();
  if (isLoggedIn && user != null)
    return '/structure';

  return '/welcome';
}

User getUser() {
  User? user = AppSharedPreferences.getLocalUser();
  return user!;
}
