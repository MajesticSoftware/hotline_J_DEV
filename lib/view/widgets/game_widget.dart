import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotlines/constant/shred_preference.dart';
import 'package:hotlines/extras/constants.dart';
import 'package:hotlines/model/game_model.dart';
import 'package:hotlines/theme/app_color.dart';
import 'package:hotlines/theme/helper.dart';
import 'package:hotlines/utils/animated_search.dart';
import 'package:hotlines/utils/utils.dart';
import 'package:hotlines/view/sports/gameListing/game_listing_con.dart';

import '../../constant/app_strings.dart';
import '../../generated/assets.dart';
import '../../model/leauge_model.dart';
import 'common_widget.dart';

class GameWidget extends StatelessWidget {
  const GameWidget(
      {Key? key,
      required this.awayTeamImageUrl,
      required this.awayTeamRank,
      required this.awayTeamAbb,
      required this.awayTeamScore,
      required this.homeTeamImageUrl,
      required this.homeTeamRank,
      required this.homeTeamAbb,
      required this.homeTeamScore,
      required this.dateTime,
      required this.isLive,
      required this.weather,
      required this.temp,
      required this.flameNumber,
      required this.awayTeamSpread,
      required this.awayTeamMoneyLine,
      required this.awayTeamOU,
      required this.homeTeamSpread,
      required this.homeTeamMoneyLine,
      required this.homeTeamOU,
      required this.isShowFlam,
      this.onTap,
      required this.isShowWeather})
      : super(key: key);
  final String awayTeamImageUrl;
  final String awayTeamRank;
  final String awayTeamAbb;
  final String awayTeamScore;
  final String awayTeamSpread;
  final String awayTeamMoneyLine;
  final String awayTeamOU;
  final String homeTeamImageUrl;
  final String homeTeamRank;
  final String homeTeamAbb;
  final String homeTeamScore;
  final String homeTeamSpread;
  final String homeTeamMoneyLine;
  final String homeTeamOU;
  final String dateTime;
  final bool isLive;
  final int weather;
  final bool isShowWeather;
  final bool isShowFlam;
  final num temp;
  final num flameNumber;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * .02,
            top: MediaQuery.of(context).size.width * .014,
            right: MediaQuery.of(context).size.width * .02),
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              border: Border.all(color: Theme.of(context).indicatorColor),
              borderRadius: BorderRadius.circular(
                  MediaQuery.of(context).size.width * .02)),
          child: Row(
            children: [
              Expanded(
                flex: mobileView.size.shortestSide < 600 ? 2 : 3,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * .006,
                      horizontal: MediaQuery.of(context).size.width * .02),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.topRight,
                            children: [
                              commonCachedNetworkImage(
                                width: Get.height * .042,
                                height: Get.height * .042,
                                imageUrl: awayTeamImageUrl,
                              ),
                              Positioned(
                                top: -6,
                                right: -3,
                                child: awayTeamRank.toString().appCommonText(
                                    color: Theme.of(context).highlightColor,
                                    align: TextAlign.start,
                                    size: MediaQuery.of(context).size.height *
                                        .019,
                                    weight: FontWeight.bold),
                              )
                            ],
                          ),

                          // 10.W(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .02,
                          ),
                          Expanded(
                            flex: mobileView.size.shortestSide < 600 ? 1 : 2,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  awayTeamAbb.toString(),
                                  style: GoogleFonts.nunitoSans(
                                      color: Theme.of(context).highlightColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: Get.height * .016),
                                  textAlign: TextAlign.start,

                                ),
                              ),
                            ),
                          ),
                          Text(
                            awayTeamScore.toString(),
                            style: GoogleFonts.nunitoSans(
                              color: Theme.of(context).highlightColor,
                              fontWeight: FontWeight.w700,
                              fontSize: Get.height * .016,
                            ),
                            textAlign: TextAlign.start,
                            maxLines: 2,
                          )
                        ],
                      ),
                      5.H(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 0,
                            child: Text(
                              '  @',
                              style: GoogleFonts.nunitoSans(
                                color: Theme.of(context).highlightColor,
                                fontWeight: FontWeight.w600,
                                fontSize: Get.height * .016,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                              flex: mobileView.size.shortestSide < 600 ? 1 : 4,
                              child: commonDivider(context)),
                        ],
                      ),
                      5.H(),
                      Row(
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              commonCachedNetworkImage(
                                  width: Get.height * .042,
                                  height: Get.height * .042,
                                  imageUrl: homeTeamImageUrl),
                              Positioned(
                                top: -6,
                                right: -1,
                                child: homeTeamRank.appCommonText(
                                    color: Theme.of(context).highlightColor,
                                    align: TextAlign.start,
                                    size: MediaQuery.of(context).size.height *
                                        .019,
                                    weight: FontWeight.bold),
                              )
                            ],
                          ),

                          // 10.W(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .02,
                          ),
                          Expanded(
                            flex: mobileView.size.shortestSide < 600 ? 1 : 2,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  homeTeamAbb.toString(),
                                  style: GoogleFonts.nunitoSans(
                                      color: Theme.of(context).highlightColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: Get.height * .016),
                                  textAlign: TextAlign.start,

                                ),
                              ),
                            ),
                          ),
                          Text(
                            homeTeamScore.toString(),
                            style: GoogleFonts.nunitoSans(
                              color: Theme.of(context).highlightColor,
                              fontWeight: FontWeight.w700,
                              fontSize: Get.height * .016,
                            ),
                            textAlign: TextAlign.start,
                            maxLines: 2,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              10.w.W(),
              Visibility(
                visible: isShowFlam,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    (MediaQuery.of(context).size.height * .005).H(),
                    SizedBox(
                      width: 60.h,
                      child: dateTime.appCommonText(
                        size: Get.height * .012,
                        color: Theme.of(context).highlightColor,
                      ),
                    ),
                    10.w.H(),
                    isLive
                        ? Container(
                            height: MediaQuery.of(context).size.height * .02,
                            width: MediaQuery.of(context).size.width * .07,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(105),
                                color: redColor),
                            child: Center(
                              child: 'LIVE'.appCommonText(
                                  color: whiteColor,
                                  size:
                                      MediaQuery.of(context).size.height * .012,
                                  weight: FontWeight.bold),
                            ),
                          )
                        : const SizedBox(),
                    Column(
                      children: [
                        SvgPicture.asset(Assets.assetsImagesFire,
                                fit: BoxFit.contain,
                                height:
                                    MediaQuery.of(context).size.height * .028)
                            .paddingSymmetric(vertical: 10.h),
                        '$flameNumber'.appCommonText(
                            color: Theme.of(context).highlightColor,
                            weight: FontWeight.w600,
                            size: MediaQuery.of(context).size.height * .018)
                      ],
                    ),
                    5.w.H(),
                  ],
                ),
              ),
              /* Visibility(
                  visible: isShowWeather&&!isShowFlam,
                  child: Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        (MediaQuery.of(context).size.height * .005).H(),
                        Text(
                          dateTime,
                          style: GoogleFonts.nunitoSans(
                            color: Theme.of(context).dividerColor,
                            fontWeight: FontWeight.w600,
                            fontSize: Get.height * .01,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        isLive
                            ? Container(
                                height:
                                    MediaQuery.of(context).size.height * .02,
                                width: MediaQuery.of(context).size.width * .07,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(105),
                                    color: redColor),
                                child: Center(
                                  child: 'LIVE'.appCommonText(
                                      color: whiteColor,
                                      size: MediaQuery.of(context).size.height *
                                          .012,
                                      weight: FontWeight.bold),
                                ),
                              )
                            : const SizedBox(),
                        5.w.H(),
                        Column(
                          children: [
                            getWeatherIcon(weather, context,
                                MediaQuery.of(context).size.height * .035),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              textBaseline: TextBaseline.alphabetic,
                              verticalDirection: VerticalDirection.up,
                              children: [
                                Text(
                                  temp == 32
                                      ? "TBD"
                                      : '  ${temp.toString().split('.').first}',
                                  style: GoogleFonts.nunitoSans(
                                      color: Theme.of(context).highlightColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: temp == 32
                                          ? MediaQuery.of(context).size.height *
                                              .014
                                          : MediaQuery.of(context).size.height *
                                              .024),
                                ),
                                Text(
                                  '°F',
                                  style: GoogleFonts.nunitoSans(
                                    color: Theme.of(context).highlightColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: Get.height * .01,
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  )),
              Visibility(
                visible: !isShowWeather&&!isShowFlam,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    (MediaQuery.of(context).size.height * .005).H(),
                    SizedBox(
                      width: 60.h,
                      child: Text(
                        dateTime,
                        style: GoogleFonts.nunitoSans(
                          color: Theme.of(context).dividerColor,
                          fontWeight: FontWeight.w600,
                          fontSize: Get.height * .01,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    isLive
                        ? Container(
                            height: MediaQuery.of(context).size.height * .02,
                            width: MediaQuery.of(context).size.width * .07,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(105),
                                color: redColor),
                            child: Center(
                              child: 'LIVE'.appCommonText(
                                  color: whiteColor,
                                  size: MediaQuery.of(context).size.height *
                                      .012,
                                  weight: FontWeight.bold),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),*/
              10.w.W(),
              buildExpandedBoxWidget(context,
                  bottomText: homeTeamSpread, upText: awayTeamSpread),
              buildExpandedBoxWidget(context,
                  bottomText: homeTeamMoneyLine, upText: awayTeamMoneyLine),
              Expanded(
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
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          textBaseline: TextBaseline.alphabetic,
                          verticalDirection: VerticalDirection.up,
                          children: [
                            Text('o',
                                style: GoogleFonts.nunitoSans(
                                    color: Theme.of(context).cardColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Get.height * .014)),
                            Text(awayTeamOU.toString(),
                                style: GoogleFonts.nunitoSans(
                                    color: Theme.of(context).cardColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Get.height * .014)),
                          ],
                        )),
                      ).paddingSymmetric(
                        horizontal: mobileView.size.shortestSide < 600
                            ? MediaQuery.of(context).size.height * .008
                            : MediaQuery.of(context).size.height * .015,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * .04,
                        // width: MediaQuery.of(context).size.width * .09,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(
                                MediaQuery.of(context).size.width * .008)),
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          textBaseline: TextBaseline.alphabetic,
                          verticalDirection: VerticalDirection.up,
                          children: [
                            Text('u',
                                style: GoogleFonts.nunitoSans(
                                    color: Theme.of(context).cardColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Get.height * .014)),
                            Text(homeTeamOU.toString(),
                                style: GoogleFonts.nunitoSans(
                                    color: Theme.of(context).cardColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Get.height * .014)),
                          ],
                        )),
                      ).paddingSymmetric(
                        horizontal: mobileView.size.shortestSide < 600
                            ? MediaQuery.of(context).size.height * .008
                            : MediaQuery.of(context).size.height * .015,
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

Future<dynamic> subscriptionDialog(BuildContext context, {required Function() onTap,required Function() restoreOnTap,bool showButton=true,String? price}) {
  return showDialog(
    context: context,
    builder: (context) {
      return SimpleDialog(
        contentPadding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 30.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        title: 'Hotlines Analytics'.appCommonText(
            decorationColor: yellowColor,
            color: yellowColor,
            size: Get.height * .03,
            decoration: TextDecoration.underline,
            weight: FontWeight.bold),
        children: [
          'Unlock next level analytics & we’ll help you easily identify the biggest mismatches for every game!'
              .appCommonText(
                  color: whiteColor,
                  size: Get.height * .021,
                  weight: FontWeight.bold),
          20.h.H(),
          Image.asset(
            Assets.imagesSs,
            height: 300,
          ),
          20.h.H(),
          RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text:
                      'This subscription automatically renews for ${price??"\$9.99/mo"} a month. You can cancel anytime. By upgrading, you agree to Hotlines ',
                  style: GoogleFonts.nunitoSans(
                    color: whiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: Get.height * .018,
                  ),
                  children: [
                    linkTextWidget(context,
                        text: 'Terms of Service',
                        color: yellowColor,
                        link: 'https://www.hotlinesmd.com/terms-of-service'),
                    TextSpan(
                      text: ', ',
                      style: GoogleFonts.nunitoSans(
                        color: whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: Get.height * .018,
                      ),
                    ),
                    linkTextWidget(context,
                        text: 'EULA',
                        color: yellowColor,
                        link: 'https://www.hotlinesmd.com/eula'),
                    TextSpan(
                      text: ', and ',
                      style: GoogleFonts.nunitoSans(
                        color: whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: Get.height * .018,
                      ),
                    ),
                    linkTextWidget(context,
                        text: 'Privacy Policy.',
                        color: yellowColor,
                        link: 'https://www.hotlinesmd.com/privacy-policy'),
                  ])),
          (showButton?20:0).h.H(),
          Visibility(
            visible: showButton,
            child: CommonAppButton(
              title: "Upgrade for ${price??"\$9.99"}/mo",
              textColor: blackColor,
              onTap: onTap,
            ).paddingSymmetric(horizontal: 40.h),
          ),
          (showButton?10:0).h.H(),
          Visibility(
            visible: showButton,
            child: InkWell(
              highlightColor: Colors.transparent,splashFactory: NoSplash.splashFactory,
              onTap:
                restoreOnTap
              ,
              child: "Restore"
                  .appCommonText(
                  color: yellowColor,
                  size: Get.height * .022,decoration: TextDecoration.underline,decorationColor: yellowColor,
                  weight: FontWeight.bold),
            ),
          ),
        ],
      );
    },
  );
}

