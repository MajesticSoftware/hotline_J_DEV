import 'dart:io';

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
import 'package:webview_flutter/webview_flutter.dart';

import '../../constant/app_strings.dart';
import '../../generated/assets.dart';
import '../../model/leauge_model.dart';

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
      required this.awayTeamSpread,
      required this.awayTeamMoneyLine,
      required this.awayTeamOU,
      required this.homeTeamSpread,
      required this.homeTeamMoneyLine,
      required this.homeTeamOU,
      this.onTap})
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
  final num temp;
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
              border: Border.all(
                  color: PreferenceManager.getIsDarkMode() ?? false
                      ? greyColor
                      : dividerColor),
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
                                width: Get.height * .044,
                                height: Get.height * .044,
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
                            child: Text(
                              awayTeamAbb.toString(),
                              style: Theme.of(context).textTheme.labelLarge,
                              textAlign: TextAlign.start,
                              maxLines: 2,
                            ),
                          ),
                          Text(
                            awayTeamScore.toString(),
                            style: Theme.of(context).textTheme.headlineLarge,
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
                              '  Vs',
                              style: Theme.of(context).textTheme.labelSmall,
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
                                  width: Get.height * .044,
                                  height: Get.height * .044,
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
                            child: Text(
                              homeTeamAbb.toString(),
                              style: Theme.of(context).textTheme.labelLarge,
                              textAlign: TextAlign.start,
                              maxLines: 2,
                            ),
                          ),
                          Text(
                            homeTeamScore.toString(),
                            style: Theme.of(context).textTheme.headlineLarge,
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
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    (MediaQuery.of(context).size.height * .005).H(),
                    Text(
                      dateTime,
                      style: Theme.of(context).textTheme.displaySmall,
                      textAlign: TextAlign.center,
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
                                  size:
                                      MediaQuery.of(context).size.height * .012,
                                  weight: FontWeight.bold),
                            ),
                          )
                        : const SizedBox(),
                    5.w.H(),
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
                          style: temp == 32
                              ? Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                      fontSize: MediaQuery.of(context)
                                              .size
                                              .height *
                                          .014)
                              : Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              .024),
                        ),
                        Text(
                          '°F',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    )
                  ],
                ),
              ),
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
                                style: Theme.of(context).textTheme.bodySmall),
                            Text(awayTeamOU.toString(),
                                style: Theme.of(context).textTheme.bodySmall),
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
                                style: Theme.of(context).textTheme.bodySmall),
                            Text(homeTeamOU.toString(),
                                style: Theme.of(context).textTheme.bodySmall),
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

class GameTabCard extends StatelessWidget {
  const GameTabCard(
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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
            width: Get.width,
            height: MediaQuery.of(context).size.height * .05,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return index == 3 || index == 4
                      ? InkWell(
                          onTap: Platform.isIOS && index == 3
                              ? onTapContact
                              : index == 3
                                  ? onTapGambling
                                  : onTapContact,
                          child: Container(
                            height: MediaQuery.of(context).size.height * .05,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: Theme.of(context).primaryColor),
                            child: Center(
                              child: (Platform.isIOS && index == 3
                                      ? 'Contact'
                                      : index == 3
                                          ? gambling
                                          : 'Contact')
                                  .appCommonText(
                                      color: Theme.of(context).cardColor,
                                      align: TextAlign.start,
                                      size: MediaQuery.of(context).size.height *
                                          .018,
                                      weight: FontWeight.w700)
                                  .paddingSymmetric(horizontal: 20.w),
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            controller.tabClick(context, index);
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * .05,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                image: controller.isSelectedGame ==
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
                                      )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  sportsLeagueList[index].gameImage,
                                  height:
                                      MediaQuery.of(context).size.height * .04,
                                  width:
                                      MediaQuery.of(context).size.width * .01,
                                  fit: BoxFit.contain,
                                ).paddingSymmetric(
                                    vertical:
                                        MediaQuery.of(context).size.height *
                                            .010,
                                    horizontal:
                                        MediaQuery.of(context).size.height *
                                            .010),
                                sportsLeagueList[index]
                                    .gameName
                                    .appCommonText(
                                        color: Colors.white,
                                        align: TextAlign.start,
                                        size:
                                            MediaQuery.of(context).size.height *
                                                .018,
                                        weight: FontWeight.w700)
                                    .paddingOnly(
                                        right:
                                            MediaQuery.of(context).size.height *
                                                .020)
                              ],
                            ),
                          ),
                        );
                },
                separatorBuilder: (context, index) {
                  return 20.w.W();
                },
                itemCount: Platform.isIOS ? 4 : 5))
        .paddingSymmetric(
            vertical: 15.h,
            horizontal: MediaQuery.of(context).size.width * .03);
  }
}

Future showDialogIfFirstLoaded(BuildContext context) async {
  if (PreferenceManager.getIsFirstLoaded() != null) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Getting Started:"),
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
  const ContactView({Key? key, required this.webController}) : super(key: key);
  final WebViewController webController;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebViewWidget(controller: webController),
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
    return Column(
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
              Positioned(
                bottom: MediaQuery.of(context).size.height * .07,
                width: MediaQuery.of(context).size.width * .34,
                child: GestureDetector(
                    onTap: () {
                      Get.back();
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
              )
            ],
          ),
        ),
      ],
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
                    size: MediaQuery.of(context).size.height * .017),
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
                    size: MediaQuery.of(context).size.height * .017),
              ),
              Expanded(
                flex: 1,
                child: moneyLine.appCommonText(
                    color: whiteColor,
                    weight: FontWeight.w600,
                    size: MediaQuery.of(context).size.height * .017),
              ),
              Expanded(
                flex: 1,
                child: overUnder.appCommonText(
                    color: whiteColor,
                    weight: FontWeight.w600,
                    size: MediaQuery.of(context).size.height * .017),
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
              90.w.H(),
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
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                            color: PreferenceManager.getIsDarkMode() ?? false
                                ? blackColor
                                : Colors.transparent,
                            width: 2),
                        color: PreferenceManager.getIsDarkMode() ?? false
                            ? blackColor
                            : dividerColor),
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
                              width: 40.w,
                              height: 36.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(8.r)),
                                  color:
                                      PreferenceManager.getIsDarkMode() ?? false
                                          ? blackColor
                                          : whiteColor),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    Assets.imagesSunLight,
                                    // ignore: deprecated_member_use
                                    color: PreferenceManager.getIsDarkMode() ??
                                            false
                                        ? darkSunColor
                                        : blackColor,
                                    width: 24.w,
                                    height: 24.w,
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
                            width: 40.w,
                            height: 36.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.horizontal(
                                    right: Radius.circular(8.r)),
                                color:
                                    PreferenceManager.getIsDarkMode() ?? false
                                        ? darkBackGroundColor
                                        : dividerColor),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  Assets.imagesMoon,
                                  // ignore: deprecated_member_use
                                  color:
                                      PreferenceManager.getIsDarkMode() ?? false
                                          ? whiteColor
                                          : greyDarkColor,
                                  width: 24.w,
                                  height: 24.w,
                                  fit: BoxFit.contain,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SvgPicture.asset(Assets.imagesLogo,
                        height: 34.w, fit: BoxFit.contain),
                  ),
                  const TransperCard(),
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
