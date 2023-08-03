import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hotlines/generated/assets.dart';
import 'package:hotlines/model/game_listing.dart';
import 'package:hotlines/utils/utils.dart';
import 'package:intl/intl.dart';
import '../../../constant/constant.dart';
import '../../../constant/shred_preference.dart';
import '../../../theme/helper.dart';
import '../../../theme/theme.dart';
import '../../../utils/app_progress.dart';

import '../gameDetails/game_details_screen.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

import 'game_listing_con.dart';

// ignore: must_be_immutable
class GameListingScreen extends StatefulWidget {
  const GameListingScreen(
      {Key? key,
      required this.sportKey,
      required this.sportId,
      required this.date,
      required this.keys})
      : super(key: key);
  final String sportKey;
  final String date;
  final String keys;
  final String sportId;

  @override
  State<GameListingScreen> createState() => _GameListingScreenState();
}

class _GameListingScreenState extends State<GameListingScreen> {
  final GameListingController gameListingController = Get.find();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    var client = http.Client();
    client.close();
  }

  @override
  Widget build(BuildContext context) {
    isDark = PreferenceManager.getIsDarkMode() ?? false;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: commonAppBar(context),
      body: Stack(
        children: [
          GetBuilder<GameListingController>(initState: (state) async {
            if (widget.sportKey == 'MLB') {
              getGameListingDataRes(true);
            } else {
              gameListingController
                  .gameListingApiRes(
                      key: widget.keys,
                      isLoad: true,
                      date: widget.date,
                      sportId: widget.sportId)
                  .then((value) {
                if (gameListingController.sportEventsList.isNotEmpty) {
                  for (int i = 0;
                      i < gameListingController.sportEventsList.length;
                      i++) {
                    int index = gameListingController.sportEventsList
                        .indexWhere((element) => element.uuids != null);
                    if (index >= 0) {
                      gameListingController.boxScoreResponse(
                          homeTeamId: gameListingController
                                  .sportEventsList[i].competitors[0].uuids ??
                              "",
                          awayTeamId: gameListingController
                                  .sportEventsList[i].competitors[1].uuids ??
                              "",
                          gameId:
                              gameListingController.sportEventsList[i].uuids ??
                                  '1ec03c45-ce1b-4908-a507-9678e2d14628',
                          index: i);
                    }
                  }
                }
                gameListingController.gameListingsWithLogoResponse(
                    widget.date, widget.sportKey,
                    isLoad: true);
              });
            }
          }, builder: (controller) {
            return gameListingView(context);
          }),
          Obx(() => gameListingController.isLoading.value
              ? const AppProgress()
              : const SizedBox())
        ],
      ),
    );
  }

  getGameListingDataRes(bool isLoad) async {
    gameListingController.sportEventsList.clear();
    final DateTime now = DateTime.now().add(const Duration(days: 1));
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);
    await gameListingController
        .gameListingApiRes(
            key: widget.keys,
            isLoad: isLoad,
            date: widget.date,
            sportId: widget.sportId)
        .then((value) {
      gameListingController
          .gameListingApiRes(
              key: widget.keys,
              isLoad: isLoad,
              date: formatted,
              sportId: widget.sportId)
          .then((value) {
        if (gameListingController.sportEventsList.isNotEmpty) {
          for (int i = 0;
              i < gameListingController.sportEventsList.length;
              i++) {
            int index = gameListingController.sportEventsList
                .indexWhere((element) => element.uuids != null);
            if (index >= 0) {
              gameListingController.boxScoreResponse(
                  homeTeamId: gameListingController
                          .sportEventsList[i].competitors[0].uuids ??
                      "",
                  awayTeamId: gameListingController
                          .sportEventsList[i].competitors[1].uuids ??
                      "",
                  gameId: gameListingController.sportEventsList[i].uuids ??
                      '1ec03c45-ce1b-4908-a507-9678e2d14628',
                  index: i);
            }
          }
        }
        gameListingController.gameListingsWithLogoResponse(
            widget.date, widget.sportKey,
            isLoad: isLoad);
      });
    });
  }

  SingleChildScrollView gameListingView(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .9,
            decoration: BoxDecoration(
                color: isDark || selectGameController.isDarkMode
                    ? blackColor
                    : whiteColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isDark || selectGameController.isDarkMode
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1),
                        child: commonDivider(context),
                      )
                    : const SizedBox(),
                tabTitleWidget(context),
                commonDivider(context),
                tableDetailWidget(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  PreferredSize commonAppBar(BuildContext context) {
    return PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: Container(
          height: Get.height * .098,
          alignment: Alignment.bottomCenter,
          color: Theme.of(context).secondaryHeaderColor,
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: Get.width * .02, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      Assets.imagesBackArrow,
                      height: MediaQuery.of(context).size.height * .015,
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                )),
                Expanded(
                  child: widget.sportKey.appCommonText(
                      color: whiteColor,
                      weight: FontWeight.w700,
                      size: Get.height * .024),
                ),
                Expanded(
                  child: '  '.appCommonText(
                      color: whiteColor, weight: FontWeight.w700, size: 24),
                )
              ],
            ),
          ),
        ));
  }

  tableDetailWidget(BuildContext context) {
    return Expanded(
        child: GetBuilder<GameListingController>(
      initState: (state) {},
      builder: (controller) {
        return controller.isLoading.value
            ? const SizedBox()
            : controller.sportEventsList.isNotEmpty
                ? RefreshIndicator(
                    onRefresh: () {
                      if (widget.sportKey == 'MLB') {
                        return getGameListingDataRes(false);
                      } else {
                        return gameListingController
                            .gameListingApiRes(
                                key: widget.keys,
                                isLoad: false,
                                date: widget.date,
                                sportId: widget.sportId)
                            .then((value) {
                          if (gameListingController
                              .sportEventsList.isNotEmpty) {
                            for (int i = 0;
                                i <
                                    gameListingController
                                        .sportEventsList.length;
                                i++) {
                              int index = gameListingController.sportEventsList
                                  .indexWhere(
                                      (element) => element.uuids != null);
                              if (index >= 0) {
                                gameListingController.boxScoreResponse(
                                    homeTeamId: gameListingController
                                            .sportEventsList[i]
                                            .competitors[0]
                                            .uuids ??
                                        "",
                                    awayTeamId: gameListingController
                                            .sportEventsList[i]
                                            .competitors[1]
                                            .uuids ??
                                        "",
                                    gameId: gameListingController
                                            .sportEventsList[i].uuids ??
                                        '1ec03c45-ce1b-4908-a507-9678e2d14628',
                                    index: i);
                              }
                            }
                          }
                          gameListingController.gameListingsWithLogoResponse(
                              widget.date, widget.sportKey,
                              isLoad: false);
                        });
                      }
                    },
                    color: Theme.of(context).disabledColor,
                    child: ListView.builder(
                      // controller: scrollController,
                      itemCount: controller.sportEventsList.length,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        try {
                          DateTime time = (DateTime.parse(
                              controller.sportEventsList[index].scheduled ??
                                  ''));
                          var difference = (time
                              .toUtc()
                              .difference((DateTime.now().toUtc())));

                          return GestureDetector(
                              onTap: () {
                                Get.to(SportDetailsScreen(
                                  gameDetails:
                                      controller.sportEventsList[index],
                                  sportKey: widget.sportKey,
                                ));
                              },
                              child: (controller.sportEventsList[index].season
                                                  ?.id ==
                                              'sr:season:100127' &&
                                          widget.sportKey == 'MLB' &&
                                          difference >=
                                              const Duration(hours: -6) ||
                                      controller.sportEventsList[index].season
                                                  ?.id ==
                                              'sr:season:102797' &&
                                          widget.sportKey == 'NFL' ||
                                      controller.sportEventsList[index].season
                                                  ?.id ==
                                              'sr:season:101983' &&
                                          widget.sportKey == 'NCAA')
                                  ? teamWidget(
                                      controller.sportEventsList[index],
                                      context,
                                      index: index)
                                  : const SizedBox());
                        } catch (e) {
                          return const SizedBox();
                        }
                      },
                    ),
                  )
                : emptyDataWidget(context);
      },
    ));
  }

  Center emptyDataWidget(BuildContext context) {
    return Center(
        child: Stack(
      children: [
        SvgPicture.asset(
          Assets.imagesNodataImage,
          width: MediaQuery.of(context).size.width * .349,
          height: MediaQuery.of(context).size.height * .329,
          fit: BoxFit.contain,
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.height * .07,
          left: MediaQuery.of(context).size.height * .08,
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
                      size: MediaQuery.of(context).size.height * .014,
                      weight: FontWeight.w500),
                ),
              )),
        )
      ],
    ));
  }

  teamWidget(SportEvents competitors, BuildContext context, {int index = 0}) {
    Competitors? homeTeam;
    Competitors? awayTeam;
    if (competitors.competitors.isNotEmpty) {
      if (competitors.competitors[0].qualifier == 'home') {
        homeTeam = competitors.competitors[0];
      } else {
        awayTeam = competitors.competitors[0];
      }
      if (competitors.competitors[1].qualifier == 'away') {
        awayTeam = competitors.competitors[1];
      } else {
        homeTeam = competitors.competitors[1];
      }
    }

    if (competitors.markets.isNotEmpty) {
      for (var marketData in competitors.markets) {
        ///MONEY LINES
        if (marketData.oddsTypeId == 1) {
          for (var bookData in marketData.books) {
            int fanDuelIndex = marketData.books
                .indexWhere((element) => element.name == 'FanDuel');
            if (fanDuelIndex >= 0) {
              if (bookData.name.isNotEmpty) {
                if (bookData.name == 'FanDuel') {
                  if (bookData.outcomes?[0].type == 'home') {
                    competitors.homeMoneyLine =
                        bookData.outcomes?[0].odds.toString() ?? '00';
                  }
                  if (bookData.outcomes?[1].type == 'away') {
                    competitors.awayMoneyLine =
                        bookData.outcomes?[1].odds.toString() ?? '00';
                  }
                }
              }
            } else if (bookData.name == 'Bet365NewJersey') {
              if (bookData.outcomes?[0].type == 'home') {
                competitors.homeMoneyLine =
                    bookData.outcomes?[0].odds.toString() ?? '';
              }
              if (bookData.outcomes?[1].type == 'away') {
                competitors.awayMoneyLine =
                    bookData.outcomes?[1].odds.toString() ?? '';
              }
            } else if (bookData.name == 'MGM') {
              if (bookData.outcomes?[0].type == 'home') {
                competitors.homeMoneyLine =
                    bookData.outcomes?[0].odds.toString() ?? '';
              }
              if (bookData.outcomes?[1].type == 'away') {
                competitors.awayMoneyLine =
                    bookData.outcomes?[1].odds.toString() ?? '';
              }
            }
          }
        }

        ///OVER-UNDER
        if (marketData.oddsTypeId == 3) {
          for (var bookData in marketData.books) {
            int fanDuelIndex = marketData.books
                .indexWhere((element) => element.name == 'FanDuel');
            if (fanDuelIndex >= 0) {
              if (bookData.name == 'FanDuel') {
                if (bookData.outcomes?[0].type == 'over') {
                  competitors.awayOU =
                      bookData.outcomes?[0].total.toString() ?? '00';
                }
                if (bookData.outcomes?[1].type == 'under') {
                  competitors.homeOU =
                      bookData.outcomes?[1].total.toString() ?? '00';
                }
              }
            } else if (bookData.name == 'Bet365NewJersey') {
              if (bookData.outcomes?[0].type == 'over') {
                competitors.awayOU =
                    bookData.outcomes?[0].total.toString() ?? '';
              }
              if (bookData.outcomes?[1].type == 'under') {
                competitors.homeOU =
                    bookData.outcomes?[1].total.toString() ?? '';
              }
            } else if (bookData.name == 'MGM') {
              if (bookData.outcomes?[0].type == 'over') {
                competitors.awayOU =
                    bookData.outcomes?[0].total.toString() ?? '';
              }
              if (bookData.outcomes?[1].type == 'under') {
                competitors.homeOU =
                    bookData.outcomes?[1].total.toString() ?? '';
              }
            }
          }
        }

        ///SPREAD
        if (marketData.oddsTypeId == 4) {
          for (var bookData in marketData.books) {
            int fanDuelIndex = marketData.books
                .indexWhere((element) => element.name == 'FanDuel');
            if (fanDuelIndex >= 0) {
              if (bookData.name == 'FanDuel') {
                if (bookData.outcomes?[0].type == 'home') {
                  competitors.homeSpread =
                      bookData.outcomes?[0].spread.toString() ?? '00';
                }
                if (bookData.outcomes?[1].type == 'away') {
                  competitors.awaySpread =
                      bookData.outcomes?[1].spread.toString() ?? '00';
                }
              }
            } else if (bookData.name == 'Bet365NewJersey') {
              if (bookData.outcomes?[0].type == 'home') {
                competitors.homeSpread =
                    bookData.outcomes?[0].spread.toString() ?? '';
              }
              if (bookData.outcomes?[1].type == 'away') {
                competitors.awaySpread =
                    bookData.outcomes?[1].spread.toString() ?? '';
              }
            } else if (bookData.name == 'MGM') {
              if (bookData.outcomes?[0].type == 'home') {
                competitors.homeSpread =
                    bookData.outcomes?[0].spread.toString() ?? '';
              }
              if (bookData.outcomes?[1].type == 'away') {
                competitors.awaySpread =
                    bookData.outcomes?[1].spread.toString() ?? '';
              }
            }
          }
        }
      }
    }
    String date = DateFormat.MMMd()
        .format(DateTime.parse(competitors.scheduled ?? '').toLocal());
    String dateTime = DateFormat.jm()
        .format(DateTime.parse(competitors.scheduled ?? '').toLocal());
    try {
      return DateTime.parse(competitors.scheduled ?? '').toUtc().day ==
                  DateTime.now().toUtc().day ||
              DateTime.parse(competitors.scheduled ?? '').toUtc().day ==
                  DateTime.now().add(const Duration(days: 1)).toUtc().day
          ? Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * .02,
                  top: MediaQuery.of(context).size.width * .014,
                  right: MediaQuery.of(context).size.width * .02),
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    border: Border.all(
                        color: isDark || selectGameController.isDarkMode
                            ? greyColor
                            : dividerColor),
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.width * .02)),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height * .006,
                            horizontal:
                                MediaQuery.of(context).size.width * .02),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                commonCachedNetworkImage(
                                  width: Get.height * .044,
                                  height: Get.height * .044,
                                  imageUrl: competitors.gameLogoAwayLink,
                                ),
                                // 10.W(),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * .01,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    (awayTeam?.name ?? "").toString(),
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                    textAlign: TextAlign.start,
                                    maxLines: 2,
                                  ),
                                ),
                                Text(
                                  (gameListingController
                                          .sportEventsList[index].awayScore)
                                      .toString(),
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
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
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                    flex: 4, child: commonDivider(context)),
                              ],
                            ),
                            5.H(),
                            Row(
                              children: [
                                commonCachedNetworkImage(
                                    width: Get.height * .044,
                                    height: Get.height * .044,
                                    imageUrl: competitors.gameHomeLogoLink),
                                // 10.W(),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * .01,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    (homeTeam?.name ?? "").toString(),
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                    textAlign: TextAlign.start,
                                    maxLines: 2,
                                  ),
                                ),
                                Text(
                                  gameListingController
                                      .sportEventsList[index].homeScore
                                      .toString(),
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
                                  textAlign: TextAlign.start,
                                  maxLines: 2,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '$date, $dateTime',
                            style: Theme.of(context).textTheme.displaySmall,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .001,
                          ),
                          getWeatherIcon(
                              competitors.venue?.weather ?? 1,
                              context,
                              MediaQuery.of(context).size.height * .064),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            textBaseline: TextBaseline.alphabetic,
                            verticalDirection: VerticalDirection.up,
                            children: [
                              Text(
                                '${competitors.venue?.tmpInFahrenheit ?? 0}',
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                              Text(
                                '°F',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    buildExpandedBoxWidget(context,
                        bottomText: competitors.homeSpreadValue.contains('-')
                            ? competitors.homeSpreadValue
                            : '+${competitors.homeSpreadValue}',
                        upText: competitors.awaySpreadValue.contains('-')
                            ? competitors.awaySpreadValue
                            : '+${competitors.awaySpreadValue}'),
                    buildExpandedBoxWidget(context,
                        bottomText: competitors.homeMoneyLineValue,
                        upText: competitors.awayMoneyLineValue),
                    Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * .04,
                              width: MediaQuery.of(context).size.width * .09,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.width *
                                          .008)),
                              child: Center(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                textBaseline: TextBaseline.alphabetic,
                                verticalDirection: VerticalDirection.up,
                                children: [
                                  Text('o',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                                  Text((competitors.awayOUValue).toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                                ],
                              )),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .02,
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * .04,
                              width: MediaQuery.of(context).size.width * .09,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.width *
                                          .008)),
                              child: Center(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                textBaseline: TextBaseline.alphabetic,
                                verticalDirection: VerticalDirection.up,
                                children: [
                                  Text('u',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                                  Text((competitors.homeOUValue).toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                                ],
                              )),
                            )
                          ],
                        )),
                  ],
                ),
              ),
            )
          : SizedBox();
    } catch (e) {
      return const SizedBox();
    }
  }

  Container tabTitleWidget(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * .05,
        decoration:
            BoxDecoration(color: Theme.of(context).secondaryHeaderColor),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: game.appCommonText(
                    color: whiteColor,
                    weight: FontWeight.w600,
                    size: MediaQuery.of(context).size.height * .017),
              ),
              Expanded(
                flex: 1,
                child: time.appCommonText(
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
