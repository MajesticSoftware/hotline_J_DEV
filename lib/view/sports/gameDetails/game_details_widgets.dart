import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hotlines/utils/extension.dart';
import 'package:hotlines/view/sports/gameListing/game_listing_con.dart';
import 'package:intl/intl.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

import '../../../constant/app_strings.dart';
import '../../../constant/shred_preference.dart';
import '../../../extras/constants.dart';
import '../../../generated/assets.dart';
import '../../../model/DET_KC_model.dart';
import '../../../model/game_listing.dart';
import '../../../theme/app_color.dart';
import '../../../theme/helper.dart';
import '../../../utils/layouts.dart';
import '../selectSport/selecte_game_con.dart';
import 'game_details_controller.dart';

PreferredSize commonAppBarWidget(BuildContext context, bool isDark) {
  return PreferredSize(
      preferredSize: const Size.fromHeight(100.0),
      child: GetBuilder<SelectGameController>(builder: (con) {
        return Container(
          height: Get.height * .098,
          alignment: Alignment.bottomCenter,
          color: Theme.of(context).secondaryHeaderColor,
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * .01,
                left: MediaQuery.of(context).size.width * .02,
                right: MediaQuery.of(context).size.width * .02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SvgPicture.asset(
                        Assets.imagesBackArrow,
                        height: MediaQuery.of(context).size.height * .02,
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SvgPicture.asset(Assets.imagesLogo,
                      height: MediaQuery.of(context).size.height * .025,
                      fit: BoxFit.contain),
                ),
                /*('${awayTeam?.abbreviation} @ ${homeTeam?.abbreviation}')
                      .appCommonText(
                          color: whiteColor,
                          size: MediaQuery.of(context).size.height * .024,
                          weight: FontWeight.w700),*/
                /* Container(
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
                                MediaQuery.of(context).size.width * .002),
                            child: Container(
                              width: MediaQuery.of(context).size.width * .039,
                              height: MediaQuery.of(context).size.height * .04,
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
                                    // ignore: deprecated_member_use
                                    color: isDark || con.isDarkMode
                                        ? darkSunColor
                                        : blackColor,
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
                                  // ignore: deprecated_member_use
                                  color: isDark || con.isDarkMode
                                      ? whiteColor
                                      : greyDarkColor,
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
                      ],
                    ),
                  )*/
                Expanded(
                  child: SvgPicture.asset(
                    Assets.imagesBackArrow,
                    color: Colors.transparent,
                    height: MediaQuery.of(context).size.height * .02,
                    alignment: Alignment.centerLeft,
                  ),
                ),
              ],
            ),
          ),
        );
      }));
}

Padding teamReportWidget(BuildContext context, String sportKey,
    SportEvents gameDetails, Competitors? awayTeam, Competitors? homeTeam) {
  return Padding(
    padding: EdgeInsets.all(MediaQuery.of(context).size.height * .02),
    child: Container(
      // height: MediaQuery.of(context).size.height * .227,
      decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(MediaQuery.of(context).size.width * .01),
          color: Theme.of(context).canvasColor),
      child: GetBuilder<GameDetailsController>(builder: (controller) {
        return StickyHeader(
            header: headerTitleWidget(context, teamReport,
                isTeamReport: true,
                gameDetails: gameDetails,
                awayTeam: awayTeam,
                homeTeam: homeTeam),
            content: Column(
              children: [
                sportKey == 'MLB'
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          rankingCommonWidget(
                              context: context,
                              title: 'Team Hitting Rankings',
                              isPlayStat: false),
                          ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: controller.hittingMLB.length,
                            itemBuilder: (context, index) {
                              return commonRankingWidget(
                                isReport: true,
                                context,
                                teamReports: controller.hittingMLB[index],
                                awayText: controller.mlbAwayHittingList.isEmpty
                                    ? '0'
                                    : controller.mlbAwayHittingList[index],
                                homeText: controller.mlbHomeHittingList.isEmpty
                                    ? '0'
                                    : controller.mlbHomeHittingList[index],
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return commonDivider(context);
                            },
                          ),
                          rankingCommonWidget(
                              context: context,
                              title: 'Team Pitching Rankings',
                              isPlayStat: false),
                          ListView.separated(
                            padding: EdgeInsets.zero,
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.pittchingMLB.length,
                            itemBuilder: (context, index) {
                              return commonRankingWidget(context,
                                  isReport: true,
                                  teamReports: controller.pittchingMLB[index],
                                  homeText: controller
                                          .mlbHomePitchingList.isEmpty
                                      ? '0'
                                      : controller.mlbHomePitchingList[index],
                                  awayText: controller
                                          .mlbAwayPitchingList.isEmpty
                                      ? "0"
                                      : controller.mlbAwayPitchingList[index]);
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return commonDivider(context);
                            },
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          rankingCommonWidget(
                              context: context,
                              isPlayStat: false,
                              title: 'Offensive Rankings'),
                          ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: controller.offensive.length,
                            itemBuilder: (context, index) {
                              return commonRankingWidget(
                                context,
                                isReport: true,
                                teamReports: controller.offensive[index],
                                awayText: controller
                                        .nflAwayOffensiveList.isEmpty
                                    ? '0'
                                    : controller.nflAwayOffensiveList[index],
                                homeText: controller
                                        .nflHomeOffensiveList.isEmpty
                                    ? '0'
                                    : controller.nflHomeOffensiveList[index],
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return commonDivider(context);
                            },
                          ),
                          rankingCommonWidget(
                              context: context,
                              isPlayStat: false,
                              title: 'Defensive Rankings'),
                          ListView.separated(
                            padding: EdgeInsets.zero,
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.defensive.length,
                            itemBuilder: (context, index) {
                              return commonRankingWidget(context,
                                  teamReports: controller.defensive[index],
                                  isReport: true,
                                  homeText: controller
                                          .nflHomeDefensiveList.isEmpty
                                      ? '0'
                                      : controller.nflHomeDefensiveList[index],
                                  awayText: controller
                                          .nflAwayDefensiveList.isEmpty
                                      ? "0"
                                      : controller.nflAwayDefensiveList[index]);
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return commonDivider(context);
                            },
                          ),
                        ],
                      ),
              ],
            ));
      }),
    ),
  );
}

