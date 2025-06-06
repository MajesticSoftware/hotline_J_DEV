// ignore_for_file: unnecessary_import, unused_local_variable

import 'dart:developer';
import '../../../model/nba_statics_model.dart' as pro;
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotlines/utils/extension.dart';
import 'package:hotlines/view/sports/gameListing/game_listing_con.dart';
import 'package:hotlines/view/subscription/subscription_controller.dart';
import 'package:hotlines/view/widgets/sportsbooks_buttons.dart';
import 'package:intl/intl.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

import '../../../constant/app_strings.dart';
import '../../../constant/shred_preference.dart';
import '../../../extras/constants.dart';
import '../../../generated/assets.dart';
import '../../../model/game_listing.dart';
import '../../../model/game_model.dart';
import '../../../theme/app_color.dart';
import '../../../theme/helper.dart';
import '../../../utils/layouts.dart';
import '../../auth/log_in_module/log_in_screen.dart';
import '../../widgets/common_dialog.dart';
import '../../widgets/game_widget.dart';
import 'game_details_controller.dart';
import 'package:hotlines/utils/app_helper.dart';
PreferredSize commonTabletAppBar(BuildContext context, bool isDark,
    GameDetailsController con) {
  return PreferredSize(
      preferredSize: Size.fromHeight(110.w),
      child: AnimatedContainer(
        alignment: Alignment.bottomCenter,
        color: Theme
            .of(context)
            .secondaryHeaderColor,
        duration: const Duration(milliseconds: 500),
        child: Padding(
          padding: EdgeInsets.only(bottom: 27.w, left: 24.w, right: 24.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    onTap: () {
                      con.isTeamReportTab = true;
                      Get.back();
                    },
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: SizedBox(
                        height: 30, width: 30,
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 30.h,
                          color: whiteColor,
                        ),
                      ),
                    ),
                  ).paddingOnly(left: 8.h),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SvgPicture.asset(Assets.imagesLogo,
                      height: 34.w, fit: BoxFit.contain),),
              ),
              Expanded(
                child: (PreferenceManager.getSubscriptionActive() ?? "0") ==
                    "1"
                    ? SizedBox(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * .028,
                ) :
                Align(
                  alignment: Alignment.bottomRight,
                  child: GetBuilder<SubscriptionController>(
                      builder: (ctrl) {
                        return InkWell(
                          highlightColor: Colors.transparent,
                          splashFactory: NoSplash.splashFactory,
                          onTap: () {
                            subscriptionDialog(context, restoreOnTap: () async {
                              await ctrl.restorePurchase(context);
                            }, price: ctrl.price, onTap: () async {
                              Get.back();
                              if (PreferenceManager.getIsLogin() ?? false) {
                                if (ctrl.products.isEmpty) {
                                  null;
                                } else {
                                  log('ON TAP');
                                  try {
                                    await ctrl.buyProduct(ctrl.products[0]);
                                    con.update();
                                  } catch (e) {
                                    log('Error: $e');
                                  }
                                }
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return exitApp(
                                      context,
                                      buttonText: 'Login',
                                      cancelText: 'Cancel',
                                      title: 'Error',
                                      subtitle: 'You have to login for Subscription!',
                                      onTap: () {
                                        Get.offAll(LogInScreen());
                                      },
                                    );
                                  },
                                );
                              }
                            },);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: yellowColor,
                                borderRadius: BorderRadius.circular(5.w)),

                            child: 'Go Premium'.appCommonText(
                                color: whiteColor,
                                weight: FontWeight.w800,
                                size: 20.sp).paddingSymmetric(
                                horizontal: 10.w, vertical: 5.h),
                          ),
                          /*Image.asset(
                            Assets.imagesLock, fit: BoxFit.contain,
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * .028,
                            alignment: Alignment.centerRight,),*/
                        );
                      }
                  ),
                ),
              ),
            ],
          ),
        ),
      ));
}

AppBar commonAppBarWidget(BuildContext context, bool isDark,
    GameDetailsController con) {
  return AppBar(
    centerTitle: true,
    backgroundColor: Theme
        .of(context)
        .secondaryHeaderColor,
    leading: InkWell(
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      onTap: () {
        con.isTeamReportTab = true;
        Get.back();
      },
      child: SizedBox(
        height: 30, width: 30,
        child: Icon(
          Icons.arrow_back_ios,
          size: 30.h,
          color: whiteColor,
        ),
      ),
    ),
    actions: [
      Visibility(
        visible: (PreferenceManager.getSubscriptionActive() ?? "0") !=
            "1",
        child: GetBuilder<SubscriptionController>(
            builder: (ctrl) {
              return InkWell(
                highlightColor: Colors.transparent,
                splashFactory: NoSplash.splashFactory,
                onTap: () {
                  subscriptionDialog(context, restoreOnTap: () async {
                    await ctrl.restorePurchase(context);
                  }, price: ctrl.price, onTap: () async {
                    Get.back();
                    if (PreferenceManager.getIsLogin() ?? false) {
                      if (ctrl.products.isEmpty) {
                        null;
                      } else {
                        log('ON TAP');
                        try {
                          await ctrl.buyProduct(ctrl.products[0]);
                          con.update();
                        } catch (e) {
                          log('Error: $e');
                        }
                      }
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return exitApp(
                            context,
                            buttonText: 'Login',
                            cancelText: 'Cancel',
                            title: 'Error',
                            subtitle: 'You have to login for Subscription!',
                            onTap: () {
                              Get.offAll(LogInScreen());
                            },
                          );
                        },
                      );
                    }
                  },);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: yellowColor,
                      borderRadius: BorderRadius.circular(5.w)),

                  child: 'Go Premium'.appCommonText(
                      color: whiteColor,
                      weight: FontWeight.w800,
                      size: 20.sp).paddingSymmetric(
                      horizontal: 10.w, vertical: 5.h),
                ),

              ).paddingOnly(right: 24.w);
            }
        ),
      )
    ],
    title: SvgPicture.asset(Assets.imagesLogo,
        height: 34.w, fit: BoxFit.contain),
  );
}