class GameTabCard extends StatelessWidget {
  GameTabCard(
      {Key? key,
      this.onTap,
      this.onTapGambling,
      this.onTapContact,
      required this.controller})
      : super(key: key);
  final void Function()? onTap;
  final void Function()? onTapGambling;
  final void Function()? onTapContact;
  final GameListingController controller;
  final List<Color> sportSelectedColor = [
    const Color(0xff0C4981),
    const Color(0xff1A8B47),
    const Color(0xffEABB42),
    Colors.orange,
    Colors.deepPurpleAccent
  ];
  final List<Color> sportColor = [
    const Color(0xff0C4981).withOpacity(.4),
    const Color(0xff1A8B47).withOpacity(.4),
    const Color(0xffEABB42).withOpacity(.4),
    Colors.orange.withOpacity(.4),
    Colors.deepPurpleAccent.withOpacity(.4),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
            width: Get.width,
            height: MediaQuery.of(context).size.height * .05,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return /*index == 5 */ /*|| index == 4*/ /*
                      ? InkWell(
                          highlightColor: Colors.transparent,
                          onTap: */
                      /* Platform.isIOS && index == 3
                              ? onTapContact
                              : index == 3
                                  ?*/
                      /*
                              onTapGambling */ /*  : onTapContact*/ /*,
                          child: Container(
                            height: MediaQuery.of(context).size.height * .05,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: Theme.of(context).primaryColor),
                            child: Center(
                              child:
                                  (*/ /*Platform.isIOS && index == 3
                                      ? 'Contact'
                                      : index == 3
                                          ?*/ /*
                                          gambling */ /*: 'Contact'*/ /*)
                                      .appCommonText(
                                          color: Theme.of(context).cardColor,
                                          align: TextAlign.start,
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .018,
                                          weight: FontWeight.w700)
                                      .paddingSymmetric(horizontal: 20.w),
                            ),
                          ),
                        )
                      :*/
                      GestureDetector(
                    onTap: () {
                      controller.tabClick(context, index);
                      controller.update();
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * .05,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: controller.isSelectedGame ==
                                  sportsLeagueList[index].gameName
                              ? sportSelectedColor[index]
                              : sportColor[index]
                          /*image: controller.isSelectedGame ==
                                        sportsLeagueList[index].gameName
                                    ? DecorationImage(
                                        image: AssetImage(
                                            sportsLeagueList[index].image),
                                        fit: BoxFit.cover,
                                      )
                                    : DecorationImage(
                                        image: AssetImage(
                                            sportsLeagueList[index].image),
                                        colorFilter: ColorFilter.mode(
                                            Theme.of(context)
                                                .scaffoldBackgroundColor
                                                .withOpacity(0.5),
                                            BlendMode.dstATop),
                                        fit: BoxFit.cover,
                                      )*/
                          ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            sportsLeagueList[index].gameImage,
                            height: MediaQuery.of(context).size.height * .04,
                            width: MediaQuery.of(context).size.width * .01,
                            fit: index == 1 || index == 2
                                ? BoxFit.cover
                                : BoxFit.contain,
                            color: whiteColor,
                          ).paddingSymmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * .010,
                              horizontal:
                                  MediaQuery.of(context).size.height * .010),
                          sportsLeagueList[index]
                              .gameName
                              .appCommonText(
                                  color: Colors.white,
                                  align: TextAlign.start,
                                  size:
                                      MediaQuery.of(context).size.height * .018,
                                  weight: FontWeight.w700)
                              .paddingOnly(
                                  right:
                                      MediaQuery.of(context).size.height * .020)
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return 20.w.W();
                },
                itemCount: /* Platform.isIOS ? */ 5 /*: 5*/))
        .paddingSymmetric(
            vertical: 15.h,
            horizontal: MediaQuery.of(context).size.width * .03);
  }
}

