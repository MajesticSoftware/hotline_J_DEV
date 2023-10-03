import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hotlines/utils/extension.dart';
import 'package:hotlines/view/sports/gameListing/game_listing_con.dart';

import '../extras/constants.dart';
import '../view/sports/selectSport/selecte_game_con.dart';
import '../generated/assets.dart';
import '../theme/app_color.dart';

commonImageWidget(String image, BuildContext context,
    {void Function()? onTap, bool isComingSoon = false}) {
  return Stack(
    alignment: Alignment.center,
    children: [
      GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * .01),
          child: isComingSoon
              ? Image.asset(
                  image,
                  width: Get.width * .29,
                  fit: BoxFit.contain,
                )
              : ColorFiltered(
                  colorFilter: ColorFilter.mode(
                      Theme.of(context)
                          .scaffoldBackgroundColor
                          .withOpacity(0.5),
                      BlendMode.dstATop),
                  child: Image.asset(
                    image,
                    width: Get.width * .29,
                    fit: BoxFit.contain,
                  ),
                ),
        ),
      ),
      isComingSoon
          ? const SizedBox()
          : SvgPicture.asset(
              Assets.imagesCommingSoon,
              width: Get.width * .2,
              fit: BoxFit.contain,
            ),
    ],
  );
}

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

Expanded buildExpandedBoxWidget(BuildContext context,
    {String upText = '', String bottomText = '', bool isDetail = false}) {
  return Expanded(
      flex: 1,
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
                      style: Theme.of(context).textTheme.bodySmall)),
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
                    style: Theme.of(context).textTheme.bodySmall),
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

Widget commonBoxWidget(BuildContext context, {String title = ''}) {
  return Container(
    height: MediaQuery.of(context).size.height * .032,
    // width: MediaQuery.of(context).size.width * .09,
    decoration: BoxDecoration(
        color: whiteColor,
        border: Border.all(color: greyDarkColor, width: 1),
        borderRadius:
            BorderRadius.circular(MediaQuery.of(context).size.width * .012)),
    child: Center(
        child: title.appCommonText(
            color: blackColor,
            weight: FontWeight.w700,
            maxLine: 1,
            size: mobileView.size.shortestSide < 600
                ? MediaQuery.of(context).size.height * .010
                : MediaQuery.of(context).size.height * .014,
            align: TextAlign.center)),
  ).paddingSymmetric(
    horizontal: MediaQuery.of(context).size.height * .012,
  );
}

GameListingController selectGameController = Get.find();
bool isDark = false;
Container commonDivider(BuildContext context) {
  return Container(
    height: isDark || selectGameController.isDarkMode
        ? MediaQuery.of(context).size.height * .00018
        : MediaQuery.of(context).size.height * .001,
    color: backGroundColor,
  );
}
