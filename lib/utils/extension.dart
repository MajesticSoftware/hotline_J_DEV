import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/theme.dart';

extension MediaQueryValues on BuildContext {
  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;
}

extension AddSpace on num {
  Widget H() {
    return SizedBox(height: toDouble());
  }

  Widget W() {
    return SizedBox(width: toDouble());
  }
}

replaceId(String id) {
  String fistId = id.split(',').first;
  String secondId = id.split(',').last;

  if (fistId.contains("-")) {
    return fistId;
  } else if (secondId.contains("-")) {
    return secondId;
  } else {
    return id;
  }
}

void printData({required dynamic tittle, dynamic val}) {
  log("$tittle:-$val");
}

bool isHistory = false;

extension AddText on String {
  Widget appCommonText(
      {Color color = appColor,
      double size = 20,
      double letterSpacing = 0,
      TextAlign align = TextAlign.center,
      FontWeight weight = FontWeight.w500,
      TextDecoration? decoration,
      FontStyle fontStyle = FontStyle.normal,
      int? maxLine,
      TextOverflow? overflow}) {
    return Text(
      this,
      style: GoogleFonts.nunitoSans(
          fontSize: size,
          color: color,
          letterSpacing: letterSpacing,
          // color: isDarkMode ? Colors.white : color,
          fontWeight: weight,
          fontStyle: fontStyle,
          decoration: decoration),
      textAlign: align,
      overflow: overflow,
      maxLines: maxLine,
    );
  }

  Widget lightText(
      {Color color = const Color(0XFF0D0D0D),
      num size = 14,
      FontWeight weight = FontWeight.w300,
      TextDecoration? decoration}) {
    return Text(
      this,
      style: defaultTextStyle(
          color: color, size: size, weight: weight, decoration: decoration),
      textAlign: TextAlign.center,
    );
  }
}

TextStyle defaultTextStyle(
    {Color color = const Color(0XFF9A9A9A),
    num size = 14,
    FontWeight weight = FontWeight.normal,
    TextDecoration? decoration}) {
  return GoogleFonts.nunitoSans(
      color: color,
      fontSize: size.toDouble(),
      fontWeight: weight,
      decoration: decoration);
}

TextStyle hintTextStyle(
    {Color color = const Color(0XFF9A9A9A),
    num size = 14,
    FontWeight weight = FontWeight.normal,
    TextDecoration? decoration}) {
  return GoogleFonts.nunitoSans(
      color: color,
      fontSize: size.toDouble(),
      fontWeight: weight,
      decoration: decoration);
}

TextStyle textFieldTextStyle(
    {Color color = const Color(0XFF0D0D0D),
    num size = 14,
    FontWeight weight = FontWeight.w500,
    TextDecoration? decoration}) {
  return GoogleFonts.nunitoSans(
      color: color,
      fontSize: size.toDouble(),
      fontWeight: weight,
      decoration: decoration);
}