/*class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.height * .35,
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      child: GetBuilder<GameListingController>(builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            110.h.H(),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  commonCachedNetworkImage(
                    imageUrl:
                        ('${AppUrls.imageUrl}${PreferenceManager.getUserProfile()}'),
                    height: MediaQuery.of(context).size.height * .12,
                    width: MediaQuery.of(context).size.height * .12,
                  ),
                  10.h.H(),
                  (PreferenceManager.getUserName() ?? "Name")
                      .toString()
                      .appCommonText(
                          color: yellowColor,
                          align: TextAlign.start,
                          weight: FontWeight.w700,
                          size: MediaQuery.of(context).size.height * .02),
                  (PreferenceManager.getUserEmail() ?? 'name@gmail.com')
                      .toString()
                      .appCommonText(
                          color: yellowColor,
                          align: TextAlign.start,
                          weight: FontWeight.w700,
                          size: MediaQuery.of(context).size.height * .022),
                ],
              ),
            ),
            20.h.H(),
            commonDivider(context),
            30.h.H(),
            drawerCard(
              icon: Assets.imagesNfl,
              title: 'NFL',
              context: context,
              onTap: () {
                scaffoldKey.currentState!.closeDrawer();
                controller.isSelectedGame = sportsLeagueList[0].gameName;
                controller.date = sportsLeagueList[0].date;
                controller.sportKey = sportsLeagueList[0].key;
                controller.apiKey = sportsLeagueList[0].apiKey;
                controller.sportId = sportsLeagueList[0].sportId;
                if (controller.isSelected
                    .contains(sportsLeagueList[0].gameName)) {
                } else {
                  controller.isSelected.add(sportsLeagueList[0].gameName);
                  Future.delayed(const Duration(seconds: 0), () {
                    controller.isLoading.value = true;
                    controller.isPagination = true;
                    controller.getResponse(true, sportsLeagueList[0].key);
                  });
                }
                controller.update();
              },
            ),
            drawerCard(
              icon: Assets.imagesNcaa,
              title: 'NCAAF',
              context: context,
              onTap: () {
                scaffoldKey.currentState!.closeDrawer();
                controller.isSelectedGame = sportsLeagueList[1].gameName;
                controller.date = sportsLeagueList[1].date;
                controller.sportKey = sportsLeagueList[1].key;
                controller.apiKey = sportsLeagueList[1].apiKey;
                controller.sportId = sportsLeagueList[1].sportId;
                if (controller.isSelected
                    .contains(sportsLeagueList[1].gameName)) {
                } else {
                  controller.isSelected.add(sportsLeagueList[1].gameName);
                  Future.delayed(const Duration(seconds: 0), () {
                    controller.isLoading.value = true;
                    controller.isPagination = true;
                    controller.getResponse(true, sportsLeagueList[1].key);
                  });
                }
                controller.update();
              },
            ),
            drawerCard(
              icon: Assets.imagesMlb,
              title: 'MLB',
              context: context,
              onTap: () {
                scaffoldKey.currentState!.closeDrawer();
                controller.isSelectedGame = sportsLeagueList[2].gameName;
                controller.date = sportsLeagueList[2].date;
                controller.sportKey = sportsLeagueList[2].key;
                controller.apiKey = sportsLeagueList[2].apiKey;
                controller.sportId = sportsLeagueList[2].sportId;
                if (controller.isSelected
                    .contains(sportsLeagueList[2].gameName)) {
                } else {
                  controller.isSelected.add(sportsLeagueList[2].gameName);
                  Future.delayed(const Duration(seconds: 0), () {
                    controller.isLoading.value = true;
                    controller.isPagination = true;
                    controller.getResponse(true, sportsLeagueList[2].key);
                  });
                }
                controller.update();
              },
            ),
            drawerCard(
              widget: Icon(
                Icons.local_fire_department_outlined,
                color: whiteColor,
                size: MediaQuery.of(context).size.width * .06,
              ),
              title: 'Gambling 101',
              context: context,
              onTap: () {
                scaffoldKey.currentState!.closeDrawer();
                toggle = 0;
                controller.isSelectedGame = 'Gambling 101';
              },
            ),
            Visibility(
              visible: (PreferenceManager.getIsLogin() ?? false) == true,
              child: drawerCard(
                widget: Icon(
                  Icons.person_outline_rounded,
                  color: whiteColor,
                  size: MediaQuery.of(context).size.width * .06,
                ),
                title: 'Profile',
                context: context,
                onTap: () {
                  scaffoldKey.currentState!.closeDrawer();
                  Get.to(ProfileScreen());
                },
              ),
            ),
            drawerCard(
              widget: Icon(
                Icons.logout,
                color: whiteColor,
                size: MediaQuery.of(context).size.width * .05,
              ),
              title: 'Logout',
              context: context,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return exitApp(
                      context,
                      onTap: () {
                        controller.logOut(context);
                      },
                    );
                  },
                );
              },
            ),
            20.h.H(),
            Container(
              width: 160.w,
              height: 70.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.r),
                  color: Theme.of(context).bottomAppBarColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      PreferenceManager.setIsDarkMod(false);
                      Get.changeThemeMode(ThemeMode.light);
                      // controller.isDarkMode = false;
                      // isDark = false;
                      controller.update();
                    },
                    child: Padding(
                      padding: EdgeInsets.all(2.sp),
                      child: Container(
                        width: 60.w,
                        height: 50.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(100.r)),
                            color: Theme.of(context).cardColor),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              Assets.imagesSunLight,
                              // ignore: deprecated_member_use
                              color: Theme.of(context).hintColor,
                              width: 35.w,
                              height: 35.w,
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
                      // controller.isDarkMode = true;
                      // isDark = true;
                      controller.update();
                    },
                    child: Container(
                      width: 60.w,
                      height: 50.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.horizontal(
                              right: Radius.circular(100.r)),
                          color: Theme.of(context).bottomAppBarColor),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            Assets.imagesMoon,
                            // ignore: deprecated_member_use
                            color: PreferenceManager.getIsDarkMode() ?? false
                                ? whiteColor
                                : greyDarkColor,
                            width: 35.w,
                            height: 35.w,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ).paddingSymmetric(
                horizontal: MediaQuery.of(Get.context!).size.width * .05),
          ],
        );
      }),
    );
  }
}*/

