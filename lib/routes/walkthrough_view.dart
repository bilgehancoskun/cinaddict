import 'package:cinaddict/utils/colors.dart';
import 'package:cinaddict/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class WalkthroughView extends StatelessWidget {
  const WalkthroughView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IntroductionScreen(
          pages: [
            PageViewModel(
              title: 'We Love Movies',
              body: 'Connect and meet with all movie lovers around the world.',
              image: Icon(Icons.local_movies_outlined, size: 240, color: AppColors.softRed,),
              decoration: getCardDecoration(),
            ),
            PageViewModel(
              title: 'Share Posts',
              body: 'Share photos or videos about movies or movie theaters.',
              image: Icon(Icons.image_outlined, size: 240, color: AppColors.softRed,),
              decoration: getCardDecoration(),
            ),
            PageViewModel(
              title: 'Likes - Comments',
              body: 'Like other people\'s posts. Comment on them.',
              image: Icon(Icons.thumb_up_alt_rounded, size: 240, color: AppColors.softRed,),
              decoration: getCardDecoration(),
            ),
            PageViewModel(
              title: 'Discuss with People',
              body:
                  'Find out what people think about movies or movie theaters.',
              image: Icon(Icons.tag, size: 240, color: AppColors.softRed),
              decoration: getCardDecoration(),
            ),
            PageViewModel(
              title: 'Checkout Upcoming Movies',
              body:
              'Checkout current or upcoming movies in theatres. Discuss with other people about them.',
              image: Icon(Icons.theater_comedy, size: 240, color: AppColors.softRed),
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
            activeColor: AppColors.softRed,
            color: Colors.white,
            size: Size(10, 10),
            activeSize: Size(22, 10),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          onDone: () {},
          showSkipButton: true,
          onSkip: () {},
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