Widget teamReportWidget(BuildContext context, String sportKey,
    SportEvents gameDetails, Competitors? awayTeam, Competitors? homeTeam) {
  return Padding(
    padding: EdgeInsets.all(MediaQuery
        .of(context)
        .size
        .height * .02),
    child: Container(
      // height: MediaQuery.of(context).size.height * .227,
      decoration: BoxDecoration(
          borderRadius:
          BorderRadius.circular(MediaQuery
              .of(context)
              .size
              .width * .01),
          color: Theme
              .of(context)
              .canvasColor),
      child: GetBuilder<GameDetailsController>(builder: (controller) {
        return StickyHeader(
            header: headerTitleWidget(context, teamReport,
                isTeamReport: true,
                gameDetails: gameDetails,
                awayTeam: awayTeam,
                homeTeam: homeTeam),
            content: Column(
              children: [
                sportKey == SportName.MLB.name
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
                      itemCount: controller.pitchingMLB.length,
                      itemBuilder: (context, index) {
                        return commonRankingWidget(context,
                            isReport: true,
                            teamReports: controller.pitchingMLB[index],
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
                          awayText:
                          gameDetails.nflAwayOffensiveList.isEmpty
                              ? '0'
                              : gameDetails.nflAwayOffensiveList[index]
                              .toString(),
                          homeText:
                          gameDetails.nflHomeOffensiveList.isEmpty
                              ? '0'
                              : gameDetails.nflHomeOffensiveList[index]
                              .toString(),
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
                            homeText: gameDetails
                                .nflHomeDefensiveList.isEmpty
                                ? '0'
                                : gameDetails.nflHomeDefensiveList[index]
                                .toString(),
                            awayText: gameDetails
                                .nflAwayDefensiveList.isEmpty
                                ? "0"
                                : gameDetails.nflAwayDefensiveList[index]
                                .toString());
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

Padding playerStatWidget(BuildContext context,
    GameDetailsController con,
    String sportKey,
    SportEvents gameDetails,
    Competitors? awayTeam,
    Competitors? homeTeam) {
  return Padding(
    padding: EdgeInsets.only(
        left: MediaQuery
            .of(context)
            .size
            .height * .02,
        right: MediaQuery
            .of(context)
            .size
            .height * .02,
        bottom: MediaQuery
            .of(context)
            .size
            .height * .02),
    child: Container(
      // height: MediaQuery.of(context).size.height * .227,
      decoration: BoxDecoration(
          borderRadius:
          BorderRadius.circular(MediaQuery
              .of(context)
              .size
              .width * .01),
          color: Theme
              .of(context)
              .canvasColor),
      child: GetBuilder<GameDetailsController>(initState: (state) {

      }, builder: (controller) {
        return StickyHeader(
            header: headerTitleWidget(context, 'Pitching',
                isTeamReport: false,
                gameDetails: gameDetails,
                homeTeam: homeTeam,
                awayTeam: awayTeam),
            content: Column(
              children: [
                Column(
                  children: [
                    rankingCommonWidget(
                        context: context,
                        title: '',
                        awayText: gameDetails.awayPlayerName,
                        homeText: gameDetails.homePlayerName),
                    commonRankingWidget(context,
                        teamReports: controller.teamPitcherMLB[0],
                        awayText: gameDetails.wlAway,
                        homeText: gameDetails.wlHome),
                    commonDivider(context),
                    commonRankingWidget(context,
                        teamReports: controller.teamPitcherMLB[1],
                        awayText: double.parse(gameDetails.eraAway)
                            .toStringAsFixed(1),
                        homeText: double.parse(gameDetails.eraHome)
                            .toStringAsFixed(1)),
                    commonDivider(context),
                    commonRankingWidget(context,
                        teamReports: controller.teamPitcherMLB[2],
                        awayText: double.parse(controller.whipAway)
                            .toStringAsFixed(1),
                        homeText: double.parse(controller.whipHome)
                            .toStringAsFixed(1)),
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
              ],
            ));
      }),
    ),
  );
}

Padding hitterPlayerStatWidget(BuildContext context,

    SportEvents gameDetails,
    Competitors? awayTeam,
    Competitors? homeTeam,
    String sportKey) {
  return Padding(
    padding: EdgeInsets.only(
        left: MediaQuery
            .of(context)
            .size
            .height * .02,
        right: MediaQuery
            .of(context)
            .size
            .height * .02,
        bottom: MediaQuery
            .of(context)
            .size
            .height * .02),
    child: Container(
      // height: MediaQuery.of(context).size.height * .227,
      decoration: BoxDecoration(
          borderRadius:
          BorderRadius.circular(MediaQuery
              .of(context)
              .size
              .width * .01),
          color: Theme
              .of(context)
              .canvasColor),
      child: GetBuilder<GameDetailsController>(builder: (controller) {
        return StickyHeader(
            header: customTabBar(
                context,
                controller,
                gameDetails,
                awayTeam,
                homeTeam,
                sportKey,
                sportKey == SportName.NBA.name || sportKey == SportName.NCAAB.name
                    ? "Players"
                    : 'Rushing'),
            content: sportKey == SportName.NBA.name || sportKey == SportName.NCAAB.name
                ? Column(
              children: [
                headerOfNBAPlayerStat(context),
                commonDivider(context),
                nbaRushingCard(controller, gameDetails),
              ],
            )
                : sportKey == SportName.MLB.name
                ? Column(
              children: [
                headerOfHitterPlayerStat(context),
                commonDivider(context),
                hitterPlayerDetailCard(controller),
              ],
            )
                : Column(
              children: [
                headerOfRunningBacks(context),
                commonDivider(context),
                runningBacksCard(controller, gameDetails),
              ],
            ));
      }),
    ),
  );
}

Padding wrPlayersWidget(BuildContext context,
    GameDetailsController con,
    SportEvents gameDetails,
    Competitors? awayTeam,
    Competitors? homeTeam,
    String sportKey) {
  return Padding(
    padding: EdgeInsets.only(
        left: MediaQuery
            .of(context)
            .size
            .height * .02,
        right: MediaQuery
            .of(context)
            .size
            .height * .02,
        bottom: MediaQuery
            .of(context)
            .size
            .height * .02),
    child: Container(
      // height: MediaQuery.of(context).size.height * .227,
      decoration: BoxDecoration(
          borderRadius:
          BorderRadius.circular(MediaQuery
              .of(context)
              .size
              .width * .01),
          color: Theme
              .of(context)
              .canvasColor),
      child: GetBuilder<GameDetailsController>(builder: (controller) {
        return StickyHeader(
          header: customTabBar1(context, con, gameDetails, awayTeam, homeTeam),
          content: Column(
            children: [
              headerOfWRPlayers(context),
              commonDivider(context),
              ListView.separated(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, i) {
                  // Determine total plays
                  num totalPlay = (con.isTeamReportTab
                      ? (gameDetails.nflAwayReceiversPlayer[i].gamesPlayed == 0
                      ? 1
                      : (gameDetails.nflAwayReceiversPlayer[i].gamesPlayed ??
                      1))
                      : (gameDetails.nflHomeReceiversPlayer[i].gamesPlayed == 0
                      ? 1
                      : (gameDetails.nflHomeReceiversPlayer[i].gamesPlayed ??
                      1)));
                  sortPlayers(gameDetails, totalPlay);
                  return con.isTeamReportTab
                      ? ExpandableNotifier(
                    initialExpanded: i == con.isExpand,
                    child: ScrollOnExpand(
                      child: Column(
                        children: [
                          ExpandablePanel(
                            theme: const ExpandableThemeData(hasIcon: false),
                            header: receivingAwayPlayerCard(
                                context, gameDetails, i, totalPlay),
                            collapsed: const SizedBox(),
                            expanded: Column(
                              children: [
                                expandableTileCardRunning(
                                  context,
                                  con,
                                  value2: (gameDetails.nflAwayReceiversPlayer[i]
                                      .receiving?.yards ??
                                      0)
                                      .toStringAsFixed(1),
                                  title2: 'Yards',
                                  title1: 'Longest Catch',
                                  value1: (gameDetails.nflAwayReceiversPlayer[i]
                                      .receiving?.longest ??
                                      0)
                                      .toStringAsFixed(1),
                                ),
                                expandableTileCardRunning(
                                  context,
                                  con,
                                  value1: (gameDetails
                                      .nflAwayReceiversPlayer[i]
                                      .receiving?.avgYards ??
                                      0)
                                      .toStringAsFixed(1),
                                  title1: 'Average Catch',
                                  title2: 'Drops',
                                  value2: (gameDetails.nflAwayReceiversPlayer[i]
                                      .receiving?.droppedPasses ??
                                      0)
                                      .toStringAsFixed(1),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                      : ExpandableNotifier(
                    key: Key(i.toString()),
                    initialExpanded: i == con.isExpand,
                    child: ScrollOnExpand(
                      child: Column(
                        children: [
                          ExpandablePanel(
                            theme: const ExpandableThemeData(hasIcon: false),
                            header: receivingHomePlayerCard(
                                context, gameDetails, i, totalPlay),
                            collapsed: const SizedBox(),
                            expanded: Column(
                              children: [
                                expandableTileCardRunning(
                                  context,
                                  con,
                                  value2: (gameDetails.nflHomeReceiversPlayer[i]
                                      .receiving?.yards ??
                                      0)
                                      .toStringAsFixed(1),
                                  title2: 'Yards',
                                  title1: 'Longest Catch',
                                  value1: (gameDetails.nflHomeReceiversPlayer[i]
                                      .receiving?.longest ??
                                      0)
                                      .toStringAsFixed(1),
                                ),
                                expandableTileCardRunning(
                                  context,
                                  con,
                                  value1: (gameDetails
                                      .nflHomeReceiversPlayer[i]
                                      .receiving?.avgYards ??
                                      0)
                                      .toStringAsFixed(1),
                                  title1: 'Average Catch',
                                  title2: 'Drops',
                                  value2: (gameDetails.nflHomeReceiversPlayer[i]
                                      .receiving?.droppedPasses ??
                                      0)
                                      .toStringAsFixed(1),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return commonDivider(context);
                },
                itemCount: con.isTeamReportTab
                    ? gameDetails.nflAwayReceiversPlayer.length
                    : gameDetails.nflHomeReceiversPlayer.length,
              ),
            ],
          ),
        )
        ;
      }),
    ),
  );
}

void sortPlayers(SportEvents gameDetails, num totalPlay) {
  // Sort away receivers by touchdowns (descending), then by yards (descending)
  gameDetails.nflAwayReceiversPlayer.sort((a, b) {
    // Sort by touchdowns first (descending order)
    num touchdownsA = a.receiving?.touchdownsPerGame ?? 0;
    num touchdownsB = b.receiving?.touchdownsPerGame ?? 0;

    int result = touchdownsB.compareTo(touchdownsA); // Sorting descending
    if (result == 0) {
      // If touchdowns are the same, sort by yards (descending)
      num yardsA = a.receiving?.yards == null ? 0 : (a.receiving?.yards ?? 0);
      num yardsB = b.receiving?.yards == null ? 0 : (b.receiving?.yards ?? 0);
      result = yardsB.compareTo(yardsA); // Sorting descending
    }

    return result;
  });

  // Sort home receivers by touchdowns (descending), then by yards (descending)
  gameDetails.nflHomeReceiversPlayer.sort((a, b) {
    // Sort by touchdowns first (descending order)
    num touchdownsA = a.receiving?.touchdownsPerGame ?? 0;
    num touchdownsB = b.receiving?.touchdownsPerGame ?? 0;


    int result = touchdownsB.compareTo(touchdownsA); // Sorting descending
    if (result == 0) {
      // If touchdowns are the same, sort by yards (descending)
      num yardsA = a.receiving?.yards == null ? 0 : (a.receiving?.yards ?? 0);
      num yardsB = b.receiving?.yards == null ? 0 : (b.receiving?.yards ?? 0);
      result = yardsB.compareTo(yardsA); // Sorting descending
    }

    return result;
  });
}

Widget teamReportNFL(BuildContext context,
    GameDetailsController con,
    SportEvents gameDetails,
    Competitors? awayTeam,
    Competitors? homeTeam,
    String sportKey) {
  return Padding(
    padding: EdgeInsets.all(MediaQuery
        .of(context)
        .size
        .height * .02),
    child: Container(
      // height: MediaQuery.of(context).size.height * .227,
      decoration: BoxDecoration(
          borderRadius:
          BorderRadius.circular(MediaQuery
              .of(context)
              .size
              .width * .01),
          color: Theme
              .of(context)
              .canvasColor),
      child: StickyHeader(
          header: Column(
            children: [
              HeaderTab(
                awayOnTap: () {
                  con.isTeamReportTab = true;
                },
                isTeamStat: true,
                homeOnTap: () {
                  con.isTeamReportTab = false;
                },
                title: 'Team Stats',
                isSelected: con.isTeamReportTab,
                gameDetails: gameDetails,
                awayText: con.isTeamReportTab ? "Offense" : 'Defense',
                homeText: con.isTeamReportTab ? "Defense" : 'Offense',
                homeTeam: homeTeam,
                awayTeam: awayTeam,
              ),
            ],
          ),
          content: Column(
            children: [
              commonDivider(context),
              // Use nbaOffenseDefenseData for NBA, NCAAB, and MLB
              sportKey == SportName.NBA.name || sportKey == SportName.NCAAB.name || sportKey == SportName.MLB.name
                  ? nbaOffenseDefenseData(
                  awayTeam, homeTeam, con, context, gameDetails, sportKey)
                  : nflOffenseDefenseData(
                  con, context, sportKey, awayTeam, homeTeam, gameDetails),
            ],
          )),
    ),
  );
}


class FiveStatics extends StatelessWidget {
  const FiveStatics(
      {super.key, required this.con, required this.gameDetails, this.awayTeam, this.homeTeam, required this.sportKey});

  final GameDetailsController con;
  final SportEvents gameDetails;
  final Competitors? awayTeam;
  final Competitors? homeTeam;
  final String sportKey;

  @override
  Widget build(BuildContext context) {
    if (gameDetails.pgDataAway == null || gameDetails.pgDataHome == null) {
      return const SizedBox();
    }

    return Padding(
      padding: EdgeInsets.only(
        left: MediaQuery
            .of(context)
            .size
            .height * .02, right: MediaQuery
          .of(context)
          .size
          .height * .02, bottom: MediaQuery
          .of(context)
          .size
          .height * .02,

      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(MediaQuery
              .of(context)
              .size
              .width * .01),
          color: Theme
              .of(context)
              .canvasColor,
        ),
        child: StickyHeader(
          header: customTabBar(
              context,
              con,
              isTab: false,
              gameDetails,
              awayTeam,
              homeTeam,
              sportKey,
              'Stating Five'),
          content: ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, i) {
              try {
                return ExpandableNotifier(
                  key: Key(i.toString()),
                  initialExpanded: i == con.isExpand,
                  child: ScrollOnExpand(
                    child: Column(
                      children: [
                        ExpandablePanel(
                          theme: const ExpandableThemeData(hasIcon: false),
                          header: playerHeaderRow(
                              context,
                              gameDetails,
                              awayTeam,
                              homeTeam,
                              i >= 2 ? "F" : 'G',
                              gameDetails.startingHomeFiveList[i],
                              gameDetails.startingAwayFiveList[i]),
                          collapsed: const SizedBox(),
                          expanded: Column(
                            children: List.generate(
                              con.statics.length,
                                  (index) =>
                                  Container(
                                    color: Theme
                                        .of(context)
                                        .indicatorColor
                                        .withOpacity(.5),
                                    child: Column(
                                      children: [
                                        Visibility(
                                            visible: index != 0,
                                            child: commonDivider(context)),
                                        statRow(
                                          context,
                                          index,
                                          gameDetails.startingAwayFiveList[i],
                                          gameDetails.startingHomeFiveList[i],
                                          con.statics[index],
                                        ),

                                      ],
                                    ),
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } catch (e) {
                return const SizedBox();
              }
            },
            separatorBuilder: (BuildContext context, int index) {
              return commonDivider(context);
            },
            itemCount: gameDetails.startingHomeFiveList.length,
          ),
        ),
      ),
    );
  }
}


Widget playerHeaderRow(BuildContext context, SportEvents gameDetails,
    Competitors? awayTeam, Competitors? homeTeam, String title,
    pro.Players? homePlayer, pro.Players? awayPlayer) {
  return Container(
    decoration: BoxDecoration(

      borderRadius: BorderRadius.circular(MediaQuery
          .of(context)
          .size
          .width * .01),
      color: Theme
          .of(context)
          .canvasColor,
    ),
    height: MediaQuery
        .sizeOf(context)
        .height * .034,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 4,
          child: playerInfo(
              context, awayPlayer, awayTeam, gameDetails,
              isAway: true),
        ),
        Expanded(
          flex: 0,
          child: title.appCommonText(
            weight: FontWeight.bold,
            align: TextAlign.center,
            size: MediaQuery
                .of(context)
                .size
                .height * .018,
            color: Theme
                .of(context)
                .highlightColor,
          ),
        ),
        Expanded(flex: 4,
          child: playerInfo(
              context, homePlayer, homeTeam, gameDetails,
              isAway: false),
        ),
      ],
    ),
  );
}

Widget playerInfo(BuildContext context, pro.Players? player, Competitors? team,
    SportEvents gameDetails, {required bool isAway}) {
  return InkWell(
    highlightColor: Colors.transparent,
    child: Row(
      mainAxisAlignment: MainAxisAlignment
          .center,
      children: [
        if (isAway) ...[
          ('${player?.firstName
              .toString()
              .characters
              .first}. ${player?.lastName}').appCommonText(
            weight: FontWeight.w600,
            maxLine: 1,
            align: TextAlign.center,
            size: MediaQuery
                .of(context)
                .size
                .height * .016,
            color: blueColor,
          ),

        ],


        if (!isAway) ...[

          ('${player?.firstName
              .toString()
              .characters
              .first}. ${player?.lastName}').appCommonText(
            weight: FontWeight.w600,
            maxLine: 1,
            align: TextAlign.center,
            size: MediaQuery
                .of(context)
                .size
                .height * .016,
            color: blueColor,
          ),
        ],
      ],
    ),
  );
}

Widget statRow(BuildContext context, int index, pro.Players awayPlayer,
    pro.Players homePlayer, String statName) {
  num awayStat = getStatByIndex(awayPlayer, index);
  num homeStat = getStatByIndex(homePlayer, index);

  return Row(
    children: [
      Expanded(
        child: Column(
          children: [
            awayStat.toStringAsFixed(1).appCommonText(
              weight: FontWeight.w700,
              align: TextAlign.center,
              size: MediaQuery
                  .of(context)
                  .size
                  .height * .014,
              color: Theme
                  .of(context)
                  .highlightColor,
            ),
            statName.appCommonText(
              weight: FontWeight.w700,
              align: TextAlign.center,
              color: darkGreyColor,
              size: MediaQuery
                  .of(context)
                  .size
                  .height * .014,
            ),
          ],
        ).paddingSymmetric(vertical: MediaQuery
            .of(context)
            .size
            .height * .003),
      ),
      Container(
        width: 1,
        height: MediaQuery
            .of(context)
            .size
            .height * .044,
        color: Theme
            .of(context)
            .indicatorColor
            .withOpacity(.2),
      ),
      Expanded(
        child: Column(
          children: [
            homeStat.toStringAsFixed(1).appCommonText(
              weight: FontWeight.w700,
              align: TextAlign.center,
              color: Theme
                  .of(context)
                  .highlightColor,
              size: MediaQuery
                  .of(context)
                  .size
                  .height * .014,
            ),
            statName.appCommonText(
              weight: FontWeight.w700,
              align: TextAlign.center,
              color: darkGreyColor,
              size: MediaQuery
                  .of(context)
                  .size
                  .height * .014,
            ),
          ],
        ).paddingSymmetric(vertical: MediaQuery
            .of(context)
            .size
            .height * .003),
      ),
    ],
  );
}

num getStatByIndex(pro.Players player, int index) {
  switch (index) {
    case 0:
    // Assuming player.average?.points is already a double or a numeric type
      return player.average?.points ?? 0.0;
    case 1:
      return player.average?.rebounds ?? 0.0;
    case 2:
      return player.average?.assists ?? 0.0;
  // Add additional cases if needed
    default:
      return 0.0;
  }
}


Padding quarterBacks(BuildContext context,
    GameDetailsController con,
    SportEvents gameDetails,
    Competitors? awayTeam,
    Competitors? homeTeam,
    String sportKey) {
  return Padding(
    padding: EdgeInsets.only(
        bottom: MediaQuery
            .of(context)
            .size
            .height * .02,
        left: MediaQuery
            .of(context)
            .size
            .height * .02,
        right: MediaQuery
            .of(context)
            .size
            .height * .02),
    child: Container(
      decoration: BoxDecoration(
          borderRadius:
          BorderRadius.circular(MediaQuery
              .of(context)
              .size
              .width * .01),
          color: Theme
              .of(context)
              .canvasColor),
      child: StickyHeader(
          header: Column(
            children: [
              HeaderTab(
                title: 'QBs',
                isSelected: con.isTeamReportTab,
                gameDetails: gameDetails,
                homeText: !con.isTeamReportTab
                    ? gameDetails.homePlayerName
                    : 'Defense',
                awayText: (con.isTeamReportTab
                    ? gameDetails.awayPlayerName
                    : 'Defense'),
                homeTeam: homeTeam,
                awayTeam: awayTeam,
              ),
            ],
          ),
          content: Column(
            children: [
              commonDivider(context),
              quarterBacksData(con, context, gameDetails, sportKey)
            ],
          )),
    ),
  );
}

Widget nflOffenseDefenseData(GameDetailsController con, BuildContext context,
    String sportKey, Competitors? awayTeam, Competitors? homeTeam,
    SportEvents gameDetails) {
  return GetBuilder<GameDetailsController>(builder: (con) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        ListView.separated(padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              int offensePointColor = 0;
              if ((PreferenceManager.getSubscriptionActive() ?? "0") == "1") {
                offensePointColor = (con.isTeamReportTab ? (int.tryParse(
                    gameDetails.nflHomeDefensiveRank.isEmpty ? "0" : gameDetails
                        .nflHomeDefensiveRank[index]) ?? 0) - (int.tryParse(
                    gameDetails.nflAwayOffensiveRank.isEmpty ? "0" : gameDetails
                        .nflAwayOffensiveRank[index]) ?? 0) :
                (int.tryParse(
                    gameDetails.nflHomeOffensiveRank.isEmpty ? "0" : gameDetails
                        .nflHomeOffensiveRank[index]) ?? 0) - (int.tryParse(
                    gameDetails.nflAwayDefensiveRank.isEmpty ? "0" : gameDetails
                        .nflAwayDefensiveRank[index]) ?? 0));
              }

              return Stack(
                alignment: Alignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  (con.isTeamReportTab
                                      ? ((num.tryParse(
                                      gameDetails.nflAwayOffensiveList.isEmpty
                                          ? '0'
                                          : gameDetails
                                          .nflAwayOffensiveList[index])) ??
                                      gameDetails.nflAwayOffensiveList[index])
                                      .toString()
                                      : ((num.tryParse(
                                      gameDetails.nflAwayDefensiveList.isEmpty
                                          ? '0'
                                          : gameDetails
                                          .nflAwayDefensiveList[index])) ??
                                      gameDetails.nflAwayDefensiveList[index])
                                      .toString())
                                      .appCommonText(
                                      color: Theme
                                          .of(context)
                                          .highlightColor,
                                      weight: FontWeight.w700,
                                      align: TextAlign.center,
                                      size: MediaQuery
                                          .of(context)
                                          .size
                                          .height * .014),
                                  ((PreferenceManager.getSubscriptionActive() ??
                                      "0") == "1")
                                      ?
                                  (con.isTeamReportTab
                                      ? (gameDetails.nflAwayOffensiveRank
                                      .isEmpty
                                      ? '0'
                                      : ' (${dateWidget(
                                      gameDetails
                                          .nflAwayOffensiveRank[index])})')
                                      .toString()
                                      : (gameDetails.nflAwayDefensiveRank
                                      .isEmpty
                                      ? '0'
                                      : ' (${dateWidget(
                                      gameDetails
                                          .nflAwayDefensiveRank[index])})')
                                      .toString())
                                      .appCommonText(
                                      color: con.isTeamReportTab
                                          ? (gameDetails
                                          .nflAwayOffensiveRank.isEmpty ? Colors
                                          .transparent : gameDetails
                                          .nflAwayOffensiveRank[index] == "0"
                                          ? Colors
                                          .transparent
                                          : (num.tryParse(
                                          gameDetails
                                              .nflAwayOffensiveRank[index]
                                              .toString()) ?? 0) <=
                                          11 ? Colors.green : (((int.tryParse(
                                          gameDetails
                                              .nflAwayOffensiveRank[index]
                                              .toString()) ?? 0) <=
                                          22) && ((int.tryParse(
                                          gameDetails
                                              .nflAwayOffensiveRank[index]
                                              .toString()) ?? 0) >
                                          11)) ? yellowColor : redColor)
                                          : (gameDetails
                                          .nflAwayDefensiveRank.isEmpty ? Colors
                                          .transparent : gameDetails
                                          .nflAwayDefensiveRank[index] == "0"
                                          ? Colors
                                          .transparent
                                          : (num.tryParse(
                                          gameDetails
                                              .nflAwayDefensiveRank[index]
                                              .toString()) ?? 0) <=
                                          11 ? Colors.green : (((int.tryParse(
                                          gameDetails
                                              .nflAwayDefensiveRank[index]
                                              .toString()) ?? 0) <=
                                          22) && ((int.tryParse(
                                          gameDetails
                                              .nflAwayDefensiveRank[index]
                                              .toString()) ?? 0) >
                                          11)) ? yellowColor : redColor),
                                      weight: FontWeight.w800,
                                      align: TextAlign.center,
                                      size: MediaQuery
                                          .of(context)
                                          .size
                                          .height * .014)
                                      : const SizedBox(),
                                ]),
                            (con.isTeamReportTab
                                ? con.offensive[index]
                                : con.defensive[index])
                                .toString()
                                .appCommonText(
                                color: darkGreyColor,
                                align: TextAlign.center,
                                weight: FontWeight.w600,
                                size: MediaQuery
                                    .of(context)
                                    .size
                                    .height * .012),
                          ],
                        ).paddingSymmetric(
                            vertical: MediaQuery
                                .of(context)
                                .size
                                .height * .003),
                      ),
                      Container(
                        width: 1,
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * .043,
                        color: Theme
                            .of(context)
                            .indicatorColor,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                (con.isTeamReportTab
                                    ? ((num.tryParse(
                                    gameDetails.nflHomeDefensiveList.isEmpty
                                        ? '0'
                                        : gameDetails
                                        .nflHomeDefensiveList[index])) ??
                                    gameDetails.nflHomeDefensiveList[index])
                                    .toString()
                                    : ((num.tryParse(
                                    gameDetails.nflHomeOffensiveList.isEmpty
                                        ? '0'
                                        : gameDetails
                                        .nflHomeOffensiveList[index])) ??
                                    gameDetails.nflHomeOffensiveList[index])
                                    .toString())
                                    .appCommonText(
                                    color: Theme
                                        .of(context)
                                        .highlightColor,
                                    weight: FontWeight.w700,
                                    align: TextAlign.center,
                                    size: MediaQuery
                                        .of(context)
                                        .size
                                        .height * .014),

                                ((PreferenceManager.getSubscriptionActive() ??
                                    "0") == "1")
                                    ? (con.isTeamReportTab
                                    ? (gameDetails.nflHomeDefensiveRank.isEmpty
                                    ? '0'
                                    : ' (${dateWidget(
                                    gameDetails.nflHomeDefensiveRank[index])})')
                                    .toString()
                                    : (gameDetails.nflHomeOffensiveRank.isEmpty
                                    ? '0'
                                    : ' (${dateWidget(
                                    gameDetails.nflHomeOffensiveRank[index])})')
                                    .toString())
                                    .appCommonText(
                                    color: con.isTeamReportTab
                                        ? (gameDetails
                                        .nflHomeOffensiveRank.isEmpty ? Colors
                                        .transparent : gameDetails
                                        .nflHomeDefensiveRank[index] == "0"
                                        ? Colors
                                        .transparent
                                        : (num.tryParse(
                                        gameDetails.nflHomeDefensiveRank[index]
                                            .toString()) ?? 0) <=
                                        11 ? Colors.green : (((int.tryParse(
                                        gameDetails.nflHomeDefensiveRank[index]
                                            .toString()) ?? 0) <=
                                        22) && ((int.tryParse(
                                        gameDetails.nflHomeDefensiveRank[index]
                                            .toString()) ?? 0) >
                                        11)) ? yellowColor : redColor)
                                        : (gameDetails
                                        .nflHomeOffensiveRank.isEmpty ? Colors
                                        .transparent : gameDetails
                                        .nflHomeOffensiveRank[index] == "0"
                                        ? Colors
                                        .transparent
                                        : (num.tryParse(
                                        gameDetails.nflHomeOffensiveRank[index]
                                            .toString()) ?? 0) <=
                                        11 ? Colors.green : (((int.tryParse(
                                        gameDetails.nflHomeOffensiveRank[index]
                                            .toString()) ?? 0) <=
                                        22) && ((int.tryParse(
                                        gameDetails.nflHomeOffensiveRank[index]
                                            .toString()) ?? 0) >
                                        11)) ? yellowColor : redColor),

                                    weight: FontWeight.w800,
                                    align: TextAlign.center,
                                    size: MediaQuery
                                        .of(context)
                                        .size
                                        .height * .014)
                                    : const SizedBox(),
                              ],
                            ),
                            (con.isTeamReportTab
                                ? con.defensive[index]
                                : con.offensive[index])
                                .toString()
                                .appCommonText(
                                color: darkGreyColor,
                                align: TextAlign.center,
                                weight: FontWeight.w600,
                                size: MediaQuery
                                    .of(context)
                                    .size
                                    .height * .012),
                          ],
                        ).paddingSymmetric(
                            vertical: MediaQuery
                                .of(context)
                                .size
                                .height * .003),
                      ),
                    ],
                  ),
                  (sportKey ==
                      SportName.NFL.name || sportKey ==
                      SportName.NCAA.name) &&
                      ((PreferenceManager.getSubscriptionActive() ?? "0") ==
                          "1") &&
                      ((offensePointColor >= 15 || offensePointColor <= -15)) ?

                  Positioned(
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashFactory: NoSplash.splashFactory,
                      onTap: () {
                        showDialogForRank(
                            context, sportKey: sportKey,
                            awayText: '${awayTeam?.abbreviation} ${con
                                .isTeamReportTab
                                ? con.offensive[index]
                                : con.defensive[index]} ranks',
                            awayRank: con.isTeamReportTab ? (gameDetails
                                .nflAwayOffensiveRank.isEmpty
                                ? "0"
                                : gameDetails
                                .nflAwayOffensiveRank[index]) : (gameDetails
                                .nflAwayDefensiveRank.isEmpty
                                ? "0"
                                : gameDetails
                                .nflAwayDefensiveRank[index]),
                            homeText: '${homeTeam?.abbreviation} ${con
                                .isTeamReportTab

                                ? con.defensive[index]
                                : con.offensive[index]} ranks',
                            homeRank:
                            con.isTeamReportTab
                                ? (gameDetails.nflHomeDefensiveRank.isEmpty
                                ? "0"
                                : gameDetails.nflHomeDefensiveRank[index])
                                : (gameDetails.nflHomeOffensiveRank.isEmpty
                                ? "0"
                                : gameDetails.nflHomeOffensiveRank[index])
                        );
                      },
                      child: Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * .038, width: MediaQuery
                          .of(context)
                          .size
                          .height * .038,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (offensePointColor >= 25 ||
                              offensePointColor <= -25) ? Colors.red : Colors
                              .orange,
                        ),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                                Assets.assetsImagesFire, fit: BoxFit.contain,
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height * .028),
                          ],
                        ),
                      ),
                    ),
                  ) : const SizedBox(),
                ],
              );
            },
            separatorBuilder: (context, index) {
              return commonDivider(context);
            },
            itemCount: con.defensive.length),
      ],
    );
  },);
}

Future<dynamic> showDialogForRank(BuildContext context,
    {String awayRank = '', String awayText = "", String homeRank = '', String homeText = "", required String sportKey}) {
  return showDialog(
    context: context,

    builder: (context) {
      return AlertDialog(
        titlePadding: EdgeInsets.all(10.h),
        content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  children: [
                    TextSpan(text: '$awayText ', style: GoogleFonts.nunitoSans(
                      color: Colors.black, fontWeight: FontWeight.w700,
                    )),
                    TextSpan(
                      // Apply NCAAB thresholds to MLB as well
                      text: '${dateWidget(awayRank)} ${num.parse(awayRank) >
                          (sportKey == SportName.NCAAB.name || sportKey == SportName.MLB.name ? 75 : 22)
                          ? "(poor)"
                          : num.parse(awayRank) >
                          (sportKey == SportName.NCAAB.name || sportKey == SportName.MLB.name ? 50 : 11) &&
                          num.parse(awayRank) <= (sportKey == SportName.NCAAB.name || sportKey == SportName.MLB.name ? 75 : 22)
                          ? "(mid)"
                          : "(strong)"} ',
                      style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold,
                          // Apply NCAAB thresholds to MLB as well
                          color: num.parse(awayRank) >
                              (sportKey == SportName.NCAAB.name || sportKey == SportName.MLB.name ? 75 : 22)
                              ? redColor
                              : num.parse(
                              awayRank) > (sportKey == SportName.NCAAB.name || sportKey == SportName.MLB.name ? 50 : 11) &&
                              num.parse(awayRank) <=
                                  (sportKey == SportName.NCAAB.name || sportKey == SportName.MLB.name ? 75 : 22)
                              ? yellowColor
                              : Colors.green),
                    ),

                    TextSpan(text: 'in the league.\n\n $homeText ',
                        style: GoogleFonts.nunitoSans(
                          color: Colors.black, fontWeight: FontWeight.w700,
                        )),
                    TextSpan(
                      // Apply NCAAB thresholds to MLB as well
                      text: '${dateWidget(homeRank)} ${num.parse(homeRank) >
                          (sportKey == SportName.NCAAB.name || sportKey == SportName.MLB.name ? 75 : 22)
                          ? "(poor)"
                          : num.parse(homeRank) >
                          (sportKey == SportName.NCAAB.name || sportKey == SportName.MLB.name ? 50 : 11) &&
                          num.parse(homeRank) <= (sportKey == SportName.NCAAB.name || sportKey == SportName.MLB.name ? 75 : 22)
                          ? "(mid)"
                          : "(strong)"}. ',
                      style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold,
                          // Apply NCAAB thresholds to MLB as well
                          color: num.parse(homeRank) >
                              (sportKey == SportName.NCAAB.name || sportKey == SportName.MLB.name ? 75 : 22)
                              ? redColor
                              : num.parse(
                              homeRank) > (sportKey == SportName.NCAAB.name || sportKey == SportName.MLB.name ? 50 : 11) &&
                              num.parse(homeRank) <=
                                  (sportKey == SportName.NCAAB.name || sportKey == SportName.MLB.name ? 75 : 22)
                              ? yellowColor
                              : Colors.green),
                    ),
                  ],
                ),
              ).paddingAll(20.h),
              SportsBooksButtons()
            ]
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              20.r,
            ),
          ),
        ),
        shadowColor: Theme
            .of(context)
            .secondaryHeaderColor,
        contentPadding: const EdgeInsets.all(0.0),
      );
    },
  );
}

