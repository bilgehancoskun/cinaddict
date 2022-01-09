import 'package:cinaddict/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  static const cardTitle = TextStyle(fontWeight: FontWeight.bold, fontSize: 28);
  static const cardBody = TextStyle(fontSize: 20);
  static const lightTextStyle = TextStyle(
    color: AppColors.lightGrey,
    fontSize: 14.0,
    letterSpacing: -0.5,
  );
  static const lighterTextStyle = TextStyle(
    color: AppColors.lighterGrey,
    fontSize: 14.0,
    letterSpacing: -0.7,
  );
  static const lightersmallTextStyle = TextStyle(
    color: AppColors.lighterGrey,
    fontSize: 12.0,
    letterSpacing: -0.7,
  );
  static const lightestboldTextStyle = TextStyle(
    color: AppColors.white,
    fontSize: 14.0,
    letterSpacing: -0.7,
    fontWeight:  FontWeight.bold,
  );

  static const lightestsmallTextStyle = TextStyle(
    color: AppColors.lightestGrey,
    fontSize: 12.0,
    letterSpacing: -0.7,
  );
  static const lighterbiggerTextStyle = TextStyle(
    color: AppColors.lighterGrey,
    fontSize: 16.0,
    letterSpacing: -0.7,
  );
  static const lighterbiggerboldTextStyle = TextStyle(
    color: AppColors.lighterGrey,
    fontSize: 16.0,
    letterSpacing: -0.7,
    fontWeight:  FontWeight.bold,
  );

  static const darkTextStyle = TextStyle(
    color: AppColors.black,
    fontSize: 16.0,
    letterSpacing: 0.3,
  );
  static const darksmallerTextStyle = TextStyle(
    color: AppColors.black,
    fontSize: 14.0,
    letterSpacing: 0.0,
  );
  static const darksmallestTextStyle = TextStyle(
    color: AppColors.black,
    fontSize: 10.0,
    letterSpacing: 0.0,
  );
  static const darkboldTextStyle = TextStyle(
    color: AppColors.black,
    fontSize: 16.0,
    letterSpacing: 0.3,
    fontWeight:  FontWeight.bold,

  );

  static const whiteTextStyle = TextStyle(
    color: AppColors.white,
    fontSize: 16.0,
    letterSpacing: 0.3,
  );

  static TextStyle welcomeTextStyle = GoogleFonts.yanoneKaffeesatz(
    fontSize: 36,
    fontWeight: FontWeight.w300
  );

}

class AppButtonStyle {
  static ButtonStyle primaryRedButton = OutlinedButton.styleFrom(
    backgroundColor: AppColors.primaryRed,
  );

  static ButtonStyle primaryYellowButton = OutlinedButton.styleFrom(
    backgroundColor: AppColors.yellow,
  );
  static ButtonStyle primaryWhiteButton = OutlinedButton.styleFrom(
    backgroundColor: AppColors.white,
  );
  static ButtonStyle primaryGreyButton = OutlinedButton.styleFrom(
    backgroundColor: AppColors.midGrey,
  );
}

class LoadingAnimation extends StatelessWidget {
  const LoadingAnimation({Key? key, this.text = 'Sharing Post'}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
      child: Center(
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinKitCubeGrid(color: Colors.white, size: 50.0),
              Text(text, style: TextStyle(
                fontSize: 16, color: AppColors.white
              ),),
            ],
          )
      ),
    );
  }
}
