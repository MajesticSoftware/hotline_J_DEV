import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../extras/constants.dart';
import '../generated/assets.dart';

getWeatherIconOld(String condition, BuildContext context, double height) {
  // int data = (((condition) - 32) * (5 / 9) + 273.15).toInt();
  // log('data---${data}');
  if (condition == 'Sunny') {
    return svgPicture(context, Assets.imagesSun, height);
  } else if (condition == 'Patchy rain possible') {
    return svgPicture(context, Assets.imagesSun2, height);
  } else if (condition == 'Rain' || condition == 'Light rain') {
    return svgPicture(context, Assets.imagesSun3, height);
  } else if (condition == 'Partly cloudy') {
    return svgPicture(context, Assets.imagesSun1, height);
  } else if (condition == 'cloudy' || condition == 'Overcast') {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * .02),
      child: svgPicture(context, Assets.imagesSun4, height),
    );
  } else {
    return svgPicture(context, Assets.imagesSun, height);
  }
}

Widget getWeatherIcon(int condition, BuildContext context, double height) {
  if (condition < 300) {
    return svgPicture(context, Assets.imagesSun3, height);
  } else if (condition < 400) {
    return svgPicture(context, Assets.imagesSun3, height);
  } else if (condition < 600) {
    return svgPicture(context, Assets.imagesSun2, height);
  } else if (condition < 700) {
    return svgPicture(context, Assets.imagesSun1, height);
  } else if (condition < 800) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * .02),
      child: svgPicture(context, Assets.imagesSun4, height),
    );
  } else if (condition == 800) {
    return svgPicture(context, Assets.imagesSun, height);
  } else if (condition <= 804) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * .02),
      child: svgPicture(context, Assets.imagesSun1, height),
    );
  } else {
    return svgPicture(context, Assets.imagesSun, height);
  }
}

SvgPicture svgPicture(BuildContext context, String image, double height) {
  return SvgPicture.asset(
    image,
    width: height,
    height: height,
    fit: BoxFit.contain,
  );
}

Widget buildExpandedBoxWidget(BuildContext context,
    {String upText = '', String bottomText = '', bool isDetail = false}) {
  return SizedBox(
      width: 70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .04,
            // width: MediaQuery.of(context).size.width * .09,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.width * .008)),
            child: Center(
              child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(upText,
                      style: GoogleFonts.nunitoSans(
                          color: Theme.of(context).cardColor,
                          fontWeight: FontWeight.bold,
                          fontSize: Get.height * .014))),
            ),
          ).paddingSymmetric(
            horizontal: mobileView.size.shortestSide < 600
                ? MediaQuery.of(context).size.height * .008
                : MediaQuery.of(context).size.height * .015,
          ),
          SizedBox(
            height: isDetail
                ? MediaQuery.of(context).size.height * .01
                : MediaQuery.of(context).size.height * .02,
          ),
          Container(
            height: MediaQuery.of(context).size.height * .04,
            // width: MediaQuery.of(context).size.width * .09,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.width * .008)),
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(bottomText,
                    style: GoogleFonts.nunitoSans(
                        color: Theme.of(context).cardColor,
                        fontWeight: FontWeight.bold,
                        fontSize: Get.height * .014)),
              ),
            ),
          ).paddingSymmetric(
            horizontal: mobileView.size.shortestSide < 600
                ? MediaQuery.of(context).size.height * .008
                : MediaQuery.of(context).size.height * .015,
          )
        ],
      ));
}

// GameListingController selectGameController = Get.find();
// bool isDark = false;
Container commonDivider(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height * .001,
    color: Theme.of(context).indicatorColor,
  );
}