Widget nbaOffenseDefenseData(Competitors? awayTeam, Competitors? homeTeam,
    GameDetailsController con, BuildContext context, SportEvents gameDetails,
    String sportKey) {
  return ListView.separated(
    itemBuilder: (context, index) {
      int offensePointColor = 0;

      offensePointColor =
      (con.isTeamReportTab ? ((gameDetails.nbaAwayOffensiveRank.isEmpty)
          ? 0
          : (int.parse(
          gameDetails.nbaAwayOffensiveRank[index])) -
          (gameDetails.nbaHomeDefensiveRank.isEmpty ? 0 : int.parse(
              gameDetails.nbaHomeDefensiveRank[index]))) :
      (((gameDetails.nbaHomeOffensiveRank.isEmpty) ? 0 : (int.parse(
          gameDetails.nbaHomeOffensiveRank[index]))) -
          (gameDetails.nbaAwayDefensiveRank.isEmpty ? 0 : int.parse(
              gameDetails.nbaAwayDefensiveRank[index]))));

      return Stack(
        alignment: Alignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        (con.isTeamReportTab
                            ? ((num.tryParse(
                            gameDetails.nbaAwayOffensiveList.isEmpty
                                ? '0'
                                : gameDetails.nbaAwayOffensiveList[index])) ??
                            gameDetails.nbaAwayOffensiveList[index])
                            .toString()
                            : ((num.tryParse(
                            gameDetails.nbaAwayDefensiveList.isEmpty
                                ? '0'
                                : gameDetails.nbaAwayDefensiveList[index])) ??
                            gameDetails.nbaAwayDefensiveList[index])
                            .toString())
                            .appCommonText(
                            color: Theme
                                .of(context)
                                .highlightColor,
                            weight: FontWeight.w700,
                            align: TextAlign.center,
                            size: MediaQuery
                                .of(context)
                                .size
                                .height * .014),
                        Visibility(
                          visible: (PreferenceManager.getSubscriptionActive() ??
                              "0") == "1",
                          child: (con.isTeamReportTab
                              ? gameDetails.nbaAwayOffensiveRank.isEmpty
                              ? "0"
                              : ' (${dateWidget(
                              gameDetails.nbaAwayOffensiveRank[index])})'
                              .toString()
                              : gameDetails.nbaAwayDefensiveRank.isEmpty
                              ? "0"
                              : ' (${dateWidget(
                              gameDetails.nbaAwayDefensiveRank[index])})'
                              .toString())
                              .appCommonText(
                              // Apply NCAAB thresholds to MLB as well
                              color: con.isTeamReportTab ? gameDetails
                                  .nbaAwayOffensiveRank.isEmpty ? Colors
                                  .transparent : int.parse(
                                  gameDetails.nbaAwayOffensiveRank[index]) <=
                                  (sportKey == SportName.NCAAB.name || sportKey == SportName.MLB.name ? 50 : 11)
                                  ? Colors.green
                                  : (int.parse(
                                  gameDetails.nbaAwayOffensiveRank[index]) >
                                  (sportKey == SportName.NCAAB.name || sportKey == SportName.MLB.name ? 50 : 11) &&
                                  int.parse(
                                      gameDetails
                                          .nbaAwayOffensiveRank[index]) <=
                                      (sportKey == SportName.NCAAB.name || sportKey == SportName.MLB.name ? 75 : 22))
                                  ? yellowColor
                                  : redColor :
                              gameDetails.nbaAwayDefensiveRank.isEmpty ? Colors
                                  .transparent : int.parse(
                                  gameDetails.nbaAwayDefensiveRank[index]) <=
                                  (sportKey == SportName.NCAAB.name || sportKey == SportName.MLB.name ? 50 : 11)
                                  ? Colors.green
                                  : (int.parse(
                                  gameDetails.nbaAwayDefensiveRank[index]) >
                                  (sportKey == SportName.NCAAB.name || sportKey == SportName.MLB.name ? 50 : 11) &&
                                  int.parse(
                                      gameDetails
                                          .nbaAwayDefensiveRank[index]) <=
                                      (sportKey == SportName.NCAAB.name || sportKey == SportName.MLB.name ? 75 : 22))
                                  ? yellowColor
                                  : redColor,
                              weight: FontWeight.w700,
                              align: TextAlign.center,
                              size: MediaQuery
                                  .of(context)
                                  .size
                                  .height * .014),
                        )

                      ],
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: (con.isTeamReportTab
                          ? con.nbaOffensive[index]
                          : mobileView.size.shortestSide < 600 ? con
                          .nbaMobileDefensive[index] : con.nbaDefensive[index])
                          .toString()
                          .appCommonText(
                          color: darkGreyColor,
                          align: TextAlign.center,
                          weight: FontWeight.w600,
                          size: MediaQuery
                              .of(context)
                              .size
                              .height * .012),
                    ),
                  ],
                ).paddingSymmetric(
                    vertical: MediaQuery
                        .of(context)
                        .size
                        .height * .003),
              ),
              Container(
                width: 1,
                height: MediaQuery
                    .of(context)
                    .size
                    .height * .043,
                color: Theme
                    .of(context)
                    .indicatorColor,
              ),
              Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          (!con.isTeamReportTab
                              ? ((num.tryParse(
                              gameDetails.nbaHomeOffensiveList.isEmpty
                                  ? '0'
                                  : gameDetails.nbaHomeOffensiveList[index])) ??
                              gameDetails.nbaHomeOffensiveList[index])
                              .toString()
                              : ((num.tryParse(
                              gameDetails.nbaHomeDefensiveList.isEmpty
                                  ? '0'
                                  : gameDetails.nbaHomeDefensiveList[index])) ??
                              gameDetails.nbaHomeDefensiveList[index])
                              .toString())
                              .appCommonText(
                              color: Theme
                                  .of(context)
                                  .highlightColor,
                              weight: FontWeight.w700,
                              align: TextAlign.center,
                              size: MediaQuery
                                  .of(context)
                                  .size
                                  .height * .014),
                          Visibility(
                            visible: (PreferenceManager
                                .getSubscriptionActive() ?? "0") == "1",
                            child: (!con.isTeamReportTab
                                ? ' (${dateWidget(
                                gameDetails.nbaHomeOffensiveRank.isEmpty ? "0" :
                                gameDetails.nbaHomeOffensiveRank[index])})'
                                .toString()
                                : ' (${dateWidget(
                                gameDetails.nbaHomeDefensiveRank.isEmpty ? "0" :
                                gameDetails.nbaHomeDefensiveRank[index])})'
                                .toString())
                                .appCommonText(
                                // Apply NCAAB thresholds to MLB as well
                                color: !con.isTeamReportTab ? gameDetails
                                    .nbaHomeOffensiveRank.isEmpty ? Colors
                                    .transparent : int.parse(
                                    gameDetails.nbaHomeOffensiveRank[index]) <=
                                    (sportKey == SportName.NCAAB.name || sportKey == SportName.MLB.name ? 50 : 11)
                                    ? Colors.green
                                    : (int.parse(
                                    gameDetails.nbaHomeOffensiveRank[index]) >
                                    (sportKey == SportName.NCAAB.name || sportKey == SportName.MLB.name ? 50 : 11) &&
                                    int.parse(
                                        gameDetails
                                            .nbaHomeOffensiveRank[index]) <=
                                        (sportKey == SportName.NCAAB.name || sportKey == SportName.MLB.name ? 75 : 22))
                                    ? yellowColor
                                    : redColor :
                                gameDetails.nbaHomeDefensiveRank.isEmpty
                                    ? Colors
                                    .transparent
                                    : int.parse(
                                    gameDetails.nbaHomeDefensiveRank[index]) <=
                                    (sportKey == SportName.NCAAB.name || sportKey == SportName.MLB.name ? 50 : 11)
                                    ? Colors.green
                                    : (int.parse(
                                    gameDetails.nbaHomeDefensiveRank[index]) >
                                    (sportKey == SportName.NCAAB.name || sportKey == SportName.MLB.name ? 50 : 11) &&
                                    int.parse(
                                        gameDetails
                                            .nbaHomeDefensiveRank[index]) <=
                                        (sportKey == SportName.NCAAB.name || sportKey == SportName.MLB.name ? 75 : 22))
                                    ? yellowColor
                                    : redColor,

                                weight: FontWeight.w700,
                                align: TextAlign.center,
                                size: MediaQuery
                                    .of(context)
                                    .size
                                    .height * .014),
                          )
                        ],
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: (con.isTeamReportTab
                            ? mobileView.size.shortestSide < 600 ? con
                            .nbaMobileDefensive[index] : con.nbaDefensive[index]
                            : con.nbaOffensive[index])
                            .toString()
                            .appCommonText(
                            color: darkGreyColor,
                            align: TextAlign.center,
                            weight: FontWeight.w600,
                            size: MediaQuery
                                .of(context)
                                .size
                                .height * .012),
                      ),
                    ],
                  ).paddingSymmetric(
                      vertical: MediaQuery
                          .of(context)
                          .size
                          .height * .003)
              ),
            ],
          ),
          /*&&PreferenceManager.getSubscriptionRecUrl()!=null*/
          Visibility(
            visible: (PreferenceManager.getSubscriptionActive() ?? "0") == "1",
            // Apply NCAAB thresholds to MLB as well
            child: ((offensePointColor >= (sportKey == SportName.NCAAB.name || sportKey == SportName.MLB.name ? 50 : 15) ||
                offensePointColor <= (sportKey == SportName.NCAAB.name || sportKey == SportName.MLB.name ? -50 : -15))) ?

            Positioned(
              child: InkWell(
                highlightColor: Colors.transparent,
                splashFactory: NoSplash.splashFactory,
                onTap: () {
                  showDialogForRank(
                      context, sportKey: sportKey,
                      awayText: '${awayTeam?.abbreviation} ${(con
                          .isTeamReportTab
                          ? con.nbaOffensive[index]
                          : mobileView.size.shortestSide < 600 ? con
                          .nbaMobileDefensive[index] : con
                          .nbaDefensive[index])} ranks',
                      awayRank: con.isTeamReportTab ? (gameDetails
                          .nbaAwayOffensiveRank.isEmpty
                          ? "0"
                          : gameDetails
                          .nbaAwayOffensiveRank[index]) : (gameDetails
                          .nbaAwayDefensiveRank.isEmpty
                          ? '0'
                          : gameDetails.nbaAwayDefensiveRank[index]),
                      homeText: '${homeTeam?.abbreviation} ${(con
                          .isTeamReportTab
                          ? mobileView.size.shortestSide < 600 ? con
                          .nbaMobileDefensive[index] : con.nbaDefensive[index]
                          : con.nbaOffensive[index])} ranks',
                      homeRank:
                      con.isTeamReportTab
                          ? (gameDetails.nbaHomeDefensiveRank.isEmpty ? "0" :
                      gameDetails.nbaHomeDefensiveRank[index])
                          : (gameDetails.nbaHomeOffensiveRank.isEmpty ? "0" :
                      gameDetails.nbaHomeOffensiveRank[index])
                  );
                },
                child: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * .038, width: MediaQuery
                    .of(context)
                    .size
                    .height * .038,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    // Apply NCAAB thresholds to MLB as well
                    color: (offensePointColor >=
                        (sportKey == SportName.NCAAB.name || sportKey == SportName.MLB.name ? 75 : 25) ||
                        offensePointColor <= (sportKey == SportName.NCAAB.name || sportKey == SportName.MLB.name ? -75 : -25))
                        ? Colors.red
                        : Colors
                        .orange,
                  ),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                          Assets.assetsImagesFire, fit: BoxFit.contain,
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * .028),
                    ],
                  ),
                ),
              ),
            ) : const SizedBox(),
          )
        ],
      );
    },
    padding: EdgeInsets.zero,
    physics: const BouncingScrollPhysics(),
    shrinkWrap: true,
    itemCount: con.nbaOffensive.length,
    separatorBuilder: (BuildContext context, int index) {
      return commonDivider(context);
    },
  );
}

Widget quarterBacksData(GameDetailsController con, BuildContext context,
    SportEvents gameDetails, String sportKey) {
  return ListView.separated(
    itemBuilder: (context, index) {
      int offensePointColor = 0;
      if ((PreferenceManager.getSubscriptionActive() ?? "0") == "1") {
        offensePointColor = (con.isTeamReportTab ? (int.tryParse(
            gameDetails.homeQbDefenseRank.isEmpty ? "0" : gameDetails
                .homeQbDefenseRank[index]) ?? 0) - (int.tryParse(
            gameDetails.awayQbRank.isEmpty ? "0" : gameDetails
                .awayQbRank[index]) ?? 0) :
        (int.tryParse(gameDetails.homeQbRank.isEmpty ? "0" : gameDetails
            .homeQbRank[index]) ?? 0) - (int.tryParse(
            gameDetails.awayQbDefenseRank.isEmpty ? "0" : gameDetails
                .awayQbDefenseRank[index]) ?? 0));
      }
      return Stack(
        alignment: Alignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        (gameDetails.awayQb.isEmpty ||
                            gameDetails.awayDefense.isEmpty
                            ? "0"
                            : con.isTeamReportTab
                            ? gameDetails.awayQb[index]
                            : gameDetails.awayDefense[index])
                            .appCommonText(
                            color: Theme
                                .of(context)
                                .highlightColor,
                            weight: FontWeight.w700,
                            align: TextAlign.center,
                            size: MediaQuery
                                .of(context)
                                .size
                                .height * .014),
                        Visibility(
                          visible: (PreferenceManager.getSubscriptionActive() ??
                              "0") == "1",
                          child: (gameDetails.awayQbRank.isEmpty ||
                              gameDetails.awayQbDefenseRank.isEmpty
                              ? ""
                              : con.isTeamReportTab
                              ? ' (${dateWidget(
                              gameDetails.awayQbRank[index])})'
                              : ' (${dateWidget(
                              gameDetails.awayQbDefenseRank[index])})')
                              .appCommonText(
                              color: (gameDetails.awayQbRank.isEmpty ||
                                  gameDetails.awayQbDefenseRank.isEmpty)
                                  ? redColor : con.isTeamReportTab ?
                              (int.tryParse(gameDetails.awayQbRank[index]) ??
                                  0) <= 11
                                  ? Colors.green
                                  : ((int.tryParse(
                                  gameDetails.awayQbRank[index]) ?? 0) <=
                                  22 &&
                                  (int.tryParse(
                                      gameDetails.awayQbRank[index]) ?? 0) > 11)
                                  ? yellowColor
                                  : redColor
                                  : (int.tryParse(
                                  gameDetails.awayQbDefenseRank[index]) ??
                                  0) <= 11 ? Colors.green : ((int.tryParse(
                                  gameDetails.awayQbDefenseRank[index]) ?? 0) <=
                                  22 &&
                                  (int.tryParse(
                                      gameDetails.awayQbDefenseRank[index]) ??
                                      0) > 11) ? yellowColor : redColor,
                              weight: FontWeight.w700,
                              align: TextAlign.center,
                              size: MediaQuery
                                  .of(context)
                                  .size
                                  .height * .014),
                        ),
                      ],
                    ),
                    (con.isTeamReportTab
                        ? con.teamQuarterBacks[index]
                        : con.teamQuarterBacksDefence[index])
                        .toString()
                        .appCommonText(
                        color: darkGreyColor,
                        align: TextAlign.center,
                        weight: FontWeight.w600,
                        size: MediaQuery
                            .of(context)
                            .size
                            .height * .012),
                  ],
                ).paddingSymmetric(
                    vertical: MediaQuery
                        .of(context)
                        .size
                        .height * .003),
              ),
              Container(
                width: 1,
                height: MediaQuery
                    .of(context)
                    .size
                    .height * .044,
                color: Theme
                    .of(context)
                    .indicatorColor,
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        (gameDetails.homeQb.isEmpty ||
                            gameDetails.homeDefense.isEmpty
                            ? "0"
                            : con.isTeamReportTab
                        // : !gameDetails.isQuarterBacksTab
                            ? gameDetails.homeDefense[index]
                            : gameDetails.homeQb[index])
                            .appCommonText(
                            color: Theme
                                .of(context)
                                .highlightColor,
                            weight: FontWeight.w700,
                            align: TextAlign.center,
                            size: MediaQuery
                                .of(context)
                                .size
                                .height * .014),
                        Visibility(
                          visible: (PreferenceManager.getSubscriptionActive() ??
                              "0") == "1",
                          child: (gameDetails.homeQbDefenseRank.isEmpty ||
                              gameDetails.homeQbRank.isEmpty
                              ? ""
                              : con.isTeamReportTab
                          // : !con.isQuarterBacksTab
                              ? ' (${dateWidget(
                              gameDetails.homeQbDefenseRank[index])})'
                              : ' (${dateWidget(
                              gameDetails.homeQbRank[index])})')
                              .appCommonText(
                              color: (gameDetails.homeQbDefenseRank.isEmpty ||
                                  gameDetails.homeQbRank.isEmpty)
                                  ? redColor
                                  : con.isTeamReportTab ?
                              (int.tryParse(
                                  gameDetails.homeQbDefenseRank[index]) ?? 0) <=
                                  11 ? Colors.green : ((int.tryParse(
                                  gameDetails.homeQbDefenseRank[index]) ?? 0) <=
                                  22 &&
                                  (int.tryParse(
                                      gameDetails.homeQbDefenseRank[index]) ??
                                      0) > 11) ? yellowColor : redColor
                                  : (int.tryParse(
                                  gameDetails.homeQbRank[index]) ?? 0) <=
                                  11 ? Colors.green : ((int.tryParse(
                                  gameDetails.homeQbRank[index]) ?? 0) <= 22 &&
                                  (int.tryParse(
                                      gameDetails.homeQbRank[index]) ?? 0) > 11)
                                  ? yellowColor
                                  : redColor,

                              weight: FontWeight.w700,
                              align: TextAlign.center,
                              size: MediaQuery
                                  .of(context)
                                  .size
                                  .height * .014),
                        ),
                      ],
                    ),
                    (con.isTeamReportTab
                        ? con.teamQuarterBacksDefence[index]
                        : con.teamQuarterBacks[index])
                        .toString()
                        .appCommonText(
                        color: darkGreyColor,
                        align: TextAlign.center,
                        weight: FontWeight.w600,
                        size: MediaQuery
                            .of(context)
                            .size
                            .height * .012),
                  ],
                ).paddingSymmetric(
                    vertical: MediaQuery
                        .of(context)
                        .size
                        .height * .003),
              ),
            ],
          ),
          ((PreferenceManager.getSubscriptionActive() ?? "0") == "1") &&
              ((offensePointColor >= 15 || offensePointColor <= -15)) ?

          Positioned(
            child: InkWell(
              highlightColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory,
              onTap: () {
                showDialogForRank(
                  context, sportKey: sportKey,
                  awayText: '${con
                      .isTeamReportTab
                      ? gameDetails.awayPlayerName
                      : "Defense"} ${ (con
                      .isTeamReportTab
                      ? con.teamQuarterBacks[index]
                      : con.teamQuarterBacksDefence[index])} ranks',
                  awayRank: (gameDetails.awayQbRank.isEmpty ||
                      gameDetails.awayQbDefenseRank.isEmpty
                      ? "0"
                      : con.isTeamReportTab
                      ? gameDetails.awayQbRank[index]
                      : gameDetails.awayQbDefenseRank[index]),
                  homeText: '${con
                      .isTeamReportTab ? "Defense" : gameDetails
                      .homePlayerName} ${(con
                      .isTeamReportTab
                      ? con.teamQuarterBacksDefence[index]
                      : con.teamQuarterBacks[index])} ranks',
                  homeRank:
                  (gameDetails.homeQbRank.isEmpty ||
                      gameDetails.homeQbDefenseRank.isEmpty
                      ? "0"
                      : con.isTeamReportTab
                      ? gameDetails.homeQbDefenseRank[index]
                      : gameDetails.homeQbRank[index]),
                );
              },
              child: Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * .038, width: MediaQuery
                  .of(context)
                  .size
                  .height * .038,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (offensePointColor >= 25 ||
                      offensePointColor <= -25) ? Colors.red : Colors
                      .orange,
                ),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                        Assets.assetsImagesFire, fit: BoxFit.contain,
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * .028),
                  ],
                ),
              ),
            ),
          ) : const SizedBox(),
        ],
      );
    },
    separatorBuilder: (context, index) {
      return commonDivider(context);
    },
    itemCount: con.teamQuarterBacks.length,
    padding: EdgeInsets.zero,
    physics: const BouncingScrollPhysics(),
    shrinkWrap: true,);
}