Padding playerStatWidget(
    BuildContext context,
    GameDetailsController con,
    String sportKey,
    SportEvents gameDetails,
    Competitors? awayTeam,
    Competitors? homeTeam) {
  GameListingController gameListingController = Get.find();
  return Padding(
    padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.height * .02,
        right: MediaQuery.of(context).size.height * .02,
        bottom: MediaQuery.of(context).size.height * .02),
    child: Container(
      // height: MediaQuery.of(context).size.height * .227,
      decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(MediaQuery.of(context).size.width * .01),
          color: Theme.of(context).canvasColor),
      child: GetBuilder<GameDetailsController>(builder: (controller) {
        return StickyHeader(
            header: headerTitleWidget(context, 'Player Stats',
                isTeamReport: false,
                gameDetails: gameDetails,
                homeTeam: homeTeam,
                awayTeam: awayTeam),
            content: Column(
              children: [
                sportKey == 'MLB'
                    ? Column(
                        children: [
                          rankingCommonWidget(
                              context: context,
                              title: 'Pitcher',
                              awayText: gameDetails.awayPlayerName,
                              homeText: gameDetails.homePlayerName),
                          commonRankingWidget(context,
                              teamReports: controller.teamPitcherMLB[0],
                              awayText: gameDetails.wlAway,
                              homeText: gameDetails.wlHome),
                          commonDivider(context),
                          commonRankingWidget(context,
                              teamReports: controller.teamPitcherMLB[1],
                              awayText: gameDetails.eraAway,
                              homeText: gameDetails.eraHome),
                          commonDivider(context),
                          commonRankingWidget(context,
                              teamReports: controller.teamPitcherMLB[2],
                              awayText: controller.whipAway,
                              homeText: controller.whipHome),
                          commonDivider(context),
                          commonRankingWidget(context,
                              teamReports: controller.teamPitcherMLB[3],
                              awayText: controller.awayIp,
                              homeText: controller.homeIp),
                          commonDivider(context),
                          commonRankingWidget(context,
                              teamReports: controller.teamPitcherMLB[4],
                              awayText: controller.awayH,
                              homeText: controller.homeH),
                          commonDivider(context),
                          commonRankingWidget(context,
                              teamReports: controller.teamPitcherMLB[5],
                              awayText: controller.awayKk,
                              homeText: controller.homeKk),
                          commonDivider(context),
                          commonRankingWidget(context,
                              teamReports: controller.teamPitcherMLB[6],
                              awayText: controller.awayBb,
                              homeText: controller.homeBb),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          rankingCommonWidget(
                              context: context,
                              title: 'Pitcher',
                              awayText: 'Williams',
                              homeText: 'Patrick'),
                          ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: controller.teamPitcherMLB.length,
                            itemBuilder: (context, index) {
                              return commonRankingWidget(context,
                                  teamReports: controller.teamPitcherMLB[index],
                                  awayText: '0',
                                  homeText: '0');
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return commonDivider(context);
                            },
                          ),
                          rankingCommonWidget(
                              context: context,
                              title: 'Batting',
                              awayText: 'Williams',
                              homeText: 'Patrick'),
                          ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: controller.teamBattingMLB.length,
                            itemBuilder: (context, index) {
                              return commonRankingWidget(context,
                                  teamReports: controller.teamBattingMLB[index],
                                  awayText: '0',
                                  homeText: '0');
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return commonDivider(context);
                            },
                          ),
                        ],
                      ),
              ],
            ));
      }),
    ),
  );
}

Padding hitterPlayerStatWidget(BuildContext context, GameDetailsController con,
    SportEvents gameDetails, Competitors? awayTeam, Competitors? homeTeam) {
  return Padding(
    padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.height * .02,
        right: MediaQuery.of(context).size.height * .02,
        bottom: MediaQuery.of(context).size.height * .02),
    child: Container(
      // height: MediaQuery.of(context).size.height * .227,
      decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(MediaQuery.of(context).size.width * .01),
          color: Theme.of(context).canvasColor),
      child: GetBuilder<GameDetailsController>(builder: (controller) {
        return StickyHeader(
            header: customTabBar(context, con, gameDetails, awayTeam, homeTeam),
            content: Column(
              children: [
                headerOfHitterPlyerStat(context),
                commonDivider(context),
                hitterPlayerDetailCard(con),
              ],
            ));
      }),
    ),
  );
}

