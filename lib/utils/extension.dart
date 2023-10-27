import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotlines/view/sports/gameListing/game_listing_con.dart';

import '../constant/shred_preference.dart';
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

String dateWidget(String down) {
  if ((down) == '1') {
    return '${down}st';
  } else if ((down).toString().endsWith('1') &&
      !(down).toString().startsWith('1')) {
    return '${down}st';
  } else if ((down).toString().endsWith('2') &&
      !(down).toString().startsWith('1')) {
    return '${down}nd';
  } else if ((down).toString().endsWith('3') &&
      !(down).toString().startsWith('1')) {
    return '${down}rd';
  } else {
    return '${down}th';
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
    num size = 16,
    FontWeight weight = FontWeight.normal,
    TextDecoration? decoration}) {
  return GoogleFonts.nunitoSans(
      color: color,
      fontSize: size.toDouble(),
      fontWeight: weight,
      decoration: decoration);
}

Widget commonTextFiled(BuildContext context,
    {TextEditingController? controller,
    void Function(String)? onChanged,
    required GameListingController ctrl}) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 500),
    height: MediaQuery.of(context).size.height * .05,
    width: Get.width,
    child: TextField(
        onChanged: onChanged,
        controller: controller,
        textAlign: TextAlign.start,
        cursorColor:
            PreferenceManager.getIsDarkMode() ?? false ? whiteColor : boxColor,
        style: defaultTextStyle(
            size: MediaQuery.of(context).size.height * .016,
            color: Theme.of(context).highlightColor),
        decoration: InputDecoration(
          fillColor: Theme.of(context).canvasColor,
          filled: true,
          contentPadding: EdgeInsets.zero,
          hintStyle: hintTextStyle(
              size: MediaQuery.of(context).size.height * .018,
              color: PreferenceManager.getIsDarkMode() ?? false
                  ? greyColor
                  : greyColor.withOpacity(0.5)),
          hintText: 'Search game here...',
          prefixIcon: Icon(
            Icons.search,
            size: MediaQuery.of(context).size.height * .028,
            color: PreferenceManager.getIsDarkMode() ?? false
                ? greyColor
                : boxColor,
          ),
          suffixIcon: InkWell(
            onTap: () {
              ctrl.searchCon.clear();
              ctrl.isSearch = false;
              ctrl.update();
            },
            child: ctrl.searchCon.text.isNotEmpty
                ? Icon(
                    Icons.close,
                    size: MediaQuery.of(context).size.height * .028,
                    color: PreferenceManager.getIsDarkMode() ?? false
                        ? greyColor
                        : boxColor,
                  )
                : const SizedBox(),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(MediaQuery.of(context).size.width * .1),
            ),
            borderSide: const BorderSide(
              color: greyColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(MediaQuery.of(context).size.width * .1),
            ),
            borderSide: BorderSide(
              color: PreferenceManager.getIsDarkMode() ?? false
                  ? greyColor
                  : boxColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(MediaQuery.of(context).size.width * .1),
            ),
            borderSide: BorderSide(
              color: PreferenceManager.getIsDarkMode() ?? false
                  ? greyColor
                  : dividerColor,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(MediaQuery.of(context).size.width * .01),
            ),
            borderSide: BorderSide(
              color: PreferenceManager.getIsDarkMode() ?? false
                  ? greyColor
                  : dividerColor,
            ),
          ),
        )),
  );
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
