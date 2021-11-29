import 'package:cinaddict/utils/colors.dart';
import 'package:flutter/material.dart';

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
}

class AppButtonStyle {
  static ButtonStyle primaryRedButton = OutlinedButton.styleFrom(
    backgroundColor: AppColors.primaryRed,
  );
}