ListView hitterPlayerDetailCard(GameDetailsController con) {
  return ListView.separated(
    shrinkWrap: true,
    physics: const BouncingScrollPhysics(),
    itemBuilder: (context, i) {
      return ExpandableNotifier(
        child: ScrollOnExpand(
          child: Column(
            children: [
              con.isTab
                  ? ExpandablePanel(
                      theme: const ExpandableThemeData(hasIcon: false),
                      header: expandedAwayHeader(context, i, con),
                      collapsed: const SizedBox(),
                      expanded: Column(
                        children: [
                          expandableTileCard(context, con,
                              value1: con.hitterAwayPlayerMainList[i].runValue,
                              title1: con.hitterAwayPlayerMainList[i].run,
                              title2: con.hitterAwayPlayerMainList[i].obp,
                              value2: con.hitterAwayPlayerMainList[i].obpValue),
                          expandableTileCard(context, con,
                              value1: con
                                  .hitterAwayPlayerMainList[i].totalBaseValue,
                              title1: con.hitterAwayPlayerMainList[i].totalBase,
                              title2: con.hitterAwayPlayerMainList[i].slg,
                              value2: con.hitterAwayPlayerMainList[i].slgValue),
                          expandableTileCard(context, con,
                              value1: con
                                  .hitterAwayPlayerMainList[i].stolenBaseValue,
                              title1:
                                  con.hitterAwayPlayerMainList[i].stolenBase,
                              title2: con.hitterAwayPlayerMainList[i].cycle,
                              value2:
                                  con.hitterAwayPlayerMainList[i].cycleValue),
                        ],
                      ),
                    )
                  : ExpandablePanel(
                      theme: const ExpandableThemeData(hasIcon: false),
                      header: expandedHomeHeader(context, i, con),
                      collapsed: const SizedBox(),
                      expanded: Column(
                        children: [
                          expandableTileCard(context, con,
                              value1: con.hitterHomePlayerMainList[i].runValue,
                              title1: con.hitterHomePlayerMainList[i].run,
                              title2: con.hitterHomePlayerMainList[i].obp,
                              value2: con.hitterHomePlayerMainList[i].obpValue),
                          expandableTileCard(context, con,
                              value1: con
                                  .hitterHomePlayerMainList[i].totalBaseValue,
                              title1: con.hitterHomePlayerMainList[i].totalBase,
                              title2: con.hitterHomePlayerMainList[i].slg,
                              value2: con.hitterHomePlayerMainList[i].slgValue),
                          expandableTileCard(context, con,
                              value1: con
                                  .hitterHomePlayerMainList[i].stolenBaseValue,
                              title1:
                                  con.hitterHomePlayerMainList[i].stolenBase,
                              title2: con.hitterHomePlayerMainList[i].cycle,
                              value2:
                                  con.hitterHomePlayerMainList[i].cycleValue),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      );
    },
    separatorBuilder: (BuildContext context, int index) {
      return commonDivider(context);
    },
    itemCount: con.isTab
        ? con.hitterAwayPlayerMainList.length
        : con.hitterHomePlayerMainList.length,
  );
}

Container expandableTileCard(BuildContext context, GameDetailsController con,
    {String title1 = '',
    String value1 = '',
    String title2 = '',
    String value2 = ''}) {
  return Container(
    color: Theme.of(context).unselectedWidgetColor,
    // height: MediaQuery.sizeOf(context).height * .031,
    child: Row(
      children: [
        hitterDataCard(title1, context, value1, false),
        hitterDataCard(title2, context, value2, true),
      ],
    ).paddingSymmetric(
        horizontal: MediaQuery.sizeOf(context).width * .015,
        vertical: MediaQuery.sizeOf(context).width * .01),
  );
}

Expanded hitterDataCard(
    String title, BuildContext context, String value, bool isFirst) {
  return Expanded(
    flex: 2,
    child: Row(
      children: [
        SizedBox(
          width: isFirst
              ? mobileView.size.shortestSide < 600
                  ? MediaQuery.sizeOf(context).width * .0
                  : MediaQuery.sizeOf(context).width * .05
              : 0,
        ),
        Expanded(
          flex: 2,
          child: title.appCommonText(
              color: Theme.of(context).highlightColor,
              align: TextAlign.start,
              weight: FontWeight.w600,
              size: MediaQuery.sizeOf(context).height * .014),
        ),
        Expanded(
            flex: 2,
            child: value.appCommonText(
                color: Theme.of(context).highlightColor,
                align: TextAlign.end,
                weight: FontWeight.w400,
                size: MediaQuery.sizeOf(context).height * .014)),
        SizedBox(
          width: isFirst
              ? 0
              : mobileView.size.shortestSide < 600
                  ? MediaQuery.sizeOf(context).width * .06
                  : 0,
        )
      ],
    ),
  );
}

SizedBox expandedAwayHeader(
    BuildContext context, int index, GameDetailsController con) {
  return SizedBox(
    // height: MediaQuery.sizeOf(context).height * .031,
    child: Row(
      children: [
        Expanded(
            flex: mobileView.size.shortestSide < 600 ? 2 : 3,
            child: Row(
              children: [
                con.hitterAwayPlayerMainList[index].playerName.appCommonText(
                    color: blueColor,
                    align: TextAlign.start,
                    weight: FontWeight.w600,
                    size: MediaQuery.sizeOf(context).height * .014),
                ' ${con.hitterAwayPlayerMainList[index].position}'
                    .appCommonText(
                        color: grayColor,
                        align: TextAlign.start,
                        weight: FontWeight.w400,
                        size: MediaQuery.sizeOf(context).height * .014),
              ],
            )),
        Expanded(
            child: con.hitterAwayPlayerMainList[index].hAb.appCommonText(
                color: Theme.of(context).highlightColor,
                align: TextAlign.end,
                weight: FontWeight.w400,
                size: MediaQuery.sizeOf(context).height * .014)),
        Expanded(
            child: con.hitterAwayPlayerMainList[index].hr.appCommonText(
                color: Theme.of(context).highlightColor,
                align: TextAlign.end,
                weight: FontWeight.w400,
                size: MediaQuery.sizeOf(context).height * .014)),
        Expanded(
            child: con.hitterAwayPlayerMainList[index].rbi.appCommonText(
                color: Theme.of(context).highlightColor,
                align: TextAlign.end,
                weight: FontWeight.w400,
                size: MediaQuery.sizeOf(context).height * .014)),
        Expanded(
            child: con.hitterAwayPlayerMainList[index].sb.appCommonText(
                color: Theme.of(context).highlightColor,
                align: TextAlign.end,
                weight: FontWeight.w400,
                size: MediaQuery.sizeOf(context).height * .014)),
        Expanded(
            child: con.hitterAwayPlayerMainList[index].avg.appCommonText(
                color: Theme.of(context).highlightColor,
                align: TextAlign.end,
                weight: FontWeight.w400,
                size: MediaQuery.sizeOf(context).height * .014)),
      ],
    ).paddingSymmetric(
        horizontal: MediaQuery.sizeOf(context).width * .015,
        vertical: MediaQuery.sizeOf(context).width * .01),
  );
}

SizedBox expandedHomeHeader(
    BuildContext context, int index, GameDetailsController con) {
  return SizedBox(
    // height: MediaQuery.sizeOf(context).height * .031,
    child: Row(
      children: [
        Expanded(
            flex: mobileView.size.shortestSide < 600 ? 2 : 3,
            child: Row(
              children: [
                con.hitterHomePlayerMainList[index].playerName.appCommonText(
                    color: blueColor,
                    align: TextAlign.start,
                    weight: FontWeight.w600,
                    size: MediaQuery.sizeOf(context).height * .014),
                ' ${con.hitterHomePlayerMainList[index].position}'
                    .appCommonText(
                        color: grayColor,
                        align: TextAlign.start,
                        weight: FontWeight.w400,
                        size: MediaQuery.sizeOf(context).height * .014),
              ],
            )),
        Expanded(
            child: con.hitterHomePlayerMainList[index].hAb.appCommonText(
                color: Theme.of(context).highlightColor,
                align: TextAlign.end,
                weight: FontWeight.w400,
                size: MediaQuery.sizeOf(context).height * .014)),
        Expanded(
            child: con.hitterHomePlayerMainList[index].hr.appCommonText(
                color: Theme.of(context).highlightColor,
                align: TextAlign.end,
                weight: FontWeight.w400,
                size: MediaQuery.sizeOf(context).height * .014)),
        Expanded(
            child: con.hitterHomePlayerMainList[index].rbi.appCommonText(
                color: Theme.of(context).highlightColor,
                align: TextAlign.end,
                weight: FontWeight.w400,
                size: MediaQuery.sizeOf(context).height * .014)),
        Expanded(
            child: con.hitterHomePlayerMainList[index].sb.appCommonText(
                color: Theme.of(context).highlightColor,
                align: TextAlign.end,
                weight: FontWeight.w400,
                size: MediaQuery.sizeOf(context).height * .014)),
        Expanded(
            child: con.hitterHomePlayerMainList[index].avg.appCommonText(
                color: Theme.of(context).highlightColor,
                align: TextAlign.end,
                weight: FontWeight.w400,
                size: MediaQuery.sizeOf(context).height * .014)),
      ],
    ).paddingSymmetric(
        horizontal: MediaQuery.sizeOf(context).width * .015,
        vertical: MediaQuery.sizeOf(context).width * .01),
  );
}

SizedBox headerOfHitterPlyerStat(BuildContext context) {
  return SizedBox(
    height: MediaQuery.sizeOf(context).height * .034,
    child: Row(
      children: [
        Expanded(
            flex: mobileView.size.shortestSide < 600 ? 2 : 3,
            child: 'Hitters'.appCommonText(
                color: Theme.of(context).highlightColor,
                align: TextAlign.start,
                weight: FontWeight.w700,
                size: MediaQuery.sizeOf(context).height * .016)),
        Expanded(
            child: 'H-AB'.appCommonText(
                color: Theme.of(context).highlightColor,
                align: TextAlign.end,
                weight: FontWeight.w700,
                size: MediaQuery.sizeOf(context).height * .016)),
        Expanded(
            child: 'HR'.appCommonText(
                color: Theme.of(context).highlightColor,
                align: TextAlign.end,
                weight: FontWeight.w700,
                size: MediaQuery.sizeOf(context).height * .016)),
        Expanded(
            child: 'RBI'.appCommonText(
                color: Theme.of(context).highlightColor,
                align: TextAlign.end,
                weight: FontWeight.w700,
                size: MediaQuery.sizeOf(context).height * .016)),
        Expanded(
            child: 'SB'.appCommonText(
                color: Theme.of(context).highlightColor,
                align: TextAlign.end,
                weight: FontWeight.w700,
                size: MediaQuery.sizeOf(context).height * .016)),
        Expanded(
            child: 'AVG'.appCommonText(
                color: Theme.of(context).highlightColor,
                align: TextAlign.end,
                weight: FontWeight.w700,
                size: MediaQuery.sizeOf(context).height * .016)),
      ],
    ).paddingSymmetric(horizontal: MediaQuery.sizeOf(context).width * .015),
  );
}

Container customTabBar(BuildContext context, GameDetailsController con,
    SportEvents gameDetails, Competitors? awayTeam, Competitors? homeTeam) {
  return Container(
      height: MediaQuery.of(context).size.height * .044,
      width: Get.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(MediaQuery.of(context).size.width * .01)),
          color: Theme.of(context).disabledColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .004,
            width: Get.width,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: InkWell(
                  onTap: () {
                    con.isTab = true;
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: (mobileView.size.shortestSide < 600
                                ? (awayTeam?.abbreviation ?? '')
                                : (awayTeam?.name ?? ''))
                            .appCommonText(
                          weight: FontWeight.w600,
                          maxLine: 1,
                          align: TextAlign.end,
                          size: MediaQuery.of(context).size.height * .016,
                          color: Theme.of(context).cardColor,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .01,
                      ),
                      commonCachedNetworkImage(
                          width: Get.height * .025,
                          height: Get.height * .025,
                          imageUrl: gameDetails.gameLogoAwayLink),
                    ],
                  ),
                ),
              ),
              const Expanded(
                flex: 2,
                child: SizedBox(),
              ),
              Expanded(
                flex: 2,
                child: InkWell(
                  onTap: () {
                    con.isTab = false;
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      commonCachedNetworkImage(
                          width: Get.height * .025,
                          height: Get.height * .025,
                          imageUrl: gameDetails.gameHomeLogoLink),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .01,
                      ),
                      Expanded(
                        child: (mobileView.size.shortestSide < 600
                                ? (homeTeam?.abbreviation ?? '')
                                : (homeTeam?.name ?? ''))
                            .appCommonText(
                          weight: FontWeight.w600,
                          maxLine: 1,
                          align: TextAlign.start,
                          size: MediaQuery.of(context).size.height * .016,
                          color: Theme.of(context).cardColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ).paddingSymmetric(
              horizontal: MediaQuery.sizeOf(context).width * .015),
          const Spacer(),
          con.isTab
              ? Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height * .004,
                        width: Get.width,
                        color: yellowColor,
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                  ],
                )
              : Row(
                  children: [
                    const Expanded(child: SizedBox()),
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height * .004,
                        width: Get.width,
                        color: yellowColor,
                      ),
                    ),
                  ],
                ),
        ],
      ));
}

