import 'package:cinaddict/utils/styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';

class WelcomeView extends StatefulWidget {
  @override
  const WelcomeView({Key? key, required this.analytics, required this.observer})
      : super(key: key);
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  WelcomeView1 createState() => WelcomeView1();}

class WelcomeView1 extends State<WelcomeView> {
  List<Color> colorList = [
    Colors.blueGrey,
    Colors.deepOrange,
    Colors.deepPurpleAccent,
    Colors.black38,
    const Color(0xffacc271)
  ];
  int index = 0;
  Color bottomColor = Colors.deepOrange;
  Color topColor = Colors.black;
  Alignment begin = Alignment.bottomLeft;
  Alignment end = Alignment.topRight;
  void initState(){
    super.initState();
    Future.delayed(const Duration(milliseconds: 10), () {
      setState(() {
        bottomColor = const Color(0xffacc271);
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
            children:[ AnimatedContainer(
                duration: Duration(seconds: 2),
                onEnd: () {
                  setState(() {
                    index = index + 1;
                    // animate the color
                    bottomColor = colorList[index % colorList.length];
                    topColor = colorList[(index + 1) % colorList.length];

                    //// animate the alignment
                    // begin = alignmentList[index % alignmentList.length];
                    // end = alignmentList[(index + 2) % alignmentList.length];
                  });
                },
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: begin, end: end, colors: [bottomColor, topColor])),

                child: Padding(
                  padding: EdgeInsets.all(30).copyWith(top: 80),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image(
                        image: AssetImage("lib/assets/cinaddict_logo.png"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Column(
                          children: [
                            Text(
                              'Welcome to cinaddict',
                              style: AppTextStyle.welcomeTextStyle,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Flex(
                              direction: Axis.horizontal,
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, "/login");
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
                            SizedBox(
                              height: 16,
                            ),
                            Flex(
                              direction: Axis.horizontal,
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, "/signup");
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                                      child: Text(
                                        'Signup',
                                        style: AppTextStyle.whiteTextStyle,
                                      ),
                                    ),
                                    style: AppButtonStyle.primaryRedButton,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
            ),



            ] ));
  }

}