Widget drawerCard(
    {String title = '',
    Function()? onTap,
    required BuildContext context,
    String? icon,
    Widget? widget}) {
  return GestureDetector(
    onTap: onTap,
    child: Row(
      children: [
        CircleAvatar(
          radius: 28.h,
          backgroundColor: whiteColor.withOpacity(.2),
          child: icon != null
              ? SvgPicture.asset(
                  icon,
                  height: MediaQuery.of(context).size.height * .026,
                  width: MediaQuery.of(context).size.width * .01,
                  fit: BoxFit.contain,
                )
              : widget ?? const SizedBox(),
        ),
        20.h.W(),
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: title.appCommonText(
                color: whiteColor,
                align: TextAlign.start,
                weight: FontWeight.w700,
                size: 22.h),
          ),
        ),
      ],
    ).paddingOnly(bottom: MediaQuery.of(Get.context!).size.width * .04),
  ).paddingSymmetric(horizontal: MediaQuery.of(Get.context!).size.width * .05);
}

Future showDialogIfFirstLoaded(BuildContext context) async {
  if (PreferenceManager.getIsFirstLoaded() != null) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: const Text("Getting Started:"),
          titleTextStyle:
              defaultTextStyle(color: blackColor, weight: FontWeight.w700),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              dialogCard(
                  image:
                      'https://a.slack-edge.com/production-standard-emoji-assets/14.0/apple-medium/1f3c8.png',
                  title:
                      'Pick a Sport - SEC football fan? Jump to NCAAF. Baltimore Ravens fan? Jump to NFL to see their next game.'),
              dialogCard(
                  image:
                      'https://a.slack-edge.com/production-standard-emoji-assets/14.0/apple-medium/1f37f.png',
                  title:
                      'Pick a Game - Have a favorite team? Click into their next game to see how they stack up against the competition.'),
              dialogCard(
                  image:
                      'https://a.slack-edge.com/production-standard-emoji-assets/14.0/apple-medium/1f4da.png',
                  title:
                      'Learn - We provide you with head to head matchups and analysis to give you insights on trends.'),
              dialogCard(
                  image:
                      'https://a.slack-edge.com/production-standard-emoji-assets/14.0/apple-medium/2665-fe0f.png',
                  title: 'Share - Love HotlinesCB? Share with your friends!'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    return appColor;
                  },
                ),
              ),
              child: 'OK'
                  .appCommonText(weight: FontWeight.w700, color: whiteColor),
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
                PreferenceManager.setIsFirstLoaded(true);
              },
            ),
          ],
        );
      },
    );
  }
}

