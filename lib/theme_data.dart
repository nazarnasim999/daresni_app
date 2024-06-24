import 'package:flutter/material.dart';

class AppTheme {
  static Color primaryColor = const Color(0xff9F172E);
  static Color secondaryColor = const Color(0xff102C4C);
  static Color naviBlueColor = const Color(0xff001E41);
  static Color orangeColor = const Color(0xffd55e4e);

  static Color white = const Color(0xffffffff);
  static Color black = const Color(0xff000000);
  static Color greyColor = const Color(0xffDBD8D5);
  static Color appGreyColor = const Color(0xffF4F4F4);
  static Color appGreenColor = const Color(0xff528B74);
  static Color appDarkGreenColor = const Color.fromARGB(255, 48, 209, 88);
}

class AppTStyle {
  static TextStyle regularStyle18 = const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  static TextStyle regularStyle12 = const TextStyle(fontSize: 12, fontWeight: FontWeight.bold);
  static TextStyle primaryStyle12 =
      TextStyle(fontSize: 12, color: AppTheme.primaryColor);
  static TextStyle primaryStyle18 =
  TextStyle(fontSize: 18, color: AppTheme.primaryColor);
  static TextStyle secondaryStyle12 =
      TextStyle(fontSize: 12, color: AppTheme.secondaryColor, fontWeight: FontWeight.bold);


  static TextStyle secondaryStyle =
  TextStyle(fontSize: 10, color: AppTheme.secondaryColor);
  static TextStyle secondaryStyle14 =
  TextStyle(fontSize: 14, color: AppTheme.secondaryColor, fontWeight: FontWeight.bold);

  static TextStyle secondaryStyle10 =
  TextStyle(fontSize: 12, color: AppTheme.secondaryColor);
}
