import 'dart:async';
import 'package:cinaddict/routes/feed_view.dart';
import 'package:cinaddict/utils/app_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
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
        '/feed': (context) => FeedView(
              analytics: analytics,
              observer: observer,
            )
      },
      theme: ThemeData.dark(),
    );
  }
}

String decideInitialRoute() {
  bool isFirstLaunched = AppSharedPreferences.getIsFirstLaunch();
  return isFirstLaunched ? '/walkthrough' : '/welcome';
}