Widget dialogCard({required String image, required String title}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Image.asset(
        image,
        height: MediaQuery.of(Get.context!).size.width * .055,
        fit: BoxFit.contain,
      ),
      20.w.W(),
      Expanded(
        child: title.appCommonText(
            size: MediaQuery.of(Get.context!).size.height * .022,
            align: TextAlign.start,
            color: whiteColor,
            weight: FontWeight.w600),
      )
    ],
  ).paddingOnly(bottom: 10);
}

class ContactView extends StatelessWidget {
  const ContactView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            width: Get.width,
            // height: MediaQuery.of(context).size.height * .05,
            decoration:
                BoxDecoration(color: Theme.of(context).secondaryHeaderColor),
            child: 'Contact'
                .appCommonText(
                    color: whiteColor,
                    weight: FontWeight.bold,
                    size: MediaQuery.of(context).size.height * .018)
                .paddingSymmetric(vertical: 20.w)),
      ],
    );
  }
}

class NoGameWidget extends StatelessWidget {
  const NoGameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: Get.width,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  Assets.imagesNodataImage,
                  width: MediaQuery.of(context).size.width * .349,
                  height: MediaQuery.of(context).size.height * .329,
                  fit: BoxFit.fill,
                ),
                /* Positioned(
                  bottom: MediaQuery.of(context).size.height * .07,
                  width: MediaQuery.of(context).size.width * .34,
                  child: GestureDetector(
                      onTap: () {
                        // Get.back();
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * .032,
                        width: MediaQuery.of(context).size.width * .34,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Theme.of(context).backgroundColor),
                        child: Center(
                          child: backButton.appCommonText(
                              color: whiteColor,
                              size: mobileView.size.shortestSide < 600
                                  ? MediaQuery.of(context).size.height * .012
                                  : MediaQuery.of(context).size.height * .014,
                              weight: FontWeight.w500),
                        ),
                      )),
                )*/
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderCard extends StatelessWidget {
  const HeaderCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        // height: MediaQuery.of(context).size.height * .05,
        decoration:
            BoxDecoration(color: Theme.of(context).secondaryHeaderColor),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: mobileView.size.shortestSide < 600 ? 2 : 3,
                child: ''.appCommonText(
                    color: whiteColor,
                    weight: FontWeight.w600,
                    size: MediaQuery.of(context).size.height * .016),
              ),
              Expanded(
                flex: 1,
                child: ''.appCommonText(
                    color: whiteColor,
                    weight: FontWeight.w600,
                    size: MediaQuery.of(context).size.height * .017),
              ),
              Expanded(
                flex: 1,
                child: spread.appCommonText(
                    color: whiteColor,
                    weight: FontWeight.w600,
                    size: MediaQuery.of(context).size.height * .016),
              ),
              Expanded(
                flex: 1,
                child: moneyLine.appCommonText(
                    color: whiteColor,
                    weight: FontWeight.w600,
                    size: MediaQuery.of(context).size.height * .016),
              ),
              Expanded(
                flex: 1,
                child: overUnder.appCommonText(
                    color: whiteColor,
                    weight: FontWeight.w600,
                    size: MediaQuery.of(context).size.height * .016),
              ),
            ],
          ),
        ));
  }
}

