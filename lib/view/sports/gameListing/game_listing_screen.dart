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
              getGameListingForOtherGame(true);
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
    final DateTime now = DateTime.now().add(const Duration(days: 1));
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);
    await gameListingController
        .gameListingTodayApiRes(
            key: widget.keys,
            isLoad: isLoad,
            sportKey: widget.sportKey,
            date: widget.date,
            sportId: widget.sportId)
        .then((value) {
      gameListingController
          .gameListingTomorrowApiRes(
              key: widget.keys,
              isLoad: isLoad,
              sportKey: widget.sportKey,
              date: formatted,
              sportId: widget.sportId)
          .then((value) {
        gameListingController.getAllEventList(widget.sportKey);
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

  getGameListingForOtherGame(bool isLoad) {
    final DateTime now =
        DateTime.parse(widget.date).add(const Duration(days: 1));
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);
    gameListingController
        .gameListingTodayApiRes(
            key: widget.keys,
            isLoad: isLoad,
            sportKey: widget.sportKey,
            date: widget.date,
            sportId: widget.sportId)
        .then((value) {
      gameListingController
          .gameListingTomorrowApiRes(
              key: widget.keys,
              isLoad: isLoad,
              sportKey: widget.sportKey,
              date: formatted,
              sportId: widget.sportId)
          .then((value) {
        gameListingController.getAllEventList(widget.sportKey);
        gameListingController.gameListingsWithLogoResponse(
            widget.date, widget.sportKey,
            isLoad: true);
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
                        return getGameListingForOtherGame(false);
                      }
                    },
                    color: Theme.of(context).disabledColor,
                    child: ListView.builder(
                      itemCount: controller.sportEventsList.length,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        try {
                          return GestureDetector(
                              onTap: () {
                                Get.to(SportDetailsScreen(
                                  gameDetails:
                                      controller.sportEventsList[index],
                                  sportKey: widget.sportKey,
                                ));
                              },
                              child: teamWidget(
                                  controller.sportEventsList[index], context,
                                  index: index));
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
    String date = DateFormat.MMMd()
        .format(DateTime.parse(competitors.scheduled ?? '').toLocal());
    String dateTime = DateFormat.jm()
        .format(DateTime.parse(competitors.scheduled ?? '').toLocal());
    try {
      return Padding(
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
                      horizontal: MediaQuery.of(context).size.width * .02),
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
                            width: MediaQuery.of(context).size.width * .01,
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              (gameListingController
                                      .sportEventsList[index].awayTeam)
                                  .toString(),
                              style: Theme.of(context).textTheme.labelLarge,
                              textAlign: TextAlign.start,
                              maxLines: 2,
                            ),
                          ),
                          Text(
                            (gameListingController
                                    .sportEventsList[index].awayScore)
                                .toString(),
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
                          Expanded(flex: 4, child: commonDivider(context)),
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
                            width: MediaQuery.of(context).size.width * .01,
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              (gameListingController
                                      .sportEventsList[index].homeTeam)
                                  .toString(),
                              style: Theme.of(context).textTheme.labelLarge,
                              textAlign: TextAlign.start,
                              maxLines: 2,
                            ),
                          ),
                          Text(
                            gameListingController
                                .sportEventsList[index].homeScore
                                .toString(),
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
                    getWeatherIcon(competitors.venue?.weather ?? 1, context,
                        MediaQuery.of(context).size.height * .064),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      textBaseline: TextBaseline.alphabetic,
                      verticalDirection: VerticalDirection.up,
                      children: [
                        Text(
                          '${competitors.venue?.tmpInFahrenheit ?? 0}',
                          style: Theme.of(context).textTheme.displayMedium,
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
                            Text((competitors.awayOUValue).toString(),
                                style: Theme.of(context).textTheme.bodySmall),
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
                            Text((competitors.homeOUValue).toString(),
                                style: Theme.of(context).textTheme.bodySmall),
                          ],
                        )),
                      )
                    ],
                  )),
            ],
          ),
        ),
      );
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
