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
      primaryColor: boxColor,
      canvasColor: whiteColor,
      focusColor: dividerColor,
      unselectedWidgetColor: backGroundColor,
      cardColor: whiteColor,
      splashColor: primaryColor,
      disabledColor: appColor,
      hintColor: blackColor,
      backgroundColor: appColor,
      highlightColor: blackColor,
      hoverColor: successColor,
      dividerColor: greyColor,
      textTheme: TextTheme(
        bodyLarge: GoogleFonts.nunitoSans(
            color: appColor, fontWeight: FontWeight.w500, fontSize: 16),
        bodyMedium: GoogleFonts.nunitoSans(
          color: appColor,
          fontWeight: FontWeight.w600,
          fontSize: 28,
        ),

        /// for authnetication text-field tittle
        bodySmall: GoogleFonts.nunitoSans(
            color: whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: Get.height * .014),

        labelLarge: GoogleFonts.nunitoSans(
          color: blackColor,
          fontWeight: FontWeight.w700,
          fontSize: Get.height * .016,
        ),

        labelSmall: GoogleFonts.nunitoSans(
          color: greyColor,
          fontWeight: FontWeight.w600,
          fontSize: Get.height * .016,
        ),
        displayMedium: GoogleFonts.nunitoSans(
          color: blackColor,
          fontWeight: FontWeight.w600,
          fontSize: Get.height * .03,
        ),
        displaySmall: GoogleFonts.nunitoSans(
          color: greyColor,
          fontWeight: FontWeight.w600,
          fontSize: Get.height * .01,
        ),
        headlineSmall: GoogleFonts.nunitoSans(
          color: blackColor,
          fontWeight: FontWeight.w600,
          fontSize: Get.height * .01,
        ),
        headlineLarge: GoogleFonts.nunitoSans(
          color: blackColor,
          fontWeight: FontWeight.w700,
          fontSize: Get.height * .02,
        ),

        /*   displayLarge: GoogleFonts.nunitoSans(
          color: appColor,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        displayMedium: const TextStyle(
          color: appColor,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        displaySmall: TextStyle(
          color: appColor,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),

        labelMedium: GoogleFonts.nunitoSans(
          color: greyColor,
          fontWeight: FontWeight.w600,
          fontSize: Get.height * .012,
        ),

        /// for setting screen
        headlineMedium: const TextStyle(
          color: blackColor,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),

        headlineSmall: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
        titleLarge: TextStyle(
          color: appColor,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
        headlineLarge: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 22,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
      ),
      colorScheme: ColorScheme.light(
              background: Colors.white,
              primary: Colors.black,
              error: Colors.black,
              onBackground: Colors.black.withOpacity(0.5))
          .copyWith(secondary: Colors.black)*/
      ));

  static ThemeData darkTheme = ThemeData(
      secondaryHeaderColor: darkBackGroundColor,
      focusColor: blackColor,
      scaffoldBackgroundColor: darkScaffoldColor,
      primaryColor: whiteColor,
      unselectedWidgetColor: whiteColor.withOpacity(0.1),
      splashColor: whiteColor.withOpacity(0.2),
      cardColor: blackColor,
      backgroundColor: blackColor,
      hintColor: darkSunColor,
      disabledColor: whiteColor,
      canvasColor: darkBackGroundColor,
      highlightColor: whiteColor,
      hoverColor: darkBackGroundColor,
      dividerColor: whiteColor,
      textTheme: TextTheme(
        bodyLarge: GoogleFonts.nunitoSans(
            color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
        bodyMedium: GoogleFonts.nunitoSans(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 28,
        ),

        /// body large
        bodySmall: GoogleFonts.nunitoSans(
          color: blackColor,
          fontWeight: FontWeight.bold,
          fontSize: Get.height * .014,
        ),

        /// display large
        labelLarge: GoogleFonts.nunitoSans(
          color: whiteColor,
          fontWeight: FontWeight.w700,
          fontSize: Get.height * .016,
        ),
        labelMedium: GoogleFonts.nunitoSans(
          color: whiteColor,
          fontWeight: FontWeight.w600,
          fontSize: Get.height * .012,
        ),

        /// display small
        labelSmall: GoogleFonts.nunitoSans(
          color: whiteColor,
          fontWeight: FontWeight.w600,
          fontSize: Get.height * .016,
        ),
        displayMedium: GoogleFonts.nunitoSans(
          color: whiteColor,
          fontWeight: FontWeight.w600,
          fontSize: Get.height * .03,
        ),
        displaySmall: GoogleFonts.nunitoSans(
          color: whiteColor,
          fontWeight: FontWeight.w600,
          fontSize: Get.height * .01,
        ),
        headlineSmall: GoogleFonts.nunitoSans(
          color: whiteColor,
          fontWeight: FontWeight.w600,
          fontSize: Get.height * .01,
        ),
        headlineLarge: GoogleFonts.nunitoSans(
          color: whiteColor,
          fontWeight: FontWeight.w700,
          fontSize: Get.height * .02,
        ),
        /* displayLarge: const TextStyle(
          color: Color(0XFFFF6666),
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        displayMedium: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        displaySmall: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        headlineMedium: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),

        headlineSmall: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
        titleLarge: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
        headlineLarge: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 22,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
      ),
      colorScheme: ColorScheme.dark(
              background: Colors.black,
              primary: Colors.white,
              error: Colors.white,
              onBackground: Colors.grey.withOpacity(0.5))
          .copyWith(secondary: Colors.white)*/
      ));
}