Column commonRankingWidget(BuildContext context,
    {String homeText = '',
    String awayText = '',
    String teamReports = '',
    bool isReport = false}) {
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * .016,
            vertical: MediaQuery.of(context).size.height * .003),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: awayText.appCommonText(
                  color: Theme.of(context).highlightColor,
                  weight: FontWeight.w700,
                  align: mobileView.size.shortestSide < 600
                      ? TextAlign.center
                      : TextAlign.end,
                  size: MediaQuery.of(context).size.height * .014),
            ),
            Expanded(
              flex: isReport ? 3 : 2,
              child: teamReports.toString().appCommonText(
                  color: darkGreyColor,
                  align: TextAlign.center,
                  weight: FontWeight.w600,
                  size: MediaQuery.of(context).size.height * .016),
            ),
            Expanded(
              flex: 2,
              child: homeText.appCommonText(
                  color: Theme.of(context).highlightColor,
                  weight: FontWeight.w700,
                  align: mobileView.size.shortestSide < 600
                      ? TextAlign.center
                      : TextAlign.start,
                  size: MediaQuery.of(context).size.height * .014),
            )
          ],
        ),
      ),
    ],
  );
}

Container rankingCommonWidget(
    {required BuildContext context,
    String homeText = '',
    String awayText = '',
    required String title,
    bool isPlayStat = true}) {
  return Container(
    color: Theme.of(context).splashColor,
    child: Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * .003),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: (isPlayStat ? awayText : '').appCommonText(
                color: Theme.of(context).highlightColor,
                weight: FontWeight.bold,
                align: mobileView.size.shortestSide < 600
                    ? TextAlign.center
                    : TextAlign.end,
                size: MediaQuery.of(context).size.height * .014),
          ),
          Expanded(
            flex: mobileView.size.shortestSide < 600 ? 3 : 2,
            child: title.appCommonText(
                color: Theme.of(context).highlightColor,
                weight: FontWeight.bold,
                align: TextAlign.center,
                size: MediaQuery.of(context).size.height * .014),
          ),
          Expanded(
            flex: 2,
            child: (isPlayStat ? homeText : '').appCommonText(
                color: Theme.of(context).highlightColor,
                weight: FontWeight.bold,
                align: mobileView.size.shortestSide < 600
                    ? TextAlign.center
                    : TextAlign.start,
                size: MediaQuery.of(context).size.height * .014),
          ),
        ],
      ),
    ),
  );
}

