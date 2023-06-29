import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hotlines/utils/extension.dart';

import '../constant/shred_preference.dart';
import '../controller/selecte_game_con.dart';
import '../generated/assets.dart';
import '../theme/app_color.dart';

commonImageWidget(String image, {void Function()? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Image.asset(
        image,
        width: Get.width * .29,
        fit: BoxFit.contain,
      ),
    ),
  );
}

SvgPicture getWeatherIcon(int condition, BuildContext context) {
  if (condition < 300) {
    return SvgPicture.asset(
      Assets.imagesSun3,
      width: MediaQuery.of(context).size.width * .068,
      height: MediaQuery.of(context).size.height * .068,
      fit: BoxFit.contain,
    );
  } else if (condition < 400) {
    return SvgPicture.asset(
      Assets.imagesSun3,
      width: MediaQuery.of(context).size.width * .068,
      height: MediaQuery.of(context).size.height * .068,
      fit: BoxFit.contain,
    );
  } else if (condition < 600) {
    return SvgPicture.asset(
      Assets.imagesSun2,
      width: MediaQuery.of(context).size.width * .068,
      height: MediaQuery.of(context).size.height * .068,
      fit: BoxFit.contain,
    );
  } else if (condition < 700) {
    return SvgPicture.asset(
      Assets.imagesSun1,
      width: MediaQuery.of(context).size.width * .068,
      height: MediaQuery.of(context).size.height * .068,
      fit: BoxFit.contain,
    );
  } else if (condition < 800) {
    return SvgPicture.asset(
      Assets.imagesSun1,
      width: MediaQuery.of(context).size.width * .068,
      height: MediaQuery.of(context).size.height * .068,
      fit: BoxFit.contain,
    );
  } else if (condition == 800) {
    return SvgPicture.asset(
      Assets.imagesSun,
      width: MediaQuery.of(context).size.width * .068,
      height: MediaQuery.of(context).size.height * .068,
      fit: BoxFit.contain,
    );
  } else if (condition <= 804) {
    return SvgPicture.asset(
      Assets.imagesSun4,
      width: MediaQuery.of(context).size.width * .068,
      height: MediaQuery.of(context).size.height * .068,
      fit: BoxFit.contain,
    );
  } else {
    return SvgPicture.asset(
      Assets.imagesSun,
      width: MediaQuery.of(context).size.width * .068,
      height: MediaQuery.of(context).size.height * .068,
      fit: BoxFit.contain,
    );
  }
}

Expanded buildExpandedBoxWidget(BuildContext context,
    {String upText = '', String bottomText = ''}) {
  return Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .046,
            width: MediaQuery.of(context).size.width * .09,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.width * .008)),
            child: Center(
              child: Text(upText, style: Theme.of(context).textTheme.bodySmall),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .045,
          ),
          Container(
            height: MediaQuery.of(context).size.height * .046,
            width: MediaQuery.of(context).size.width * .09,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.width * .008)),
            child: Center(
              child: Text(bottomText,
                  style: Theme.of(context).textTheme.bodySmall),
            ),
          )
        ],
      ));
}

Container commonBoxWidget(BuildContext context, {String title = ''}) {
  return Container(
    height: MediaQuery.of(context).size.height * .036,
    width: MediaQuery.of(context).size.width * .09,
    decoration: BoxDecoration(
        color: whiteColor,
        border: Border.all(color: greyDarkColor, width: 1),
        borderRadius:
            BorderRadius.circular(MediaQuery.of(context).size.width * .012)),
    child: Center(
        child: title.appCommonText(
            color: blackColor,
            weight: FontWeight.w700,
            size: MediaQuery.of(context).size.height * .016,
            align: TextAlign.center)),
  );
}

SelectGameController selectGameController = Get.find();
bool isDark = false;
Container commonDivider(BuildContext context) {
  return Container(
    height: isDark || selectGameController.isDarkMode
        ? MediaQuery.of(context).size.height * .00016
        : MediaQuery.of(context).size.height * .001,
    color: backGroundColor,
  );
}
