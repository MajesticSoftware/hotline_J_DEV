import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../constant/constant.dart';
import '../../constant/shred_preference.dart';
import '../../controller/selecte_game_con.dart';
import '../../generated/assets.dart';
import '../../model/leauge_model.dart';
import '../../theme/theme.dart';
import '../../utils/utils.dart';
import '../sports/game_listing_screen.dart';

// ignore: must_be_immutable
class SelectSportScreen extends StatelessWidget {
  SelectSportScreen({Key? key}) : super(key: key);
  SelectGameController selectGameController = Get.find();
  bool isDark = false;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectGameController>(builder: (controller) {
      isDark = PreferenceManager.getIsDarkMode() ?? false;
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: commonAppBar(context, controller),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .01,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.height * .02),
              child: Wrap(
                  runSpacing: 0,
                  alignment: WrapAlignment.start,
                  spacing: Get.height * .02,
                  children: List.generate(
                    sportsLeagueList.length,
                    (index) => commonImageWidget(
                      sportsLeagueList[index].image,
                      isComingSoon: sportsLeagueList[index].isAvailable,
                      context,
                      onTap: sportsLeagueList[index].isAvailable == true
                          ? () {
                              Get.to(GameListingScreen(
                                sportKey: sportsLeagueList[index].key,
                                date: sportsLeagueList[index].date,
                              ));
                            }
                          : () {},
                    ),
                  )),
            ),
          ],
        ),
      );
    });
  }

  PreferredSize commonAppBar(
      BuildContext context, SelectGameController controller) {
    return PreferredSize(
        preferredSize: const Size.fromHeight(147.0),
        child: Container(
          height: MediaQuery.of(context).size.height * .12,
          alignment: Alignment.bottomCenter,
          color: Theme.of(context).secondaryHeaderColor,
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * .024,
                left: MediaQuery.of(context).size.width * .02,
                right: MediaQuery.of(context).size.width * .02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .04,
                  width: MediaQuery.of(context).size.width * .086,
                  child: SvgPicture.asset(Assets.imagesThemeDark,
                      color: Colors.transparent),
                ),
                selectGame.appCommonText(
                    color: whiteColor,
                    size: MediaQuery.of(context).size.height * .03,
                    weight: FontWeight.w700),
                Container(
                  height: MediaQuery.of(context).size.height * .033,
                  // width: MediaQuery.of(context).size.width * .099,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.width * .005),
                      border: Border.all(
                          color: isDark || controller.isDarkMode
                              ? blackColor
                              : Colors.transparent,
                          width: 2),
                      color: isDark || controller.isDarkMode
                          ? blackColor
                          : dividerColor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          PreferenceManager.setIsDarkMod(false);
                          Get.changeThemeMode(ThemeMode.light);
                          controller.isDarkMode = false;
                          isDark = false;
                          controller.update();
                        },
                        child: Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * .004),
                          child: Container(
                            width: MediaQuery.of(context).size.width * .039,
                            height: MediaQuery.of(context).size.height * .04,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(
                                        MediaQuery.of(context).size.width *
                                            .005)),
                                color: isDark || controller.isDarkMode
                                    ? blackColor
                                    : whiteColor),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  Assets.imagesSunLight,
                                  color: isDark || controller.isDarkMode
                                      ? darkSunColor
                                      : blackColor,
                                  width:
                                      MediaQuery.of(context).size.width * .02,
                                  height:
                                      MediaQuery.of(context).size.height * .02,
                                  fit: BoxFit.contain,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          PreferenceManager.setIsDarkMod(true);
                          Get.changeThemeMode(ThemeMode.dark);
                          controller.isDarkMode = true;
                          isDark = true;
                          controller.update();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * .039,
                          height: MediaQuery.of(context).size.height * .04,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.horizontal(
                                  right: Radius.circular(
                                      MediaQuery.of(context).size.width *
                                          .005)),
                              color: isDark || controller.isDarkMode
                                  ? darkBackGroundColor
                                  : dividerColor),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                Assets.imagesMoon,
                                color: isDark || controller.isDarkMode
                                    ? whiteColor
                                    : greyDarkColor,
                                width: MediaQuery.of(context).size.width * .02,
                                height:
                                    MediaQuery.of(context).size.height * .02,
                                fit: BoxFit.contain,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
