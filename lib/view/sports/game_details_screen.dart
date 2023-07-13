import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hotlines/generated/assets.dart';
import 'package:hotlines/theme/app_color.dart';
import 'package:hotlines/utils/extension.dart';
import 'package:intl/intl.dart';

import '../../constant/constant.dart';
import '../../constant/shred_preference.dart';
import '../../controller/game_details_controller.dart';
import '../../controller/selecte_game_con.dart';
import '../../model/game_detail_model.dart';
import '../../theme/helper.dart';
import '../../utils/app_progress.dart';
import '../../utils/layouts.dart';

// ignore: must_be_immutable
class SportDetailsScreen extends StatefulWidget {
  const SportDetailsScreen({
    Key? key,
    required this.gameDetails,
    required this.sportKey,
  }) : super(key: key);
  final Result gameDetails;
  final String sportKey;

  @override
  State<SportDetailsScreen> createState() => _SportDetailsScreenState();
}

class _SportDetailsScreenState extends State<SportDetailsScreen> {
  final SelectGameController selectGameController = Get.find();
  final GameDetailsController gameDetailsController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.sportKey == 'MLB'
        ? gameDetailsController.mlbInjuriesReportResponse(context,
            teamAwayName: widget.gameDetails.teams.away.abbreviation,
            teamHomeName: widget.gameDetails.teams.home.abbreviation,
            league: widget.sportKey)
        : gameDetailsController.nflInjuriesReportResponse(context,
            teamAwayName: widget.gameDetails.teams.away.abbreviation,
            teamHomeName: widget.gameDetails.teams.home.abbreviation,
            league: widget.sportKey);
  }

  Future _refreshLocalGallery() async {
    // getRanking();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = PreferenceManager.getIsDarkMode() ?? false;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: commonAppBarWidget(context, isDark),
      body: RefreshIndicator(
        onRefresh: () {
          return _refreshLocalGallery();
        },
        color: Theme.of(context).disabledColor,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      headerWidget(context),
                      playerPropBetsWidget(context),
                      teamReportWidget(context),
                      widget.sportKey == 'MLB'
                          ? mlbInjuryReportWidget(context)
                          : nflInjuryReportWidget(context),
                      40.H(),
                    ],
                  ),
                ))
              ],
            ),
            Obx(() => gameDetailsController.isLoading.value
                ? const AppProgress()
                : const SizedBox())
          ],
        ),
      ),
    );
  }

  PreferredSize commonAppBarWidget(BuildContext context, bool isDark) {
    return PreferredSize(
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
                  '${widget.gameDetails.teams.away.abbreviation} @ ${widget.gameDetails.teams.home.abbreviation}'
                      .appCommonText(
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
                  )
                ],
              ),
            ),
          );
        }));
  }

  Padding teamReportWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * .02),
      child: Container(
        // height: MediaQuery.of(context).size.height * .227,
        decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(MediaQuery.of(context).size.width * .01),
            color: Theme.of(context).canvasColor),
        child: GetBuilder<GameDetailsController>(initState: (state) {
          getRanking();
        }, builder: (controller) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              headerTitleWidget(context, teamReport, isTeamReport: true),
              rankingCommonWidget(context, 'Offensive Rankings'),
              commonRankingWidget(context,
                  teamReports: controller.offensive[0],
                  awayText: '0',
                  homeText: '0'),
              commonRankingWidget(context,
                  teamReports: controller.offensive[1],
                  awayText: '0',
                  homeText: '0'),
              commonRankingWidget(context,
                  teamReports: controller.offensive[2],
                  awayText: '0',
                  homeText: '0'),
              commonRankingWidget(context,
                  teamReports: controller.offensive[3],
                  awayText: '0',
                  homeText: '0'),
              commonRankingWidget(context,
                  teamReports: controller.offensive[4],
                  awayText: '0',
                  homeText: '0'),
              commonRankingWidget(context,
                  teamReports: controller.offensive[5],
                  awayText: '0',
                  homeText: '0'),
              commonRankingWidget(context,
                  teamReports: controller.offensive[6],
                  awayText: controller.awayRushingOffenseTDs,
                  homeText: controller.homeRushingOffenseTDs),
              commonRankingWidget(context,
                  teamReports: controller.offensive[7],
                  awayText: controller.awayPassingOffenseTDs,
                  homeText: controller.homePassingOffenseTDs),
              commonRankingWidget(context,
                  teamReports: controller.offensive[8],
                  awayText: '0',
                  homeText: '0'),
              commonRankingWidget(context,
                  teamReports: controller.offensive[9],
                  awayText: '0',
                  homeText: '0'),
              commonRankingWidget(context,
                  teamReports: controller.offensive[10],
                  awayText: '0',
                  homeText: '0'),
              commonRankingWidget(context,
                  teamReports: controller.offensive[11],
                  awayText: '0',
                  homeText: '0'),
              rankingCommonWidget(context, 'Defensive Rankings'),
              commonRankingWidget(context,
                  teamReports: controller.defensive[0],
                  awayText: '0',
                  homeText: '0'),
              commonRankingWidget(context,
                  teamReports: controller.defensive[1],
                  awayText: '0',
                  homeText: '0'),
              commonRankingWidget(context,
                  teamReports: controller.defensive[2],
                  awayText: '0',
                  homeText: '0'),
              commonRankingWidget(context,
                  teamReports: controller.defensive[3],
                  awayText: '0',
                  homeText: '0'),
              commonRankingWidget(context,
                  teamReports: controller.defensive[4],
                  awayText: '0',
                  homeText: '0'),
              commonRankingWidget(context,
                  teamReports: controller.defensive[5],
                  awayText: '0',
                  homeText: '0'),
              commonRankingWidget(context,
                  teamReports: controller.defensive[6],
                  awayText: controller.awayRushingDefenseTDs,
                  homeText: controller.homeRushingDefenseTDs),
              commonRankingWidget(context,
                  teamReports: controller.defensive[7],
                  awayText: controller.awayPassingDefenseTDs,
                  homeText: controller.homePassingDefenseTDs),
              commonRankingWidget(context,
                  teamReports: controller.defensive[8],
                  awayText: '0',
                  homeText: '0'),
              commonRankingWidget(context,
                  teamReports: controller.defensive[9],
                  awayText: '0',
                  homeText: '0'),
              commonRankingWidget(context,
                  teamReports: controller.defensive[10],
                  awayText: '0',
                  homeText: '0'),
              rankingCommonWidget(context, 'Team Stats'),
              commonRankingWidget(context,
                  teamReports: controller.teamStatus[0],
                  awayText: controller.lastAwayGameRecord,
                  homeText: controller.lastHomeGameRecord),
              commonRankingWidget(context,
                  teamReports: controller.teamStatus[1],
                  awayText: '0',
                  homeText: '0'),
              commonRankingWidget(context,
                  teamReports: controller.teamStatus[2],
                  awayText: '0',
                  homeText: '0'),
              commonRankingWidget(context,
                  teamReports: controller.teamStatus[3],
                  awayText: '0',
                  homeText: '0'),
              commonRankingWidget(context,
                  teamReports: controller.teamStatus[4],
                  awayText: '0',
                  homeText: '0'),
              commonRankingWidget(context,
                  teamReports: controller.teamStatus[5],
                  awayText: '0',
                  homeText: '0'),
            ],
          );
        }),
      ),
    );
  }

  Future getRanking() {
    gameDetailsController.nflRushingOffenseRankingResponse(context,
        awayTeam: widget.gameDetails.teams.away.mascot,
        homeTeam: widget.gameDetails.teams.home.mascot,
        year: '2022',
        isLoad: true);
    gameDetailsController.nflRushingDefenseRankingResponse(context,
        awayTeam: widget.gameDetails.teams.away.mascot,
        homeTeam: widget.gameDetails.teams.home.mascot,
        year: '2022',
        isLoad: true);
    gameDetailsController.nflPassingOffenseRankingResponse(context,
        awayTeam: widget.gameDetails.teams.away.mascot,
        homeTeam: widget.gameDetails.teams.home.mascot,
        year: '2022',
        isLoad: true);
    gameDetailsController.nflPassingDefenseRankingResponse(context,
        awayTeam: widget.gameDetails.teams.away.mascot,
        homeTeam: widget.gameDetails.teams.home.mascot,
        year: '2022',
        isLoad: true);
    return gameDetailsController.nflLastRecordResponse(context,
        awayTeam: widget.gameDetails.teams.away.team,
        homeTeam: widget.gameDetails.teams.home.team,
        year: '2022',
        isLoad: true);
  }

  Column commonRankingWidget(BuildContext context,
      {String homeText = '', String awayText = '', String teamReports = ''}) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .016,
              vertical: MediaQuery.of(context).size.height * .003),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: awayText.appCommonText(
                    color: Theme.of(context).highlightColor,
                    weight: FontWeight.w700,
                    align: TextAlign.end,
                    size: MediaQuery.of(context).size.height * .014),
              ),
              Expanded(
                flex: 2,
                child: teamReports.toString().appCommonText(
                    color: darkGreyColor,
                    align: TextAlign.center,
                    weight: FontWeight.w600,
                    size: MediaQuery.of(context).size.height * .016),
              ),
              Expanded(
                flex: 1,
                child: homeText.appCommonText(
                    color: Theme.of(context).highlightColor,
                    weight: FontWeight.w700,
                    align: TextAlign.start,
                    size: MediaQuery.of(context).size.height * .014),
              )
            ],
          ),
        ),
        commonDivider(context),
      ],
    );
  }

  Container rankingCommonWidget(BuildContext context, String title) {
    return Container(
      color: darkGreyColor,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * .003),
        child: Center(
          child: title.appCommonText(
              color: Theme.of(context).highlightColor,
              weight: FontWeight.bold,
              align: TextAlign.end,
              size: MediaQuery.of(context).size.height * .014),
        ),
      ),
    );
  }

  nflInjuryReportWidget(BuildContext context) {
    try {
      return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.height * .02),
        child: Container(
          // height: MediaQuery.of(context).size.height * .12,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                  MediaQuery.of(context).size.width * .01),
              color: Theme.of(context).canvasColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              headerTitleWidget(context, injuryReport),
              GetBuilder<GameDetailsController>(builder: (controller) {
                return controller.isLoading.value
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * .1,
                      )
                    : controller.injuredAwayPlayerList.isEmpty &&
                            controller.injuredHomePlayerList.isEmpty
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height * .1,
                            child: Center(
                              child: 'No Data'.appCommonText(
                                  color: Theme.of(context).highlightColor,
                                  weight: FontWeight.w700,
                                  align: TextAlign.start,
                                  size: MediaQuery.of(context).size.height *
                                      .016),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              controller.injuredAwayPlayerList.isNotEmpty
                                  ? Expanded(
                                      flex: 1,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: controller
                                                    .injuredAwayPlayerList
                                                    .length >=
                                                controller.injuredHomePlayerList
                                                    .length
                                            ? controller
                                                .injuredAwayPlayerList.length
                                            : controller
                                                .injuredHomePlayerList.length,
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
                                                  child: '${controller.injuredAwayPlayerList[index].shortName}(${controller.injuredAwayPlayerList[index].currentStatus})'
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
                                                        (controller
                                                                        .injuredAwayPlayerList
                                                                        .length >=
                                                                    controller
                                                                        .injuredHomePlayerList
                                                                        .length
                                                                ? controller
                                                                    .injuredAwayPlayerList
                                                                    .length
                                                                : controller
                                                                    .injuredHomePlayerList
                                                                    .length) -
                                                            1
                                                    ? const SizedBox()
                                                    : commonDivider(context),
                                              ],
                                            );
                                          } catch (e) {
                                            return commonCatchWidget(
                                                context, index, controller);
                                          }
                                        },
                                      ),
                                    )
                                  : commonEmptyInjuryReportWidget(controller),
                              commonEmptyInjuryReportWidget(controller),
                              controller.injuredHomePlayerList.isNotEmpty
                                  ? Expanded(
                                      flex: 1,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: controller
                                                    .injuredHomePlayerList
                                                    .length >=
                                                controller.injuredAwayPlayerList
                                                    .length
                                            ? controller
                                                .injuredHomePlayerList.length
                                            : controller
                                                .injuredAwayPlayerList.length,
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
                                                  child: '${controller.injuredHomePlayerList[index].shortName}(${controller.injuredHomePlayerList[index].currentStatus})'
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
                                                        (controller
                                                                        .injuredAwayPlayerList
                                                                        .length >=
                                                                    controller
                                                                        .injuredHomePlayerList
                                                                        .length
                                                                ? controller
                                                                    .injuredAwayPlayerList
                                                                    .length
                                                                : controller
                                                                    .injuredHomePlayerList
                                                                    .length) -
                                                            1
                                                    ? const SizedBox()
                                                    : commonDivider(context),
                                              ],
                                            );
                                          } catch (e) {
                                            return commonCatchWidget(
                                                context, index, controller);
                                          }
                                        },
                                      ),
                                    )
                                  : commonEmptyInjuryReportWidget(controller),
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

  mlbInjuryReportWidget(BuildContext context) {
    try {
      return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.height * .02),
        child: Container(
          // height: MediaQuery.of(context).size.height * .12,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                  MediaQuery.of(context).size.width * .01),
              color: Theme.of(context).canvasColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              headerTitleWidget(context, injuryReport),
              GetBuilder<GameDetailsController>(builder: (controller) {
                return controller.isLoading.value
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * .1,
                      )
                    : controller.mlbInjuredAwayPlayerList.isEmpty &&
                            controller.mlbInjuredHomePlayerList.isEmpty
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height * .1,
                            child: Center(
                              child: 'No Data'.appCommonText(
                                  color: Theme.of(context).highlightColor,
                                  weight: FontWeight.w700,
                                  align: TextAlign.start,
                                  size: MediaQuery.of(context).size.height *
                                      .016),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              controller.mlbInjuredAwayPlayerList.isNotEmpty
                                  ? Expanded(
                                      flex: 1,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: controller
                                                    .mlbInjuredAwayPlayerList
                                                    .length >=
                                                controller
                                                    .mlbInjuredHomePlayerList
                                                    .length
                                            ? controller
                                                .mlbInjuredAwayPlayerList.length
                                            : controller
                                                .mlbInjuredHomePlayerList
                                                .length,
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
                                                  child: '${controller.mlbInjuredAwayPlayerList[index].firstName}(${controller.mlbInjuredAwayPlayerList[index].injuryStatus})'
                                                      .toString()
                                                      .appCommonText(
                                                          color: Theme.of(
                                                                  context)
                                                              .highlightColor,
                                                          weight:
                                                              FontWeight.w700,
                                                          maxLine: 2,
                                                          align:
                                                              TextAlign.start,
                                                          size: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              .016),
                                                ),
                                                index ==
                                                        (controller
                                                                        .mlbInjuredAwayPlayerList
                                                                        .length >=
                                                                    controller
                                                                        .mlbInjuredHomePlayerList
                                                                        .length
                                                                ? controller
                                                                    .mlbInjuredAwayPlayerList
                                                                    .length
                                                                : controller
                                                                    .mlbInjuredHomePlayerList
                                                                    .length) -
                                                            1
                                                    ? const SizedBox()
                                                    : commonDivider(context),
                                              ],
                                            );
                                          } catch (e) {
                                            return commonCatchWidget(
                                                context, index, controller);
                                          }
                                        },
                                      ),
                                    )
                                  : commonEmptyInjuryReportWidget(controller),
                              commonEmptyInjuryReportWidget(controller),
                              controller.mlbInjuredHomePlayerList.isNotEmpty
                                  ? Expanded(
                                      flex: 1,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: controller
                                                    .mlbInjuredHomePlayerList
                                                    .length >=
                                                controller
                                                    .mlbInjuredAwayPlayerList
                                                    .length
                                            ? controller
                                                .mlbInjuredHomePlayerList.length
                                            : controller
                                                .mlbInjuredAwayPlayerList
                                                .length,
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
                                                  child: '${controller.mlbInjuredHomePlayerList[index].firstName}(${controller.mlbInjuredHomePlayerList[index].injuryStatus})'
                                                      .toString()
                                                      .appCommonText(
                                                          color: Theme.of(
                                                                  context)
                                                              .highlightColor,
                                                          weight:
                                                              FontWeight.w700,
                                                          maxLine: 2,
                                                          align:
                                                              TextAlign.start,
                                                          size: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              .016),
                                                ),
                                                index ==
                                                        (controller
                                                                        .mlbInjuredAwayPlayerList
                                                                        .length >=
                                                                    controller
                                                                        .mlbInjuredHomePlayerList
                                                                        .length
                                                                ? controller
                                                                    .mlbInjuredAwayPlayerList
                                                                    .length
                                                                : controller
                                                                    .mlbInjuredHomePlayerList
                                                                    .length) -
                                                            1
                                                    ? const SizedBox()
                                                    : commonDivider(context),
                                              ],
                                            );
                                          } catch (e) {
                                            return commonCatchWidget(
                                                context, index, controller);
                                          }
                                        },
                                      ),
                                    )
                                  : commonEmptyInjuryReportWidget(controller),
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

  Expanded commonEmptyInjuryReportWidget(GameDetailsController controller) {
    return Expanded(
      flex: 1,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.sportKey == 'MLB'
            ? controller.mlbInjuredAwayPlayerList.length >=
                    controller.mlbInjuredHomePlayerList.length
                ? controller.mlbInjuredAwayPlayerList.length
                : controller.mlbInjuredHomePlayerList.length
            : controller.injuredAwayPlayerList.length >=
                    controller.injuredHomePlayerList.length
                ? controller.injuredAwayPlayerList.length
                : controller.injuredHomePlayerList.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return commonCatchWidget(context, index, controller);
        },
      ),
    );
  }

  Column commonCatchWidget(
      BuildContext context, int index, GameDetailsController controller) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.width * .038,
        ),
        (widget.sportKey == 'MLB'
                ? (index ==
                    (controller.mlbInjuredAwayPlayerList.length >=
                                controller.mlbInjuredHomePlayerList.length
                            ? controller.mlbInjuredAwayPlayerList.length
                            : controller.mlbInjuredHomePlayerList.length) -
                        1)
                : (index ==
                    (controller.injuredAwayPlayerList.length >=
                                controller.injuredHomePlayerList.length
                            ? controller.injuredAwayPlayerList.length
                            : controller.injuredHomePlayerList.length) -
                        1))
            ? const SizedBox()
            : commonDivider(context),
      ],
    );
  }

  Container headerTitleWidget(BuildContext context, String title,
      {bool isTeamReport = false}) {
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
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: widget.gameDetails.teams.away.team.appCommonText(
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
                      imageUrl: widget.gameDetails.awayGameLogo),
                ],
              ),
            ),
            Expanded(
              flex: isTeamReport ? 2 : 1,
              child: title.appCommonText(
                  color: Theme.of(context).cardColor,
                  align: TextAlign.center,
                  maxLine: 1,
                  weight: FontWeight.w700,
                  size: Get.height * .018),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  commonCachedNetworkImage(
                      width: Get.height * .025,
                      height: Get.height * .025,
                      imageUrl: widget.gameDetails.homeGameLogo),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .01,
                  ),
                  Expanded(
                    child: widget.gameDetails.teams.home.team.appCommonText(
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
              itemCount: 3,
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
                              child: widget.gameDetails.teams.home.team
                                  .appCommonText(
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
                    index == 2 ? const SizedBox() : commonDivider(context),
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
            var data = widget.gameDetails.odds;

            String date = DateFormat.d()
                .format(widget.gameDetails.schedule.date.toLocal());
            String month = DateFormat.MMM()
                .format(widget.gameDetails.schedule.date.toLocal());
            String year = DateFormat.y()
                .format(widget.gameDetails.schedule.date.toLocal());
            String day = DateFormat.MMMEd()
                .format(widget.gameDetails.schedule.date.toLocal())
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
            // log('widget.gameDetails.awayLiveScores---${widget.gameDetails.awayLiveScores}');
            return Container(
              width: Get.width,
              height: MediaQuery.of(context).size.height * .175,
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
                        vertical: MediaQuery.of(context).size.height * .008),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        commonBoxWidget(
                          context,
                          title: (data.isNotEmpty
                              ? ('${data[0].spread.current.away.toString().contains('-') ? data[0].spread.current.away : '+${data[0].spread.current.away}'}')
                                  .toString()
                              : '00'),
                        ),
                        commonBoxWidget(context,
                            title: data.isNotEmpty
                                ? ('${data[0].moneyline.current.awayOdds.toString().contains('-') ? data[0].moneyline.current.awayOdds : '+${data[0].moneyline.current.awayOdds}'}')
                                    .toString()
                                : "00"),
                        commonBoxWidget(context,
                            title: data.isNotEmpty
                                ? ('o/u ${data[0].total.current.total.toInt()}')
                                    .toString()
                                : 'o/u 00')
                      ],
                    ),
                  )),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      commonCachedNetworkImage(
                          width: Get.height * .048,
                          height: Get.height * .048,
                          imageUrl: widget.gameDetails.awayGameLogo),
                      (widget.gameDetails.teams.away.mascot)
                          .toString()
                          .appCommonText(
                              weight: FontWeight.bold,
                              size: MediaQuery.of(context).size.height * .016,
                              align: TextAlign.end,
                              maxLine: 1,
                              color: whiteColor),
                      widget.gameDetails.liveSpreadAwayRecord.appCommonText(
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
                          SizedBox(
                            height: MediaQuery.of(context).size.width * .01,
                          ),
                          '$day, $month $date $year'.appCommonText(
                              color: whiteColor,
                              size: MediaQuery.of(context).size.height * .014,
                              weight: FontWeight.w600),
                          SizedBox(
                            height: MediaQuery.of(context).size.width * .01,
                          ),
                          '${widget.gameDetails.scoreboard?.score?.away ?? '0'} - ${widget.gameDetails.scoreboard?.score?.home ?? '0'}'
                              .appCommonText(
                                  color: whiteColor,
                                  size:
                                      MediaQuery.of(context).size.height * .048,
                                  weight: FontWeight.w700),
                          '${widget.gameDetails.venue.name}, ${widget.gameDetails.venue.state}'
                              .appCommonText(
                                  color: primaryColor,
                                  size:
                                      MediaQuery.of(context).size.height * .014,
                                  weight: FontWeight.w600),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              (widget.gameDetails.venue.tmpInFahrenheit)
                                  .toString()
                                  .appCommonText(
                                      size: MediaQuery.of(context).size.height *
                                          .018,
                                      color: whiteColor,
                                      weight: FontWeight.bold),
                              ' °F'.appCommonText(
                                size: MediaQuery.of(context).size.height * .01,
                                weight: FontWeight.bold,
                                color: whiteColor,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .01,
                              ),
                              getWeatherIcon(
                                  widget.gameDetails.venue.weather,
                                  context,
                                  MediaQuery.of(context).size.height * .024),
                            ],
                          ),
                        ],
                      )),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      commonCachedNetworkImage(
                          width: Get.height * .048,
                          height: Get.height * .048,
                          imageUrl: widget.gameDetails.homeGameLogo),
                      widget.gameDetails.teams.home.mascot.appCommonText(
                          weight: FontWeight.bold,
                          size: MediaQuery.of(context).size.height * .016,
                          align: TextAlign.start,
                          maxLine: 1,
                          color: whiteColor),
                      widget.gameDetails.liveSpreadHomeRecord.appCommonText(
                          align: TextAlign.end,
                          weight: FontWeight.w700,
                          size: MediaQuery.of(context).size.height * .014,
                          color: whiteColor),
                    ],
                  )),
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * .008),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        commonBoxWidget(context,
                            title: (data.isNotEmpty
                                ? ('${data[0].spread.current.home.toString().contains('-') ? data[0].spread.current.home : '+${data[0].spread.current.home}'}')
                                    .toString()
                                : '00')),
                        commonBoxWidget(context,
                            title: data.isNotEmpty
                                ? ('${data[0].moneyline.current.homeOdds.toString().contains('-') ? data[0].moneyline.current.homeOdds : '+${data[0].moneyline.current.homeOdds}'}')
                                    .toString()
                                : "00"),
                        commonBoxWidget(context,
                            title: data.isNotEmpty
                                ? ('o/u ${data[0].total.current.total.toInt()}')
                                    .toString()
                                : 'o/u 00')
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
