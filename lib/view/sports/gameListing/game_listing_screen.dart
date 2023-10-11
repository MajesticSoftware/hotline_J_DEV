import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hotlines/view/sports/gameListing/game_listing_con.dart';
import 'package:hotlines/view/widgets/game_widget.dart';
import 'package:intl/intl.dart';
import '../../../constant/shred_preference.dart';
import '../../../extras/constants.dart';
import '../../../model/game_listing.dart';
import '../../../utils/app_progress.dart';
import '../../../utils/utils.dart';
import '../../../theme/theme.dart';

// ignore: must_be_immutable
class SelectGameScreen extends StatelessWidget {
  SelectGameScreen({Key? key}) : super(key: key);

  final GameListingController gameListingController =
      Get.put(GameListingController());
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GameListingController>(initState: (state) async {
      return await gameListingController.getGameListingForNFLGame(true,
          apiKey: gameListingController.apiKey,
          sportKey: gameListingController.sportKey,
          date: gameListingController.date,
          sportId: gameListingController.sportId);
    }, builder: (controller) {
      isDark = PreferenceManager.getIsDarkMode() ?? false;
      return Scaffold(
          floatingActionButton: controller.isSelectedGame == 'Gambling 101' ||
                  controller.isSelectedGame == 'Contact'
              ? const SizedBox()
              : buildAnimSearchBar(controller, context).paddingSymmetric(
                  horizontal: MediaQuery.of(context).size.width * .03),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: commonAppBar(context, controller),
          body: SingleChildScrollView(
            child: Column(
              children: [
                GameTabCard(
                  onTapContact: () {
                    controller.isSelectedGame = 'Contact';
                    controller.update();
                  },
                  onTapGambling: () {
                    controller.isSelectedGame = 'Gambling 101';
                    controller.update();
                    // showDataAlert(context);
                  },
                  controller: controller,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: isDark || selectGameController.isDarkMode
                        ? blackColor
                        : whiteColor,
                  ),
                  height: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).size.height * .2,
                  width: Get.width,
                  clipBehavior: Clip.antiAlias,
                  child: controller.isSelectedGame == 'Gambling 101'
                      ? const GamblingCard()
                      : controller.isSelectedGame == 'Contact'
                          ? ContactView(
                              webController: controller.webController,
                            )
                          : tableDetailWidget(context, controller),
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
            controller.searchCon.text.isEmpty
                ? Expanded(
                    child: RefreshIndicator(
                    onRefresh: () async {
                      await controller.getResponse(false, controller.sportKey);
                    },
                    color: Theme.of(context).primaryColor,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: spotList(controller).length + 1,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        try {
                          SportEvents competitors = spotList(controller)[index];
                          String date = DateFormat.MMMd().format(
                              DateTime.parse(competitors.scheduled ?? '')
                                  .toLocal());
                          String dateTime = DateFormat.jm().format(
                              DateTime.parse(competitors.scheduled ?? '')
                                  .toLocal());
                          return spotList(controller).length == index
                              ? controller.isPagination
                                  ? const PaginationProgress()
                                  : const SizedBox()
                              : spotList(controller).isEmpty &&
                                      !controller.isLoading.value &&
                                      !controller.isPagination
                                  ? const NoGameWidget()
                                  : Visibility(
                                      visible: (competitors.status !=
                                                  'closed' &&
                                              controller.sportKey != "NFL") ||
                                          (competitors.status != 'postponed'),
                                      child: GameWidget(
                                        onTap: () {
                                          controller.gameOnClick(
                                              context, index);
                                        },
                                        awayTeamMoneyLine:
                                            competitors.awayMoneyLineValue,
                                        homeTeamMoneyLine:
                                            competitors.homeMoneyLineValue,
                                        awayTeamOU: competitors.awayOUValue,
                                        homeTeamOU: competitors.homeOUValue,
                                        weather: competitors.weather,
                                        homeTeamSpread: competitors
                                                .homeSpreadValue
                                                .contains('-')
                                            ? competitors.homeSpreadValue
                                            : '+${competitors.homeSpreadValue}',
                                        awayTeamSpread: competitors
                                                .awaySpreadValue
                                                .contains('-')
                                            ? competitors.awaySpreadValue
                                            : '+${competitors.awaySpreadValue}',
                                        temp: competitors.tmpInFahrenheit,
                                        isLive: competitors.status == 'live',
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
                                                    : competitors
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
                                                    : competitors
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
                              awayTeamImageUrl: spotList(controller)[index]
                                          .awayTeam ==
                                      'North Carolina State Wolfpack'
                                  ? 'https://a.espncdn.com/i/teamlogos/ncaa/500/152.png'
                                  : spotList(controller)[index].awayTeam ==
                                          'Louisiana-Lafayette Ragin Cajuns'
                                      ? "https://a.espncdn.com/i/teamlogos/ncaa/500/309.png"
                                      : spotList(controller)[index].awayTeam ==
                                              'Sam Houston State Bearkats'
                                          ? "https://a.espncdn.com/i/teamlogos/ncaa/500/2534.png"
                                          : competitors.gameLogoAwayLink,
                              awayTeamRank:
                                  (spotList(controller)[index].awayRank == '0'
                                      ? ''
                                      : spotList(controller)[index].awayRank),
                              awayTeamAbb: (mobileView.size.shortestSide < 600
                                  ? spotList(controller)[index].awayTeamAbb
                                  : spotList(controller)[index].awayTeam),
                              awayTeamScore:
                                  (spotList(controller)[index].awayScore),
                              homeTeamImageUrl: spotList(controller)[index]
                                          .homeTeam ==
                                      'North Carolina State Wolfpack'
                                  ? 'https://a.espncdn.com/i/teamlogos/ncaa/500/152.png'
                                  : spotList(controller)[index].homeTeam ==
                                          'Louisiana-Lafayette Ragin Cajuns'
                                      ? "https://a.espncdn.com/i/teamlogos/ncaa/500/309.png"
                                      : spotList(controller)[index].homeTeam ==
                                              'Sam Houston State Bearkats'
                                          ? "https://a.espncdn.com/i/teamlogos/ncaa/500/2534.png"
                                          : competitors.gameHomeLogoLink,
                              homeTeamRank:
                                  (spotList(controller)[index].homeRank == '0'
                                      ? ''
                                      : spotList(controller)[index].homeRank),
                              homeTeamAbb: (mobileView.size.shortestSide < 600
                                  ? spotList(controller)[index].homeTeamAbb
                                  : spotList(controller)[index].homeTeam),
                              homeTeamScore:
                                  spotList(controller)[index].homeScore,
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