class HeaderTab extends StatelessWidget {
  const HeaderTab({Key? key,
    required this.isSelected,
    required this.awayText,
    required this.homeText,
    this.awayTeam,
    this.homeTeam,
    this.isTeamStat = false,
    required this.gameDetails,
    this.color,
    required this.title,
    this.awayOnTap,
    this.homeOnTap})
      : super(key: key);
  final bool isSelected;
  final String awayText;
  final String homeText;
  final String title;
  final Competitors? awayTeam;
  final Competitors? homeTeam;
  final SportEvents gameDetails;
  final void Function()? awayOnTap;
  final void Function()? homeOnTap;
  final Color? color;
  final bool? isTeamStat;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * .046,
        width: Get.width,
        decoration: BoxDecoration(
          color: Theme
              .of(context)
              .disabledColor,
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(MediaQuery
                  .of(context)
                  .size
                  .width * .01)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * .004,
              width: Get.width,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    // onTap: awayOnTap,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        commonCachedNetworkImage(
                          width: Get.height * .025,
                          height: Get.height * .025,
                          imageUrl: awayLogo(awayTeam, gameDetails),
                        ),
                        SizedBox(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * .01,
                        ),
                        awayText.length >= 18
                            ? Container(
                          width: 150.h,
                          alignment: Alignment.centerLeft,
                          child: (awayText).appCommonText(
                            weight: FontWeight.bold,
                            maxLine: 2,
                            size:
                            MediaQuery
                                .of(context)
                                .size
                                .height * .013,
                            align: TextAlign.start,
                            color: Theme
                                .of(context)
                                .cardColor,
                          ),
                        )
                            : (awayText).appCommonText(
                          weight: FontWeight.bold,
                          maxLine: 2,
                          size: MediaQuery
                              .of(context)
                              .size
                              .height * .013,
                          align: TextAlign.start,
                          color: Theme
                              .of(context)
                              .cardColor,
                        ),
                      ],
                    ).paddingSymmetric(
                        vertical: MediaQuery
                            .of(context)
                            .size
                            .height * .006),
                  ),
                ),
                Expanded(
                  flex: isTeamStat ?? false ? 2 : 1,
                  child: title.appCommonText(
                    weight: FontWeight.bold,
                    align: TextAlign.center,
                    size: MediaQuery
                        .of(context)
                        .size
                        .height * .018,
                    color: Theme
                        .of(context)
                        .cardColor,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    // onTap: homeOnTap,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        (homeText).appCommonText(
                          weight: FontWeight.bold,
                          maxLine: 1,
                          size: MediaQuery
                              .of(context)
                              .size
                              .height * .014,
                          align: TextAlign.start,
                          color: Theme
                              .of(context)
                              .cardColor,
                        ),
                        SizedBox(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * .01,
                        ),
                        commonCachedNetworkImage(
                          width: Get.height * .025,
                          height: Get.height * .025,
                          imageUrl: homeLogo(homeTeam, gameDetails),
                        ),
                      ],
                    ).paddingSymmetric(
                        vertical: MediaQuery
                            .of(context)
                            .size
                            .height * .006),
                  ),
                ),
              ],
            ),
            isSelected
                ? Row(
              children: [
                Expanded(
                  child: Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * .004,
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
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * .004,
                    width: Get.width,
                    color: yellowColor,
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}

SizedBox receivingAwayPlayerCard(BuildContext context, SportEvents gameDetails,
    int index, num totalPlay) {
  return SizedBox(
    // height: MediaQuery.sizeOf(context).height * .034,
    child: Row(
      children: [
        _buildStatCell(
          context,
          gameDetails.nflAwayReceiversPlayer[index].name ?? '',
          color: blueColor,
          textAlign: TextAlign.start,
          flex: 3,
        ),
        _buildStatCell(
          context,
          _calculateStat(
            gameDetails.nflAwayReceiversPlayer[index].receiving
                ?.touchdownsPerGame,
            1,
          ),
          color: Theme
              .of(context)
              .highlightColor,
          textAlign: TextAlign.end,
          flex: 2,
        ),
        _buildStatCell(
          context,
          _calculateStat(
            gameDetails.nflAwayReceiversPlayer[index].receiving?.yards,
            totalPlay,
          ),
          color: Theme
              .of(context)
              .highlightColor,
          textAlign: TextAlign.end,
          flex: 2,
        ),
        _buildStatCell(
          context,
          _calculateStat(
            gameDetails.nflAwayReceiversPlayer[index].receiving?.receptions,
            totalPlay,
          ),
          color: Theme
              .of(context)
              .highlightColor,
          textAlign: TextAlign.end,
          flex: 2,
        ),
      ],
    ).paddingSymmetric(
        horizontal: MediaQuery
            .sizeOf(context)
            .width * .015,
        vertical: MediaQuery
            .sizeOf(context)
            .width * .01),
  );
}

Widget _buildStatCell(BuildContext context,
    String text, {
      required Color color,
      required TextAlign textAlign,
      required int flex,
    }) {
  return Expanded(
    flex: flex,
    child: text
        .appCommonText(
      color: color,
      align: textAlign,
      weight: FontWeight.w400,
      size: MediaQuery
          .sizeOf(context)
          .height * .014,
    ),
  );
}

String _calculateStat(num? value, num totalPlay) {
  if (value == null) return '0';
  return ((value / totalPlay).toStringAsFixed(1) == '0.0' ? "0" : (value /
      totalPlay).toStringAsFixed(1));
}

SizedBox receivingHomePlayerCard(BuildContext context, SportEvents gameDetails,
    int index, num totalPlay) {
  return SizedBox(
    // height: MediaQuery.sizeOf(context).height * .034,
    child: Row(
      children: [
        Expanded(
            flex: 3,
            child: ('${gameDetails.nflHomeReceiversPlayer[index].name}')
                .toString()
                .appCommonText(
                color: blueColor,
                align: TextAlign.start,
                weight: FontWeight.w400,
                size: MediaQuery
                    .sizeOf(context)
                    .height * .014)),
        Expanded(
            flex: 2,
            child: _calculateStat(
              gameDetails.nflHomeReceiversPlayer[index].receiving
                  ?.touchdownsPerGame,
              1,
            )
                .toString()
                .appCommonText(
                color: Theme
                    .of(context)
                    .highlightColor,
                align: TextAlign.end,
                weight: FontWeight.w400,
                size: MediaQuery
                    .sizeOf(context)
                    .height * .014)),
        Expanded(
            flex: 2,
            child: _calculateStat(
              gameDetails.nflHomeReceiversPlayer[index].receiving?.yards,
              totalPlay,
            ).appCommonText(
                color: Theme
                    .of(context)
                    .highlightColor,
                align: TextAlign.end,
                weight: FontWeight.w400,
                size: MediaQuery
                    .sizeOf(context)
                    .height * .014)),
        Expanded(
            flex: 2,
            child: _calculateStat(
              gameDetails.nflHomeReceiversPlayer[index].receiving?.receptions,
              totalPlay,
            ).toString()
                .appCommonText(
                color: Theme
                    .of(context)
                    .highlightColor,
                align: TextAlign.end,
                weight: FontWeight.w400,
                size: MediaQuery
                    .sizeOf(context)
                    .height * .014)),
      ],
    ).paddingSymmetric(
        horizontal: MediaQuery
            .sizeOf(context)
            .width * .015,
        vertical: MediaQuery
            .sizeOf(context)
            .width * .01),
  );
}

ListView hitterPlayerDetailCard(GameDetailsController con) {
  return ListView.separated(
    shrinkWrap: true,
    padding: EdgeInsets.zero,
    physics: const BouncingScrollPhysics(),
    itemBuilder: (context, i) {
      con.hitterAwayPlayerMainList.sort(
              (HitterPlayerStatMainModel a, HitterPlayerStatMainModel b) =>
              int.parse(b.ab).compareTo(int.parse(a.ab)));
      con.hitterHomePlayerMainList
          .sort((b, a) => int.parse(a.ab).compareTo(int.parse(b.ab)));
      return con.isTeamReportTab
          ? ExpandableNotifier(
        initialExpanded: i == con.isExpand,
        child: ScrollOnExpand(
          child: Column(
            children: [
              ExpandablePanel(
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
                          title2: con.hitterAwayPlayerMainList[i].hAb,
                          value2: con.hitterAwayPlayerMainList[i].hAbValue),
                    ],
                  )
              )
            ],
          ),
        ),
      )
          : ExpandableNotifier(
        key: Key(i.toString()),
        initialExpanded: i == con.isExpand,
        child: ScrollOnExpand(
          child: Column(
            children: [
              ExpandablePanel(
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
                        title2: con.hitterHomePlayerMainList[i].hAb,
                        value2: con.hitterHomePlayerMainList[i].hAbValue),
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
    itemCount: con.isTeamReportTab
        ? con.hitterAwayPlayerMainList.length
        : con.hitterHomePlayerMainList.length,
  );
}

ListView runningBacksCard(GameDetailsController con,
    SportEvents gameDetails,) {
  return ListView.separated(
    shrinkWrap: true,
    padding: EdgeInsets.zero,
    physics: const BouncingScrollPhysics(),
    itemBuilder: (context, i) {
      num totalPlay = (con.isTeamReportTab
          ? (gameDetails.nflAwayRunningBackPlayer[i].gamesPlayed == 0
          ? 1
          : (gameDetails.nflAwayRunningBackPlayer[i].gamesPlayed ??
          1))
          : (gameDetails.nflHomeRunningBackPlayer[i].gamesPlayed == 0
          ? 1
          : (gameDetails.nflHomeRunningBackPlayer[i].gamesPlayed ??
          1)));

      sortRushingPlayer(gameDetails);
      return con.isTeamReportTab
          ? ExpandableNotifier(
        initialExpanded: i == con.isExpand,
        child: ScrollOnExpand(
          child: Column(
            children: [
              ExpandablePanel(
                  theme: const ExpandableThemeData(hasIcon: false),
                  header: runningAwayHeader(
                      context, i, con, gameDetails, totalPlay),
                  collapsed: const SizedBox(),
                  expanded: Column(
                    children: [
                      expandableTileCardRunning(context, con,
                          value1: gameDetails
                              .nflAwayRunningBackPlayer[i]
                              .receiving != null ? ((int.parse(gameDetails
                              .nflAwayRunningBackPlayer[i]
                              .receiving
                              ?.yards
                              .toString() ??
                              "0") /
                              totalPlay)
                              .toStringAsFixed(1)) : "0",
                          title1: 'Rec Yds/Game',
                          title2: 'Rush TDs/Game',
                          value2: gameDetails
                              .nflAwayRunningBackPlayer[i]
                              .rushing != null ? ((int.parse(gameDetails
                              .nflAwayRunningBackPlayer[i]
                              .rushing
                              ?.touchdowns
                              .toString() ??
                              "0") /
                              totalPlay)
                              .toStringAsFixed(1)) : "0"),
                      expandableTileCardRunning(context, con,
                          value1: gameDetails
                              .nflAwayRunningBackPlayer[i]
                              .receiving != null ? (((int.parse(gameDetails
                              .nflAwayRunningBackPlayer[i]
                              .receiving
                              ?.yards
                              .toString() ??
                              "0") + int.parse(gameDetails
                              .nflAwayRunningBackPlayer[i]
                              .rushing
                              ?.yards
                              .toString() ??
                              "0")) /
                              totalPlay)
                              .toStringAsFixed(1)) : "0",
                          title1: 'All Purp Yrd/Game',
                          title2: 'Longest Run',
                          value2:
                          '${gameDetails.nflAwayRunningBackPlayer[i].rushing
                              ?.longest ?? "0"}'),
                      expandableTileCardRunning(context, con,
                          value1: gameDetails
                              .nflAwayRunningBackPlayer[i]
                              .receiving != null ? ((int.parse(gameDetails
                              .nflAwayRunningBackPlayer[i]
                              .receiving
                              ?.touchdowns
                              .toString() ??
                              "0") /
                              totalPlay)
                              .toStringAsFixed(1)) : "0",
                          title1: 'Rec TDs/Game',
                          title2: 'Fumbles/Game',
                          value2:
                          ((gameDetails.nflAwayRunningBackPlayer[i].fumbles
                              ?.fumbles ?? 1) / totalPlay).toStringAsFixed(1)),
                      expandableTileCardRunning(context, con,
                          value1: gameDetails
                              .nflAwayRunningBackPlayer[i]
                              .rushing != null ? (num.parse(gameDetails
                              .nflAwayRunningBackPlayer[i]
                              .rushing
                              ?.avgYards
                              .toString() ??
                              '0')
                              .toStringAsFixed(1)) : "0",
                          title1: 'Average Carry',
                          title2: '',
                          value2: ""),
                    ],
                  ))
            ],
          ),
        ),
      ) : ExpandableNotifier(
        key: Key(i.toString()),
        initialExpanded: i == con.isExpand,
        child: ScrollOnExpand(
          child: Column(
            children: [
              ExpandablePanel(
                theme: const ExpandableThemeData(hasIcon: false),
                header: runningHomeHeader(
                    context, i, con, gameDetails, totalPlay),
                collapsed: const SizedBox(),
                expanded: Column(
                  children: [
                    expandableTileCardRunning(context, con,
                        value1: gameDetails
                            .nflHomeRunningBackPlayer[i]
                            .receiving != null ? ((int.parse(gameDetails
                            .nflHomeRunningBackPlayer[i]
                            .receiving
                            ?.yards
                            .toString() ??
                            "0") /
                            totalPlay)
                            .toStringAsFixed(1)) : "0",
                        title1: 'Rec Yds/Game',
                        title2: 'Rush TDs/Game',
                        value2: gameDetails
                            .nflHomeRunningBackPlayer[i]
                            .rushing != null ? ((int.parse(gameDetails
                            .nflHomeRunningBackPlayer[i]
                            .rushing
                            ?.touchdowns
                            .toString() ??
                            "0") /
                            totalPlay)
                            .toStringAsFixed(1)) : "0"),
                    expandableTileCardRunning(context, con,
                        value1: gameDetails
                            .nflHomeRunningBackPlayer[i]
                            .receiving != null ? (((int.parse(gameDetails
                            .nflHomeRunningBackPlayer[i]
                            .receiving
                            ?.yards
                            .toString() ??
                            "0") + int.parse(gameDetails
                            .nflHomeRunningBackPlayer[i]
                            .rushing
                            ?.yards
                            .toString() ??
                            "0")) /
                            totalPlay)
                            .toStringAsFixed(1)) : "0",
                        title1: 'All Purp Yrd/Game',
                        title2: 'Longest Run',
                        value2:
                        '${gameDetails.nflHomeRunningBackPlayer[i].rushing
                            ?.longest ?? "0"}'),
                    expandableTileCardRunning(context, con,
                        value1: gameDetails
                            .nflHomeRunningBackPlayer[i]
                            .receiving != null ? ((int.parse(gameDetails
                            .nflHomeRunningBackPlayer[i]
                            .receiving
                            ?.touchdowns
                            .toString() ??
                            "0") /
                            totalPlay)
                            .toStringAsFixed(1)) : "0",
                        title1: 'Rec TDs/Game',
                        title2: 'Fumbles/Game',
                        value2:
                        ((gameDetails.nflHomeRunningBackPlayer[i].fumbles
                            ?.fumbles ?? 1) / totalPlay).toStringAsFixed(1)),
                    expandableTileCardRunning(context, con,
                        value1: gameDetails
                            .nflHomeRunningBackPlayer[i]
                            .rushing != null ? (num.parse(gameDetails
                            .nflHomeRunningBackPlayer[i]
                            .rushing
                            ?.avgYards
                            .toString() ??
                            '0')
                            .toStringAsFixed(1)) : "0",
                        title1: 'Average Carry',
                        title2: '',
                        value2:
                        ""),
                  ],
                ),
              ),
            ]
            ,
          )
          ,
        )
        ,
      );
    },
    separatorBuilder: (BuildContext context, int index) {
      return commonDivider(context);
    },
    itemCount: con.isTeamReportTab
        ? gameDetails.nflAwayRunningBackPlayer.length
        : gameDetails.nflHomeRunningBackPlayer.length,
  );
}

sortRushingPlayer(SportEvents gameDetails) {
  // Sort home running backs by touchdowns first, then by yards if touchdowns are null or zero
  gameDetails.nflHomeRunningBackPlayer.sort((a, b) {
    // Extract touchdowns or default to 0 if null
    num touchdownsA = a.rushing?.touchdowns ?? 0;
    num touchdownsB = b.rushing?.touchdowns ?? 0;

    if (touchdownsA != touchdownsB) {
      return touchdownsB.compareTo(
          touchdownsA); // Sort by touchdowns descending
    }

    // If touchdowns are equal or both are zero/null, sort by yards
    num yardsA = a.rushing?.yards ?? 0;
    num yardsB = b.rushing?.yards ?? 0;
    return yardsB.compareTo(yardsA); // Sort by yards descending
  });

// Sort away running backs by touchdowns first, then by yards if touchdowns are null or zero
  gameDetails.nflAwayRunningBackPlayer.sort((a, b) {
    // Extract touchdowns or default to 0 if null
    num touchdownsA = a.rushing?.touchdowns ?? 0;
    num touchdownsB = b.rushing?.touchdowns ?? 0;

    if (touchdownsA != touchdownsB) {
      return touchdownsB.compareTo(
          touchdownsA); // Sort by touchdowns descending
    }

    // If touchdowns are equal or both are zero/null, sort by yards
    num yardsA = a.rushing?.yards ?? 0;
    num yardsB = b.rushing?.yards ?? 0;
    return yardsB.compareTo(yardsA); // Sort by yards descending
  });
}

ListView nbaRushingCard(GameDetailsController con,
    SportEvents gameDetails,) {
  return ListView.separated(
    shrinkWrap: true,
    padding: EdgeInsets.zero,
    physics: const BouncingScrollPhysics(),
    itemBuilder: (context, i) {
      return con.isTeamReportTab
          ? ExpandableNotifier(
        initialExpanded: i == con.isExpand,
        child: ScrollOnExpand(
          child: Column(
            children: [
              ExpandablePanel(
                theme: const ExpandableThemeData(hasIcon: false),
                header: nbaAwayHeader(
                  context,
                  i,
                  con,
                  gameDetails,
                ),
                collapsed: const SizedBox(),
                expanded: Column(
                  children: [
                    expandableTileCardRunning(context, con,
                        value1: ((average(gameDetails, i)
                            ?.blocks ??
                            0)
                            .toStringAsFixed(1)),
                        title1: 'Blocks/Gm',
                        title2: 'Steals/Gm',
                        value2: ((average(gameDetails, i)
                            ?.steals ??
                            0)
                            .toStringAsFixed(1))),
                    /* expandableTileCardRunning(context, con,
                        value1: (gameDetails.awayRushingPlayer[i].average
                            ?.minutes ??
                            0)
                            .toStringAsFixed(1),
                        title1: 'Minutes/Game',
                        title2: 'Turnovers/Game',
                        value2: (gameDetails.awayRushingPlayer[i].average
                            ?.turnovers ??
                            0)
                            .toStringAsFixed(1)),*/
                    expandableTileCardRunning(context, con,
                        value1:
                        '${(average(gameDetails, i)
                            ?.fieldGoalsMade ?? 0).round()}/${(average(
                            gameDetails, i)
                            ?.fieldGoalsAtt ?? 0).round()} (${(average(
                            gameDetails, i)
                            ?.fieldGoalsAtt ?? 0).round() > 0 ? (((average(
                            gameDetails, i)
                            ?.fieldGoalsMade ?? 0).round() /
                            (average(gameDetails, i)
                                ?.fieldGoalsAtt ?? 0).round()) * 100)
                            .toStringAsFixed(0) : "0"}%)',
                        title1: 'FG/Gm',
                        title2: 'FT/Gm',
                        value2: '${(average(gameDetails, i)
                            ?.freeThrowsMade ?? 0).round()}/${(average(
                            gameDetails, i)
                            ?.freeThrowsAtt ?? 0).round()} (${(average(
                            gameDetails, i)
                            ?.freeThrowsAtt ?? 0).round() > 0 ? (((average(
                            gameDetails, i)
                            ?.freeThrowsMade ?? 0).round() /
                            (average(gameDetails, i)
                                ?.freeThrowsAtt ?? 0).round()) * 100)
                            .toStringAsFixed(0) : "0"}%)'),
                    expandableTileCardRunning(context, con,
                        value1:
                        '${(average(gameDetails, i)
                            ?.threePointsMade ?? 0).round()}/${(average(
                            gameDetails, i)
                            ?.threePointsAtt ?? 0).round()} (${(average(
                            gameDetails, i)
                            ?.threePointsAtt ?? 0).round() > 0 ? (((average(
                            gameDetails, i)
                            ?.threePointsMade ?? 0).round() /
                            (average(gameDetails, i)
                                ?.threePointsAtt ?? 0).round()) * 100)
                            .toStringAsFixed(0) : "0"}%)',
                        title1: '3Pt/Gm',
                        title2: /*'Player +/-'*/"",
                        value2:
                        /*(((gameDetails.awayRushingPlayer[i].total
                            ?.plus ??
                            0) -
                            (gameDetails.awayRushingPlayer[i]
                                .total?.minus ??
                                0)) /
                            (gameDetails.awayRushingPlayer[i].total
                                ?.gamesPlayed ??
                                1))
                            .toStringAsFixed(1)*/""),
                    /*expandableTileCardRunning(context, con,
                        value1: ('${((gameDetails.awayRushingPlayer[i].total
                            ?.trueShootingPct ?? 0) * (100)).round()}%')
                            .toString(),
                        title1: 'True Shooting',
                        title2: '',
                        value2: ("").toString()),*/
                  ],
                ),
              ),
            ],
          ),
        ),
      )
          : ExpandableNotifier(
        key: Key(i.toString()),
        initialExpanded: i == con.isExpand,
        child: ScrollOnExpand(
          child: Column(
            children: [
              ExpandablePanel(
                theme: const ExpandableThemeData(hasIcon: false),
                header: nbaHomeHeader(
                  context,
                  i,
                  con,
                  gameDetails,
                ),
                collapsed: const SizedBox(),
                expanded: Column(
                  children: [
                    expandableTileCardRunning(context, con,
                        value1: ((homeAverage(gameDetails, i)
                            ?.blocks ??
                            0)
                            .toStringAsFixed(1)),
                        title1: 'Blocks/Gm',
                        title2: 'Steals/Gm',
                        value2: ((homeAverage(gameDetails, i)
                            ?.steals ??
                            0)
                            .toStringAsFixed(1))), /*
                    expandableTileCardRunning(context, con,
                        value1: (gameDetails.homeRushingPlayer[i].average
                            ?.minutes ??
                            0)
                            .toStringAsFixed(1),
                        title1: 'Minutes/Game',
                        title2: 'Turnovers/Game',
                        value2: (gameDetails.homeRushingPlayer[i].average
                            ?.turnovers ??
                            0)
                            .toStringAsFixed(1)),*/
                    expandableTileCardRunning(
                      context,
                      con,
                      value1:
                      '${(homeAverage(gameDetails, i)
                          ?.fieldGoalsMade ?? 0).round()}/${(homeAverage(
                          gameDetails, i)
                          ?.fieldGoalsAtt ?? 0).round()} (${(homeAverage(
                          gameDetails, i)
                          ?.fieldGoalsAtt ?? 0).round() > 0 ? ((((homeAverage(
                          gameDetails, i)
                          ?.fieldGoalsMade ?? 0).round()) /
                          ((homeAverage(gameDetails, i)
                              ?.fieldGoalsAtt ?? 0).round())) * 100)
                          .toStringAsFixed(0) : "0"}%)',
                      title1: 'FG/Gm',
                      title2: 'FT/Gm',
                      value2:
                      '${(homeAverage(gameDetails, i)
                          ?.freeThrowsMade ?? 0).round()}/${(homeAverage(
                          gameDetails, i)
                          ?.freeThrowsAtt ?? 0).round()} (${(homeAverage(
                          gameDetails, i)
                          ?.freeThrowsAtt ?? 0).round() > 0 ? ((((homeAverage(
                          gameDetails, i)
                          ?.freeThrowsMade ?? 0).round()) /
                          ((homeAverage(gameDetails, i)
                              ?.freeThrowsAtt ?? 0).round())) * 100)
                          .toStringAsFixed(0) : "0"}%)',
                    ),
                    expandableTileCardRunning(
                      context,
                      con,
                      value1:
                      '${(homeAverage(gameDetails, i)
                          ?.threePointsMade ?? 0).round()}/${(homeAverage(
                          gameDetails, i)
                          ?.threePointsAtt ?? 0).round()} (${(homeAverage(
                          gameDetails, i)
                          ?.threePointsAtt ?? 0).round() > 0 ? ((((homeAverage(
                          gameDetails, i)
                          ?.threePointsMade ?? 0).round()) /
                          ((homeAverage(gameDetails, i)
                              ?.threePointsAtt ?? 0).round())) * 100)
                          .toStringAsFixed(0) : "0"}%)',
                      title1: '3Pt/Gm',
                      title2: /*'Player +/-'*/"",
                      value2:
                     /* (((gameDetails.homeRushingPlayer[i].total
                          ?.plus ??
                          0) -
                          (gameDetails.homeRushingPlayer[i]
                              .total?.minus ??
                              0)) /
                          (gameDetails.homeRushingPlayer[i].total
                              ?.gamesPlayed ??
                              1))
                          .toStringAsFixed(1)*/"",
                    ),
                    /*   expandableTileCardRunning(context, con,
                        value1: '${((gameDetails.homeRushingPlayer[i].total
                            ?.trueShootingPct ?? 0) * (100)).round()}%',
                        title1: 'True Shooting',
                        title2: '',
                        value2: ('').toString()),*/
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
    itemCount: con.isTeamReportTab
        ? gameDetails.awayRushingPlayer.length
        : gameDetails.homeRushingPlayer.length,
  );
}

pro.Average? homeAverage(SportEvents gameDetails, int i) =>
    gameDetails.homeRushingPlayer[i].average;

pro.Average? average(SportEvents gameDetails, int i) =>
    gameDetails.awayRushingPlayer[i].average;

Container expandableTileCard(BuildContext context, GameDetailsController con,
    {String title1 = '',
      String value1 = '',
      String title2 = '',
      String value2 = ''}) {
  return Container(
    color: Theme
        .of(context)
        .unselectedWidgetColor,
    // height: MediaQuery.sizeOf(context).height * .031,
    child: Row(
      children: [
        hitterDataCard(title1, context, value1, false),
        hitterDataCard(title2, context, value2, true),
      ],
    ).paddingSymmetric(
        horizontal: MediaQuery
            .sizeOf(context)
            .width * .015,
        vertical: MediaQuery
            .sizeOf(context)
            .width * .01),
  );
}

Container expandableTileCardRunning(BuildContext context,
    GameDetailsController con,
    {String title1 = '',
      String value1 = '',
      String title2 = '',
      String value2 = ''}) {
  return Container(
    color: Theme
        .of(context)
        .unselectedWidgetColor,
    // height: MediaQuery.sizeOf(context).height * .031,
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: title1.appCommonText(
              color: Theme
                  .of(context)
                  .highlightColor,
              align: TextAlign.start,
              weight: FontWeight.w600,
              size: MediaQuery
                  .sizeOf(context)
                  .height * .014),
        ),
        Expanded(
            flex: 2,
            child: value1.appCommonText(
                color: Theme
                    .of(context)
                    .highlightColor,
                align: TextAlign.end,
                weight: FontWeight.w400,
                size: MediaQuery
                    .sizeOf(context)
                    .height * .014)),
        SizedBox(width: MediaQuery
            .sizeOf(context)
            .height * .02),
        Expanded(
          flex: 2,
          child: title2.appCommonText(
              color: Theme
                  .of(context)
                  .highlightColor,
              align: TextAlign.start,
              weight: FontWeight.w600,
              size: MediaQuery
                  .sizeOf(context)
                  .height * .014),
        ),
        Expanded(
            flex: 2,
            child: value2.appCommonText(
                color: Theme
                    .of(context)
                    .highlightColor,
                align: TextAlign.end,
                weight: FontWeight.w400,
                size: MediaQuery
                    .sizeOf(context)
                    .height * .014)),
      ],
    ).paddingSymmetric(
        horizontal: MediaQuery
            .sizeOf(context)
            .width * .015,
        vertical: MediaQuery
            .sizeOf(context)
            .width * .01),
  );
}