nflStaticInjuryReportWidget(
    BuildContext context,
    GameDetailsController con,
    String sportKey,
    SportEvents gameDetails,
    Competitors? awayTeam,
    Competitors? homeTeam) {
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
          headerTitleWidget(context, injuryReport,
              isInjury: true,
              gameDetails: gameDetails,
              awayTeam: awayTeam,
              homeTeam: homeTeam),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: awayTeamInjury.length,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.width * .038,
                          child: awayTeamInjury[index].toString().appCommonText(
                              color: Theme.of(context).highlightColor,
                              weight: FontWeight.w700,
                              maxLine: 2,
                              align: TextAlign.start,
                              size: MediaQuery.of(context).size.height * .016),
                        ),
                        index == 1 ? const SizedBox() : commonDivider(context),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.width * .038,
                            child: ''.toString().appCommonText(
                                color: Theme.of(context).highlightColor,
                                weight: FontWeight.w700,
                                maxLine: 2,
                                align: TextAlign.start,
                                size:
                                    MediaQuery.of(context).size.height * .016),
                          ),
                          index == 1
                              ? const SizedBox()
                              : commonDivider(context),
                        ],
                      )),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.width * .038,
                          child: homeTeamInjury[index].toString().appCommonText(
                              color: Theme.of(context).highlightColor,
                              weight: FontWeight.w700,
                              maxLine: 2,
                              align: TextAlign.start,
                              size: MediaQuery.of(context).size.height * .016),
                        ),
                        index == 1 ? const SizedBox() : commonDivider(context),
                      ],
                    ),
                  ),
                ],
              );
            },
          )
        ],
      ),
    ),
  );
}

