import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hotlines/generated/assets.dart';
import 'package:hotlines/utils/utils.dart';
import 'package:intl/intl.dart';
import '../../constant/constant.dart';
import '../../constant/shred_preference.dart';
import '../../controller/sport_controller.dart';
import '../../model/game_detail_model.dart';
import '../../theme/helper.dart';
import '../../theme/theme.dart';
import '../../utils/app_progress.dart';
import 'game_details_screen.dart';

// ignore: must_be_immutable
class GameListingScreen extends StatelessWidget {
  GameListingScreen({Key? key, required this.sportKey, required this.date})
      : super(key: key);
  final String sportKey;
  final String date;
  final SportController sportController = Get.find();
  late ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    isDark = PreferenceManager.getIsDarkMode() ?? false;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100.0),
          child: Container(
            height: Get.height * .098,
            alignment: Alignment.bottomCenter,
            color: Theme.of(context).secondaryHeaderColor,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * .02, vertical: 5),
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
                    child: sportKey.appCommonText(
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
          )),
      body: Stack(
        children: [
          GetBuilder<SportController>(initState: (state) {
            sportController
                .gameListingsResponse(context, sportKey: sportKey, date: date)
                .then((value) => sportController.gameListingsWithLogoResponse(
                    context, '2023', sportKey));

            // sportController.getSportDataFromJson(context);
          }, builder: (controller) {
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 1),
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
          }),
          Obx(() => sportController.isLoading.value
              ? const AppProgress()
              : const SizedBox())
        ],
      ),
    );
  }

  tableDetailWidget(BuildContext context) {
    return Expanded(
        child: GetBuilder<SportController>(
      initState: (state) {},
      builder: (controller) {
        return sportController.isLoading.value
            ? const SizedBox()
            : controller.gameDetails.isNotEmpty
                ? ListView.builder(
                    // controller: scrollController,
                    itemCount: controller.gameDetails.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            Get.to(SportDetailsScreen(
                              gameDetails: controller.gameDetails[index],
                              sportKey: sportKey,
                            ));
                          },
                          child: teamWidget(
                              controller.gameDetails[index], context,
                              index: index));
                    },
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

  teamWidget(Result? results, BuildContext context, {int index = 0}) {
    String date = DateFormat.MMMd()
        .format(results?.schedule.date.toLocal() ?? DateTime.now().toLocal());
    String dateTime = DateFormat.jm()
        .format(results?.schedule.date.toLocal() ?? DateTime.now().toLocal());
    try {
      return (results?.odds ?? []).isEmpty && sportKey == 'MLB'
          ? const SizedBox()
          : Padding(
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
                                  imageUrl: results?.gameLogoAwayLink ?? '',
                                ),
                                // 10.W(),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * .01,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    (results?.teams.away.team ?? "").toString(),
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                    textAlign: TextAlign.start,
                                    maxLines: 2,
                                  ),
                                ),
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
                                    imageUrl:
                                        (results?.gameHomeLogoLink ?? "")),
                                // 10.W(),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * .01,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    (results?.teams.home.team ?? "").toString(),
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                    textAlign: TextAlign.start,
                                    maxLines: 2,
                                  ),
                                ),
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
                          getWeatherIcon(results?.venue.weather ?? 0, context,
                              MediaQuery.of(context).size.height * .064),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            textBaseline: TextBaseline.alphabetic,
                            verticalDirection: VerticalDirection.up,
                            children: [
                              Text(
                                '${results?.venue.tmpInFahrenheit}',
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
                        bottomText: results != null
                            ? results.odds.isNotEmpty
                                ? ('${results.odds[0].spread.current.home.toString().contains('-') ? results.odds[0].spread.current.home : '+${results.odds[0].spread.current.home}'}')
                                    .toString()
                                : '00'
                            : '',
                        upText: results != null
                            ? results.odds.isNotEmpty
                                ? ('${results.odds[0].spread.current.away.toString().contains('-') ? results.odds[0].spread.current.away : '+${results.odds[0].spread.current.away}'}')
                                : '00'
                            : ''),
                    buildExpandedBoxWidget(context,
                        bottomText: results != null
                            ? results.odds.isNotEmpty
                                ? ('${results.odds[0].moneyline.current.homeOdds.toString().contains('-') ? results.odds[0].moneyline.current.homeOdds : '+${results.odds[0].moneyline.current.homeOdds}'}')
                                    .toString()
                                : "00"
                            : '',
                        upText: results != null
                            ? results.odds.isNotEmpty
                                ? ('${results.odds[0].moneyline.current.awayOdds.toString().contains('-') ? results.odds[0].moneyline.current.awayOdds : '+${results.odds[0].moneyline.current.awayOdds}'}')
                                    .toString()
                                : '00'
                            : ""),
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
                                  Text(
                                      (results != null
                                              ? results.odds.isNotEmpty
                                                  ? results.odds[0].total
                                                      .current.total
                                                  : '00'
                                              : "")
                                          .toString(),
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
                                  Text(
                                      (results != null
                                              ? results.odds.isNotEmpty
                                                  ? results.odds[0].total
                                                      .current.total
                                                  : '00'
                                              : "")
                                          .toString(),
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