Expanded hitterDataCard(String title, BuildContext context, String value,
    bool isFirst) {
  return Expanded(
    flex: 2,
    child: Row(
      children: [
        SizedBox(
          width: isFirst
              ? mobileView.size.shortestSide < 600
              ? MediaQuery
              .sizeOf(context)
              .width * .0
              : MediaQuery
              .sizeOf(context)
              .width * .08
              : 0,
        ),
        Expanded(
          flex: 3,
          child: title.toString().appCommonText(
              color: Theme
                  .of(context)
                  .highlightColor,
              align: TextAlign.start,
              weight: FontWeight.w600,
              size: MediaQuery
                  .sizeOf(context)
                  .height * .014),
        ),
        Expanded(
            flex: 2,
            child: (double.tryParse(value) ?? value)
                .toString()
                .replaceAll(regex, "")
                .appCommonText(
                color: Theme
                    .of(context)
                    .highlightColor,
                align: TextAlign.end,
                weight: FontWeight.w400,
                size: MediaQuery
                    .sizeOf(context)
                    .height * .014)),
        SizedBox(
          width: isFirst
              ? 0
              : mobileView.size.shortestSide < 600
              ? MediaQuery
              .sizeOf(context)
              .width * .06
              : 0,
        )
      ],
    ),
  );
}

SizedBox expandedAwayHeader(BuildContext context, int index,
    GameDetailsController con) {
  return SizedBox(
    // height: MediaQuery.sizeOf(context).height * .031,
    child: Row(
      children: [
        Expanded(
            flex: 2,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  con.hitterAwayPlayerMainList[index].playerName
                      .toString()
                      .appCommonText(
                      color: blueColor,
                      align: TextAlign.start,
                      weight: FontWeight.w600,
                      size: MediaQuery
                          .sizeOf(context)
                          .height * .014),
                  ' ${con.hitterAwayPlayerMainList[index].position}'
                      .appCommonText(
                      color: grayColor,
                      align: TextAlign.start,
                      weight: FontWeight.w400,
                      size: MediaQuery
                          .sizeOf(context)
                          .height * .014),
                ],
              ),
            )),
        /*Expanded(
            child: con.hitterAwayPlayerMainList[index].hAb.appCommonText(
                color: Theme.of(context).highlightColor,
                align: TextAlign.end,
                weight: FontWeight.w400,
                size: MediaQuery.sizeOf(context).height * .014)),*/
        Expanded(
            child: con.hitterAwayPlayerMainList[index].hr
                .toString()
                .appCommonText(
                color: Theme
                    .of(context)
                    .highlightColor,
                align: TextAlign.end,
                weight: FontWeight.w400,
                size: MediaQuery
                    .sizeOf(context)
                    .height * .014)),
        Expanded(
            child: con.hitterAwayPlayerMainList[index].rbi
                .toString()
                .appCommonText(
                color: Theme
                    .of(context)
                    .highlightColor,
                align: TextAlign.end,
                weight: FontWeight.w400,
                size: MediaQuery
                    .sizeOf(context)
                    .height * .014)),
        Expanded(
            child: con.hitterAwayPlayerMainList[index].bb
                .toString()
                .appCommonText(
                color: Theme
                    .of(context)
                    .highlightColor,
                align: TextAlign.end,
                weight: FontWeight.w400,
                size: MediaQuery
                    .sizeOf(context)
                    .height * .014)),
        Expanded(
            child: con.hitterAwayPlayerMainList[index].avg
                .toString()
                .appCommonText(
                color: Theme
                    .of(context)
                    .highlightColor,
                align: TextAlign.end,
                weight: FontWeight.w400,
                size: MediaQuery
                    .sizeOf(context)
                    .height * .014)),
      ],
    ).paddingSymmetric(
        horizontal: MediaQuery
            .sizeOf(context)
            .width * .015,
        vertical: MediaQuery
            .sizeOf(context)
            .width * .01),
  );
}

SizedBox expandedHomeHeader(BuildContext context, int index,
    GameDetailsController con) {
  return SizedBox(
    // height: MediaQuery.sizeOf(context).height * .031,
    child: Row(
      children: [
        Expanded(
            flex: mobileView.size.shortestSide < 600 ? 2 : 2,
            child: Row(
              children: [
                con.hitterHomePlayerMainList[index].playerName
                    .toString()
                    .appCommonText(
                    color: blueColor,
                    align: TextAlign.start,
                    weight: FontWeight.w600,
                    size: MediaQuery
                        .sizeOf(context)
                        .height * .014),
                ' ${con.hitterHomePlayerMainList[index].position}'
                    .appCommonText(
                    color: grayColor,
                    align: TextAlign.start,
                    weight: FontWeight.w400,
                    size: MediaQuery
                        .sizeOf(context)
                        .height * .014),
              ],
            )),
        /* Expanded(
            child: con.hitterHomePlayerMainList[index].hAb.appCommonText(
                color: Theme.of(context).highlightColor,
                align: TextAlign.end,
                weight: FontWeight.w400,
                size: MediaQuery.sizeOf(context).height * .014)),*/
        Expanded(
            child: con.hitterHomePlayerMainList[index].hr
                .toString()
                .appCommonText(
                color: Theme
                    .of(context)
                    .highlightColor,
                align: TextAlign.end,
                weight: FontWeight.w400,
                size: MediaQuery
                    .sizeOf(context)
                    .height * .014)),
        Expanded(
            child: con.hitterHomePlayerMainList[index].rbi
                .toString()
                .appCommonText(
                color: Theme
                    .of(context)
                    .highlightColor,
                align: TextAlign.end,
                weight: FontWeight.w400,
                size: MediaQuery
                    .sizeOf(context)
                    .height * .014)),
        Expanded(
            child: con.hitterHomePlayerMainList[index].bb
                .toString()
                .appCommonText(
                color: Theme
                    .of(context)
                    .highlightColor,
                align: TextAlign.end,
                weight: FontWeight.w400,
                size: MediaQuery
                    .sizeOf(context)
                    .height * .014)),
        Expanded(
            child: con.hitterHomePlayerMainList[index].avg
                .toString()
                .appCommonText(
                color: Theme
                    .of(context)
                    .highlightColor,
                align: TextAlign.end,
                weight: FontWeight.w400,
                size: MediaQuery
                    .sizeOf(context)
                    .height * .014)),
      ],
    ).paddingSymmetric(
        horizontal: MediaQuery
            .sizeOf(context)
            .width * .015,
        vertical: MediaQuery
            .sizeOf(context)
            .width * .01),
  );
}

SizedBox runningHomeHeader(BuildContext context,
    int index,
    GameDetailsController con,
    SportEvents gameDetails,
    num totalPlay,) {
  return SizedBox(
    // height: MediaQuery.sizeOf(context).height * .031,
    child: Row(
      children: [
        Expanded(
            flex: 3,
            child: (gameDetails.nflHomeRunningBackPlayer[index].name ?? "")
                .appCommonText(
                color: blueColor,
                align: TextAlign.start,
                weight: FontWeight.w400,
                size: MediaQuery
                    .sizeOf(context)
                    .height * .014)),
        Expanded(
            flex: 2,
            child: (gameDetails
                .nflHomeRunningBackPlayer[index]
                .rushing != null ? gameDetails
                .nflHomeRunningBackPlayer[index]
                .rushing
                ?.touchdowns == 0.0 ? "0" : (num.parse(((num.parse((gameDetails
                .nflHomeRunningBackPlayer[index]
                .rushing
                ?.touchdowns ??
                "0")
                .toString()) +
                num.parse((gameDetails.nflHomeRunningBackPlayer[index]
                    .receiving?.touchdowns ??
                    "0")
                    .toString())) /
                totalPlay)
                .toString())
                .toStringAsFixed(1)) : "0")
                .appCommonText(
                color: Theme
                    .of(context)
                    .highlightColor,
                align: TextAlign.end,
                weight: FontWeight.w400,
                size: MediaQuery
                    .sizeOf(context)
                    .height * .014)),
        Expanded(
            flex: 2,
            child: (gameDetails
                .nflHomeRunningBackPlayer[index]
                .rushing != null ? (num.parse(((num.parse((gameDetails
                .nflHomeRunningBackPlayer[index]
                .rushing
                ?.yards ??
                "0")
                .toString())) /
                totalPlay)
                .toString())
                .toStringAsFixed(1)) : "0")
                .appCommonText(
                color: Theme
                    .of(context)
                    .highlightColor,
                align: TextAlign.end,
                weight: FontWeight.w400,
                size: MediaQuery
                    .sizeOf(context)
                    .height * .014)),
        Expanded(
            flex: 2,
            child: (gameDetails
                .nflHomeRunningBackPlayer[index].rushing != null ? ((int.parse(
                gameDetails
                    .nflHomeRunningBackPlayer[index].rushing?.attempts
                    .toString() ??
                    "0") /
                totalPlay)
                .toStringAsFixed(1)) : "0")
                .appCommonText(
                color: Theme
                    .of(context)
                    .highlightColor,
                align: TextAlign.end,
                weight: FontWeight.w400,
                size: MediaQuery
                    .sizeOf(context)
                    .height * .014)),
      ],
    ).paddingSymmetric(
        horizontal: MediaQuery
            .sizeOf(context)
            .width * .015,
        vertical: MediaQuery
            .sizeOf(context)
            .width * .01),
  );
}

SizedBox nbaHomeHeader(BuildContext context,
    int index,
    GameDetailsController con,
    SportEvents gameDetails,) {
  try {
    return SizedBox(
      // height: MediaQuery.sizeOf(context).height * .031,
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child:
              ('${gameDetails.homeRushingPlayer[index].firstName
                  .toString()
                  .characters
                  .first}. ${gameDetails.homeRushingPlayer[index].lastName}')
                  .appCommonText(
                  color: blueColor,
                  align: TextAlign.start,
                  weight: FontWeight.w400,
                  size: MediaQuery
                      .sizeOf(context)
                      .height * .014)),
          Expanded(
              flex: 2,
              child: (homeAverage(gameDetails, index)?.points ?? 0)
                  .toStringAsFixed(1)
                  .appCommonText(
                  color: Theme
                      .of(context)
                      .highlightColor,
                  align: TextAlign.end,
                  weight: FontWeight.w400,
                  size: MediaQuery
                      .sizeOf(context)
                      .height * .014)),
          // Expanded(
          //     flex: 2,
          //     child: (gameDetails
          //         .homeRushingPlayer[index].average?.threePointsMade ??
          //         0)
          //         .toStringAsFixed(1)
          //         .appCommonText(
          //         color: Theme
          //             .of(context)
          //             .highlightColor,
          //         align: TextAlign.end,
          //         weight: FontWeight.w400,
          //         size: MediaQuery
          //             .sizeOf(context)
          //             .height * .014)),

          Expanded(
              flex: 2,
              child:
              (homeAverage(gameDetails, index)?.rebounds ?? 0)
                  .toStringAsFixed(1)
                  .appCommonText(
                  color: Theme
                      .of(context)
                      .highlightColor,
                  align: TextAlign.end,
                  weight: FontWeight.w400,
                  size: MediaQuery
                      .sizeOf(context)
                      .height * .014)),
          Expanded(
              flex: 2,
              child:
              (homeAverage(gameDetails, index)?.assists ?? 0)
                  .toStringAsFixed(1)
                  .appCommonText(
                  color: Theme
                      .of(context)
                      .highlightColor,
                  align: TextAlign.end,
                  weight: FontWeight.w400,
                  size: MediaQuery
                      .sizeOf(context)
                      .height * .014)),
        ],
      ).paddingSymmetric(
          horizontal: MediaQuery
              .sizeOf(context)
              .width * .015,
          vertical: MediaQuery
              .sizeOf(context)
              .width * .01),
    );
  } catch (e) {
    return const SizedBox();
  }
}

SizedBox nbaAwayHeader(BuildContext context,
    int index,
    GameDetailsController con,
    SportEvents gameDetails,) {
  try {
    return SizedBox(
      // height: MediaQuery.sizeOf(context).height * .031,
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child:
              ('${gameDetails.awayRushingPlayer[index].firstName
                  .toString()
                  .characters
                  .first}. ${gameDetails.awayRushingPlayer[index].lastName}')
                  .appCommonText(
                  color: blueColor,
                  align: TextAlign.start,
                  weight: FontWeight.w400,
                  size: MediaQuery
                      .sizeOf(context)
                      .height * .014)),
          Expanded(
              flex: 2,
              child: (average(gameDetails, index)?.points ?? 0)
                  .toStringAsFixed(1)
                  .appCommonText(
                  color: Theme
                      .of(context)
                      .highlightColor,
                  align: TextAlign.end,
                  weight: FontWeight.w400,
                  size: MediaQuery
                      .sizeOf(context)
                      .height * .014)),
          // Expanded(
          //     flex: 2,
          //     child: (gameDetails
          //         .awayRushingPlayer[index].average?.threePointsMade ??
          //         0)
          //         .toStringAsFixed(1)
          //         .appCommonText(
          //         color: Theme
          //             .of(context)
          //             .highlightColor,
          //         align: TextAlign.end,
          //         weight: FontWeight.w400,
          //         size: MediaQuery
          //             .sizeOf(context)
          //             .height * .014)),
          Expanded(
              flex: 2,
              child:
              (average(gameDetails, index)?.rebounds ?? 0)
                  .toStringAsFixed(1)
                  .appCommonText(
                  color: Theme
                      .of(context)
                      .highlightColor,
                  align: TextAlign.end,
                  weight: FontWeight.w400,
                  size: MediaQuery
                      .sizeOf(context)
                      .height * .014)),
          Expanded(
              flex: 2,
              child:
              ((average(gameDetails, index)?.assists ?? 0)
                  .toStringAsFixed(1))
                  .toString()
                  .appCommonText(
                  color: Theme
                      .of(context)
                      .highlightColor,
                  align: TextAlign.end,
                  weight: FontWeight.w400,
                  size: MediaQuery
                      .sizeOf(context)
                      .height * .014)),

        ],
      ).paddingSymmetric(
          horizontal: MediaQuery
              .sizeOf(context)
              .width * .015,
          vertical: MediaQuery
              .sizeOf(context)
              .width * .01),
    );
  } catch (e) {
    return const SizedBox();
  }
}

SizedBox runningAwayHeader(BuildContext context,
    int index,
    GameDetailsController con,
    SportEvents gameDetails,
    num totalPlay,) {
  return SizedBox(
    // height: MediaQuery.sizeOf(context).height * .031,
    child: Row(
      children: [
        Expanded(
            flex: 3,
            child: (gameDetails.nflAwayRunningBackPlayer[index].name ?? "")
                .appCommonText(
                color: blueColor,
                align: TextAlign.start,
                weight: FontWeight.w400,
                size: MediaQuery
                    .sizeOf(context)
                    .height * .014)),
        Expanded(
            flex: 2,
            child: (gameDetails
                .nflAwayRunningBackPlayer[index]
                .rushing != null ? gameDetails
                .nflAwayRunningBackPlayer[index]
                .rushing
                ?.touchdowns == 0.0 ? "0" : (num.parse(((num.parse((gameDetails
                .nflAwayRunningBackPlayer[index]
                .rushing
                ?.touchdowns ??
                "0")
                .toString()) +
                num.parse((gameDetails.nflAwayRunningBackPlayer[index]
                    .receiving?.touchdowns ??
                    "0")
                    .toString())) /
                totalPlay)
                .toString())
                .toStringAsFixed(1)) : "0")
                .appCommonText(
                color: Theme
                    .of(context)
                    .highlightColor,
                align: TextAlign.end,
                weight: FontWeight.w400,
                size: MediaQuery
                    .sizeOf(context)
                    .height * .014)),
        Expanded(
            flex: 2,
            child: (gameDetails
                .nflAwayRunningBackPlayer[index]
                .rushing != null ? (num.parse(((num.parse((gameDetails
                .nflAwayRunningBackPlayer[index]
                .rushing
                ?.yards ??
                "0")
                .toString())) /
                totalPlay)
                .toString())
                .toStringAsFixed(1)
                .toString()) : "0")
                .appCommonText(
                color: Theme
                    .of(context)
                    .highlightColor,
                align: TextAlign.end,
                weight: FontWeight.w400,
                size: MediaQuery
                    .sizeOf(context)
                    .height * .014)),
        Expanded(
            flex: 2,
            child: (gameDetails
                .nflAwayRunningBackPlayer[index].rushing != null ? ((int.parse(
                gameDetails
                    .nflAwayRunningBackPlayer[index].rushing?.attempts
                    .toString() ??
                    "0") /
                totalPlay)
                .toStringAsFixed(1)) : "0")
                .appCommonText(
                color: Theme
                    .of(context)
                    .highlightColor,
                align: TextAlign.end,
                weight: FontWeight.w400,
                size: MediaQuery
                    .sizeOf(context)
                    .height * .014)),
      ],
    ).paddingSymmetric(
        horizontal: MediaQuery
            .sizeOf(context)
            .width * .015,
        vertical: MediaQuery
            .sizeOf(context)
            .width * .01),
  );
}

