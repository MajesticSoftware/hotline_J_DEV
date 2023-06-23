import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hotlines/generated/assets.dart';
import 'package:hotlines/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../constant/constant.dart';
import '../../controller/sport_controller.dart';
import '../../model/game_detail_model.dart';
import '../../theme/helper.dart';
import '../../theme/theme.dart';
import '../../utils/app_progress.dart';

// ignore: must_be_immutable
class GameTeamScreen extends StatelessWidget {
  GameTeamScreen({Key? key, required this.sportKey}) : super(key: key);
  final String sportKey;
  final SportController sportController = Get.find();
  late ScrollController scrollController;
  // late GameDetailDataSource gameDetailDataSource;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100.0),
          child: Container(
            height: Get.height * .098,
            alignment: Alignment.bottomCenter,
            color: appColor,
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
            sportController.isClick.clear();
            sportController.isClick.add(1);
            /* scrollController = ScrollController();
            scrollController.addListener(() {
              // log('${scrollController.position.maxScrollExtent}----${scrollController.position.pixels}');

              if (sportController.gameDetails.isNotEmpty) {
                if (scrollController.position.pixels == 0.0) {
                  sportController.isClick.clear();
                  sportController.isClick.add(1);
                  sportController.update();
                } else if (sportController.gameDetails[0].results.length > 6) {
                  sportController.isClick.clear();
                  sportController.isClick.add(2);
                  sportController.update();
                } else if (sportController.gameDetails[0].results.length > 12) {
                  sportController.isClick.clear();
                  sportController.isClick.add(3);
                  sportController.update();
                } else {
                  sportController.isClick.clear();
                  sportController.isClick.add(1);
                  sportController.update();
                }
              }
            });*/
            // sportController.gameDetailsResponse(context, sportKey: sportKey);
            sportController.getSportDataFromJson();
          }, builder: (controller) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      height: Get.height * .8,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: whiteColor),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          tabTitleWidget(),
                          tableDetailWidget(),
                        ],
                      ),
                    ),
                  ),
                  bottomWidget()
                  // SfDataPager(pageCount: 20, delegate: gameDetailDataSource),
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

  SizedBox bottomWidget() {
    return SizedBox(
      height: 48,
      child: GetBuilder<SportController>(
          initState: (state) {},
          builder: (controller) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: 7,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: index == 4
                      ? Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: SvgPicture.asset(Assets.imagesDotes),
                        )
                      : GestureDetector(
                          onTap: index == 0 || index == 6
                              ? () {}
                              : () {
                                  controller.isClick.clear();
                                  controller.isClick.add(index);
                                  controller.update();
                                  log('tap--${controller.isClick}');
                                },
                          child: Container(
                            height: 48,
                            width: 48,
                            decoration: BoxDecoration(
                                border: Border.all(color: dividerColor),
                                color: controller.isClick.contains(index)
                                    ? appColor
                                    : whiteColor,
                                borderRadius: BorderRadius.circular(5)),
                            child: index == 0
                                ? const Icon(
                                    Icons.arrow_back_ios_rounded,
                                    size: 16,
                                  )
                                : index == 6
                                    ? const Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        size: 16,
                                      )
                                    : Center(
                                        child: '${index == 5 ? '99' : index}'
                                            .appCommonText(
                                                color: controller.isClick
                                                        .contains(index)
                                                    ? whiteColor
                                                    : blackColor,
                                                size: 16,
                                                weight: FontWeight.w600)),
                          ),
                        ),
                );
              },
            );
          }),
    );
  }

  Expanded tableDetailWidget() {
    return Expanded(child: GetBuilder<SportController>(
      builder: (controller) {
        return sportController.isLoading.value
            ? const SizedBox()
            : controller.gameDetails.isNotEmpty
                ? ListView.builder(
                    // controller: scrollController,
                    itemCount: controller.gameDetails[0].results.length,
                    itemBuilder: (context, index) {
                      return SingleChildScrollView(
                        // controller: scrollController,
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  // Get.to(SportDetailsScreen());
                                },
                                child: teamWidget(
                                    controller.gameDetails[0].results[index])),
                            Container(
                              height: 1,
                              color: dividerColor,
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : Center(
                    child: Stack(
                    children: [
                      SvgPicture.asset(Assets.imagesNodataImage),
                      Positioned(
                        bottom: 70,
                        left: 20,
                        right: 0,
                        child: TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Container(
                              height: 32,
                              width: 218,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: boxColor),
                              child: Center(
                                child: backButton.appCommonText(
                                    color: whiteColor,
                                    size: 14,
                                    weight: FontWeight.w500),
                              ),
                            )),
                      )
                    ],
                  ));
      },
    ));
  }

  Row teamWidget(Result results) {
    String dateTime = DateFormat.jm().format(results.schedule.date);
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    commonCachedNetworkImage(
                        width: 48, height: 48, imageUrl: ''),
                    10.W(),
                    Expanded(
                      flex: 2,
                      child: results.teams.away.team.toString().appCommonText(
                          color: blackColor,
                          align: TextAlign.start,
                          weight: FontWeight.w700,
                          size: Get.height * .018),
                    ),
                  ],
                ),
                5.H(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: '@'.appCommonText(
                          color: greyColor,
                          size: Get.height * .016,
                          weight: FontWeight.w600),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        height: 1,
                        color: dividerColor,
                      ),
                    ),
                  ],
                ),
                5.H(),
                Row(
                  children: [
                    commonCachedNetworkImage(
                        width: 48, height: 48, imageUrl: ''),
                    10.W(),
                    Expanded(
                      flex: 2,
                      child: results.teams.home.team.appCommonText(
                          color: blackColor,
                          align: TextAlign.start,
                          weight: FontWeight.w700,
                          size: Get.height * .018),
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
              dateTime.appCommonText(
                  weight: FontWeight.w600,
                  size: Get.height * .012,
                  color: greyColor),
              SvgPicture.asset(
                Assets.imagesSun,
                width: Get.width * .068,
                height: Get.height * .068,
                fit: BoxFit.fill,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                textBaseline: TextBaseline.alphabetic,
                verticalDirection: VerticalDirection.up,
                children: [
                  '  83'.appCommonText(size: Get.height * .03),
                  '°F'.appCommonText(size: Get.height * .01),
                ],
              )
            ],
          ),
        ),
        buildExpandedBoxWidget(
            bottomText: results.odds.isNotEmpty
                ? results.odds[0].spread.current.home.toString()
                : '00',
            upText: results.odds.isNotEmpty
                ? results.odds[0].spread.current.away.toString()
                : '00'),
        buildExpandedBoxWidget(
            bottomText: results.odds.isNotEmpty
                ? results.odds[0].moneyline.current.homeOdds.toString()
                : "00",
            upText: results.odds.isNotEmpty
                ? results.odds[0].moneyline.current.awayOdds.toString()
                : '00'),
        Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 76,
                  height: 46,
                  decoration: BoxDecoration(
                      color: boxColor, borderRadius: BorderRadius.circular(5)),
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    textBaseline: TextBaseline.alphabetic,
                    verticalDirection: VerticalDirection.up,
                    children: [
                      'o'.appCommonText(
                          color: whiteColor, size: 16, weight: FontWeight.w600),
                      (results.odds.isNotEmpty
                              ? results.odds[0].total.current.overOdds
                              : '00')
                          .toString()
                          .appCommonText(
                              color: whiteColor,
                              size: 16,
                              weight: FontWeight.bold),
                    ],
                  )),
                ),
                45.H(),
                Container(
                  width: 76,
                  height: 46,
                  decoration: BoxDecoration(
                      color: boxColor, borderRadius: BorderRadius.circular(5)),
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    textBaseline: TextBaseline.alphabetic,
                    verticalDirection: VerticalDirection.up,
                    children: [
                      'u'.appCommonText(
                          color: whiteColor, size: 16, weight: FontWeight.w600),
                      (results.odds.isNotEmpty
                              ? results.odds[0].total.current.underOdds
                              : '00')
                          .toString()
                          .appCommonText(
                              color: whiteColor,
                              size: 16,
                              weight: FontWeight.bold),
                    ],
                  )),
                )
              ],
            ))
      ],
    );
  }

  Expanded buildExpandedBoxWidget(
      {String upText = '', String bottomText = ''}) {
    return Expanded(
        flex: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 76,
              height: 46,
              decoration: BoxDecoration(
                  color: boxColor, borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: upText.appCommonText(
                    color: whiteColor, size: 16, weight: FontWeight.bold),
              ),
            ),
            45.H(),
            Container(
              width: 76,
              height: 46,
              decoration: BoxDecoration(
                  color: boxColor, borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: bottomText.appCommonText(
                    color: whiteColor, size: 16, weight: FontWeight.bold),
              ),
            )
          ],
        ));
  }

  Container tabTitleWidget() {
    return Container(
        height: 68,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            color: appColor),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: game.appCommonText(
                    color: whiteColor,
                    weight: FontWeight.w600,
                    size: Get.height * .018),
              ),
              Expanded(
                flex: 1,
                child: time.appCommonText(
                    color: whiteColor,
                    weight: FontWeight.w600,
                    size: Get.height * .018),
              ),
              Expanded(
                flex: 1,
                child: spread.appCommonText(
                    color: whiteColor,
                    weight: FontWeight.w600,
                    size: Get.height * .018),
              ),
              Expanded(
                flex: 1,
                child: moneyLine.appCommonText(
                    color: whiteColor,
                    weight: FontWeight.w600,
                    size: Get.height * .018),
              ),
              Expanded(
                flex: 1,
                child: overUnder.appCommonText(
                    color: whiteColor,
                    weight: FontWeight.w600,
                    size: Get.height * .018),
              ),
            ],
          ),
        ));
  }
}

/*
class GameDetailDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  GameDetailDataSource({required List<GameDetailsModel> gameData}) {
    _employeeData = gameData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(
                  columnName: 'Game', value: e.results[0].teams.home.team),
              DataGridCell<String>(
                  columnName: 'Time',
                  value: e.results[0].schedule.date.toString()),
              DataGridCell<String>(
                  columnName: 'Spread',
                  value:
                      e.results[0].odds[0].spread.current.homeOdds.toString()),
              DataGridCell<String>(
                  columnName: 'Money Line',
                  value:
                      e.results[0].odds[0].spread.current.homeOdds.toString()),
            ]))
        .toList();
  }

  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }
}
*/
