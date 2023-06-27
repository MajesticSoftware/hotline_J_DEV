import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hotlines/generated/assets.dart';
import 'package:hotlines/theme/app_color.dart';
import 'package:hotlines/utils/extension.dart';

import '../../constant/constant.dart';

// ignore: must_be_immutable
class SportDetailsScreen extends StatelessWidget {
  SportDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headerWidget(context),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                teamReports(context),
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

  List injuryList = [lamarJackson, odellBeckham];
  List teamReportName = ['Last 3 games', '@Home', 'Away', 'Against the spread'];
  List injuryList1 = [
    'Kenny Pickett (O)',
    'T.J. Watt (O)',
    'George Pickens (O)',
  ];

  Padding teamReportWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * .02),
      child: Container(
        height: MediaQuery.of(context).size.height * .227,
        decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(MediaQuery.of(context).size.width * .01),
            color: whiteColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: MediaQuery.of(context).size.height * .059,
                width: Get.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(
                            MediaQuery.of(context).size.width * .01)),
                    color: Theme.of(context).canvasColor),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * .01),
                  child: Padding(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * .013),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: teamReport.appCommonText(
                              color: whiteColor,
                              align: TextAlign.start,
                              weight: FontWeight.w600,
                              size: Get.height * .018),
                        ),
                        Expanded(
                          flex: 1,
                          child: Image.asset(Assets.imagesBAL,
                              width: MediaQuery.of(context).size.width * .040,
                              height:
                                  MediaQuery.of(context).size.height * .040),
                        ),
                        Expanded(
                          flex: 1,
                          child: Image.asset(Assets.imagesPITT,
                              width: MediaQuery.of(context).size.width * .040,
                              height:
                                  MediaQuery.of(context).size.height * .040),
                        ),
                      ],
                    ),
                  ),
                )),
            ListView.builder(
              shrinkWrap: true,
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 4,
                            child: teamReportName[index]
                                .toString()
                                .appCommonText(
                                    color: greyColor,
                                    align: TextAlign.start,
                                    weight: FontWeight.w600,
                                    size: MediaQuery.of(context).size.height *
                                        .014),
                          ),
                          Expanded(
                            flex: 1,
                            child: '1-3'.appCommonText(
                                color: greyColor,
                                weight: FontWeight.w700,
                                size:
                                    MediaQuery.of(context).size.height * .014),
                          ),
                          Expanded(
                            flex: 1,
                            child: '3-0'.appCommonText(
                                color: greyColor,
                                weight: FontWeight.w700,
                                size:
                                    MediaQuery.of(context).size.height * .014),
                          )
                        ],
                      ),
                    ),
                    index == 3
                        ? const SizedBox()
                        : Container(
                            height: 1,
                            color: dividerColor,
                          ),
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
          horizontal: MediaQuery.of(context).size.width * .025),
      child: Container(
        height: MediaQuery.of(context).size.height * .39,
        decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(MediaQuery.of(context).size.width * .02),
            color: whiteColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: MediaQuery.of(context).size.height * .056,
                width: Get.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(
                            MediaQuery.of(context).size.width * .02)),
                    color: Theme.of(context).canvasColor),
                child: Padding(
                  padding: EdgeInsets.all(
                    MediaQuery.of(context).size.height * .014,
                  ),
                  child: injuryReport.appCommonText(
                      color: whiteColor,
                      align: TextAlign.start,
                      weight: FontWeight.w600,
                      size: Get.height * .018),
                )),
            Container(
                height: MediaQuery.of(context).size.height * .054,
                color: primaryColor,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .002,
                  ),
                  child: teamNameWidget(
                      Assets.imagesBAL,
                      baltimoreRavens,
                      MediaQuery.of(context).size.height * .04,
                      MediaQuery.of(context).size.height * .016,
                      context),
                )),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 2,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * .016,
                          vertical: MediaQuery.of(context).size.width * .016),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          injuryList[index].toString().appCommonText(
                                color: greyColor,
                                weight: FontWeight.w600,
                                size: MediaQuery.of(context).size.height * .016,
                              ),
                        ],
                      ),
                    ),
                    Container(
                      height: 1,
                      color: dividerColor,
                    ),
                  ],
                );
              },
            ),
            Container(
                height: MediaQuery.of(context).size.height * .054,
                color: primaryColor,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .002,
                  ),
                  child: teamNameWidget(
                      Assets.imagesPITT,
                      'Pittsburgh Steelers',
                      MediaQuery.of(context).size.height * .04,
                      MediaQuery.of(context).size.height * .016,
                      context),
                )),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 3,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * .016,
                          vertical: MediaQuery.of(context).size.width * .016),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          injuryList1[index].toString().appCommonText(
                              color: greyColor,
                              weight: FontWeight.w600,
                              size: MediaQuery.of(context).size.height * .016),
                        ],
                      ),
                    ),
                    index == 2
                        ? const SizedBox()
                        : Container(
                            height: 1,
                            color: dividerColor,
                          ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Padding playerPropBetsWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * .02),
      child: Container(
        height: MediaQuery.of(context).size.height * .245,
        decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(MediaQuery.of(context).size.width * .02),
            color: whiteColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: MediaQuery.of(context).size.height * .054,
                width: Get.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(
                            MediaQuery.of(context).size.width * .020)),
                    color: Theme.of(context).canvasColor),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    playerPropBets.appCommonText(
                        color: whiteColor,
                        align: TextAlign.start,
                        weight: FontWeight.w600,
                        size: Get.height * .018),
                  ],
                )),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 3,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .062,
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
                              child: Row(
                                children: [
                                  Image.asset(Assets.imagesPITT,
                                      width:
                                          MediaQuery.of(context).size.height *
                                              .040,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .040),
                                  5.W(),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      injuryList1[index]
                                          .toString()
                                          .appCommonText(
                                              color: greyColor,
                                              weight: FontWeight.w600,
                                              size: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .014),
                                      'Baltimore Ravens'.appCommonText(
                                          color: greyColor,
                                          weight: FontWeight.w600,
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .012),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: '1.5+ rushing TD'.appCommonText(
                                  color: greyColor,
                                  weight: FontWeight.bold,
                                  size: MediaQuery.of(context).size.height *
                                      .016),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * .079,
                              height: MediaQuery.of(context).size.height * .046,
                              decoration: BoxDecoration(
                                  color: boxColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                child: '+320'.appCommonText(
                                    color: whiteColor,
                                    size: MediaQuery.of(context).size.height *
                                        .014,
                                    weight: FontWeight.w600),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .02,
                            ),
                          ],
                        ),
                      ),
                    ),
                    index == 2
                        ? const SizedBox()
                        : Container(
                            height: 1,
                            color: dividerColor,
                          ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Padding teamReports(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * .02),
      child: Container(
        height: MediaQuery.of(context).size.height * .2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).canvasColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            tabTitleWidget(context),
            Container(
              height: 1,
              color: dividerColor,
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * .01,
                      vertical: MediaQuery.of(context).size.height * .008),
                  child: Row(
                    children: [
                      teamName(Assets.imagesBAL, bALRavens, Get.height * .048,
                          Get.height * .018, context),
                      buildExpandedBoxWidget(context, upText: '-35'),
                      buildExpandedBoxWidget(context, upText: '-140'),
                      overUpper('o', context),
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  color: dividerColor,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      teamName(Assets.imagesPITT, pITTStreeles,
                          Get.height * .048, Get.height * .018, context),
                      buildExpandedBoxWidget(context, upText: '+35'),
                      buildExpandedBoxWidget(context, upText: '+140'),
                      overUpper('u', context),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Expanded overUpper(String text, BuildContext context) {
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
                borderRadius: BorderRadius.circular(5)),
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              textBaseline: TextBaseline.alphabetic,
              verticalDirection: VerticalDirection.up,
              children: [
                text.appCommonText(
                    color: Theme.of(context).cardColor,
                    size: MediaQuery.of(context).size.height * .016,
                    weight: FontWeight.w600),
                '47'.appCommonText(
                    color: Theme.of(context).cardColor,
                    size: MediaQuery.of(context).size.height * .016,
                    weight: FontWeight.w600),
              ],
            )),
          ),
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

  Expanded buildExpandedBoxWidget(BuildContext context, {String upText = ''}) {
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
                      MediaQuery.of(context).size.height * .005)),
              child: Center(
                child: upText.appCommonText(
                    color: Theme.of(context).cardColor,
                    size: MediaQuery.of(context).size.height * .016,
                    weight: FontWeight.w600),
              ),
            ),
          ],
        ));
  }

  Container tabTitleWidget(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * .053,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            color: Theme.of(context).secondaryHeaderColor),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .010),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: game.appCommonText(
                    color: whiteColor,
                    weight: FontWeight.w600,
                    size: Get.height * .018),
              ),
              Expanded(
                flex: 1,
                child: spread.appCommonText(
                    color: whiteColor,
                    weight: FontWeight.w600,
                    size: Get.height * .018),
              ),
              Expanded(
                flex: 1,
                child: moneyLine.appCommonText(
                    color: whiteColor,
                    weight: FontWeight.w600,
                    size: Get.height * .018),
              ),
              Expanded(
                flex: 1,
                child: overUnder.appCommonText(
                    color: whiteColor,
                    weight: FontWeight.w600,
                    size: Get.height * .018),
              ),
            ],
          ),
        ));
  }

  Container headerWidget(BuildContext context) {
    return Container(
      width: Get.width,
      height: MediaQuery.of(context).size.height * .345,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Assets.imagesSportDetail), fit: BoxFit.fill)),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .04,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * .02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Padding(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.height * .008),
                    child: SvgPicture.asset(
                      Assets.imagesBackArrow,
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                ),
                'BAL @ PIT'.appCommonText(
                    weight: FontWeight.w700,
                    size: MediaQuery.of(context).size.height * .024,
                    color: whiteColor),
                '  '.appCommonText(),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .04,
          ),
          Row(
            children: [
              20.W(),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                    Assets.imagesBAL,
                    width: Get.height * .109,
                    height: Get.height * .109,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .03,
                  ),
                  'Baltimore Ravens'.appCommonText(
                      weight: FontWeight.w700,
                      size: MediaQuery.of(context).size.height * .02,
                      color: whiteColor),
                  '7-6'.appCommonText(
                      weight: FontWeight.w700,
                      size: MediaQuery.of(context).size.height * .014,
                      color: whiteColor)
                ],
              )),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * .02,
                    width: MediaQuery.of(context).size.width * .13,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width * .005),
                        color: whiteColor),
                    child: Center(
                      child: 'Ongoing'.appCommonText(
                          color: blackColor,
                          size: MediaQuery.of(context).size.height * .012,
                          weight: FontWeight.w400),
                    ),
                  ),
                  '10 - 7'.appCommonText(
                      color: whiteColor,
                      size: MediaQuery.of(context).size.height * .048,
                      weight: FontWeight.w700),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * .02,
                  ),
                  '01:00 PM'.appCommonText(
                      color: primaryColor,
                      size: MediaQuery.of(context).size.height * .014,
                      weight: FontWeight.w600),
                  'Sat, Jun 10th 2023'.appCommonText(
                      color: primaryColor,
                      size: MediaQuery.of(context).size.height * .014,
                      weight: FontWeight.w600),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      '83'.appCommonText(
                          size: MediaQuery.of(context).size.height * .018,
                          color: primaryColor,
                          weight: FontWeight.w400),
                      ' °F'.appCommonText(
                          size: 10,
                          weight: FontWeight.w300,
                          color: primaryColor),
                      SvgPicture.asset(
                        Assets.imagesSun,
                        width: Get.height * .068,
                        height: Get.height * .068,
                        fit: BoxFit.fill,
                      ),
                    ],
                  )
                ],
              )),
              Expanded(
                  child: Column(
                children: [
                  Image.asset(
                    Assets.imagesPITT,
                    width: Get.height * .109,
                    height: Get.height * .109,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .03,
                  ),
                  'Baltimore Ravens'.appCommonText(
                      weight: FontWeight.w700,
                      size: MediaQuery.of(context).size.height * .02,
                      color: whiteColor),
                  '7-6'.appCommonText(
                      weight: FontWeight.w700,
                      size: MediaQuery.of(context).size.height * .014,
                      color: whiteColor)
                ],
              )),
              20.W(),
            ],
          )
        ],
      ),
    );
  }
}