SizedBox headerOfHitterPlayerStat(BuildContext context) {
  return SizedBox(
    height: MediaQuery
        .sizeOf(context)
        .height * .034,
    child: Row(
      children: [
        Expanded(
            flex: 2,
            child: 'Hitters'.appCommonText(
                color: Theme
                    .of(context)
                    .highlightColor,
                align: TextAlign.start,
                weight: FontWeight.w700,
                size: MediaQuery
                    .sizeOf(context)
                    .height * .016)),
        /*Expanded(
            child: 'H-AB'.appCommonText(
                color: Theme.of(context).highlightColor,
                align: TextAlign.end,
                weight: FontWeight.w700,
                size: MediaQuery.sizeOf(context).height * .016)),*/
        Expanded(
            child: 'HR'.appCommonText(
                color: Theme
                    .of(context)
                    .highlightColor,
                align: TextAlign.end,
                weight: FontWeight.w700,
                size: MediaQuery
                    .sizeOf(context)
                    .height * .016)),
        Expanded(
            child: 'RBI'.appCommonText(
                color: Theme
                    .of(context)
                    .highlightColor,
                align: TextAlign.end,
                weight: FontWeight.w700,
                size: MediaQuery
                    .sizeOf(context)
                    .height * .016)),
        Expanded(
            child: 'BB'.appCommonText(
                color: Theme
                    .of(context)
                    .highlightColor,
                align: TextAlign.end,
                weight: FontWeight.w700,
                size: MediaQuery
                    .sizeOf(context)
                    .height * .016)),
        Expanded(
            child: 'AVG'.appCommonText(
                color: Theme
                    .of(context)
                    .highlightColor,
                align: TextAlign.end,
                weight: FontWeight.w700,
                size: MediaQuery
                    .sizeOf(context)
                    .height * .016)),
      ],
    ).paddingSymmetric(horizontal: MediaQuery
        .sizeOf(context)
        .width * .015),
  );
}

SizedBox headerOfNBAPlayerStat(BuildContext context) {
  return SizedBox(
    height: MediaQuery
        .sizeOf(context)
        .height * .034,
    child: Row(
      children: [
        Expanded(
            flex: 2,
            child: ('Name').appCommonText(
                color: Theme
                    .of(context)
                    .highlightColor,
                align: TextAlign.start,
                weight: FontWeight.w700,
                size: MediaQuery
                    .sizeOf(context)
                    .height * .016)),
        Expanded(
            flex: 2,
            child: 'Pts/Gm'.appCommonText(
                color: Theme
                    .of(context)
                    .highlightColor,
                align: TextAlign.end,
                weight: FontWeight.w700,
                size: MediaQuery
                    .sizeOf(context)
                    .height * .016)),
        // Expanded(
        //     flex: 2,
        //     child: '3s/Gm'.appCommonText(
        //         color: Theme
        //             .of(context)
        //             .highlightColor,
        //         align: TextAlign.end,
        //         weight: FontWeight.w700,
        //         size: MediaQuery
        //             .sizeOf(context)
        //             .height * .016)),
        Expanded(
            flex: 2,
            child: 'Rbs/Gm'.appCommonText(
                color: Theme
                    .of(context)
                    .highlightColor,
                align: TextAlign.end,
                weight: FontWeight.w700,
                size: MediaQuery
                    .sizeOf(context)
                    .height * .016)),
        Expanded(
            flex: 2,
            child: 'Asst/Gm'.appCommonText(
                color: Theme
                    .of(context)
                    .highlightColor,
                align: TextAlign.end,
                weight: FontWeight.w700,
                size: MediaQuery
                    .sizeOf(context)
                    .height * .016)),

      ],
    ).paddingSymmetric(horizontal: MediaQuery
        .sizeOf(context)
        .width * .015),
  );
}

SizedBox headerOfRunningBacks(BuildContext context) {
  return SizedBox(
    height: MediaQuery
        .sizeOf(context)
        .height * .034,
    child: Row(
      children: [
        Expanded(
            flex: 3,
            child: ('Name').appCommonText(
                color: Theme
                    .of(context)
                    .highlightColor,
                align: TextAlign.start,
                weight: FontWeight.w700,
                size: MediaQuery
                    .sizeOf(context)
                    .height * .016)),
        Expanded(
            flex: 2,
            child: 'TDs/Gm'.appCommonText(
                color: Theme
                    .of(context)
                    .highlightColor,
                align: TextAlign.end,
                weight: FontWeight.w700,
                size: MediaQuery
                    .sizeOf(context)
                    .height * .016)),
        Expanded(
            flex: 2,
            child: 'RshYds/Gm'.appCommonText(
                color: Theme
                    .of(context)
                    .highlightColor,
                align: TextAlign.end,
                weight: FontWeight.w700,
                size: MediaQuery
                    .sizeOf(context)
                    .height * .016)),
        Expanded(
            flex: 2,
            child: 'Car/Gm'.appCommonText(
                color: Theme
                    .of(context)
                    .highlightColor,
                align: TextAlign.end,
                weight: FontWeight.w700,
                size: MediaQuery
                    .sizeOf(context)
                    .height * .016)),
      ],
    ).paddingSymmetric(horizontal: MediaQuery
        .sizeOf(context)
        .width * .015),
  );
}

SizedBox headerOfWRPlayers(BuildContext context) {
  return SizedBox(
    height: MediaQuery
        .sizeOf(context)
        .height * .034,
    child: Row(
      children: [
        Expanded(
            flex: 3,
            child: ('Name').appCommonText(
                color: Theme
                    .of(context)
                    .highlightColor,
                align: TextAlign.start,
                weight: FontWeight.w700,
                size: MediaQuery
                    .sizeOf(context)
                    .height * .016)),
        Expanded(
            flex: 2,
            child: 'TDs/Gm'.appCommonText(
                color: Theme
                    .of(context)
                    .highlightColor,
                align: TextAlign.end,
                weight: FontWeight.w700,
                size: MediaQuery
                    .sizeOf(context)
                    .height * .016)),
        Expanded(
            flex: 2,
            child: 'RecYds/Gm'.appCommonText(
                color: Theme
                    .of(context)
                    .highlightColor,
                align: TextAlign.end,
                weight: FontWeight.w700,
                size: MediaQuery
                    .sizeOf(context)
                    .height * .016)),
        Expanded(
            flex: 2,
            child: 'Recp/Gm'.appCommonText(
                color: Theme
                    .of(context)
                    .highlightColor,
                align: TextAlign.end,
                weight: FontWeight.w700,
                size: MediaQuery
                    .sizeOf(context)
                    .height * .016)),
      ],
    ).paddingSymmetric(horizontal: MediaQuery
        .sizeOf(context)
        .width * .015),
  );
}

Container customTabBar(BuildContext context,
    GameDetailsController con,
    SportEvents gameDetails,
    Competitors? awayTeam,
    Competitors? homeTeam,
    String sportKey,
    String title, {bool isTab = true}) {
  return Container(
      height: MediaQuery
          .of(context)
          .size
          .height * .044,
      width: Get.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(MediaQuery
                  .of(context)
                  .size
                  .width * .01)),
          color: Theme
              .of(context)
              .disabledColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery
                .of(context)
                .size
                .height * .004,
            width: Get.width,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: InkWell(
                  highlightColor: Colors.transparent,
                  // onTap: () {
                  //   con.isTab = true;
                  //   con.isExpand = -1;
                  // },
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
                          size: MediaQuery
                              .of(context)
                              .size
                              .height * .016,
                          color: Theme
                              .of(context)
                              .cardColor,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * .01,
                      ),
                      commonCachedNetworkImage(
                        width: Get.height * .025,
                        height: Get.height * .025,
                        imageUrl: awayLogo(awayTeam, gameDetails),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: title
                    .appCommonText(
                  weight: FontWeight.bold,
                  align: TextAlign.center,
                  size: MediaQuery
                      .of(context)
                      .size
                      .height * .018,
                  color: Theme
                      .of(context)
                      .cardColor,
                ),
              ),
              Expanded(
                flex: 2,
                child: InkWell(
                  highlightColor: Colors.transparent,
                  // onTap: () {
                  //   con.isTab = false;
                  //   con.isExpand = -1;
                  // },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      commonCachedNetworkImage(
                        width: Get.height * .025,
                        height: Get.height * .025,
                        imageUrl: homeLogo(homeTeam, gameDetails),
                      ),
                      SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * .01,
                      ),
                      Expanded(
                        child: (mobileView.size.shortestSide < 600
                            ? (homeTeam?.abbreviation ?? '')
                            : (homeTeam?.name ?? ''))
                            .appCommonText(
                          weight: FontWeight.w600,
                          maxLine: 1,
                          align: TextAlign.start,
                          size: MediaQuery
                              .of(context)
                              .size
                              .height * .016,
                          color: Theme
                              .of(context)
                              .cardColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ).paddingSymmetric(
              horizontal: MediaQuery
                  .sizeOf(context)
                  .width * .015),
          const Spacer(),
          // con.isTab
          !isTab ? const SizedBox() : con.isTeamReportTab
              ? Row(
            children: [
              Expanded(
                child: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * .004,
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
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * .004,
                  width: Get.width,
                  color: yellowColor,
                ),
              ),
            ],
          ),
        ],
      ));
}

Container customTabBar1(BuildContext context, GameDetailsController con,
    SportEvents gameDetails, Competitors? awayTeam, Competitors? homeTeam) {
  return Container(
      height: MediaQuery
          .of(context)
          .size
          .height * .044,
      width: Get.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(MediaQuery
                  .of(context)
                  .size
                  .width * .01)),
          color: Theme
              .of(context)
              .disabledColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery
                .of(context)
                .size
                .height * .004,
            width: Get.width,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: InkWell(
                  highlightColor: Colors.transparent,
                  // onTap: () {
                  //   con.isTab1 = true;
                  //   con.isExpand = -1;
                  // },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: (mobileView.size.shortestSide < 600
                            ? (awayTeam?.abbreviation ?? '')
                            : (awayTeam?.name ?? ''))
                            .appCommonText(
                          weight: FontWeight.w600,
                          maxLine: 1,
                          align: TextAlign.end,
                          size: MediaQuery
                              .of(context)
                              .size
                              .height * .016,
                          color: Theme
                              .of(context)
                              .cardColor,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * .01,
                      ),
                      commonCachedNetworkImage(
                        width: Get.height * .025,
                        height: Get.height * .025,
                        imageUrl: awayLogo(awayTeam, gameDetails),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: 'Receiving'.appCommonText(
                  weight: FontWeight.bold,
                  align: TextAlign.center,
                  size: MediaQuery
                      .of(context)
                      .size
                      .height * .018,
                  color: Theme
                      .of(context)
                      .cardColor,
                ),
              ),
              Expanded(
                flex: 2,
                child: InkWell(
                  highlightColor: Colors.transparent,
                  // onTap: () {
                  //   con.isTab1 = false;
                  //   con.isExpand = -1;
                  // },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      commonCachedNetworkImage(
                        width: Get.height * .025,
                        height: Get.height * .025,
                        imageUrl: homeLogo(homeTeam, gameDetails),
                      ),
                      SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * .01,
                      ),
                      Expanded(
                        child: (mobileView.size.shortestSide < 600
                            ? (homeTeam?.abbreviation ?? '')
                            : (homeTeam?.name ?? ''))
                            .appCommonText(
                          weight: FontWeight.w600,
                          maxLine: 1,
                          align: TextAlign.start,
                          size: MediaQuery
                              .of(context)
                              .size
                              .height * .016,
                          color: Theme
                              .of(context)
                              .cardColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ).paddingSymmetric(
              horizontal: MediaQuery
                  .sizeOf(context)
                  .width * .015),
          const Spacer(),
          con.isTeamReportTab
          // con.isTab1
              ? Row(
            children: [
              Expanded(
                child: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * .004,
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
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * .004,
                  width: Get.width,
                  color: yellowColor,
                ),
              ),
            ],
          ),
        ],
      ));
}

/*Container teamReportTab(BuildContext context, GameDetailsController con,
    SportEvents gameDetails, Competitors? awayTeam, Competitors? homeTeam) {
  return Container(
      height: MediaQuery
          .of(context)
          .size
          .height * .044,
      width: Get.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(MediaQuery
                  .of(context)
                  .size
                  .width * .01)),
          color: Theme
              .of(context)
              .disabledColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery
                .of(context)
                .size
                .height * .004,
            width: Get.width,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: InkWell(
                  highlightColor: Colors.transparent,
                  onTap: () {
                    con.isTeamReportTab = true;
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: (mobileView.size.shortestSide < 600
                              ? (awayTeam?.abbreviation ?? '')
                              : (awayTeam?.name ?? ''))
                              .appCommonText(
                            weight: FontWeight.w600,
                            maxLine: 1,
                            align: TextAlign.end,
                            size: MediaQuery
                                .of(context)
                                .size
                                .height * .016,
                            color: Theme
                                .of(context)
                                .cardColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * .01,
                      ),
                      commonCachedNetworkImage(
                        width: Get.height * .025,
                        height: Get.height * .025,
                        imageUrl: awayLogo(awayTeam, gameDetails),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: 'Team Stats'.appCommonText(
                  weight: FontWeight.bold,
                  align: TextAlign.center,
                  size: MediaQuery
                      .of(context)
                      .size
                      .height * .018,
                  color: Theme
                      .of(context)
                      .cardColor,
                ),
              ),
              Expanded(
                flex: 3,
                child: InkWell(
                  highlightColor: Colors.transparent,
                  onTap: () {
                    con.isTeamReportTab = false;
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      commonCachedNetworkImage(
                        width: Get.height * .025,
                        height: Get.height * .025,
                        imageUrl: homeLogo(homeTeam, gameDetails),
                      ),
                      SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * .01,
                      ),
                      Flexible(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: (mobileView.size.shortestSide < 600
                              ? (homeTeam?.abbreviation ?? '')
                              : (homeTeam?.name ?? ''))
                              .appCommonText(
                            weight: FontWeight.w600,
                            maxLine: 1,
                            align: TextAlign.start,
                            size: MediaQuery
                                .of(context)
                                .size
                                .height * .016,
                            color: Theme
                                .of(context)
                                .cardColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ).paddingSymmetric(
              horizontal: MediaQuery
                  .sizeOf(context)
                  .width * .015),
          const Spacer(),
          con.isTeamReportTab
              ? Row(
            children: [
              Expanded(
                child: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * .004,
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
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * .004,
                  width: Get.width,
                  color: yellowColor,
                ),
              ),
            ],
          ),
        ],
      ));
}*/

class TabCard extends StatelessWidget {
  const TabCard({Key? key,
    this.awayOnTap,
    required this.awayTeam,
    required this.gameDetails,
    this.homeOnTap,
    this.homeTeam,
    required this.isSelected,
    required this.title})
      : super(key: key);
  final void Function()? awayOnTap;
  final void Function()? homeOnTap;
  final Competitors? awayTeam;
  final Competitors? homeTeam;
  final SportEvents gameDetails;
  final bool isSelected;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery
            .of(context)
            .size
            .height * .044,
        width: Get.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(MediaQuery
                    .of(context)
                    .size
                    .width * .01)),
            color: Theme
                .of(context)
                .disabledColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * .004,
              width: Get.width,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    onTap: awayOnTap,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: (mobileView.size.shortestSide < 600
                                ? (awayTeam?.abbreviation ?? '')
                                : (awayTeam?.name ?? ''))
                                .appCommonText(
                              weight: FontWeight.w600,
                              maxLine: 1,
                              align: TextAlign.end,
                              size: MediaQuery
                                  .of(context)
                                  .size
                                  .height * .016,
                              color: Theme
                                  .of(context)
                                  .cardColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * .01,
                        ),
                        commonCachedNetworkImage(
                          width: Get.height * .025,
                          height: Get.height * .025,
                          imageUrl: awayLogo(awayTeam, gameDetails),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: title.appCommonText(
                    weight: FontWeight.bold,
                    align: TextAlign.center,
                    size: MediaQuery
                        .of(context)
                        .size
                        .height * .018,
                    color: Theme
                        .of(context)
                        .cardColor,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    onTap: homeOnTap,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        commonCachedNetworkImage(
                          width: Get.height * .025,
                          height: Get.height * .025,
                          imageUrl: homeLogo(homeTeam, gameDetails),
                        ),
                        SizedBox(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * .01,
                        ),
                        Flexible(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: (mobileView.size.shortestSide < 600
                                ? (homeTeam?.abbreviation ?? '')
                                : (homeTeam?.name ?? ''))
                                .appCommonText(
                              weight: FontWeight.w600,
                              maxLine: 1,
                              align: TextAlign.start,
                              size: MediaQuery
                                  .of(context)
                                  .size
                                  .height * .016,
                              color: Theme
                                  .of(context)
                                  .cardColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ).paddingSymmetric(
                horizontal: MediaQuery
                    .sizeOf(context)
                    .width * .015),
            const Spacer(),
            isSelected
                ? Row(
              children: [
                Expanded(
                  child: Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * .004,
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
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * .004,
                    width: Get.width,
                    color: yellowColor,
                  ),
                ),
              ],
            ),
          ],
        ));
  }
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
            horizontal: MediaQuery
                .of(context)
                .size
                .width * .016,
            vertical: MediaQuery
                .of(context)
                .size
                .height * .003),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: awayText.contains('(')
                  ? RichText(
                  textAlign: mobileView.size.shortestSide < 600
                      ? TextAlign.center
                      : TextAlign.end,
                  text: TextSpan(
                      text: (num.tryParse(awayText) ?? awayText)
                          .toString()
                          .split(' ')
                          .first,
                      style: GoogleFonts.nunitoSans(
                          color: Theme
                              .of(context)
                              .highlightColor,
                          fontWeight: FontWeight.w700,
                          fontSize:
                          MediaQuery
                              .of(context)
                              .size
                              .height * .014),
                      children: [
                        TextSpan(
                            text:
                            ' ${(num.tryParse(awayText) ?? awayText)
                                .toString()
                                .split(' ')
                                .last}',
                            style: GoogleFonts.nunitoSans(
                                color: num.parse((num.tryParse(awayText) ??
                                    awayText)
                                    .toString()
                                    .split(' ')
                                    .last
                                    .replaceAll('(', '')
                                    .replaceAll(')', "")) <=
                                    12
                                    ? Colors.green
                                    : num.parse((num.tryParse(awayText) ??
                                    awayText)
                                    .toString()
                                    .split(' ')
                                    .last
                                    .replaceAll('(', '')
                                    .replaceAll(')', "")) >=
                                    15
                                    ? redColor
                                    : Colors.amber,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .height *
                                    .014))
                      ]))
                  : (awayText.isNotEmpty
                  ? (num.tryParse(awayText) ?? awayText)
                  : "0")
                  .toString()
                  .appCommonText(
                  color: Theme
                      .of(context)
                      .highlightColor,
                  weight: FontWeight.w700,
                  align: mobileView.size.shortestSide < 600
                      ? TextAlign.center
                      : TextAlign.end,
                  size: MediaQuery
                      .of(context)
                      .size
                      .height * .014),
            ),
            Expanded(
              flex: isReport ? 3 : 2,
              child: teamReports.toString().appCommonText(
                  color: darkGreyColor,
                  align: TextAlign.center,
                  weight: FontWeight.w600,
                  size: MediaQuery
                      .of(context)
                      .size
                      .height * .016),
            ),
            Expanded(
              flex: 2,
              child: homeText.contains('(')
                  ? RichText(
                  textAlign: mobileView.size.shortestSide < 600
                      ? TextAlign.center
                      : TextAlign.start,
                  text: TextSpan(
                      text: (num.tryParse(homeText) ?? homeText)
                          .toString()
                          .split(' ')
                          .first,
                      style: GoogleFonts.nunitoSans(
                          color: Theme
                              .of(context)
                              .highlightColor,
                          fontWeight: FontWeight.w700,
                          fontSize:
                          MediaQuery
                              .of(context)
                              .size
                              .height * .014),
                      children: [
                        TextSpan(
                            text:
                            ' ${(num.tryParse(homeText) ?? homeText)
                                .toString()
                                .split(' ')
                                .last}',
                            style: GoogleFonts.nunitoSans(
                                color: num.parse((num.tryParse(homeText) ??
                                    homeText)
                                    .toString()
                                    .split(' ')
                                    .last
                                    .replaceAll('(', '')
                                    .replaceAll(')', "")) <=
                                    12
                                    ? Colors.green
                                    : num.parse((num.tryParse(homeText) ??
                                    homeText)
                                    .toString()
                                    .split(' ')
                                    .last
                                    .replaceAll('(', '')
                                    .replaceAll(')', "")) >=
                                    15
                                    ? redColor
                                    : Colors.amber,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .height *
                                    .014))
                      ]))
                  : (homeText.isNotEmpty
                  ? (num.tryParse(homeText) ?? homeText)
                  : "0")
                  .toString()
                  .appCommonText(
                  color: Theme
                      .of(context)
                      .highlightColor,
                  weight: FontWeight.w700,
                  align: mobileView.size.shortestSide < 600
                      ? TextAlign.center
                      : TextAlign.start,
                  size: MediaQuery
                      .of(context)
                      .size
                      .height * .014),
            )
          ],
        ),
      ),
    ],
  );
}