class GamblingCard extends StatelessWidget {
  const GamblingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              100.w.H(),
              Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                      gamblingList.length,
                      (index) => Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * .03,
                                vertical:
                                    MediaQuery.of(context).size.height * .002),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 0,
                                  child: Image.asset(
                                    Assets.imagesFire,
                                    alignment: Alignment.centerLeft,
                                    height: MediaQuery.of(context).size.height *
                                        .028,
                                    width: MediaQuery.of(context).size.width *
                                        .028,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * .02,
                                ),
                                Expanded(
                                  child: RichText(
                                    text: index == 11
                                        ? TextSpan(
                                            text: 'Juice (also known as ',
                                            style: GoogleFonts.nunitoSans(
                                              color: Theme.of(context)
                                                  .highlightColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .016,
                                            ),
                                            children: [
                                                linkTextWidget(context,
                                                    text: 'vigorish',
                                                    link:
                                                        'https://www.forbes.com/betting/sports-betting/what-is-the-vig-in-betting/'),
                                                TextSpan(
                                                  text: ' or “vig”)',
                                                  style: GoogleFonts.nunitoSans(
                                                    color: Theme.of(context)
                                                        .highlightColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            .016,
                                                  ),
                                                ),
                                                textSpanCommonWidget(context,
                                                    title: ':'),
                                                textSpanUnBoldText(
                                                    index, context,
                                                    text:
                                                        ' The amount charged by sportsbooks for taking a bet. If a bet is offered at -110, bettors would need to wager \$110 to win \$100. The \$10 on the \$110 bet is the juice. This can also be called the rake.'),
                                              ])
                                        : TextSpan(
                                            text: '${gamblingList[index]}'
                                                .toString()
                                                .split(':')
                                                .first
                                                .toString(),
                                            style: GoogleFonts.nunitoSans(
                                              color: Theme.of(context)
                                                  .highlightColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .016,
                                            ),
                                            children: index == 6
                                                ? [
                                                    textSpanCommonWidget(
                                                        context,
                                                        title: ':'),
                                                    textSpanUnBoldText(
                                                        index, context,
                                                        text:
                                                            'The expected straight-up winner of any game or event. Favorites are priced with a '),
                                                    linkTextWidget(context,
                                                        text: 'negative number',
                                                        link:
                                                            'https://www.forbes.com/betting/guide/plus-minus-odds/'),
                                                    textSpanUnBoldText(
                                                        index, context,
                                                        text:
                                                            ' and are considered to be “giving points” on the spread.'),
                                                  ]
                                                : index == 7
                                                    ? [
                                                        textSpanCommonWidget(
                                                            context,
                                                            title: ':'),
                                                        textSpanUnBoldText(
                                                            index, context,
                                                            text:
                                                                ' A wager on something that will take place longer-term than a wager on an individual game or event. Examples include '),
                                                        linkTextWidget(context,
                                                            text:
                                                                'preseason bets',
                                                            link:
                                                                'https://www.forbes.com/betting/nfl/futures-odds/'),
                                                        textSpanUnBoldText(
                                                            index, context,
                                                            text:
                                                                ' on whether a team will win a championship or which player will win awards, such as MVP.'),
                                                      ]
                                                    : index == 8
                                                        ? [
                                                            textSpanCommonWidget(
                                                                context,
                                                                title: ':'),
                                                            textSpanUnBoldText(
                                                                index, context,
                                                                text:
                                                                    ' Making a bet on the opposite side of an original wager to minimize risk and guarantee at least some return. An example would be making a large futures wager on a football team to win the '),
                                                            linkTextWidget(
                                                                context,
                                                                text:
                                                                    'Super Bowl',
                                                                link:
                                                                    'https://www.forbes.com/betting/nfl/how-to-bet-on-the-super-bowl/'),
                                                            textSpanUnBoldText(
                                                                index, context,
                                                                text:
                                                                    ', then betting against that team in the Super Bowl itself.'),
                                                          ]
                                                        : index == 10
                                                            ? [
                                                                textSpanCommonWidget(
                                                                    context,
                                                                    title: ':'),
                                                                textSpanUnBoldText(
                                                                    index,
                                                                    context,
                                                                    text:
                                                                        ' A bet made on an event after it has started. This is also called a '),
                                                                linkTextWidget(
                                                                    context,
                                                                    text:
                                                                        'live bet.',
                                                                    link:
                                                                        'https://www.forbes.com/betting/guide/in-game/'),
                                                              ]
                                                            : index == 15
                                                                ? [
                                                                    textSpanCommonWidget(
                                                                        context,
                                                                        title:
                                                                            ':'),
                                                                    textSpanUnBoldText(
                                                                        index,
                                                                        context,
                                                                        text:
                                                                            ' A '),
                                                                    linkTextWidget(
                                                                        context,
                                                                        text:
                                                                            'straight bet',
                                                                        link:
                                                                            'https://www.forbes.com/betting/guide/moneyline/'),
                                                                    textSpanUnBoldText(
                                                                        index,
                                                                        context,
                                                                        text:
                                                                            ' made simply on a contest’s outcome with no point spread involved. Favorites have negative odds, while underdogs are listed with positive odds.'),
                                                                  ]
                                                                : index == 16
                                                                    ? [
                                                                        textSpanCommonWidget(
                                                                            context,
                                                                            title:
                                                                                ':'),
                                                                        textSpanUnBoldText(
                                                                            index,
                                                                            context,
                                                                            text:
                                                                                ' The measure of '),
                                                                        linkTextWidget(
                                                                            context,
                                                                            text:
                                                                                'how much a bettor can win',
                                                                            link:
                                                                                'https://www.forbes.com/betting/sports-betting/how-sports-betting-odds-work/#:~:text=First%2C%20sports%20betting%20odds%20outline%20a%20particular%20game,small%20cut%20on%20both%20sides%20of%20a%20line.'),
                                                                        textSpanUnBoldText(
                                                                            index,
                                                                            context,
                                                                            text:
                                                                                ' on a specific wager, per \$100 in American odds. For example, a bettor will win \$124 with a \$100 bet at +124 odds but must wager \$124 to win \$100 if the odds are -124.'),
                                                                      ]
                                                                    : index ==
                                                                            17
                                                                        ? [
                                                                            textSpanCommonWidget(context,
                                                                                title: ':'),
                                                                            textSpanUnBoldText(index,
                                                                                context,
                                                                                text: '  This can be a number posted on how many scoring units will be scored in a game or match, as well as how many games a team will win during a season. If a football game’s '),
                                                                            linkTextWidget(context,
                                                                                text: 'over/under',
                                                                                link: 'https://www.forbes.com/betting/sports-betting/what-is-over-under-betting/'),
                                                                            textSpanUnBoldText(index,
                                                                                context,
                                                                                text: ' is 43.5 and the two teams combine to score 44 points, bets on the over are paid out. If a baseball team’s preseason win total over/under is 82.5, and it wins 81 games, futures bets on the under are paid out.'),
                                                                          ]
                                                                        : index ==
                                                                                18
                                                                            ? [
                                                                                textSpanCommonWidget(context, title: ':'),
                                                                                textSpanUnBoldText(index, context, text: ' A single wager that involves the bettor making multiple bets and '),
                                                                                linkTextWidget(context, text: 'tying them into one.', link: 'https://www.forbes.com/betting/sports-betting/what-is-a-parlay-bet/'),
                                                                                textSpanUnBoldText(index, context, text: ' The payouts of parlays are typically larger than a wager on a single game because each individual bet must win in order for a parlay to pay out.'),
                                                                              ]
                                                                            : index == 21
                                                                                ? [
                                                                                    textSpanCommonWidget(context, title: ':'),
                                                                                    textSpanUnBoldText(index, context, text: ' A bet made on something that may occur during a game that isn’t necessarily tied to the game’s outcome. These bets are often closely tied to the game itself, like a wager on whether or not an individual player will '),
                                                                                    linkTextWidget(context, text: 'score a touchdown.', link: 'https://www.forbes.com/betting/sports-betting/what-is-a-prop-bet/'),
                                                                                    textSpanUnBoldText(index, context, text: ' There are also props that are only loosely connected to the game, like wagers on a football game’s opening '),
                                                                                    linkTextWidget(context, text: 'coin toss.', link: 'https://www.forbes.com/betting/nfl/coin-toss/'),
                                                                                  ]
                                                                                : index == 24
                                                                                    ? [
                                                                                        textSpanCommonWidget(context, title: ':'),
                                                                                        textSpanUnBoldText(index, context, text: ' A '),
                                                                                        linkTextWidget(context, text: 'specific parlay type', link: 'https://www.forbes.com/betting/sports-betting/what-is-same-game-parlay/'),
                                                                                        textSpanUnBoldText(index, context, text: ' that combines multiple wagers from the same sporting event into one bet. Like traditional parlays, SGPs are usually difficult to win.'),
                                                                                      ]
                                                                                    : [
                                                                                        textSpanCommonWidget(context, title: ':'),
                                                                                        textSpanUnBoldText(index, context, text: gamblingList[index].toString().split(':').last.toString()),
                                                                                      ],
                                          ),
                                  ),
                                )
                              ],
                            ),
                          ))),
            ],
          ),
        ),
        Container(
            width: Get.width,
            // height: MediaQuery.of(context).size.height * .05,
            decoration:
                BoxDecoration(color: Theme.of(context).secondaryHeaderColor),
            child: gambling
                .appCommonText(
                    color: whiteColor,
                    weight: FontWeight.bold,
                    size: MediaQuery.of(context).size.height * .018)
                .paddingSymmetric(vertical: 20.w)),
      ],
    );
  }
}

