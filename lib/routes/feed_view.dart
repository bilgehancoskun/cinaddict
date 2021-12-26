import 'package:cinaddict/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class FeedView extends StatelessWidget {
  const FeedView({Key? key, required this.analytics, required this.observer}) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feed'),

      ),
      body: Column(
        children: [
          Text('Hey')
        ],
      ),
    );
  }
}
