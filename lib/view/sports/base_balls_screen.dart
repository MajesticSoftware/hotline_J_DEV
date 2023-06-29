import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hotlines/controller/sport_controller.dart';
import 'package:hotlines/generated/assets.dart';
import 'package:hotlines/theme/app_color.dart';
import 'package:hotlines/utils/extension.dart';

import '../../constant/constant.dart';
import '../../constant/shred_preference.dart';
import '../../controller/selecte_game_con.dart';
import '../../utils/layouts.dart';

// ignore: must_be_immutable
class SportDetailsScreen extends StatelessWidget {
  SportDetailsScreen({Key? key}) : super(key: key);
  final SelectGameController selectGameController = Get.find();

  @override
  Widget build(BuildContext context) {
    bool isDark = PreferenceManager.getIsDarkMode() ?? false;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100.0),
          child: GetBuilder<SelectGameController>(builder: (con) {
            return Container(
              height: MediaQuery.of(context).size.height * .1,
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
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * .099,
                        child: SvgPicture.asset(
                          Assets.imagesBackArrow,
                          height: MediaQuery.of(context).size.height * .015,
                          alignment: Alignment.centerLeft,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    'BAL @ PIT'.appCommonText(
                        color: whiteColor,
                        size: MediaQuery.of(context).size.height * .024,
                        weight: FontWeight.w700),
                    Container(
                      height: MediaQuery.of(context).size.height * .033,
                      // width: MediaQuery.of(context).size.width * .099,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width * .005),
                          border: Border.all(
                              color: isDark || con.isDarkMode
                                  ? blackColor
                                  : Colors.transparent,
                              width: 2),
                          color: isDark || con.isDarkMode
                              ? blackColor
                              : dividerColor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              PreferenceManager.setIsDarkMod(false);
                              Get.changeThemeMode(ThemeMode.light);
                              con.isDarkMode = false;
                              isDark = false;
                              con.update();
                            },
                            child: Padding(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * .004),
                              child: Container(
                                width: MediaQuery.of(context).size.width * .039,
                                height:
                                    MediaQuery.of(context).size.height * .04,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(
                                            MediaQuery.of(context).size.width *
                                                .005)),
                                    color: isDark || con.isDarkMode
                                        ? blackColor
                                        : whiteColor),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      Assets.imagesSunLight,
                                      color: isDark || con.isDarkMode
                                          ? darkSunColor
                                          : blackColor,
                                      width: MediaQuery.of(context).size.width *
                                          .02,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .02,
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
                              con.isDarkMode = true;
                              isDark = true;
                              con.update();
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * .039,
                              height: MediaQuery.of(context).size.height * .04,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.horizontal(
                                      right: Radius.circular(
                                          MediaQuery.of(context).size.width *
                                              .005)),
                                  color: isDark || con.isDarkMode
                                      ? darkBackGroundColor
                                      : dividerColor),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    Assets.imagesMoon,
                                    color: isDark || con.isDarkMode
                                        ? whiteColor
                                        : greyDarkColor,
                                    width:
                                        MediaQuery.of(context).size.width * .02,
                                    height: MediaQuery.of(context).size.height *
                                        .02,
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
            );
          })),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .015,
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                headerWidget(context),
                injuryReportWidget(context),
                teamReportWidget(context),
                playerPropBetsWidget(context),
                40.H(),
              ],
            ),
          ))
        ],
      ),
    );
  }

  List injuryList = [lamarJackson, odellBeckham, 'Patrick Queen (O)'];
  List teamReportName = ['Last 3 games', '@Home', 'Away', 'Against the spread'];
  List injuryList1 = [
    'Kenny Pickett (O)',
    'T.J. Watt (O)',
    'George Pickens (O)',
  ];

  Padding teamReportWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * .02),
      child: Container(
        // height: MediaQuery.of(context).size.height * .227,
        decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(MediaQuery.of(context).size.width * .01),
            color: Theme.of(context).canvasColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headerTitleWidget(context),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * .016,
                          vertical: MediaQuery.of(context).size.height * .01),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            flex: 1,
                            child: '1-3'.appCommonText(
                                color: Theme.of(context).highlightColor,
                                weight: FontWeight.w700,
                                align: TextAlign.end,
                                size:
                                    MediaQuery.of(context).size.height * .014),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .046,
                          ),
                          Expanded(
                            flex: 1,
                            child: teamReportName[index]
                                .toString()
                                .appCommonText(
                                    color: darkGreyColor,
                                    align: TextAlign.center,
                                    weight: FontWeight.w600,
                                    size: MediaQuery.of(context).size.height *
                                        .016),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .046,
                          ),
                          Expanded(
                            flex: 1,
                            child: '3-0'.appCommonText(
                                color: Theme.of(context).highlightColor,
                                weight: FontWeight.w700,
                                align: TextAlign.start,
                                size:
                                    MediaQuery.of(context).size.height * .014),
                          )
                        ],
                      ),
                    ),
                    index == 3 ? const SizedBox() : commonDivider(context),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Padding injuryReportWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.height * .02),
      child: Container(
        // height: MediaQuery.of(context).size.height * .12,
        decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(MediaQuery.of(context).size.width * .01),
            color: Theme.of(context).canvasColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headerTitleWidget(context),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: injuryList.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.width * .038,
                      child: Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: '${injuryList[index]}'
                                .toString()
                                .appCommonText(
                                  color: Theme.of(context).highlightColor,
                                  weight: FontWeight.w700,
                                  align: TextAlign.end,
                                  size:
                                      MediaQuery.of(context).size.height * .016,
                                ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.height * .02,
                          ),
                          const Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.height * .023,
                          ),
                          Expanded(
                            child: '${injuryList1[index]}'
                                .toString()
                                .appCommonText(
                                    color: Theme.of(context).highlightColor,
                                    weight: FontWeight.w700,
                                    align: TextAlign.start,
                                    size: MediaQuery.of(context).size.height *
                                        .016),
                          ),
                        ],
                      ),
                    ),
                    index == injuryList.length - 1
                        ? const SizedBox()
                        : commonDivider(context),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Container headerTitleWidget(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * .032,
        width: Get.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(MediaQuery.of(context).size.width * .01)),
            color: Theme.of(context).disabledColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                'Baltimore Ravens  '.appCommonText(
                  weight: FontWeight.w600,
                  size: MediaQuery.of(context).size.height * .016,
                  align: TextAlign.start,
                  color: Theme.of(context).cardColor,
                ),
                Image.asset(
                  Assets.imagesBAL,
                  width: Get.width * .025,
                  height: Get.height * .025,
                  fit: BoxFit.contain,
                ),
              ],
            ),
            injuryReport.appCommonText(
                color: Theme.of(context).cardColor,
                align: TextAlign.start,
                weight: FontWeight.w700,
                size: Get.height * .018),
            Row(
              children: [
                Image.asset(
                  Assets.imagesPITT,
                  width: Get.width * .025,
                  height: Get.height * .025,
                  fit: BoxFit.contain,
                ),
                '  Pittsburgh Steelers'.appCommonText(
                  weight: FontWeight.w600,
                  size: MediaQuery.of(context).size.height * .016,
                  align: TextAlign.start,
                  color: Theme.of(context).cardColor,
                ),
              ],
            ),
          ],
        ));
  }

  Padding playerPropBetsWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.height * .02),
      child: Container(
        // height: MediaQuery.of(context).size.height * .245,
        decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(MediaQuery.of(context).size.width * .01),
            color: Theme.of(context).canvasColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: MediaQuery.of(context).size.height * .032,
                width: Get.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(
                            MediaQuery.of(context).size.width * .01)),
                    color: Theme.of(context).disabledColor),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    hotlines.appCommonText(
                        color: Theme.of(context).cardColor,
                        align: TextAlign.start,
                        weight: FontWeight.w600,
                        size: Get.height * .018),
                  ],
                )),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 8,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .038,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * .016),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: 'Baltimore Ravens'.appCommonText(
                                  color: Theme.of(context).highlightColor,
                                  weight: FontWeight.w400,
                                  align: TextAlign.start,
                                  size: MediaQuery.of(context).size.height *
                                      .016),
                            ),
                            Expanded(
                              flex: 2,
                              child: '1.5+ rushing TD'.appCommonText(
                                  color: Theme.of(context).highlightColor,
                                  weight: FontWeight.bold,
                                  align: TextAlign.start,
                                  size: MediaQuery.of(context).size.height *
                                      .016),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical:
                                        MediaQuery.of(context).size.width *
                                            .002),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * .096,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(0)),
                                  child: Center(
                                    child: '+320'.appCommonText(
                                        color: Theme.of(context).cardColor,
                                        size:
                                            MediaQuery.of(context).size.height *
                                                .014,
                                        weight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .02,
                            ),
                            Expanded(
                                child: index == 1 || index == 0
                                    ? Image.asset(
                                        Assets.imagesFire,
                                        alignment: Alignment.centerLeft,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .028,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .028,
                                        fit: BoxFit.contain,
                                      )
                                    : const SizedBox()),
                          ],
                        ),
                      ),
                    ),
                    index == 7 ? const SizedBox() : commonDivider(context),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Expanded overUpper(String text, BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            textBaseline: TextBaseline.alphabetic,
            verticalDirection: VerticalDirection.up,
            children: [
              text.appCommonText(
                  color: blackColor,
                  size: MediaQuery.of(context).size.height * .016,
                  weight: FontWeight.w600),
              '47'.appCommonText(
                  color: blackColor,
                  size: MediaQuery.of(context).size.height * .016,
                  weight: FontWeight.w600),
            ],
          )),
        ],
      ),
    );
  }

  teamName(String assets, String title, double width, double size,
      BuildContext context) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * .008),
        child: Row(
          children: [
            Image.asset(assets, width: width, height: width),
            SizedBox(
              width: MediaQuery.of(context).size.width * .01,
            ),
            Expanded(
                child: Text(
              title,
              style: Theme.of(context).textTheme.labelLarge,
              textAlign: TextAlign.start,
            )),
          ],
        ),
      ),
    );
  }

  teamNameWidget(String assets, String title, double width, double size,
      BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Image.asset(assets, width: width, height: width),
          SizedBox(
            width: MediaQuery.of(context).size.width * .01,
          ),
          title.appCommonText(
              color: blackColor,
              align: TextAlign.start,
              weight: FontWeight.w700,
              size: size),
        ],
      ),
    );
  }

  Container tabTitleWidget(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * .031,
        decoration: BoxDecoration(color: Theme.of(context).disabledColor),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .010),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: game.appCommonText(
                    color: Theme.of(context).highlightColor,
                    weight: FontWeight.w600,
                    size: Get.height * .016),
              ),
              Expanded(
                flex: 1,
                child: spread.appCommonText(
                    color: Theme.of(context).highlightColor,
                    weight: FontWeight.w600,
                    size: Get.height * .016),
              ),
              Expanded(
                flex: 1,
                child: moneyLine.appCommonText(
                    color: Theme.of(context).highlightColor,
                    weight: FontWeight.w600,
                    size: Get.height * .016),
              ),
              Expanded(
                flex: 1,
                child: overUnder.appCommonText(
                    color: Theme.of(context).highlightColor,
                    weight: FontWeight.w600,
                    size: Get.height * .016),
              ),
            ],
          ),
        ));
  }

  headerWidget(BuildContext context) {
    isDark = PreferenceManager.getIsDarkMode() ?? false;
    return Stack(
      fit: StackFit.loose,
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.height * .02),
          child: GetBuilder<SelectGameController>(builder: (con) {
            return Container(
              width: Get.width,
              height: MediaQuery.of(context).size.height * .210,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(
                          MediaQuery.of(context).size.width * .02)),
                  image: DecorationImage(
                      image: AssetImage(isDark || con.isDarkMode
                          ? Assets.imagesBackDark
                          : Assets.imagesBackLight),
                      fit: BoxFit.fill)),
              child: Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * .02),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        commonBoxWidget(context, title: '+3.5'),
                        commonBoxWidget(context, title: '+140'),
                        commonBoxWidget(context, title: 'o/u 47')
                      ],
                    ),
                  )),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Image.asset(
                        Assets.imagesBAL,
                        width: Get.width * .068,
                        height: Get.height * .068,
                        fit: BoxFit.contain,
                      ),
                      'Ravens'.appCommonText(
                          weight: FontWeight.bold,
                          size: MediaQuery.of(context).size.height * .02,
                          align: TextAlign.end,
                          color: whiteColor),
                      '7-6'.appCommonText(
                          align: TextAlign.end,
                          weight: FontWeight.w700,
                          size: MediaQuery.of(context).size.height * .014,
                          color: whiteColor),
                    ],
                  )),
                  Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          'Sat, Jun 10th 2023'.appCommonText(
                              color: primaryColor,
                              size: MediaQuery.of(context).size.height * .014,
                              weight: FontWeight.w600),
                          SizedBox(
                            height: MediaQuery.of(context).size.width * .02,
                          ),
                          '10 - 7'.appCommonText(
                              color: whiteColor,
                              size: MediaQuery.of(context).size.height * .048,
                              weight: FontWeight.w700),
                          'M&T Bank Stadium, US'.appCommonText(
                              color: primaryColor,
                              size: MediaQuery.of(context).size.height * .014,
                              weight: FontWeight.w600),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              '83'.appCommonText(
                                  size:
                                      MediaQuery.of(context).size.height * .018,
                                  color: whiteColor,
                                  weight: FontWeight.bold),
                              ' °F'.appCommonText(
                                size: MediaQuery.of(context).size.height * .01,
                                weight: FontWeight.bold,
                                color: whiteColor,
                              ),
                              SvgPicture.asset(
                                Assets.imagesSun,
                                width: MediaQuery.of(context).size.width * .023,
                                height:
                                    MediaQuery.of(context).size.height * .023,
                                fit: BoxFit.fill,
                              ),
                            ],
                          ),
                        ],
                      )),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        Assets.imagesPITT,
                        width: Get.width * .068,
                        height: Get.height * .068,
                        fit: BoxFit.contain,
                      ),
                      'Steelers'.appCommonText(
                          weight: FontWeight.bold,
                          size: MediaQuery.of(context).size.height * .02,
                          align: TextAlign.start,
                          color: whiteColor),
                      '11-2'.appCommonText(
                          align: TextAlign.end,
                          weight: FontWeight.w700,
                          size: MediaQuery.of(context).size.height * .014,
                          color: whiteColor),
                    ],
                  )),
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * .02),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        commonBoxWidget(context, title: '+3.5'),
                        commonBoxWidget(context, title: '+140'),
                        commonBoxWidget(context, title: 'o/u 47')
                      ],
                    ),
                  ))
                ],
              ),
            );
          }),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * .010,
          child: Container(
            height: MediaQuery.of(context).size.height * .02,
            width: MediaQuery.of(context).size.width * .07,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(105), color: redColor),
            child: Center(
              child: 'LIVE'.appCommonText(
                  color: whiteColor,
                  size: MediaQuery.of(context).size.height * .012,
                  weight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