class TransperCard extends StatelessWidget {
  const TransperCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .033,
      decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(MediaQuery.of(context).size.width * .005),
          border: Border.all(color: Colors.transparent, width: 2),
          color: Colors.transparent),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * .002),
              child: Container(
                width: MediaQuery.of(context).size.width * .039,
                height: MediaQuery.of(context).size.height * .04,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(
                            MediaQuery.of(context).size.width * .005)),
                    color: Colors.transparent),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      Assets.imagesSunLight,
                      // ignore: deprecated_member_use
                      color: Colors.transparent,
                      width: MediaQuery.of(context).size.width * .02,
                      height: MediaQuery.of(context).size.height * .02,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: MediaQuery.of(context).size.width * .039,
              height: MediaQuery.of(context).size.height * .04,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(
                          MediaQuery.of(context).size.width * .005)),
                  color: Colors.transparent),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    Assets.imagesMoon,
                    // ignore: deprecated_member_use
                    color: Colors.transparent,
                    width: MediaQuery.of(context).size.width * .02,
                    height: MediaQuery.of(context).size.height * .02,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

var scaffoldKey = GlobalKey<ScaffoldState>();

PreferredSize commonAppBar(
    BuildContext context, GameListingController controller) {
  return PreferredSize(
      preferredSize: Size.fromHeight(125.w),
      child: Container(
        alignment: Alignment.bottomCenter,
        color: Theme.of(context).secondaryHeaderColor,
        child: Padding(
          padding: EdgeInsets.only(bottom: 27.w, left: 24.w, right: 24.w),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      highlightColor: Colors.transparent,
                      onTap: () {
                        scaffoldKey.currentState!.openDrawer();
                      },
                      child: Icon(
                        Icons.menu,
                        color: yellowColor,
                        size: 35.h,
                      )),
                  Expanded(
                    child: SvgPicture.asset(Assets.imagesLogo,
                        height: 34.w, fit: BoxFit.contain),
                  ),
                  // const TransperCard(),
                  const Icon(Icons.menu, color: Colors.transparent)
                ],
              ),
              controller.isSelectedGame == 'Gambling 101' ||
                      controller.isSelectedGame == 'Contact'
                  ? const SizedBox()
                  : Positioned(
                      right: 0,
                      left: -9.h,
                      child: buildAnimSearchBar(controller, context)),
            ],
          ),
        ),
      ));
}

AnimSearchBar buildAnimSearchBar(
    GameListingController controller, BuildContext context) {
  return AnimSearchBar(
    rtl: true,
    autoFocus: true,
    width: Get.width,
    color: yellowColor,
    style: defaultTextStyle(
        size: MediaQuery.sizeOf(context).height * .02,
        color: PreferenceManager.getIsDarkMode() ?? false
            ? greyColor
            : whiteColor),
    searchIconColor: appColor,
    textFieldColor:
        PreferenceManager.getIsDarkMode() ?? false ? whiteColor : boxColor,
    helpText:
        'Search by team ${mobileView.size.shortestSide < 600 ? 'abbreviation' : 'name'}',
    helpTextColor:
        PreferenceManager.getIsDarkMode() ?? false ? greyColor : whiteColor,
    textFieldIconColor:
        PreferenceManager.getIsDarkMode() ?? false ? greyColor : whiteColor,
    textController: controller.searchCon,
    onSuffixTap: () {
      controller.searchCon.clear();
      controller.update();
    },
    onSubmitted: (String text) {
      controller.searchData(text, controller.sportKey);
      controller.update();
    },
  );
}