mlbInjuryReportWidget(BuildContext context, SportEvents gameDetails,
    String sportKey, Competitors? awayTeam, Competitors? homeTeam) {
  try {
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
            headerTitleWidget(context, injuryReport,
                isInjury: true,
                gameDetails: gameDetails,
                homeTeam: homeTeam,
                awayTeam: awayTeam),
            GetBuilder<GameDetailsController>(builder: (controller) {
              return controller.isLoading.value
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * .1,
                    )
                  : gameDetails.homeTeamInjuredPlayer.isEmpty &&
                          gameDetails.awayTeamInjuredPlayer.isEmpty
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height * .1,
                          child: Center(
                            child: 'No Data'.appCommonText(
                                color: Theme.of(context).highlightColor,
                                weight: FontWeight.w700,
                                align: TextAlign.start,
                                size:
                                    MediaQuery.of(context).size.height * .016),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            gameDetails.awayTeamInjuredPlayer.isNotEmpty
                                ? Expanded(
                                    flex: 2,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: gameDetails
                                                  .awayTeamInjuredPlayer
                                                  .length >=
                                              gameDetails
                                                  .homeTeamInjuredPlayer.length
                                          ? gameDetails
                                              .awayTeamInjuredPlayer.length
                                          : gameDetails
                                              .homeTeamInjuredPlayer.length,
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (context, index) {
                                        try {
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .038,
                                                child:
                                                    '${gameDetails.awayTeamInjuredPlayer[index]}'
                                                        .toString()
                                                        .appCommonText(
                                                            color: Theme.of(
                                                                    context)
                                                                .highlightColor,
                                                            weight:
                                                                FontWeight.w700,
                                                            align:
                                                                TextAlign.start,
                                                            size: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                .016),
                                              ),
                                              index ==
                                                      (gameDetails.awayTeamInjuredPlayer
                                                                      .length >=
                                                                  gameDetails
                                                                      .homeTeamInjuredPlayer
                                                                      .length
                                                              ? gameDetails
                                                                  .awayTeamInjuredPlayer
                                                                  .length
                                                              : gameDetails
                                                                  .homeTeamInjuredPlayer
                                                                  .length) -
                                                          1
                                                  ? const SizedBox()
                                                  : commonDivider(context),
                                            ],
                                          );
                                        } catch (e) {
                                          return commonCatchWidget(
                                              context,
                                              index,
                                              controller,
                                              sportKey,
                                              gameDetails);
                                        }
                                      },
                                    ),
                                  )
                                : commonEmptyInjuryReportWidget(
                                    controller, sportKey, gameDetails),
                            commonEmptyInjuryReportWidget(
                                controller, sportKey, gameDetails),
                            gameDetails.homeTeamInjuredPlayer.isNotEmpty
                                ? Expanded(
                                    flex: 2,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: gameDetails
                                                  .homeTeamInjuredPlayer
                                                  .length >=
                                              gameDetails
                                                  .awayTeamInjuredPlayer.length
                                          ? gameDetails
                                              .homeTeamInjuredPlayer.length
                                          : gameDetails
                                              .awayTeamInjuredPlayer.length,
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (context, index) {
                                        try {
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .038,
                                                child:
                                                    '${gameDetails.homeTeamInjuredPlayer[index]}'
                                                        .toString()
                                                        .appCommonText(
                                                            color: Theme.of(
                                                                    context)
                                                                .highlightColor,
                                                            weight:
                                                                FontWeight.w700,
                                                            align:
                                                                TextAlign.start,
                                                            size: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                .016),
                                              ),
                                              index ==
                                                      (gameDetails.awayTeamInjuredPlayer
                                                                      .length >=
                                                                  gameDetails
                                                                      .homeTeamInjuredPlayer
                                                                      .length
                                                              ? gameDetails
                                                                  .awayTeamInjuredPlayer
                                                                  .length
                                                              : gameDetails
                                                                  .homeTeamInjuredPlayer
                                                                  .length) -
                                                          1
                                                  ? const SizedBox()
                                                  : commonDivider(context),
                                            ],
                                          );
                                        } catch (e) {
                                          return commonCatchWidget(
                                              context,
                                              index,
                                              controller,
                                              sportKey,
                                              gameDetails);
                                        }
                                      },
                                    ),
                                  )
                                : commonEmptyInjuryReportWidget(
                                    controller, sportKey, gameDetails),
                          ],
                        );
            }),
          ],
        ),
      ),
    );
  } catch (e) {
    return const SizedBox();
  }
}

Expanded commonEmptyInjuryReportWidget(GameDetailsController controller,
    String sportKey, SportEvents gameDetails) {
  return Expanded(
    flex: 2,
    child: ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: sportKey == 'MLB'
          ? gameDetails.awayTeamInjuredPlayer.length >=
                  gameDetails.homeTeamInjuredPlayer.length
              ? gameDetails.awayTeamInjuredPlayer.length
              : gameDetails.homeTeamInjuredPlayer.length
          : gameDetails.awayTeamInjuredPlayer.length >=
                  gameDetails.homeTeamInjuredPlayer.length
              ? gameDetails.awayTeamInjuredPlayer.length
              : gameDetails.homeTeamInjuredPlayer.length,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return commonCatchWidget(
            context, index, controller, sportKey, gameDetails);
      },
    ),
  );
}

Column commonCatchWidget(
    BuildContext context,
    int index,
    GameDetailsController controller,
    String sportKey,
    SportEvents gameDetails) {
  return Column(
    children: [
      SizedBox(
        height: MediaQuery.of(context).size.width * .038,
      ),
      (sportKey == 'MLB'
              ? (index ==
                  (gameDetails.awayTeamInjuredPlayer.length >=
                              gameDetails.homeTeamInjuredPlayer.length
                          ? gameDetails.awayTeamInjuredPlayer.length
                          : gameDetails.homeTeamInjuredPlayer.length) -
                      1)
              : 0 ==
                  0 /*(index ==
                    (controller.injuredAwayPlayerList.length >=
                                controller.injuredHomePlayerList.length
                            ? controller.injuredAwayPlayerList.length
                            : controller.injuredHomePlayerList.length) -
                        1)*/
          )
          ? const SizedBox()
          : commonDivider(context),
    ],
  );
}

