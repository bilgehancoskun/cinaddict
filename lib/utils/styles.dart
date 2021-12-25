import 'package:cinaddict/utils/colors.dart';
import 'package:flutter/material.dart';
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
  static const lighterbiggerTextStyle = TextStyle(
    color: AppColors.lighterGrey,
    fontSize: 16.0,
    letterSpacing: -0.7,
  );
  static const darkTextStyle = TextStyle(
    color: AppColors.black,
    fontSize: 16.0,
    letterSpacing: 0.3,
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

class TextWithIcon extends StatelessWidget {
  final IconData icon;
  final String text;
  final double spacing;
  final Function onPressed;
  const TextWithIcon({Key? key, required this.icon, required this.text, this.spacing = 2, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed:() async {
       await onPressed();
      },


      padding: const EdgeInsets.all(8),
      icon: Column(

        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          SizedBox(height: spacing),
          Text(text),
        ],
      ),
    );
  }
}