Container rankingCommonWidget({required BuildContext context,
  String homeText = '',
  String awayText = '',
  required String title,
  bool isPlayStat = true}) {
  return Container(
    color: Theme
        .of(context)
        .splashColor,
    child: Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery
              .of(context)
              .size
              .height * .003),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: (isPlayStat ? awayText : '').appCommonText(
                color: Theme
                    .of(context)
                    .highlightColor,
                weight: FontWeight.bold,
                align: mobileView.size.shortestSide < 600
                    ? TextAlign.center
                    : TextAlign.end,
                size: MediaQuery
                    .of(context)
                    .size
                    .height * .014),
          ),
          Expanded(
            flex: mobileView.size.shortestSide < 600 ? 3 : 2,
            child: title.appCommonText(
                color: Theme
                    .of(context)
                    .highlightColor,
                weight: FontWeight.bold,
                align: TextAlign.center,
                size: MediaQuery
                    .of(context)
                    .size
                    .height * .014),
          ),
          Expanded(
            flex: 2,
            child: (isPlayStat ? homeText : '').appCommonText(
                color: Theme
                    .of(context)
                    .highlightColor,
                weight: FontWeight.bold,
                align: mobileView.size.shortestSide < 600
                    ? TextAlign.center
                    : TextAlign.start,
                size: MediaQuery
                    .of(context)
                    .size
                    .height * .014),
          ),
        ],
      ),
    ),
  );
}

injuryReportWidget(BuildContext context,
    SportEvents gameDetails,
    String sportKey,
    Competitors? awayTeam,
    Competitors? homeTeam,
    GameDetailsController con) {
  try {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery
              .of(context)
              .size
              .height * .02),
      child: Container(
        // height: MediaQuery.of(context).size.height * .12,
        decoration: BoxDecoration(
            borderRadius:
            BorderRadius.circular(MediaQuery
                .of(context)
                .size
                .width * .01),
            color: Theme
                .of(context)
                .canvasColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            injuriesTab(context, con, gameDetails, awayTeam, homeTeam),
            GetBuilder<GameDetailsController>(builder: (controller) {
              return controller.isLoading.value
                  ? SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * .1,
              )
                  : (!con.isTeamReportTab
                  ? gameDetails.homeTeamInjuredPlayer.isEmpty
                  : gameDetails.awayTeamInjuredPlayer.isEmpty)
                  ? SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * .1,
                child: Center(
                  child: 'No Injured Players'.appCommonText(
                      color: Theme
                          .of(context)
                          .highlightColor,
                      weight: FontWeight.w700,
                      align: TextAlign.start,
                      size:
                      MediaQuery
                          .of(context)
                          .size
                          .height * .016),
                ),
              )
                  : ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return (con.isTeamReportTab
                        ? '${gameDetails.awayTeamInjuredPlayer[index]}'
                        : '${gameDetails.homeTeamInjuredPlayer[index]}')
                        .toString()
                        .appCommonText(
                        color: Theme
                            .of(context)
                            .highlightColor,
                        weight: FontWeight.w700,
                        align: TextAlign.center,
                        size: MediaQuery
                            .of(context)
                            .size
                            .height *
                            .016)
                        .paddingSymmetric(
                        horizontal: 20.w, vertical: 8.w);
                  },
                  separatorBuilder: (context, index) {
                    return commonDivider(context);
                  },
                  itemCount: con.isTeamReportTab
                      ? gameDetails.awayTeamInjuredPlayer.length
                      : gameDetails.homeTeamInjuredPlayer.length);
            }),
          ],
        ),
      ),
    );
  } catch (e) {
    return const SizedBox();
  }
}

Container injuriesTab(BuildContext context, GameDetailsController con,
    SportEvents gameDetails, Competitors? awayTeam, Competitors? homeTeam) {
  return Container(
      height: MediaQuery
          .of(context)
          .size
          .height * .044,
      width: Get.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(MediaQuery
                  .of(context)
                  .size
                  .width * .01)),
          color: Theme
              .of(context)
              .disabledColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery
                .of(context)
                .size
                .height * .004,
            width: Get.width,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: InkWell(
                  highlightColor: Colors.transparent,
                  onTap: () {
                    // con.isInjuriesTab = true;
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: (mobileView.size.shortestSide < 600
                              ? (awayTeam?.abbreviation ?? '')
                              : (awayTeam?.name ?? ''))
                              .appCommonText(
                            weight: FontWeight.w600,
                            maxLine: 1,
                            align: TextAlign.end,
                            size: MediaQuery
                                .of(context)
                                .size
                                .height * .016,
                            color: Theme
                                .of(context)
                                .cardColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * .01,
                      ),
                      commonCachedNetworkImage(
                        width: Get.height * .025,
                        height: Get.height * .025,
                        imageUrl: awayLogo(awayTeam, gameDetails),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: injuryReport.appCommonText(
                  weight: FontWeight.bold,
                  align: TextAlign.center,
                  size: MediaQuery
                      .of(context)
                      .size
                      .height * .018,
                  color: Theme
                      .of(context)
                      .cardColor,
                ),
              ),
              Expanded(
                flex: 2,
                child: InkWell(
                  highlightColor: Colors.transparent,
                  onTap: () {
                    // con.isInjuriesTab = false;
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      commonCachedNetworkImage(
                          width: Get.height * .025,
                          height: Get.height * .025,
                          imageUrl: homeLogo(homeTeam, gameDetails)),
                      SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * .01,
                      ),
                      Flexible(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: (mobileView.size.shortestSide < 600
                              ? (homeTeam?.abbreviation ?? '')
                              : (homeTeam?.name ?? ''))
                              .appCommonText(
                            weight: FontWeight.w600,
                            maxLine: 1,
                            align: TextAlign.start,
                            size: MediaQuery
                                .of(context)
                                .size
                                .height * .016,
                            color: Theme
                                .of(context)
                                .cardColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ).paddingSymmetric(
              horizontal: MediaQuery
                  .sizeOf(context)
                  .width * .015),
          const Spacer(),
          con.isTeamReportTab
          // con.isInjuriesTab
              ? Row(
            children: [
              Expanded(
                child: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * .004,
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
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * .004,
                  width: Get.width,
                  color: yellowColor,
                ),
              ),
            ],
          ),
        ],
      ));
}

Container headerTitleWidget(BuildContext context, String title,
    {bool isTeamReport = false,
      bool isInjury = false,
      Competitors? awayTeam,
      Competitors? homeTeam,
      required SportEvents gameDetails}) {
  return Container(
      height: MediaQuery
          .of(context)
          .size
          .height * .032,
      width: Get.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(MediaQuery
                  .of(context)
                  .size
                  .width * .01)),
          color: Theme
              .of(context)
              .disabledColor),
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
                  size: MediaQuery
                      .of(context)
                      .size
                      .height * .016,
                  align: TextAlign.end,
                  color: Theme
                      .of(context)
                      .cardColor,
                )
                    : Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: (awayTeam?.name ?? '').appCommonText(
                      weight: FontWeight.w600,
                      maxLine: 1,
                      size: MediaQuery
                          .of(context)
                          .size
                          .height * .016,
                      align: TextAlign.end,
                      color: Theme
                          .of(context)
                          .cardColor,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * .01,
                ),
                commonCachedNetworkImage(
                  width: Get.height * .025,
                  height: Get.height * .025,
                  imageUrl: awayLogo(awayTeam, gameDetails),
                ),
              ],
            ),
          ),
          Expanded(
            flex: isTeamReport ? 3 : 2,
            child: title.appCommonText(
                color: Theme
                    .of(context)
                    .cardColor,
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
                  imageUrl: homeLogo(homeTeam, gameDetails),
                ),
                SizedBox(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * .01,
                ),
                mobileView.size.shortestSide < 600
                    ? (homeTeam?.abbreviation ?? "").appCommonText(
                  weight: FontWeight.w600,
                  maxLine: 1,
                  size: MediaQuery
                      .of(context)
                      .size
                      .height * .016,
                  align: TextAlign.start,
                  color: Theme
                      .of(context)
                      .cardColor,
                )
                    : Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: (homeTeam?.name ?? "").appCommonText(
                      weight: FontWeight.w600,
                      maxLine: 1,
                      size: MediaQuery
                          .of(context)
                          .size
                          .height * .016,
                      align: TextAlign.start,
                      color: Theme
                          .of(context)
                          .cardColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ));
}

Padding hotlinesWidget(BuildContext context,
    GameDetailsController con,
    SportEvents gameDetails,
    Competitors? awayTeam,
    Competitors? homeTeam,
    TabController tabController) {
  return Padding(
    padding: EdgeInsets.symmetric(
        horizontal: MediaQuery
            .of(context)
            .size
            .height * .02),
    child: Container(
      decoration: BoxDecoration(
          borderRadius:
          BorderRadius.circular(MediaQuery
              .of(context)
              .size
              .width * .01),
          color: Theme
              .of(context)
              .canvasColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * .032,
              width: Get.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(
                          MediaQuery
                              .of(context)
                              .size
                              .width * .01)),
                  color: Theme
                      .of(context)
                      .disabledColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  'Plus Money Props   '.appCommonText(
                      color: Theme
                          .of(context)
                          .cardColor,
                      align: TextAlign.start,
                      weight: FontWeight.w600,
                      size: Get.height * .016),
                  InkWell(
                    highlightColor: Colors.transparent,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  20.r,
                                ),
                              ),
                            ),
                            shadowColor: Theme
                                .of(context)
                                .secondaryHeaderColor,
                            contentPadding: EdgeInsets.all(20.h),
                            title:
                            'Fun plus money prop bets or parlay legs available for this game across major sportsbooks.'
                                .appCommonText(
                                color: Theme
                                    .of(context)
                                    .secondaryHeaderColor,
                                align: TextAlign.center,
                                weight: FontWeight.w600,
                                size: Get.height * .016),
                          );
                        },
                      );
                    },
                    child: CircleAvatar(
                      radius: Get.height * .012,
                      backgroundColor: Theme
                          .of(context)
                          .cardColor,
                      child: Center(
                        child: Icon(Icons.question_mark,
                            color: Theme
                                .of(context)
                                .disabledColor,
                            size: Get.height * .016),
                      ),
                    ),
                  )
                ],
              ).paddingSymmetric(horizontal: 20.h)),
          Container(
            height: MediaQuery
                .of(context)
                .size
                .height * .032,
            color: Theme
                .of(context)
                .splashColor,
            child: TabBar(
              controller: tabController,
              onTap: (value) {
                con.hotlinesIndex = value;
                con.update();
                // log('INDEX===$value');
              },
              dividerColor: Theme
                  .of(context)
                  .splashColor,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: EdgeInsets.zero,
              indicatorColor: yellowColor,
              tabs: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: 'All'.appCommonText(
                      weight: FontWeight.bold,
                      color: Theme
                          .of(context)
                          .highlightColor,
                      size: MediaQuery
                          .of(context)
                          .size
                          .height * .014),
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: "DraftKings".appCommonText(
                      weight: FontWeight.bold,
                      color: Theme
                          .of(context)
                          .highlightColor,
                      size: MediaQuery
                          .of(context)
                          .size
                          .height * .013),
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: 'FanDuel'.appCommonText(
                      weight: FontWeight.bold,
                      color: Theme
                          .of(context)
                          .highlightColor,
                      size: MediaQuery
                          .of(context)
                          .size
                          .height * .014),
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: 'MGM'.appCommonText(
                      weight: FontWeight.bold,
                      color: Theme
                          .of(context)
                          .highlightColor,
                      size: MediaQuery
                          .of(context)
                          .size
                          .height * .014),
                ),
              ],
            ),
          ),
          con.isLoading.value
              ? circularWidget(context)
              .paddingAll(MediaQuery
              .of(context)
              .size
              .height * .038)
              : (con.hotlinesIndex == 0
              ? gameDetails.hotlinesData.isEmpty
              : con.hotlinesIndex == 1
              ? gameDetails.hotlinesDData.isEmpty
              : con.hotlinesIndex == 2
              ? gameDetails.hotlinesFData.isEmpty
              : gameDetails.hotlinesMData.isEmpty) &&
              !con.isLoading.value
              ? emptyListWidget(
            context,
            isAll: true,
            gameDetails,
          )
              : hotlinesCard(con, gameDetails, awayTeam, homeTeam,
              tabController, context),
        ],
      ),
    ),
  );
}

mainlinesWidget(BuildContext context, SportEvents gameDetails,
    Competitors? awayTeam, Competitors? homeTeam) {
  return GetBuilder<GameListingController>(builder: (con) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery
              .of(context)
              .size
              .height * .02,
          left: MediaQuery
              .of(context)
              .size
              .height * .02,
          right: MediaQuery
              .of(context)
              .size
              .height * .02),
      child: Container(
        // height: MediaQuery.of(context).size.height * .245,
        decoration: BoxDecoration(
            borderRadius:
            BorderRadius.circular(MediaQuery
                .of(context)
                .size
                .width * .01),
            color: Theme
                .of(context)
                .canvasColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            mainLinesHeader(context),
            mainLinesDataWidget(awayTeam, gameDetails, context, homeTeam)
                .paddingSymmetric(
              vertical: MediaQuery
                  .of(context)
                  .size
                  .height * .005,
            )
          ],
        ),
      ),
    );
  });
}

Row mainLinesDataWidget(Competitors? awayTeam, SportEvents gameDetails,
    BuildContext context, Competitors? homeTeam) {
  return Row(
    children: [
      Expanded(
        flex: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  awayLogo(awayTeam, gameDetails),
                  width: Get.height * .035,
                  height: Get.height * .035,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                      Container(
                        width: Get.height * .035,
                        height: Get.height * .035,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: greyColor.withOpacity(0.2),
                        ),
                      ),
                ),
                (MediaQuery
                    .of(context)
                    .size
                    .height * .01).W(),
                Expanded(
                  flex: 2,
                  child: Text(
                    ('${awayTeam?.abbreviation} ${awayTeam?.name
                        ?.split(' ')
                        .last}')
                        .toString(),
                    style: GoogleFonts.nunitoSans(
                      color: Theme
                          .of(context)
                          .highlightColor,
                      fontWeight: FontWeight.w700,
                      fontSize: Get.height * .016,
                    ),
                    textAlign: TextAlign.start,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 0,
                  child: Text(
                    '@  ',
                    style: GoogleFonts.nunitoSans(
                      color: Theme
                          .of(context)
                          .highlightColor,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  homeLogo(homeTeam, gameDetails),
                  width: Get.height * .035,
                  height: Get.height * .035,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                      Container(
                        width: Get.height * .035,
                        height: Get.height * .035,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: greyColor.withOpacity(0.2),
                        ),
                      ),
                ),
                (MediaQuery
                    .of(context)
                    .size
                    .height * .01).W(),
                Expanded(
                  flex: 2,
                  child: Text(
                    ('${homeTeam?.abbreviation} ${homeTeam?.name
                        ?.split(' ')
                        .last}')
                        .toString(),
                    style: GoogleFonts.nunitoSans(
                      color: Theme
                          .of(context)
                          .highlightColor,
                      fontWeight: FontWeight.w700,
                      fontSize: Get.height * .016,
                    ),
                    textAlign: TextAlign.start,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ],
        ).paddingOnly(left: MediaQuery
            .of(context)
            .size
            .height * .01),
      ),
      buildExpandedBoxWidget(context,
          isDetail: true,
          bottomText: gameDetails.homeSpreadValue.contains('-')
              ? gameDetails.homeSpreadValue
              : '+${gameDetails.homeSpreadValue}',
          upText: gameDetails.awaySpreadValue.contains('-')
              ? gameDetails.awaySpreadValue
              : '+${gameDetails.awaySpreadValue}'),
      buildExpandedBoxWidget(context,
          isDetail: true,
          bottomText: gameDetails.homeMoneyLineValue,
          upText: gameDetails.awayMoneyLineValue),
      Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * .04,
                // width: MediaQuery.of(context).size.width * .09,
                decoration: BoxDecoration(
                    color: Theme
                        .of(context)
                        .primaryColor,
                    borderRadius: BorderRadius.circular(
                        MediaQuery
                            .of(context)
                            .size
                            .width * .008)),
                child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      textBaseline: TextBaseline.alphabetic,
                      verticalDirection: VerticalDirection.up,
                      children: [
                        Text('o',
                            style: GoogleFonts.nunitoSans(
                                color: Theme
                                    .of(context)
                                    .cardColor,
                                fontWeight: FontWeight.bold,
                                fontSize: Get.height * .014)),
                        Text((gameDetails.awayOUValue).toString(),
                            style: GoogleFonts.nunitoSans(
                                color: Theme
                                    .of(context)
                                    .cardColor,
                                fontWeight: FontWeight.bold,
                                fontSize: Get.height * .014)),
                      ],
                    )),
              ).paddingSymmetric(
                horizontal: mobileView.size.shortestSide < 600
                    ? MediaQuery
                    .of(context)
                    .size
                    .height * .008
                    : MediaQuery
                    .of(context)
                    .size
                    .height * .015,
              ),
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * .01,
              ),
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * .04,
                // width: MediaQuery.of(context).size.width * .09,
                decoration: BoxDecoration(
                    color: Theme
                        .of(context)
                        .primaryColor,
                    borderRadius: BorderRadius.circular(
                        MediaQuery
                            .of(context)
                            .size
                            .width * .008)),
                child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      textBaseline: TextBaseline.alphabetic,
                      verticalDirection: VerticalDirection.up,
                      children: [
                        Text('u',
                            style: GoogleFonts.nunitoSans(
                                color: Theme
                                    .of(context)
                                    .cardColor,
                                fontWeight: FontWeight.bold,
                                fontSize: Get.height * .014)),
                        Text((gameDetails.homeOUValue).toString(),
                            style: GoogleFonts.nunitoSans(
                                color: Theme
                                    .of(context)
                                    .cardColor,
                                fontWeight: FontWeight.bold,
                                fontSize: Get.height * .014)),
                      ],
                    )),
              ).paddingSymmetric(
                horizontal: mobileView.size.shortestSide < 600
                    ? MediaQuery
                    .of(context)
                    .size
                    .height * .008
                    : MediaQuery
                    .of(context)
                    .size
                    .height * .015,
              )
            ],
          )),
    ],
  );
}

Container mainLinesHeader(BuildContext context) {
  return Container(
      height: MediaQuery
          .of(context)
          .size
          .height * .032,
      width: Get.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(MediaQuery
                  .of(context)
                  .size
                  .width * .01)),
          color: Theme
              .of(context)
              .disabledColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: ''.appCommonText(
                color: Theme
                    .of(context)
                    .cardColor,
                align: TextAlign.start,
                weight: FontWeight.w600,
                size: Get.height * .018),
          ),
          Expanded(
            child: spread.appCommonText(
                color: Theme
                    .of(context)
                    .cardColor,
                align: TextAlign.center,
                weight: FontWeight.w600,
                size: Get.height * .016),
          ),
          Expanded(
            child: moneyLine.appCommonText(
                color: Theme
                    .of(context)
                    .cardColor,
                align: TextAlign.center,
                weight: FontWeight.w600,
                size: Get.height * .016),
          ),
          Expanded(
            child: overUnder.appCommonText(
                color: Theme
                    .of(context)
                    .cardColor,
                align: TextAlign.center,
                weight: FontWeight.w600,
                size: Get.height * .016),
          ),
        ],
      ).paddingSymmetric(horizontal: MediaQuery
          .of(context)
          .size
          .height * .01));
}