Container headerTitleWidget(BuildContext context, String title,
    {bool isTeamReport = false,
    bool isInjury = false,
    Competitors? awayTeam,
    Competitors? homeTeam,
    required SportEvents gameDetails}) {
  return Container(
      height: MediaQuery.of(context).size.height * .032,
      width: Get.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(MediaQuery.of(context).size.width * .01)),
          color: Theme.of(context).disabledColor),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: isInjury
                  ? MainAxisAlignment.end
                  : mobileView.size.shortestSide < 600
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.end,
              children: [
                mobileView.size.shortestSide < 600
                    ? (awayTeam?.abbreviation ?? '').appCommonText(
                        weight: FontWeight.w600,
                        maxLine: 1,
                        size: MediaQuery.of(context).size.height * .016,
                        align: TextAlign.end,
                        color: Theme.of(context).cardColor,
                      )
                    : Expanded(
                        child: (awayTeam?.name ?? '').appCommonText(
                          weight: FontWeight.w600,
                          maxLine: 1,
                          size: MediaQuery.of(context).size.height * .016,
                          align: TextAlign.end,
                          color: Theme.of(context).cardColor,
                        ),
                      ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .01,
                ),
                commonCachedNetworkImage(
                    width: Get.height * .025,
                    height: Get.height * .025,
                    imageUrl: gameDetails.gameLogoAwayLink),
              ],
            ),
          ),
          Expanded(
            flex: isTeamReport ? 3 : 2,
            child: title.appCommonText(
                color: Theme.of(context).cardColor,
                align: TextAlign.center,
                maxLine: 1,
                weight: FontWeight.w700,
                size: Get.height * .018),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: isInjury
                  ? MainAxisAlignment.start
                  : mobileView.size.shortestSide < 600
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
              children: [
                commonCachedNetworkImage(
                    width: Get.height * .025,
                    height: Get.height * .025,
                    imageUrl: gameDetails.gameHomeLogoLink),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .01,
                ),
                mobileView.size.shortestSide < 600
                    ? (homeTeam?.abbreviation ?? "").appCommonText(
                        weight: FontWeight.w600,
                        maxLine: 1,
                        size: MediaQuery.of(context).size.height * .016,
                        align: TextAlign.start,
                        color: Theme.of(context).cardColor,
                      )
                    : Expanded(
                        child: (homeTeam?.name ?? "").appCommonText(
                          weight: FontWeight.w600,
                          maxLine: 1,
                          size: MediaQuery.of(context).size.height * .016,
                          align: TextAlign.start,
                          color: Theme.of(context).cardColor,
                        ),
                      ),
              ],
            ),
          ),
        ],
      ));
}

Padding hotlinesWidget(BuildContext context, GameDetailsController con) {
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
          con.hotlinesData.isEmpty && con.isHotlines
              ? circularWidget(context)
                  .paddingAll(MediaQuery.of(context).size.height * .038)
              : con.hotlinesData.isEmpty && !con.isHotlines
                  ? emptyListWidget(context)
                  : hotlinesCard(con),
        ],
      ),
    ),
  );
}

ListView hotlinesCard(GameDetailsController con) {
  return ListView.builder(
    shrinkWrap: true,
    itemCount: con.hotlinesData.length >= 4 ? 3 : con.hotlinesData.length,
    padding: EdgeInsets.zero,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      con.hotlinesData.sort((a, b) => b.value.compareTo(a.value));
      return Column(
        children: [
          SizedBox(
            // height:
            //     MediaQuery.of(context).size.height * .038,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * .016),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: mobileView.size.shortestSide < 600 ? 7 : 4,
                    child: (con.hotlinesData[index].teamName).appCommonText(
                        color: Theme.of(context).highlightColor,
                        weight: FontWeight.bold,
                        align: TextAlign.start,
                        size: mobileView.size.shortestSide < 600
                            ? MediaQuery.of(context).size.height * .014
                            : MediaQuery.of(context).size.height * .016),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(0)),
                      child: Center(
                        child: con.hotlinesData[index].value
                            .appCommonText(
                                color: Theme.of(context).cardColor,
                                size: MediaQuery.of(context).size.height * .014,
                                weight: FontWeight.w600)
                            .paddingSymmetric(
                                vertical:
                                    MediaQuery.sizeOf(context).height * .008),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .02,
                  ),
                  Expanded(
                      child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: MediaQuery.of(context).size.height * .04,
                      width: MediaQuery.of(context).size.width * .052,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(
                              con.hotlinesData[index].bookId == 'sr:book:18186'
                                  ? Assets.imagesFanduel
                                  : Assets.imagesDraftkings,
                            ),
                            fit: BoxFit.contain,
                          )),
                    ),
                  )),
                ],
              ),
            ),
          ),
          index == 2 ? const SizedBox() : commonDivider(context),
        ],
      );
    },
  );
}

SizedBox emptyListWidget(BuildContext context) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * .038,
    child: Center(
        child: 'No Data'.appCommonText(
            weight: FontWeight.w400,
            size: Get.height * .014,
            color: Theme.of(context).highlightColor)),
  );
}

