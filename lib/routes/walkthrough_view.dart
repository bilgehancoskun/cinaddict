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
              image: Icon(
                Icons.local_movies_outlined,
                size: 240,
                color: AppColors.soft_red,
              ),
              decoration: getCardDecoration(),
            ),
            PageViewModel(
              title: 'Share Posts',
              body: 'Share photos or videos about movies or movie theaters.',
              image: Icon(
                Icons.image_outlined,
                size: 240,
                color: AppColors.soft_red,
              ),
              decoration: getCardDecoration(),
            ),
            PageViewModel(
              title: 'Interact with People',
              body: 'Like other people\'s posts, comment on them, share them.',
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
                          size: 90,
                          color: AppColors.soft_red,
                        ),
                        SizedBox(width: 10,),
                        Icon(
                          Icons.comment,
                          size: 90,
                          color: AppColors.soft_red,
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.ios_share,
                          size: 90,
                          color: AppColors.soft_red,
                        ),
                        SizedBox(width: 10,),
                        Icon(
                          Icons.location_on,
                          size: 90,
                          color: AppColors.soft_red,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              decoration: getCardDecoration(),
            ),
            PageViewModel(
              title: 'Discuss with People',
              body:
                  'Find out what people think about movies or movie theaters.',
              image: Icon(Icons.tag, size: 240, color: AppColors.soft_red),
              decoration: getCardDecoration(),
            ),
            PageViewModel(
              title: 'Checkout Upcoming Movies',
              body:
                  'Checkout current or upcoming movies in theatres. Discuss with other people about them.',
              image: Icon(Icons.theater_comedy,
                  size: 240, color: AppColors.soft_red),
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
            activeColor: AppColors.soft_red,
            color: Colors.white,
            size: Size(10, 10),
            activeSize: Size(22, 10),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          onDone: () {
            Navigator.pushReplacementNamed(context, '/welcome');
          },
          showSkipButton: true,
          onSkip: () {
            Navigator.pushReplacementNamed(context, '/welcome');
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