Widget hotlinesCard(GameDetailsController con,
    SportEvents gameDetails,
    Competitors? awayTeam,
    Competitors? homeTeam,
    TabController tabController,
    BuildContext context) {
  return ListView.separated(
    padding: EdgeInsets.zero,
    shrinkWrap: true,
    itemCount: con.hotlinesIndex == 0
        ? gameDetails.hotlinesData.length >= 6
        ? 6
        : gameDetails.hotlinesData.length
        : con.hotlinesIndex == 1
        ? gameDetails.hotlinesDData.length >= 6
        ? 6
        : gameDetails.hotlinesDData.length
        : con.hotlinesIndex == 2
        ? gameDetails.hotlinesFData.length >= 6
        ? 6
        : gameDetails.hotlinesFData.length
        : gameDetails.hotlinesMData.length >= 6
        ? 6
        : gameDetails.hotlinesMData.length,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      return SizedBox(
        // height:
        //     MediaQuery.of(context).size.height * .038,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery
                  .of(context)
                  .size
                  .width * .016),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.network(
                (homeTeam?.id ==
                    (con.hotlinesIndex == 0
                        ? gameDetails.hotlinesData[index].teamId
                        : con.hotlinesIndex == 1
                        ? gameDetails.hotlinesDData[index].teamId
                        : con.hotlinesIndex == 2
                        ? gameDetails.hotlinesFData[index].teamId
                        : gameDetails.hotlinesMData[index].teamId))
                    ? homeLogo(homeTeam, gameDetails)
                    : awayLogo(awayTeam, gameDetails),
                height: MediaQuery
                    .of(context)
                    .size
                    .height * .03,
                width: MediaQuery
                    .of(context)
                    .size
                    .width * .04,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) =>
                    Container(
                      width: Get.height * .025,
                      height: Get.height * .025,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: greyColor.withOpacity(0.2),
                      ),
                    ),
              ).paddingOnly(right: MediaQuery
                  .of(context)
                  .size
                  .width * .01),
              Expanded(
                flex: mobileView.size.shortestSide < 600 ? 7 : 4,
                child: (con.hotlinesIndex == 0
                    ? gameDetails.hotlinesData[index].teamName
                    : con.hotlinesIndex == 1
                    ? gameDetails.hotlinesDData[index].teamName
                    : con.hotlinesIndex == 2
                    ? gameDetails.hotlinesFData[index].teamName
                    : gameDetails.hotlinesMData[index].teamName)
                    .appCommonText(
                    color: Theme
                        .of(context)
                        .highlightColor,
                    weight: FontWeight.bold,
                    align: TextAlign.start,
                    size: mobileView.size.shortestSide < 600
                        ? MediaQuery
                        .of(context)
                        .size
                        .height * .014
                        : MediaQuery
                        .of(context)
                        .size
                        .height * .016),
              ),
              /* Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: (gameDetails.venue != null
                      ? '${gameDetails.venue?.name}, '
                      : '')
                      .toString()
                      .appCommonText(
                      size: MediaQuery.of(context).size.height *
                          .014,
                      color: lightGrayColor,
                      weight: FontWeight.w600),
                ),
              ),*/
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme
                          .of(context)
                          .primaryColor,
                      borderRadius: BorderRadius.circular(0)),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Center(
                      child: (con.hotlinesIndex == 0
                          ? gameDetails.hotlinesData[index].value
                          : con.hotlinesIndex == 1
                          ? gameDetails.hotlinesDData[index].value
                          : con.hotlinesIndex == 2
                          ? gameDetails.hotlinesFData[index].value
                          : gameDetails.hotlinesMData[index].value)
                          .appCommonText(
                          color: Theme
                              .of(context)
                              .cardColor,
                          size: MediaQuery
                              .of(context)
                              .size
                              .height * .014,
                          weight: FontWeight.w600)
                          .paddingSymmetric(
                          vertical:
                          MediaQuery
                              .sizeOf(context)
                              .height * .008),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * .02,
              ),
              Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * .04,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * .052,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(
                              ((con.hotlinesIndex == 0
                                  ? gameDetails.hotlinesData[index].bookId
                                  : con.hotlinesIndex == 1
                                  ? gameDetails.hotlinesDData[index].bookId
                                  : con.hotlinesIndex == 2
                                  ? gameDetails.hotlinesFData[index].bookId
                                  : gameDetails.hotlinesMData[index]
                                  .bookId) ==
                                  'sr:book:18186')
                                  ? Assets.imagesFanduel
                                  : ((con.hotlinesIndex == 0
                                  ? gameDetails.hotlinesData[index].bookId
                                  : con.hotlinesIndex == 1
                                  ? gameDetails.hotlinesDData[index].bookId
                                  : con.hotlinesIndex == 2
                                  ? gameDetails.hotlinesFData[index]
                                  .bookId
                                  : gameDetails.hotlinesMData[index]
                                  .bookId) ==
                                  'sr:book:17324')
                                  ? Assets.imagesMgm
                                  : Assets.imagesDraftkings,
                            ),
                            fit: BoxFit.contain,
                          )),
                    ),
                  )),
            ],
          ),
        ),
      );
    },
    separatorBuilder: (BuildContext context, int index) {
      return commonDivider(context);
    },
  );
}

SizedBox emptyListWidget(BuildContext context, SportEvents gameDetails,
    {bool isAll = false}) {
  return SizedBox(
    height: MediaQuery
        .of(context)
        .size
        .height * .1,
    child: Center(
        child:
        (/*gameDetails.status == 'live' || gameDetails.status == 'closed'
                ? 'Not available'
                :*/
            'Available closer to game time')
            .appCommonText(
            weight: FontWeight.bold,
            size: Get.height * .014,
            color: Theme
                .of(context)
                .highlightColor)),
  );
}

SizedBox circularWidget(BuildContext context) {
  return SizedBox(
    // height: MediaQuery.of(context).size.height * .02,
    width: Get.width,
    child: Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: MediaQuery
            .of(context)
            .size
            .height * .02,
        width: MediaQuery
            .of(context)
            .size
            .height * .02,
        child: CircularProgressIndicator(
          strokeWidth: mobileView.size.shortestSide < 600 ? 2 : 3,
          color: Theme
              .of(context)
              .primaryColor,
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
                    size: MediaQuery
                        .of(context)
                        .size
                        .height * .016,
                    weight: FontWeight.w600),
                '47'.appCommonText(
                    color: blackColor,
                    size: MediaQuery
                        .of(context)
                        .size
                        .height * .016,
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
          width: MediaQuery
              .of(context)
              .size
              .width * .01,
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
      height: MediaQuery
          .of(context)
          .size
          .height * .031,
      decoration: BoxDecoration(color: Theme
          .of(context)
          .disabledColor),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery
                .of(context)
                .size
                .width * .010),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: game.appCommonText(
                  color: Theme
                      .of(context)
                      .highlightColor,
                  weight: FontWeight.w600,
                  size: Get.height * .016),
            ),
            Expanded(
              flex: 1,
              child: spread.appCommonText(
                  color: Theme
                      .of(context)
                      .highlightColor,
                  weight: FontWeight.w600,
                  size: Get.height * .016),
            ),
            Expanded(
              flex: 1,
              child: moneyLine.appCommonText(
                  color: Theme
                      .of(context)
                      .highlightColor,
                  weight: FontWeight.w600,
                  size: Get.height * .016),
            ),
            Expanded(
              flex: 1,
              child: overUnder.appCommonText(
                  color: Theme
                      .of(context)
                      .highlightColor,
                  weight: FontWeight.w600,
                  size: Get.height * .016),
            ),
          ],
        ),
      ));
}

String teamLogo(Competitors? team, String? defaultLogo) {
  if (team == null) return defaultLogo ?? '';

  final logoMap = {
    "UTRGV":'https://a.espncdn.com/combiner/i?img=/i/teamlogos/ncaa/500/292.png&h=200&w=200',
    "ETAL":"https://a.espncdn.com/combiner/i?img=/i/teamlogos/ncaa/500/2837.png&h=200&w=200",
    'ALBY': "https://a.espncdn.com/i/teamlogos/ncaa/500/399.png",
    'MTU': "https://a.espncdn.com/combiner/i?img=/i/teamlogos/ncaa/500/2393.png&h=200&w=200",
    'SCUS': "https://a.espncdn.com/i/teamlogos/ncaa/500/2541.png",
    'UAG': "https://a.espncdn.com/combiner/i?img=/i/teamlogos/ncaa/500/399.png&h=200&w=200",
    'WEBB': "https://a.espncdn.com/i/teamlogos/ncaa/500/2241.png",
    'ARI': "https://a.espncdn.com/i/teamlogos/nfl/500/scoreboard/ari.png",
    'LINW': "https://a.espncdn.com/i/teamlogos/ncaa/500/2815.png",
    'WAS': team.id == "sr:competitor:4432"
        ? "https://a.espncdn.com/i/teamlogos/nfl/500/scoreboard/wsh.png"
        : null,
    'QUC': "https://a.espncdn.com/i/teamlogos/ncaa/500/2511.png",
    'FAMU': "https://a.espncdn.com/i/teamlogos/ncaa/500/57.png",
    'UST': "https://a.espncdn.com/i/teamlogos/ncaa/500/2900.png",
    'MCNS': "https://a.espncdn.com/i/teamlogos/ncaa/500/2377.png",
    'GC': "https://a.espncdn.com/i/teamlogos/ncaa/500/2253.png",
    'CSB': "https://a.espncdn.com/i/teamlogos/ncaa/500/2934.png",
    'NCST': "https://a.espncdn.com/i/teamlogos/ncaa/500/152.png",
    'ULL': "https://a.espncdn.com/i/teamlogos/ncaa/500/309.png",
    'UMKC': "https://a.espncdn.com/i/teamlogos/ncaa/500/140.png",
    'SIND': "https://a.espncdn.com/i/teamlogos/ncaa/500/2635.png",
    'CSN': "https://a.espncdn.com/i/teamlogos/ncaa/500/2463.png",
    'IUN': "https://a.espncdn.com/i/teamlogos/ncaa/500/2546.png",
    'LMC': "https://dxbhsrqyrr690.cloudfront.net/sidearm.nextgen.sites/lemoyne.sidearmsports.com/images/logos/site/site.png",
    'SHS': "https://a.espncdn.com/i/teamlogos/ncaa/500/2534.png",
    'IUI': "https://a.espncdn.com/combiner/i?img=/i/teamlogos/ncaa/500/85.png&h=200&w=200",
  };

  // Return the logo if the abbreviation exists in the map.
  return logoMap[team.abbreviation] ?? defaultLogo ?? '';
}

String awayLogo(Competitors? awayTeam, SportEvents gameDetails) {
  return teamLogo(awayTeam, gameDetails.gameLogoAwayLink);
}

String homeLogo(Competitors? homeTeam, SportEvents gameDetails) {
  return teamLogo(homeTeam, gameDetails.gameHomeLogoLink);
}

headerWidget(BuildContext context, SportEvents gameDetails,
    Competitors? awayTeam, Competitors? homeTeam, String sportKey) {
  return Stack(
    // fit: StackFit.loose,
    alignment: Alignment.topCenter,
    clipBehavior: Clip.none,
    children: [
      Padding(
        padding: EdgeInsets.all(MediaQuery
            .of(context)
            .size
            .height * .02),
        child: GetBuilder<GameListingController>(builder: (con) {
          String dateTime = DateFormat.jm()
              .format(DateTime.parse(gameDetails.scheduled ?? '').toLocal());
          String date = DateFormat.d()
              .format((DateTime.parse(gameDetails.scheduled ?? '')).toLocal());
          String month = DateFormat.MMM()
              .format((DateTime.parse(gameDetails.scheduled ?? '')).toLocal());
          String time = DateFormat('hh:mm').format(
              DateTime.parse(gameDetails.scheduled ?? '')
                  .toLocal());
          // String year = DateFormat.y().format(
          //     (DateTime.parse(gameDetails.scheduled ?? '')).toLocal());
          String day = DateFormat
              .MMMEd()
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
                  MediaQuery
                      .of(context)
                      .size
                      .width * .01),
              gradient: LinearGradient(colors: [
                Theme
                    .of(context)
                    .shadowColor,
                Theme
                    .of(context)
                    .secondaryHeaderColor,
              ]),
            ),
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
                          awayLogo(awayTeam, gameDetails),
                          width: Get.height * .048,
                          height: Get.height * .048,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                width: Get.height * .035,
                                height: Get.height * .035,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: greyColor.withOpacity(0.2),
                                ),
                              ),
                        ),
                        gameDetails.awayRank != "0"
                            ? RichText(
                            textAlign: TextAlign.end,
                            text: TextSpan(
                                text: gameDetails.awayRank == '0'
                                    ? ""
                                    : '(${gameDetails.awayRank})',
                                style: GoogleFonts.nunitoSans(
                                    color: whiteColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize:
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .height *
                                        .014),
                                children: [
                                  TextSpan(
                                      text: (mobileView.size.shortestSide <
                                          600
                                          ? awayTeam?.abbreviation
                                          : awayTeam?.name?.replaceAll(
                                          '${awayTeam.name
                                              ?.split(' ')
                                              .first}',
                                          '') ??
                                          ''),
                                      style: GoogleFonts.nunitoSans(
                                          color: whiteColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery
                                              .of(context)
                                              .size
                                              .height *
                                              .016))
                                ]))
                            : (mobileView.size.shortestSide < 600
                            ? awayTeam?.abbreviation
                            : awayTeam?.name?.replaceAll(
                            '${awayTeam.name
                                ?.split(' ')
                                .first}',
                            '') ??
                            '')
                            .toString()
                            .appCommonText(
                            weight: FontWeight.bold,
                            size: MediaQuery
                                .of(context)
                                .size
                                .height *
                                .016,
                            align: TextAlign.end,
                            maxLine: 1,
                            color: whiteColor),
                        ('${gameDetails.awayWin}-${gameDetails.awayLoss}')
                            .appCommonText(
                            align: TextAlign.end,
                            weight: FontWeight.w400,
                            size: MediaQuery
                                .of(context)
                                .size
                                .height * .014,
                            color: whiteColor),
                      ],
                    )),
                Expanded(
                    flex: mobileView.size.shortestSide < 600 ? 5 : 3,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        (mobileView.size.shortestSide < 600
                            ? '${gameDetails.awayScore} - ${gameDetails
                            .homeScore}'
                            : '${gameDetails.awayScore}  -  ${gameDetails
                            .homeScore}')
                            .appCommonText(
                            color: whiteColor,
                            size: MediaQuery
                                .of(context)
                                .size
                                .height * .048,
                            weight: FontWeight.w700),
                        (gameDetails.status == "closed"
                            ? 'Final'
                            : ((sportKey == SportName.NFL.name || sportKey == SportName.NCAA.name) &&
                            gameDetails.currentTime.isNotEmpty)
                            ? gameDetails.currentTime
                            : '$day, $month $date , ${((gameDetails.status ==
                            'live' || gameDetails.status ==
                            'halftime' || gameDetails.status ==
                            'inprogress')
                            ? '${gameDetails.inningHalf}${gameDetails
                            .inning} ${(sportKey == SportName.NBA.name ||
                            sportKey == SportName.NCAAB.name)
                            ? " - ${gameDetails.clock}"
                            : " - ${gameDetails.outs}"}'
                            : dateTime)} ')
                            .appCommonText(
                            color: backGroundColor,
                            size: MediaQuery
                                .of(context)
                                .size
                                .height * .014,
                            weight: FontWeight.w600),
                        SizedBox(
                          height: MediaQuery
                              .of(context)
                              .size
                              .width * .003,
                        ),
                        Visibility(
                          visible: sportKey == SportName.NFL.name ||
                              sportKey == SportName.NCAA.name || sportKey == SportName.NCAAB.name ||
                              sportKey == SportName.MLB.name,
                          child: Row(
                            //  crossAxisAlignment: WrapCrossAlignment.center,
                            // alignment: WrapAlignment.center,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Flexible(
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: (gameDetails.venue != null
                                            ? '${gameDetails.venue?.name} '
                                            : '')
                                            .toString()
                                            .appCommonText(
                                            size: MediaQuery
                                                .of(context)
                                                .size
                                                .height *
                                                .014,
                                            color: lightGrayColor,
                                            weight: FontWeight.w600),
                                      ),
                                    ),
                                    Visibility(
                                      // Hide weather for NCAAB, NBA, and MLB
                                      visible: !(sportKey == SportName.NCAAB.name || sportKey == SportName.NBA.name || sportKey == SportName.MLB.name),
                                      child: (gameDetails.tmpInFahrenheit == 32
                                          ? ",TBD"
                                          : gameDetails.tmpInFahrenheit
                                          .toString()
                                          .split('.')
                                          .first)
                                          .toString()
                                          .appCommonText(
                                          size: MediaQuery
                                              .of(context)
                                              .size
                                              .height *
                                              .014,
                                          color: whiteColor,
                                          weight: FontWeight.w400),
                                    ),
                                    Visibility(
                                      // Hide weather for NCAAB, NBA, and MLB
                                      visible: !(sportKey == SportName.NCAAB.name || sportKey == SportName.NBA.name || sportKey == SportName.MLB.name),
                                      child: ' °F '.appCommonText(
                                        size: MediaQuery
                                            .of(context)
                                            .size
                                            .height *
                                            .01,
                                        weight: FontWeight.w300,
                                        color: whiteColor,
                                      ),
                                    ),
                                    Visibility(
                                      // Hide weather for NCAAB, NBA, and MLB
                                      visible: !(sportKey == SportName.NCAAB.name || sportKey == SportName.NBA.name || sportKey == SportName.MLB.name),
                                      child: getWeatherIcon(
                                          gameDetails.weather,
                                          context,
                                          MediaQuery
                                              .of(context)
                                              .size
                                              .height *
                                              .02),
                                    )
                                    /*   getWeatherIcon(
                                        (gameDetails.venue != null
                                            ? gameDetails.venue?.weather ??
                                            'Sunny'
                                            : 'Sunny'),
                                        context,
                                        MediaQuery.of(context).size.height * .02)*/
                                  ],
                                ),
                              ),
                            ],
                          ),
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
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                width: Get.height * .035,
                                height: Get.height * .035,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: greyColor.withOpacity(0.2),
                                ),
                              ),
                          homeLogo(homeTeam, gameDetails),
                          width: Get.height * .048,
                          height: Get.height * .048,
                          fit: BoxFit.contain,
                        ),
                        gameDetails.homeRank != "0"
                            ? RichText(
                            textAlign: TextAlign.end,
                            text: TextSpan(
                                text: (mobileView.size.shortestSide < 600
                                    ? homeTeam?.abbreviation
                                    : homeTeam?.name?.replaceAll(
                                    '${homeTeam.name
                                        ?.split(' ')
                                        .last}',
                                    '') ??
                                    ''),
                                style: GoogleFonts.nunitoSans(
                                    color: whiteColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: MediaQuery
                                        .of(context)
                                        .size
                                        .height *
                                        .016),
                                children: [
                                  TextSpan(
                                      text: gameDetails.homeRank == '0'
                                          ? ""
                                          : '(${gameDetails.homeRank})',
                                      style: GoogleFonts.nunitoSans(
                                          color: whiteColor,
                                          fontWeight: FontWeight.w400,
                                          fontSize: MediaQuery
                                              .of(context)
                                              .size
                                              .height *
                                              .014))
                                ]))
                            : (mobileView.size.shortestSide < 600
                            ? homeTeam?.abbreviation
                            : homeTeam?.name?.replaceAll(
                            '${homeTeam.name
                                ?.split(' ')
                                .last}',
                            '') ??
                            '')
                            .toString()
                            .appCommonText(
                            weight: FontWeight.bold,
                            size: MediaQuery
                                .of(context)
                                .size
                                .height * .016,
                            align: TextAlign.start,
                            maxLine: 1,
                            color: whiteColor),
                        (' ${gameDetails.homeWin}-${gameDetails.homeLoss}')
                            .appCommonText(
                            align: TextAlign.end,
                            weight: FontWeight.w400,
                            size: MediaQuery
                                .of(context)
                                .size
                                .height * .014,
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
            ).paddingOnly(bottom: MediaQuery
                .of(context)
                .size
                .height * .005),
          );
        }),
      ),
      (gameDetails.status == 'live' || gameDetails.status == "inprogress" ||
          gameDetails.status == "halftime")
          ? Positioned(
        top: MediaQuery
            .of(context)
            .size
            .height * .010,
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height * .02,
          // width: MediaQuery.of(context).size.width * .07,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(105), color: redColor),
          child: Center(
            child: 'LIVE'
                .appCommonText(
                letterSpacing: 1,
                color: whiteColor,
                size: MediaQuery
                    .of(context)
                    .size
                    .height * .012,
                weight: FontWeight.bold)
                .paddingSymmetric(
                horizontal: MediaQuery
                    .of(context)
                    .size
                    .height * .01),
          ),
        ),
      )
          : const SizedBox(),
    ],
  );
}

class ClipTab extends StatelessWidget {
  const ClipTab(
      {Key? key, required this.teamLogo, required this.isSelected, this.onTap})
      : super(key: key);

  final String teamLogo;
  final bool isSelected;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: InkWell(
          highlightColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                  color: isSelected ? yellowColor : Theme
                      .of(context)
                      .disabledColor,
                  width: 3),
              borderRadius: BorderRadius.circular(2),
              color: Theme
                  .of(context)
                  .disabledColor,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                commonCachedNetworkImage(
                  width: Get.height * .028,
                  height: Get.height * .028,
                  imageUrl: teamLogo,
                ),
                '  Offense'.appCommonText(
                  size: Get.height * .018,
                  weight: FontWeight.bold,
                  color: Theme
                      .of(context)
                      .cardColor,
                )
              ],
            ).paddingSymmetric(horizontal: 10.h, vertical: 6.h),
          ),
        ));
  }
}