SizedBox circularWidget(BuildContext context) {
  return SizedBox(
    // height: MediaQuery.of(context).size.height * .02,
    width: Get.width,
    child: Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .02,
        width: MediaQuery.of(context).size.height * .02,
        child: CircularProgressIndicator(
          strokeWidth: mobileView.size.shortestSide < 600 ? 2 : 3,
          color: Theme.of(context).primaryColor,
        ),
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

headerWidget(BuildContext context, SportEvents gameDetails,
    Competitors? awayTeam, Competitors? homeTeam) {
  isDark = PreferenceManager.getIsDarkMode() ?? false;
  return Stack(
    fit: StackFit.loose,
    alignment: Alignment.topCenter,
    clipBehavior: Clip.none,
    children: [
      Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * .02),
        child: GetBuilder<SelectGameController>(builder: (con) {
          String dateTime = DateFormat.jm()
              .format(DateTime.parse(gameDetails.scheduled ?? '').toLocal());
          String date = DateFormat.d()
              .format((DateTime.parse(gameDetails.scheduled ?? '')).toLocal());
          String month = DateFormat.MMM()
              .format((DateTime.parse(gameDetails.scheduled ?? '')).toLocal());
          // String year = DateFormat.y().format(
          //     (DateTime.parse(gameDetails.scheduled ?? '')).toLocal());
          String day = DateFormat.MMMEd()
              .format((DateTime.parse(gameDetails.scheduled ?? '')).toLocal())
              .split(',')
              .first;
          if (date == '1') {
            date = '${date}st';
          } else if (date.endsWith('1') && !date.startsWith('1')) {
            date = '${date}st';
          } else if (date.endsWith('2') && !date.startsWith('1')) {
            date = '${date}nd';
          } else if (date.endsWith('3') && !date.startsWith('1')) {
            date = '${date}rd';
          } else {
            date = '${date}th';
          }
          return Container(
            width: Get.width,
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            // height: MediaQuery.of(context).size.height * .175,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.width * .01),
                image: DecorationImage(
                    image: AssetImage(isDark || con.isDarkMode
                        ? Assets.imagesBackDark
                        : Assets.imagesBackLight),
                    fit: BoxFit.fill)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /*Expanded(
                      child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * .008),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        commonBoxWidget(
                          context,
                          title:
                              gameDetails.awaySpreadValue.contains('-')
                                  ? gameDetails.awaySpreadValue
                                  : '+${gameDetails.awaySpreadValue}',
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * .025,
                        ),
                        commonBoxWidget(context,
                            title: gameDetails.awayMoneyLineValue),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * .025,
                        ),
                        commonBoxWidget(context,
                            title: 'o/u${gameDetails.awayOUValue}')
                      ],
                    ),
                  )),*/
                Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.network(
                          gameDetails.gameLogoAwayLink,
                          width: Get.height * .048,
                          height: Get.height * .048,
                          fit: BoxFit.contain,
                        ),
                        (mobileView.size.shortestSide < 600
                                ? awayTeam?.abbreviation
                                : awayTeam?.name?.replaceAll(
                                        '${awayTeam.name?.split(' ').first}',
                                        '') ??
                                    '')
                            .toString()
                            .appCommonText(
                                weight: FontWeight.bold,
                                size: MediaQuery.of(context).size.height * .016,
                                align: TextAlign.end,
                                maxLine: 1,
                                color: whiteColor),
                        ('${gameDetails.awayWin}-${gameDetails.awayLoss}')
                            .appCommonText(
                                align: TextAlign.end,
                                weight: FontWeight.w400,
                                size: MediaQuery.of(context).size.height * .014,
                                color: whiteColor),
                      ],
                    )),
                Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        (mobileView.size.shortestSide < 600
                                ? '${gameDetails.awayScore} - ${gameDetails.homeScore}'
                                : '${gameDetails.awayScore}  -  ${gameDetails.homeScore}')
                            .appCommonText(
                                color: whiteColor,
                                size: MediaQuery.of(context).size.height * .048,
                                weight: FontWeight.w700),
                        '$day, $month $date , ${(gameDetails.status == 'live' ? '${gameDetails.inningHalf}${gameDetails.inning}' : dateTime)} '
                            .appCommonText(
                                color: backGroundColor,
                                size: MediaQuery.of(context).size.height * .014,
                                weight: FontWeight.w600),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * .003,
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          alignment: WrapAlignment.center,
                          children: [
                            (gameDetails.venue != null
                                    ? '${gameDetails.venue?.name}, '
                                    : '')
                                .toString()
                                .appCommonText(
                                    size: MediaQuery.of(context).size.height *
                                        .014,
                                    color: lightGrayColor,
                                    weight: FontWeight.w600),
                            (gameDetails.venue != null
                                    ? gameDetails.venue?.tmpInFahrenheit
                                    : 00)
                                .toString()
                                .appCommonText(
                                    size: MediaQuery.of(context).size.height *
                                        .014,
                                    color: lightGrayColor,
                                    weight: FontWeight.w400),
                            ' °F  '.appCommonText(
                              size: MediaQuery.of(context).size.height * .01,
                              weight: FontWeight.w300,
                              color: lightGrayColor,
                            ),
                            getWeatherIcon(
                                (gameDetails.venue != null
                                    ? gameDetails.venue?.weather ?? 'Sunny'
                                    : 'Sunny'),
                                context,
                                MediaQuery.of(context).size.height * .02),
                          ],
                        )
                      ],
                    )),
                Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.network(
                          gameDetails.gameHomeLogoLink,
                          width: Get.height * .048,
                          height: Get.height * .048,
                          fit: BoxFit.contain,
                        ),
                        (mobileView.size.shortestSide < 600
                                ? homeTeam?.abbreviation
                                : homeTeam?.name?.replaceAll(
                                        '${homeTeam.name?.split(' ').last}',
                                        '') ??
                                    '')
                            .toString()
                            .appCommonText(
                                weight: FontWeight.bold,
                                size: MediaQuery.of(context).size.height * .016,
                                align: TextAlign.start,
                                maxLine: 1,
                                color: whiteColor),
                        (' ${gameDetails.homeWin}-${gameDetails.homeLoss}')
                            .appCommonText(
                                align: TextAlign.end,
                                weight: FontWeight.w400,
                                size: MediaQuery.of(context).size.height * .014,
                                color: whiteColor),
                      ],
                    )),
                /*Expanded(
                      child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * .008),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        commonBoxWidget(
                          context,
                          title:
                              gameDetails.homeSpreadValue.contains('-')
                                  ? gameDetails.homeSpreadValue
                                  : '+${gameDetails.homeSpreadValue}',
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * .025,
                        ),
                        commonBoxWidget(context,
                            title: gameDetails.homeMoneyLineValue),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * .025,
                        ),
                        commonBoxWidget(context,
                            title: 'o/u${gameDetails.homeOUValue}')
                      ],
                    ),
                  ))*/
              ],
            ).paddingOnly(bottom: MediaQuery.of(context).size.height * .005),
          );
        }),
      ),
      gameDetails.status == 'live'
          ? Positioned(
              top: MediaQuery.of(context).size.height * .010,
              child: Container(
                height: MediaQuery.of(context).size.height * .02,
                // width: MediaQuery.of(context).size.width * .07,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(105), color: redColor),
                child: Center(
                  child: 'LIVE'
                      .appCommonText(
                          letterSpacing: 1,
                          color: whiteColor,
                          size: MediaQuery.of(context).size.height * .012,
                          weight: FontWeight.w700)
                      .paddingSymmetric(
                          horizontal: MediaQuery.of(context).size.height * .01),
                ),
              ),
            )
          : const SizedBox(),
    ],
  );
}
