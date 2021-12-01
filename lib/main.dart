import 'package:cinaddict/utils/app_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'routes/login_view.dart';
import 'routes/signup_view.dart';
import 'routes/walkthrough_view.dart';
import 'routes/welcome_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSharedPreferences.init();

  runApp(App());
}

class AppBase extends StatelessWidget {
  const AppBase({Key? key}) : super(key: key);

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
      initialRoute: initialRoute,
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
      },
      theme: ThemeData.dark(),
    );
  }
}

String decideInitialRoute() {
  bool isFirstLaunched = AppSharedPreferences.getIsFirstLaunch();
  return isFirstLaunched ? '/walkthrough' : '/welcome';
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          print(
              "An Error Occurred While Connecting Firebase:\n ${snapshot.error.toString()}");
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          print("Successfully Connected to Firebase");
          return AppBase();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return MaterialApp(
          home: Center(
            child: Text('Connecting Firebase...'),
          ),
        );
      },
    );
  }
}
