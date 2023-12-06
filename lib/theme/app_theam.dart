import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_color.dart';

class AppTheme {
  //
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
      secondaryHeaderColor: appColor,
      scaffoldBackgroundColor: backGroundColor,
      shadowColor: filterColor,
      primaryColor: boxColor,
      canvasColor: whiteColor,
      focusColor: dividerColor,
      unselectedWidgetColor: backGroundColor,
      cardColor: whiteColor,
      splashColor: primaryColor,
      disabledColor: appColor,
      indicatorColor: dividerColor,
      hintColor: blackColor,
      backgroundColor: appColor,
      highlightColor: blackColor,
      hoverColor: successColor,
      dividerColor: greyColor,
     );

  static ThemeData darkTheme = ThemeData(
      shadowColor: darkBackGroundColor,
      secondaryHeaderColor: darkBackGroundColor,
      focusColor: blackColor,
      scaffoldBackgroundColor: darkScaffoldColor,
      primaryColor: whiteColor,
      unselectedWidgetColor: whiteColor.withOpacity(0.1),
      splashColor: whiteColor.withOpacity(0.2),
      cardColor: blackColor,
      backgroundColor: blackColor,
      hintColor: darkSunColor,
      indicatorColor: greyColor,
      disabledColor: whiteColor,
      canvasColor: darkBackGroundColor,
      highlightColor: whiteColor,
      hoverColor: darkBackGroundColor,
      dividerColor: whiteColor,);
}
