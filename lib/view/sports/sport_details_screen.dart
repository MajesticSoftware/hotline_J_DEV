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
      backgroundColor: backGroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headerWidget(),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                teamReports(),
                injuryReportWidget(),
                teamReportWidget(),
                playerPropBetsWidget(),
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

  Padding teamReportWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Container(
        height: 212,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: whiteColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: 59,
                width: Get.width,
                decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(10)),
                    color: appColor),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(13),
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
                              width: 40, height: 40),
                        ),
                        Expanded(
                          flex: 1,
                          child: Image.asset(Assets.imagesPITT,
                              width: 40, height: 40),
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
                    SizedBox(
                      height: 37,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                      size: 14),
                            ),
                            Expanded(
                              flex: 1,
                              child: '1-3'.appCommonText(
                                  color: greyColor,
                                  weight: FontWeight.w700,
                                  size: 14),
                            ),
                            Expanded(
                              flex: 1,
                              child: '3-0'.appCommonText(
                                  color: greyColor,
                                  weight: FontWeight.w700,
                                  size: 14),
                            )
                          ],
                        ),
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

  Padding injuryReportWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 356,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: whiteColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: 54,
                width: Get.width,
                decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                    color: appColor),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(13),
                    child: injuryReport.appCommonText(
                        color: whiteColor,
                        align: TextAlign.start,
                        weight: FontWeight.w600,
                        size: Get.height * .018),
                  ),
                )),
            Container(
                height: 54,
                color: primaryColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child:
                      teamNameWidget(Assets.imagesBAL, baltimoreRavens, 40, 16),
                )),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 2,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SizedBox(
                      height: 37,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            injuryList[index].toString().appCommonText(
                                color: greyColor,
                                weight: FontWeight.w600,
                                size: 14),
                          ],
                        ),
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
                height: 54,
                color: primaryColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: teamNameWidget(
                      Assets.imagesPITT, ' Pittsburgh Steelers', 40, 16),
                )),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 3,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SizedBox(
                      height: 37,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            injuryList1[index].toString().appCommonText(
                                color: greyColor,
                                weight: FontWeight.w600,
                                size: 14),
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

  Padding playerPropBetsWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 245,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: whiteColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: 54,
                width: Get.width,
                decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                    color: appColor),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(13),
                    child: playerPropBets.appCommonText(
                        color: whiteColor,
                        align: TextAlign.start,
                        weight: FontWeight.w600,
                        size: Get.height * .018),
                  ),
                )),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 3,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SizedBox(
                      height: 62,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  Image.asset(Assets.imagesPITT,
                                      height: 40, width: 40),
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
                                              size: 14),
                                      'Baltimore Ravens'.appCommonText(
                                          color: greyColor,
                                          weight: FontWeight.w600,
                                          size: 12),
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
                                  size: 16),
                            ),
                            Container(
                              width: 76,
                              height: 46,
                              decoration: BoxDecoration(
                                  color: boxColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                child: '+320'.appCommonText(
                                    color: whiteColor,
                                    size: 16,
                                    weight: FontWeight.w600),
                              ),
                            ),
                            20.W(),
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

  Padding teamReports() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        height: 188,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: whiteColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            tabTitleWidget(),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      teamName(Assets.imagesBAL, bALRavens, 46, 18),
                      buildExpandedBoxWidget(upText: '-35'),
                      buildExpandedBoxWidget(upText: '-140'),
                      overUpper('o'),
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
                      teamName(Assets.imagesPITT, pITTStreeles, 46, 18),
                      buildExpandedBoxWidget(upText: '+35'),
                      buildExpandedBoxWidget(upText: '+140'),
                      overUpper('u'),
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

  Expanded overUpper(String text) {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 76,
            height: 46,
            decoration: BoxDecoration(
                color: boxColor, borderRadius: BorderRadius.circular(5)),
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              textBaseline: TextBaseline.alphabetic,
              verticalDirection: VerticalDirection.up,
              children: [
                text.appCommonText(
                    color: whiteColor, size: 16, weight: FontWeight.w600),
                '47'.appCommonText(
                    color: whiteColor, size: 16, weight: FontWeight.w600),
              ],
            )),
          ),
        ],
      ),
    );
  }

  teamName(String assets, String title, double width, double size) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Image.asset(assets, width: width, height: width),
            10.W(),
            title.appCommonText(
                color: blackColor,
                align: TextAlign.start,
                weight: FontWeight.w700,
                size: size),
          ],
        ),
      ),
    );
  }

  teamNameWidget(String assets, String title, double width, double size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Image.asset(assets, width: width, height: width),
          10.W(),
          title.appCommonText(
              color: blackColor,
              align: TextAlign.start,
              weight: FontWeight.w700,
              size: size),
        ],
      ),
    );
  }

  Expanded buildExpandedBoxWidget({String upText = ''}) {
    return Expanded(
        flex: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 76,
              height: 46,
              decoration: BoxDecoration(
                  color: boxColor, borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: upText.appCommonText(
                    color: whiteColor, size: 16, weight: FontWeight.w600),
              ),
            ),
          ],
        ));
  }

  Container tabTitleWidget() {
    return Container(
        height: 53,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            color: appColor),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
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

  Container headerWidget() {
    return Container(
      width: Get.width,
      height: 325,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Assets.imagesSportDetail), fit: BoxFit.fill)),
      child: Column(
        children: [
          40.H(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      Assets.imagesBackArrow,
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                ),
                'BAL @ PIT'.appCommonText(
                    weight: FontWeight.w700, size: 24, color: whiteColor),
                '  '.appCommonText(),
              ],
            ),
          ),
          40.H(),
          Row(
            children: [
              Expanded(
                  child: Column(
                children: [
                  Image.asset(Assets.imagesBAL),
                  10.H(),
                  'Baltimore Ravens'.appCommonText(
                      weight: FontWeight.w700, size: 20, color: whiteColor),
                  '7-6'.appCommonText(
                      weight: FontWeight.w700, size: 14, color: whiteColor)
                ],
              )),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 20,
                    width: 63,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: whiteColor),
                    child: Center(
                      child: 'Ongoing'.appCommonText(
                          color: blackColor, size: 12, weight: FontWeight.w400),
                    ),
                  ),
                  '10 - 7'.appCommonText(
                      color: whiteColor, size: 48, weight: FontWeight.w700),
                  '01:00 PM'.appCommonText(
                      color: primaryColor, size: 14, weight: FontWeight.w600),
                  'Sat, Jun 10th 2023'.appCommonText(
                      color: primaryColor, size: 14, weight: FontWeight.w600),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      '83'.appCommonText(
                          size: 18,
                          color: primaryColor,
                          weight: FontWeight.w400),
                      ' °F'.appCommonText(
                          size: 10,
                          weight: FontWeight.w300,
                          color: primaryColor),
                      SvgPicture.asset(
                        Assets.imagesSun,
                        width: Get.width * .068,
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
                  Image.asset(Assets.imagesPITT),
                  10.H(),
                  'Baltimore Ravens'.appCommonText(
                      weight: FontWeight.w700, size: 20, color: whiteColor),
                  '7-6'.appCommonText(
                      weight: FontWeight.w700, size: 14, color: whiteColor)
                ],
              ))
            ],
          )
        ],
      ),
    );
  }
}
