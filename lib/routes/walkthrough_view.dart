import 'package:cinaddict/utils/shared_preferences.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:cinaddict/utils/colors.dart';
import 'package:cinaddict/utils/dimensions.dart';
import 'package:cinaddict/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class WalkthroughView extends StatelessWidget {
  const WalkthroughView({Key? key, required this.analytics, required this.observer}) : super(key: key);
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IntroductionScreen(
          pages: [
            PageViewModel(
              titleWidget: Text('We Love Movies', style: TextStyle(color: AppColors.white, fontSize: 24),),
              bodyWidget: Text('Connect and meet with all movie lovers around the world.', style: TextStyle(color: AppColors.white, fontSize: 20), textAlign: TextAlign.center,),
              image: Icon(
                Icons.local_movies_outlined,
                size: AppDimensions.walkthroughDefaultIconSize,
                color: AppColors.primaryRed,
              ),
              decoration: getCardDecoration(),
            ),
            PageViewModel(
              titleWidget: Text('Share Posts', style: TextStyle(color: AppColors.white, fontSize: 24),),
              bodyWidget: Text('Share photos or videos about movies or movie theaters.', style: TextStyle(color: AppColors.white, fontSize: 20), textAlign: TextAlign.center,),
              image: Icon(
                Icons.image_outlined,
                size: AppDimensions.walkthroughDefaultIconSize,
                color: AppColors.primaryRed,
              ),
              decoration: getCardDecoration(),
            ),
            PageViewModel(
              titleWidget: Text('Interact with People', style: TextStyle(color: AppColors.white, fontSize: 24),),
              bodyWidget: Text('Like other people\'s posts, comment on them, share them.', style: TextStyle(color: AppColors.white, fontSize: 20), textAlign: TextAlign.center,),
              image: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.thumb_up_alt_rounded,
                          size: AppDimensions.walkthroughMultipleIconSize,
                          color: AppColors.primaryRed,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.comment,
                          size: AppDimensions.walkthroughMultipleIconSize,
                          color: AppColors.primaryRed,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.ios_share,
                          size: AppDimensions.walkthroughMultipleIconSize,
                          color: AppColors.primaryRed,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.location_on,
                          size: AppDimensions.walkthroughMultipleIconSize,
                          color: AppColors.primaryRed,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              decoration: getCardDecoration(),
            ),
            PageViewModel(
              titleWidget: Text('Discuss with People', style: TextStyle(color: AppColors.white, fontSize: 24),),
              bodyWidget: Text('Find out what people think about movies or movie theaters.', style: TextStyle(color: AppColors.white, fontSize: 20), textAlign: TextAlign.center,),
              image: Icon(Icons.tag,
                  size: AppDimensions.walkthroughDefaultIconSize,
                  color: AppColors.primaryRed),
              decoration: getCardDecoration(),
            ),
            PageViewModel(
              titleWidget: Text('Checkout Upcoming Movies', style: TextStyle(color: AppColors.white, fontSize: 24),),
              bodyWidget: Text('Checkout current or upcoming movies in theatres. Discuss with other people about them.', style: TextStyle(color: AppColors.white, fontSize: 20), textAlign: TextAlign.center,),
              image: Icon(Icons.theater_comedy,
                  size: AppDimensions.walkthroughDefaultIconSize,
                  color: AppColors.primaryRed),
              decoration: getCardDecoration(),
            ),
          ],
          skip: Text(
            'Skip',
            style: TextStyle(color: Colors.white),
          ),
          next: Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
          done: Icon(
            Icons.check,
            color: Colors.white,
          ),
          dotsDecorator: DotsDecorator(
            activeColor: AppColors.primaryRed,
            color: Colors.white,
            size: Size(10, 10),
            activeSize: Size(22, 10),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          onDone: () async {
            Navigator.pushReplacementNamed(context, '/welcome');
            await AppSharedPreferences.setFirstLaunch(false);
          },
          showSkipButton: true,
          onSkip: () async {
            Navigator.pushReplacementNamed(context, '/welcome');
            await AppSharedPreferences.setFirstLaunch(false);
          },
          skipFlex: 0,
          nextFlex: 0,
        ),
      ),
    );
  }
}

PageDecoration getCardDecoration() {
  return PageDecoration(
      titleTextStyle: AppTextStyle.cardTitle,
      bodyTextStyle: AppTextStyle.cardBody,
      descriptionPadding: EdgeInsets.all(16).copyWith(bottom: 0),
      imagePadding: EdgeInsets.all(24));
}
