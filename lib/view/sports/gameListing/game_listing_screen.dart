import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hotlines/view/sports/gameListing/game_listing_con.dart';
import 'package:hotlines/view/widgets/game_widget.dart';
import 'package:intl/intl.dart';
import '../../../constant/shred_preference.dart';
import '../../../extras/constants.dart';
import '../../../model/game_listing.dart';
import '../../../utils/animated_search.dart';
import '../../../utils/app_progress.dart';
import '../../../utils/utils.dart';
import '../../../theme/theme.dart';

// ignore: must_be_immutable
class SelectGameScreen extends StatelessWidget {
  SelectGameScreen({Key? key}) : super(key: key);

  final GameListingController gameListingController =
      Get.put(GameListingController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GameListingController>(initState: (state) async {
      Future.delayed(
        Duration.zero,
        () async {
          await gameListingController.getGameListingForNFLGame(true,
              apiKey: gameListingController.apiKey,
              sportKey: gameListingController.sportKey,
              date: gameListingController.date,
              sportId: gameListingController.sportId);
        },
      );
    }, builder: (controller) {
      // isDark = PreferenceManager.getIsDarkMode()??false ?? false;
      return Scaffold(
          key: scaffoldKey,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: commonAppBar(context, controller),
          drawer: AppDrawer(),
          drawerEnableOpenDragGesture: false,
          body: SingleChildScrollView(
            child: Column(
              children: [
                GameTabCard(
                  onTapContact: () {
                    toggle = 0;
                    if (Platform.isIOS) {
                      controller.launchEmailSubmission();
                    } else {
                      controller.isSelectedGame = 'Contact';
                    }
                    controller.update();
                  },
                  onTapGambling: () {
                    toggle = 0;
                    controller.isSelectedGame = 'Gambling 101';
                    controller.update();
                    // showDataAlert(context);
                  },
                  controller: controller,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: PreferenceManager.getIsDarkMode() ?? false
                        ? blackColor
                        : whiteColor,
                  ),
                  height: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).size.height * .2,
                  width: Get.width,
                  clipBehavior: Clip.antiAlias,
                  child: controller.isSelectedGame == 'Gambling 101'
                      ? const GamblingCard()
                      : /*controller.isSelectedGame == 'Contact'
                          ? ContactView(
                              webController: controller.webController,
                            )
                          :*/
                      tableDetailWidget(context, controller),
                ).paddingSymmetric(
                    horizontal: MediaQuery.of(context).size.width * .03),
              ],
            ),
          ));
    });
  }

  Widget tableDetailWidget(
      BuildContext context, GameListingController controller) {
    return Stack(
      children: [
        const HeaderCard(),
        Column(
          children: [
            (MediaQuery.of(context).size.height * .06).H(),
            (controller.sportKey == 'MLB' &&
                    !(controller.mlbSportEventsList.indexWhere((element) =>
                            DateTime.parse(element.scheduled.toString())
                                .toLocal()
                                .day ==
                            DateTime.now().toLocal().day) >=
                        0) &&
                    !controller.isLoading.value)
                ? Text(
                    '\nNo games today',
                    style: Theme.of(context).textTheme.labelLarge,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                  ).paddingOnly(bottom: 15.w)
                : const SizedBox(),
            controller.searchCon.text.isEmpty
                ? Expanded(
                    child: RefreshIndicator(
                    onRefresh: () async {
                      await controller.getResponse(false, controller.sportKey);
                    },
                    color: Theme.of(context).primaryColor,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: spotList(controller).length,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        try {
                          // SportEvents competitors = spotList(controller)[index];
                          String date = DateFormat.MMMd().format(DateTime.parse(
                                  spotList(controller)[index].scheduled ?? '')
                              .toLocal());
                          String dateTime = DateFormat.jm().format(
                              DateTime.parse(
                                      spotList(controller)[index].scheduled ??
                                          '')
                                  .toLocal());
                          return (spotList(controller).length == index + 1 &&
                                  controller.isPagination)
                              ? const PaginationProgress()
                              : spotList(controller).isEmpty &&
                                      !controller.isLoading.value &&
                                      !controller.isPagination
                                  ? const NoGameWidget()
                                  : Visibility(
                                      visible: (spotList(controller)[index]
                                                      .status !=
                                                  'closed' &&
                                              controller.sportKey != "NFL") ||
                                          (spotList(controller)[index].status !=
                                              'postponed'),
                                      child: GameWidget(
                                        onTap: () {
                                          controller.gameOnClick(
                                              context, index);
                                        },
                                        awayTeamMoneyLine:
                                            spotList(controller)[index]
                                                .awayMoneyLineValue,
                                        homeTeamMoneyLine:
                                            spotList(controller)[index]
                                                .homeMoneyLineValue,
                                        awayTeamOU: spotList(controller)[index]
                                            .awayOUValue,
                                        homeTeamOU: spotList(controller)[index]
                                            .homeOUValue,
                                        weather:
                                            spotList(controller)[index].weather,
                                        homeTeamSpread: spotList(
                                                    controller)[index]
                                                .homeSpreadValue
                                                .contains('-')
                                            ? spotList(controller)[index]
                                                .homeSpreadValue
                                            : '+${spotList(controller)[index].homeSpreadValue}',
                                        awayTeamSpread: spotList(
                                                    controller)[index]
                                                .awaySpreadValue
                                                .contains('-')
                                            ? spotList(controller)[index]
                                                .awaySpreadValue
                                            : '+${spotList(controller)[index].awaySpreadValue}',
                                        temp: spotList(controller)[index]
                                            .tmpInFahrenheit,
                                        isLive: spotList(controller)[index]
                                                .status ==
                                            'live',
                                        dateTime: '$date, $dateTime',
                                        awayTeamImageUrl: spotList(
                                                        controller)[index]
                                                    .awayTeam ==
                                                'North Carolina State Wolfpack'
                                            ? 'https://a.espncdn.com/i/teamlogos/ncaa/500/152.png'
                                            : spotList(controller)[index]
                                                        .awayTeam ==
                                                    'Louisiana-Lafayette Ragin Cajuns'
                                                ? "https://a.espncdn.com/i/teamlogos/ncaa/500/309.png"
                                                : spotList(controller)[index]
                                                            .awayTeam ==
                                                        'Sam Houston State Bearkats'
                                                    ? "https://a.espncdn.com/i/teamlogos/ncaa/500/2534.png"
                                                    : spotList(
                                                            controller)[index]
                                                        .gameLogoAwayLink,
                                        awayTeamRank:
                                            (spotList(controller)[index]
                                                        .awayRank ==
                                                    '0'
                                                ? ''
                                                : spotList(controller)[index]
                                                    .awayRank),
                                        awayTeamAbb:
                                            (mobileView.size.shortestSide < 600
                                                ? spotList(controller)[index]
                                                    .awayTeamAbb
                                                : spotList(controller)[index]
                                                    .awayTeam),
                                        awayTeamScore:
                                            (spotList(controller)[index]
                                                .awayScore),
                                        homeTeamImageUrl: spotList(
                                                        controller)[index]
                                                    .homeTeam ==
                                                'North Carolina State Wolfpack'
                                            ? 'https://a.espncdn.com/i/teamlogos/ncaa/500/152.png'
                                            : spotList(controller)[index]
                                                        .homeTeam ==
                                                    'Louisiana-Lafayette Ragin Cajuns'
                                                ? "https://a.espncdn.com/i/teamlogos/ncaa/500/309.png"
                                                : spotList(controller)[index]
                                                            .homeTeam ==
                                                        'Sam Houston State Bearkats'
                                                    ? "https://a.espncdn.com/i/teamlogos/ncaa/500/2534.png"
                                                    : spotList(
                                                            controller)[index]
                                                        .gameHomeLogoLink,
                                        homeTeamRank:
                                            (spotList(controller)[index]
                                                        .homeRank ==
                                                    '0'
                                                ? ''
                                                : spotList(controller)[index]
                                                    .homeRank),
                                        homeTeamAbb:
                                            (mobileView.size.shortestSide < 600
                                                ? spotList(controller)[index]
                                                    .homeTeamAbb
                                                : spotList(controller)[index]
                                                    .homeTeam),
                                        homeTeamScore:
                                            spotList(controller)[index]
                                                .homeScore,
                                      ),
                                    );
                        } catch (e) {
                          return const SizedBox();
                        }
                      },
                    ),
                  ))
                : Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: controller.searchList.length,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        try {
                          SportEvents competitors =
                              controller.searchList[index];
                          String date = DateFormat.MMMd().format(
                              DateTime.parse(competitors.scheduled ?? '')
                                  .toLocal());
                          String dateTime = DateFormat.jm().format(
                              DateTime.parse(competitors.scheduled ?? '')
                                  .toLocal());
                          return Visibility(
                            visible: (competitors.status != 'closed' &&
                                    controller.sportKey != "NFL") ||
                                (competitors.status != 'postponed'),
                            child: GameWidget(
                              onTap: () {
                                controller.searchGameOnClick(context, index);
                              },
                              awayTeamMoneyLine: competitors.awayMoneyLineValue,
                              homeTeamMoneyLine: competitors.homeMoneyLineValue,
                              awayTeamOU: competitors.awayOUValue,
                              homeTeamOU: competitors.homeOUValue,
                              weather: competitors.weather,
                              homeTeamSpread:
                                  competitors.homeSpreadValue.contains('-')
                                      ? competitors.homeSpreadValue
                                      : '+${competitors.homeSpreadValue}',
                              awayTeamSpread:
                                  competitors.awaySpreadValue.contains('-')
                                      ? competitors.awaySpreadValue
                                      : '+${competitors.awaySpreadValue}',
                              temp: competitors.tmpInFahrenheit,
                              isLive: competitors.status == 'live',
                              dateTime: '$date, $dateTime',
                              awayTeamImageUrl: competitors.awayTeam ==
                                      'North Carolina State Wolfpack'
                                  ? 'https://a.espncdn.com/i/teamlogos/ncaa/500/152.png'
                                  : competitors.awayTeam ==
                                          'Louisiana-Lafayette Ragin Cajuns'
                                      ? "https://a.espncdn.com/i/teamlogos/ncaa/500/309.png"
                                      : competitors.awayTeam ==
                                              'Sam Houston State Bearkats'
                                          ? "https://a.espncdn.com/i/teamlogos/ncaa/500/2534.png"
                                          : competitors.gameLogoAwayLink,
                              awayTeamRank: (competitors.awayRank == '0'
                                  ? ''
                                  : competitors.awayRank),
                              awayTeamAbb: (mobileView.size.shortestSide < 600
                                  ? competitors.awayTeamAbb
                                  : competitors.awayTeam),
                              awayTeamScore: (competitors.awayScore),
                              homeTeamImageUrl: competitors.homeTeam ==
                                      'North Carolina State Wolfpack'
                                  ? 'https://a.espncdn.com/i/teamlogos/ncaa/500/152.png'
                                  : competitors.homeTeam ==
                                          'Louisiana-Lafayette Ragin Cajuns'
                                      ? "https://a.espncdn.com/i/teamlogos/ncaa/500/309.png"
                                      : competitors.homeTeam ==
                                              'Sam Houston State Bearkats'
                                          ? "https://a.espncdn.com/i/teamlogos/ncaa/500/2534.png"
                                          : competitors.gameHomeLogoLink,
                              homeTeamRank: (competitors.homeRank == '0'
                                  ? ''
                                  : competitors.homeRank),
                              homeTeamAbb: (mobileView.size.shortestSide < 600
                                  ? competitors.homeTeamAbb
                                  : competitors.homeTeam),
                              homeTeamScore: competitors.homeScore,
                            ),
                          );
                        } catch (e) {
                          return const SizedBox();
                        }
                      },
                    ),
                  ),
            (MediaQuery.of(context).size.height * .01).H(),
          ],
        ),
        Obx(() =>
            controller.isLoading.value ? const AppProgress() : const SizedBox())
      ],
    );
  }

  List<SportEvents> spotList(GameListingController controller) {
    return (controller.sportKey == 'MLB'
        ? controller.mlbSportEventsList
        : controller.sportKey == 'NFL'
            ? controller.nflSportEventsList
            : controller.ncaaSportEventsList);
  }
}
