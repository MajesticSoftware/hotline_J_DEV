import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hotlines/generated/assets.dart';
import 'package:hotlines/model/game_listing.dart';
import 'package:hotlines/theme/app_color.dart';
import 'package:hotlines/utils/extension.dart';
import 'package:intl/intl.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

import '../../../constant/constant.dart';
import '../../../constant/shred_preference.dart';
import 'game_details_controller.dart';
import '../selectSport/selecte_game_con.dart';
import '../../../model/DET_KC_model.dart';
import 'package:http/http.dart' as http;
import '../../../theme/helper.dart';
import '../../../utils/app_progress.dart';
import '../../../utils/layouts.dart';

// ignore: must_be_immutable
class SportDetailsScreen extends StatefulWidget {
  const SportDetailsScreen({
    Key? key,
    required this.gameDetails,
    required this.sportKey,
    required this.sportId,
    required this.date,
  }) : super(key: key);
  final SportEvents gameDetails;
  final String sportKey;
  final String sportId;
  final String date;

  @override
  State<SportDetailsScreen> createState() => _SportDetailsScreenState();
}

class _SportDetailsScreenState extends State<SportDetailsScreen> {
  final GameDetailsController gameDetailsController = Get.find();
  late ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }

  Future _refreshLocalGallery() async {
    // getRanking();
  }
  Competitors? homeTeam;
  Competitors? awayTeam;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    var client = http.Client();
    _controller.dispose();
    client.close();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = PreferenceManager.getIsDarkMode() ?? false;
    if (widget.gameDetails.competitors[0].qualifier == 'home') {
      homeTeam = widget.gameDetails.competitors[0];
    } else {
      awayTeam = widget.gameDetails.competitors[0];
    }
    if (widget.gameDetails.competitors[1].qualifier == 'away') {
      awayTeam = widget.gameDetails.competitors[1];
    } else {
      homeTeam = widget.gameDetails.competitors[1];
    }
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: commonAppBarWidget(context, isDark),
      body: GetBuilder<GameDetailsController>(initState: (state) {
        if (widget.sportKey == 'MLB') {
          gameDetailsController.mlbInjuriesResponse(
              isLoad: true,
              sportEvent: widget.gameDetails,
              awayTeamId: awayTeam?.uuids ?? "",
              homeTeamId: homeTeam?.uuids ?? "");
          gameDetailsController.hotlinesDataResponse(
              awayTeamId: awayTeam?.id ?? "",
              sportId: widget.sportId,
              date: widget.date,
              homeTeamId: homeTeam?.id ?? "",
              isLoad: true);
          gameDetailsController.mlbStaticsAwayTeamResponse(
              isLoad: true, awayTeamId: awayTeam?.uuids ?? '');
          gameDetailsController.mlbStaticsHomeTeamResponse(
              isLoad: true, homeTeamId: homeTeam?.uuids ?? '');
        }
      }, builder: (con) {
        return RefreshIndicator(
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
                    controller: _controller,
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        headerWidget(context),
                        hotlinesWidget(context, con),
                        teamReportWidget(context),
                        widget.sportKey == 'MLB'
                            ? mlbInjuryReportWidget(context)
                            : awayTeam?.abbreviation == 'DET' &&
                                    homeTeam?.abbreviation == 'KC'
                                ? nflStaticInjuryReportWidget(context)
                                : nflStaticInjuryReportWidget(context),
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
        );
      }),
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
                  ('${awayTeam?.abbreviation} @ ${homeTeam?.abbreviation}')
                      .appCommonText(
                          color: whiteColor,
                          size: MediaQuery.of(context).size.height * .024,
                          weight: FontWeight.w700),
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
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .099,
                  ),
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
        child: GetBuilder<GameDetailsController>(builder: (controller) {
          return StickyHeader(
              header:
                  headerTitleWidget(context, teamReport, isTeamReport: true),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  rankingCommonWidget(
                      context,
                      widget.sportKey == 'MLB'
                          ? 'Team Hitting Rankings'
                          : 'Offensive Rankings'),
                  ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: widget.sportKey == 'MLB'
                        ? controller.offensiveMLB.length
                        : controller.offensive.length,
                    itemBuilder: (context, index) {
                      var homeHitting =
                          controller.mlbStaticsHomeList?.hitting?.overall;
                      var awayHitting =
                          controller.mlbStaticsAwayList?.hitting?.overall;

                      return widget.sportKey == 'MLB'
                          ? commonRankingWidget(context,
                              teamReports: controller.offensiveMLB[index],
                              awayText: index == 0
                                  ? '${awayHitting?.runs?.total ?? "0"}'
                                  : index == 1
                                      ? '${awayHitting?.onbase?.h ?? "0"}'
                                      : index == 2
                                          ? '${awayHitting?.onbase?.hr ?? "0"}'
                                          : index == 3
                                              ? '${awayHitting?.rbi ?? "0"}'
                                              : index == 4
                                                  ? '${awayHitting?.onbase?.bb ?? "0"}'
                                                  : index == 5
                                                      ? '${awayHitting?.outs?.ktotal ?? "0"}'
                                                      : index == 6
                                                          ? '${awayHitting?.steal?.stolen ?? "0"}'
                                                          : index == 7
                                                              ? awayHitting
                                                                      ?.avg ??
                                                                  "0"
                                                              : index == 8
                                                                  ? '${awayHitting?.slg ?? '0'}'
                                                                  : index == 9
                                                                      ? '${awayHitting?.ops ?? '0'}'
                                                                      : index ==
                                                                              10
                                                                          ? '${awayHitting?.outs?.gidp ?? '0'}'
                                                                          : index ==
                                                                                  11
                                                                              ? awayHitting?.abhr?.toStringAsFixed(2) ??
                                                                                  "0"
                                                                              : '0',
                              homeText: index == 0
                                  ? '${homeHitting?.runs?.total ?? "0"}'
                                  : index == 1
                                      ? '${homeHitting?.onbase?.h ?? "0"}'
                                      : index == 2
                                          ? '${homeHitting?.onbase?.hr ?? "0"}'
                                          : index == 3
                                              ? '${homeHitting?.rbi ?? "0"}'
                                              : index == 4
                                                  ? '${homeHitting?.onbase?.bb ?? "0"}'
                                                  : index == 5
                                                      ? '${homeHitting?.outs?.ktotal ?? "0"}'
                                                      : index == 6
                                                          ? '${homeHitting?.steal?.stolen ?? "0"}'
                                                          : index == 7
                                                              ? homeHitting
                                                                      ?.avg ??
                                                                  "0"
                                                              : index == 8
                                                                  ? '${homeHitting?.slg ?? '0'}'
                                                                  : index == 9
                                                                      ? '${homeHitting?.ops ?? '0'}'
                                                                      : index ==
                                                                              10
                                                                          ? '${homeHitting?.outs?.gidp ?? '0'}'
                                                                          : index ==
                                                                                  11
                                                                              ? homeHitting?.abhr?.toStringAsFixed(2) ??
                                                                                  "0"
                                                                              : '0')
                          : commonRankingWidget(context,
                              teamReports: controller.offensive[index],
                              awayText: awayTeam?.abbreviation == 'DET' &&
                                      homeTeam?.abbreviation == 'KC'
                                  ? awayTeamOffenseValue[index]
                                  : '0',
                              homeText: awayTeam?.abbreviation == 'DET' &&
                                      homeTeam?.abbreviation == 'KC'
                                  ? homeTeamOffenseValue[index]
                                  : '0');
                    },
                  ),
                  rankingCommonWidget(
                      context,
                      widget.sportKey == 'MLB'
                          ? 'Team Pitching Rankings'
                          : 'Defensive Rankings'),
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.sportKey == 'MLB'
                        ? controller.defensiveMLB.length
                        : controller.defensive.length,
                    itemBuilder: (context, index) {
                      var homePitching =
                          controller.mlbStaticsHomeList?.pitching?.overall;
                      var awayPitching =
                          controller.mlbStaticsAwayList?.pitching?.overall;
                      return widget.sportKey == 'MLB'
                          ? commonRankingWidget(context,
                              teamReports: controller.defensiveMLB[index],
                              homeText: index == 0
                                  ? '${homePitching?.games?.win ?? '0'}'
                                  : index == 1
                                      ? '${homePitching?.games?.loss ?? '0'}'
                                      : index == 2
                                          ? '${homePitching?.era ?? '0'}'
                                          : index == 3
                                              ? '${homePitching?.games?.shutout ?? '0'}'
                                              : index == 5
                                                  ? '${homePitching?.games?.qstart ?? '0'}'
                                                  : index == 7
                                                      ? '${homePitching?.onbase?.hr ?? '0'}'
                                                      : index == 8
                                                          ? '${homePitching?.onbase?.bb ?? '0'}'
                                                          : index == 9
                                                              ? '${homePitching?.outs?.ktotal ?? '0'}'
                                                              : index == 10
                                                                  ? '${homePitching?.whip ?? "0"}'
                                                                  : index == 11
                                                                      ? '${homePitching?.oba ?? "0"}'
                                                                      : index ==
                                                                              12
                                                                          ? '${homePitching?.outs?.gidp ?? "0"}'
                                                                          : '0',
                              awayText: index == 0
                                  ? '${awayPitching?.games?.win ?? "0"}'
                                  : index == 1
                                      ? '${awayPitching?.games?.loss ?? "0"}'
                                      : index == 2
                                          ? '${awayPitching?.era ?? "0"}'
                                          : index == 3
                                              ? '${awayPitching?.games?.shutout ?? "0"}'
                                              : index == 5
                                                  ? '${awayPitching?.games?.qstart ?? "0"}'
                                                  : index == 7
                                                      ? '${awayPitching?.onbase?.hr ?? "0"}'
                                                      : index == 8
                                                          ? '${awayPitching?.onbase?.bb ?? "0"}'
                                                          : index == 9
                                                              ? '${awayPitching?.outs?.ktotal ?? "0"}'
                                                              : index == 10
                                                                  ? '${awayPitching?.whip ?? "0"}'
                                                                  : index == 11
                                                                      ? '${awayPitching?.oba ?? "0"}'
                                                                      : index ==
                                                                              12
                                                                          ? '${awayPitching?.outs?.gidp ?? "0"}'
                                                                          : '0')
                          : commonRankingWidget(context,
                              teamReports: controller.defensive[index],
                              awayText: awayTeam?.abbreviation == 'DET' &&
                                      homeTeam?.abbreviation == 'KC'
                                  ? awayTeamDefenseValue[index]
                                  : '0',
                              homeText: awayTeam?.abbreviation == 'DET' &&
                                      homeTeam?.abbreviation == 'KC'
                                  ? homeTeamDefenseValue[index]
                                  : '0');
                    },
                  ),
                  rankingCommonWidget(context, 'Team Stats'),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: widget.sportKey == 'MLB'
                        ? controller.teamStatusMLB.length
                        : controller.teamStatus.length,
                    itemBuilder: (context, index) {
                      return commonRankingWidget(context,
                          teamReports: widget.sportKey == 'MLB'
                              ? controller.teamStatusMLB[index]
                              : controller.teamStatus[index],
                          awayText: awayTeam?.abbreviation == 'DET' &&
                                  homeTeam?.abbreviation == 'KC'
                              ? awayTeamStat[index]
                              : '0',
                          homeText: awayTeam?.abbreviation == 'DET' &&
                                  homeTeam?.abbreviation == 'KC'
                              ? homeTeamStat[index]
                              : '0');
                    },
                  ),
                ],
              ));
        }),
      ),
    );
  }

  Column commonRankingWidget(BuildContext context,
      {String homeText = '', String awayText = '', String teamReports = ''}) {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);

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
                    align: data.size.shortestSide < 600
                        ? TextAlign.center
                        : TextAlign.end,
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
                    align: data.size.shortestSide < 600
                        ? TextAlign.center
                        : TextAlign.start,
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

  nflStaticInjuryReportWidget(BuildContext context) {
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
            headerTitleWidget(context, injuryReport),
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
                            child: awayTeamInjury[index]
                                .toString()
                                .appCommonText(
                                    color: Theme.of(context).highlightColor,
                                    weight: FontWeight.w700,
                                    maxLine: 2,
                                    align: TextAlign.start,
                                    size: MediaQuery.of(context).size.height *
                                        .016),
                          ),
                          index == 1
                              ? const SizedBox()
                              : commonDivider(context),
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
                                  size: MediaQuery.of(context).size.height *
                                      .016),
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
                            child: homeTeamInjury[index]
                                .toString()
                                .appCommonText(
                                    color: Theme.of(context).highlightColor,
                                    weight: FontWeight.w700,
                                    maxLine: 2,
                                    align: TextAlign.start,
                                    size: MediaQuery.of(context).size.height *
                                        .016),
                          ),
                          index == 1
                              ? const SizedBox()
                              : commonDivider(context),
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
                    : widget.gameDetails.homeTeamInjuredPlayer.isEmpty &&
                            widget.gameDetails.awayTeamInjuredPlayer.isEmpty
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
                              widget.gameDetails.awayTeamInjuredPlayer
                                      .isNotEmpty
                                  ? Expanded(
                                      flex: 1,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: widget
                                                    .gameDetails
                                                    .awayTeamInjuredPlayer
                                                    .length >=
                                                widget
                                                    .gameDetails
                                                    .homeTeamInjuredPlayer
                                                    .length
                                            ? widget.gameDetails
                                                .awayTeamInjuredPlayer.length
                                            : widget.gameDetails
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
                                                  child: '${widget.gameDetails.awayTeamInjuredPlayer[index]}'
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
                                                        (widget.gameDetails.awayTeamInjuredPlayer.length >=
                                                                    widget
                                                                        .gameDetails
                                                                        .homeTeamInjuredPlayer
                                                                        .length
                                                                ? widget
                                                                    .gameDetails
                                                                    .awayTeamInjuredPlayer
                                                                    .length
                                                                : widget
                                                                    .gameDetails
                                                                    .homeTeamInjuredPlayer
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
                              widget.gameDetails.homeTeamInjuredPlayer
                                      .isNotEmpty
                                  ? Expanded(
                                      flex: 1,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: widget
                                                    .gameDetails
                                                    .homeTeamInjuredPlayer
                                                    .length >=
                                                widget
                                                    .gameDetails
                                                    .awayTeamInjuredPlayer
                                                    .length
                                            ? widget.gameDetails
                                                .homeTeamInjuredPlayer.length
                                            : widget.gameDetails
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
                                                  child: '${widget.gameDetails.homeTeamInjuredPlayer[index]}'
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
                                                        (widget.gameDetails.awayTeamInjuredPlayer.length >=
                                                                    widget
                                                                        .gameDetails
                                                                        .homeTeamInjuredPlayer
                                                                        .length
                                                                ? widget
                                                                    .gameDetails
                                                                    .awayTeamInjuredPlayer
                                                                    .length
                                                                : widget
                                                                    .gameDetails
                                                                    .homeTeamInjuredPlayer
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

/*  nflInjuryReportWidget(BuildContext context) {
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
  }*/

  Expanded commonEmptyInjuryReportWidget(GameDetailsController controller) {
    return Expanded(
      flex: 1,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.sportKey == 'MLB'
            ? widget.gameDetails.awayTeamInjuredPlayer.length >=
                    widget.gameDetails.homeTeamInjuredPlayer.length
                ? widget.gameDetails.awayTeamInjuredPlayer.length
                : widget.gameDetails.homeTeamInjuredPlayer.length
            : widget.gameDetails.awayTeamInjuredPlayer.length >=
                    widget.gameDetails.homeTeamInjuredPlayer.length
                ? widget.gameDetails.awayTeamInjuredPlayer.length
                : widget.gameDetails.homeTeamInjuredPlayer.length,
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
                    (widget.gameDetails.awayTeamInjuredPlayer.length >=
                                widget.gameDetails.homeTeamInjuredPlayer.length
                            ? widget.gameDetails.awayTeamInjuredPlayer.length
                            : widget.gameDetails.homeTeamInjuredPlayer.length) -
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
      {bool isTeamReport = false}) {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
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
                children: [
                  Expanded(
                    child: (isTeamReport
                            ? (awayTeam?.abbreviation ?? '')
                            : (awayTeam?.name ?? ''))
                        .appCommonText(
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
                      imageUrl: widget.gameDetails.gameLogoAwayLink),
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
                      imageUrl: widget.gameDetails.gameHomeLogoLink),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .01,
                  ),
                  Expanded(
                    child: (isTeamReport
                            ? (homeTeam?.abbreviation ?? "")
                            : (homeTeam?.name ?? ""))
                        .appCommonText(
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
            con.hotlinesData.isEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * .038,
                    child: Center(
                        child: 'No Data'.appCommonText(
                            weight: FontWeight.w700,
                            color: Theme.of(context).highlightColor)),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: con.hotlinesData.length >= 3
                        ? 3
                        : con.hotlinesData.length,
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  10.W(),
                                  Expanded(
                                    flex: 4,
                                    child: (con.hotlinesData[index].teamName ??
                                            '')
                                        .appCommonText(
                                            color: Theme.of(context)
                                                .highlightColor,
                                            weight: FontWeight.bold,
                                            align: TextAlign.start,
                                            size: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .016),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .002),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .096,
                                        decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(0)),
                                        child: Center(
                                          child: con.hotlinesData[index].value
                                              .appCommonText(
                                                  color: Theme.of(context)
                                                      .cardColor,
                                                  size: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      .014,
                                                  weight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .02,
                                  ),
                                  Expanded(
                                      child: index == 1 || index == 0
                                          ? Image.asset(
                                              Assets.imagesFire,
                                              alignment: Alignment.centerLeft,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .028,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .028,
                                              fit: BoxFit.contain,
                                            )
                                          : const SizedBox()),
                                ],
                              ),
                            ),
                          ),
                          index == 2
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
            String dateTime = DateFormat.jm().format(
                DateTime.parse(widget.gameDetails.scheduled ?? '').toLocal());
            String date = DateFormat.d().format(
                (DateTime.parse(widget.gameDetails.scheduled ?? '')).toLocal());
            String month = DateFormat.MMM().format(
                (DateTime.parse(widget.gameDetails.scheduled ?? '')).toLocal());
            String year = DateFormat.y().format(
                (DateTime.parse(widget.gameDetails.scheduled ?? '')).toLocal());
            String day = DateFormat.MMMEd()
                .format((DateTime.parse(widget.gameDetails.scheduled ?? ''))
                    .toLocal())
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
            // log('widget.gameDetails??.awayLiveScores---${widget.gameDetails??.awayLiveScores}');
            return Container(
              width: Get.width,
              // height: MediaQuery.of(context).size.height * .175,
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
                          title:
                              widget.gameDetails.awaySpreadValue.contains('-')
                                  ? widget.gameDetails.awaySpreadValue
                                  : '+${widget.gameDetails.awaySpreadValue}',
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * .025,
                        ),
                        commonBoxWidget(context,
                            title: widget.gameDetails.awayMoneyLineValue),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * .025,
                        ),
                        commonBoxWidget(context,
                            title: 'o/u${widget.gameDetails.awayOUValue}')
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
                          imageUrl: widget.gameDetails.gameLogoAwayLink),
                      (awayTeam?.name ?? '').toString().appCommonText(
                          weight: FontWeight.bold,
                          size: MediaQuery.of(context).size.height * .016,
                          align: TextAlign.end,
                          maxLine: 1,
                          color: whiteColor),
                      ('${widget.gameDetails.awayWin}-${widget.gameDetails.awayLoss}')
                          .appCommonText(
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
                          dateTime.appCommonText(
                              color: whiteColor,
                              size: MediaQuery.of(context).size.height * .014,
                              weight: FontWeight.w600),
                          SizedBox(
                            height: MediaQuery.of(context).size.width * .003,
                          ),
                          '${widget.gameDetails.awayScore}-${widget.gameDetails.homeScore}'
                              .appCommonText(
                                  color: whiteColor,
                                  size:
                                      MediaQuery.of(context).size.height * .048,
                                  weight: FontWeight.w700),
                          (widget.gameDetails.venue != null
                                  ? '${widget.gameDetails.venue?.name}, ${widget.gameDetails.venue?.countryName}'
                                  : '')
                              .appCommonText(
                                  color: primaryColor,
                                  size:
                                      MediaQuery.of(context).size.height * .014,
                                  weight: FontWeight.w600),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              (widget.gameDetails.venue != null
                                      ? widget
                                          .gameDetails.venue?.tmpInFahrenheit
                                      : 00)
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
                                  (widget.gameDetails.venue != null
                                      ? widget.gameDetails.venue?.weather ??
                                          'Sunny'
                                      : 'Sunny'),
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
                          imageUrl: widget.gameDetails.gameHomeLogoLink),
                      (homeTeam?.name ?? "").appCommonText(
                          weight: FontWeight.bold,
                          size: MediaQuery.of(context).size.height * .016,
                          align: TextAlign.start,
                          maxLine: 1,
                          color: whiteColor),
                      ('${widget.gameDetails.homeWin}-${widget.gameDetails.homeLoss}')
                          .appCommonText(
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
                        commonBoxWidget(
                          context,
                          title:
                              widget.gameDetails.homeSpreadValue.contains('-')
                                  ? widget.gameDetails.homeSpreadValue
                                  : '+${widget.gameDetails.homeSpreadValue}',
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * .025,
                        ),
                        commonBoxWidget(context,
                            title: widget.gameDetails.homeMoneyLineValue),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * .025,
                        ),
                        commonBoxWidget(context,
                            title: 'o/u${widget.gameDetails.homeOUValue}')
                      ],
                    ),
                  ))
                ],
              ).paddingSymmetric(vertical: 10),
            );
          }),
        ),
        widget.gameDetails.status == 'live'
            ? Positioned(
                top: MediaQuery.of(context).size.height * .010,
                child: Container(
                  height: MediaQuery.of(context).size.height * .02,
                  width: MediaQuery.of(context).size.width * .07,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(105),
                      color: redColor),
                  child: Center(
                    child: 'LIVE'.appCommonText(
                        color: whiteColor,
                        size: MediaQuery.of(context).size.height * .012,
                        weight: FontWeight.bold),
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
