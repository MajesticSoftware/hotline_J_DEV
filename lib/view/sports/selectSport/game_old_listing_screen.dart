// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:hotlines/extras/constants.dart';
// import 'package:hotlines/generated/assets.dart';
// import 'package:hotlines/model/game_listing.dart';
// import 'package:hotlines/utils/animated_search.dart';
// import 'package:hotlines/utils/utils.dart';
// import 'package:intl/intl.dart';
// import '../../../constant/constant.dart';
// import '../../../constant/shred_preference.dart';
// import '../../../theme/helper.dart';
// import '../../../theme/theme.dart';
// import '../../../utils/app_progress.dart';
//
// import '../gameDetails/game_details_screen.dart';
// // ignore: depend_on_referenced_packages
// import 'package:http/http.dart' as http;
//
// import '../game_listing_view/game_listing_con.dart';
//
// // ignore: must_be_immutable
// class GameListingScreen extends StatefulWidget {
//   const GameListingScreen(
//       {Key? key,
//       required this.sportKey,
//       required this.sportId,
//       required this.date,
//       required this.keys})
//       : super(key: key);
//   final String sportKey;
//   final String date;
//   final String keys;
//   final String sportId;
//
//   @override
//   State<GameListingScreen> createState() => _GameListingScreenState();
// }
//
// class _GameListingScreenState extends State<GameListingScreen> {
//   final GameListingController gameListingController = Get.find();
//
//   var client = http.Client();
//   @override
//   void dispose() {
//     super.dispose();
//     client.close();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     isDark = PreferenceManager.getIsDarkMode() ?? false;
//     return GetBuilder<GameListingController>(initState: (state) async {
//       widget.sportKey == 'MLB'
//           ? gameListingController.setIsBack(false)
//           : widget.sportKey == 'NFL'
//               ? gameListingController.setIsBackNFL(false)
//               : gameListingController.setIsBackNCAA(false);
//       return getResponse(true);
//     }, builder: (controller) {
//       return Scaffold(
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         appBar: commonAppBar(context, controller),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//         floatingActionButton: buildAnimSearchBar(controller)
//             .paddingSymmetric(horizontal: Get.width * .03),
//         body: WillPopScope(
//           onWillPop: () {
//             widget.sportKey == 'MLB'
//                 ? gameListingController.setIsBack(false)
//                 : widget.sportKey == 'NFL'
//                     ? gameListingController.setIsBackNFL(false)
//                     : gameListingController.setIsBackNCAA(false);
//             gameListingController.timer = null;
//             gameListingController.timerNCAA = null;
//             FocusScope.of(context).unfocus();
//             Get.delete<GameListingController>();
//             return Future.value(true);
//           },
//           child: Stack(
//             children: [
//               gameListingView(context),
//               Obx(() => gameListingController.isLoading.value
//                   ? const AppProgress()
//                   : const SizedBox())
//             ],
//           ),
//         ),
//       );
//     });
//   }
//
//   AnimSearchBar buildAnimSearchBar(GameListingController controller) {
//     return AnimSearchBar(
//       rtl: true,
//       width: Get.width,
//       autoFocus: true,
//       color: isDark || selectGameController.isDarkMode ? whiteColor : boxColor,
//       style: defaultTextStyle(
//           size: Get.height * .028,
//           color: isDark || selectGameController.isDarkMode
//               ? greyColor
//               : whiteColor),
//       searchIconColor:
//           isDark || selectGameController.isDarkMode ? greyColor : whiteColor,
//       textFieldColor:
//           isDark || selectGameController.isDarkMode ? whiteColor : boxColor,
//       helpText: 'Search game here...',
//       textFieldIconColor:
//           isDark || selectGameController.isDarkMode ? greyColor : whiteColor,
//       textController: controller.searchCon,
//       onSuffixTap: () {
//         controller.searchCon.clear();
//       },
//       onSubmitted: (String text) {
//         controller.searchData(text, widget.sportKey);
//         controller.update();
//       },
//     );
//   }
//
//   getResponse(bool isLoad) async {
//     if (widget.sportKey == 'MLB') {
//       return await gameListingController.getGameListingForMLBRes(isLoad,
//           apiKey: widget.keys,
//           sportKey: widget.sportKey,
//           date: widget.date,
//           sportId: widget.sportId);
//     } else if (widget.sportKey == 'NFL') {
//       return await gameListingController.getGameListingForNFLGame(isLoad,
//           apiKey: widget.keys,
//           sportKey: widget.sportKey,
//           date: widget.date,
//           sportId: widget.sportId);
//     } else {
//       return gameListingController.getGameListingForNCAAGame(isLoad,
//           apiKey: widget.keys,
//           sportKey: widget.sportKey,
//           date: widget.date,
//           sportId: widget.sportId);
//     }
//   }
//
//   SingleChildScrollView gameListingView(BuildContext context) {
//     return SingleChildScrollView(
//       physics: const BouncingScrollPhysics(),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         mainAxisSize: MainAxisSize.max,
//         children: [
//           Container(
//             height: MediaQuery.of(context).size.height * .9,
//             decoration: BoxDecoration(
//                 color: isDark || selectGameController.isDarkMode
//                     ? blackColor
//                     : whiteColor),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 isDark || selectGameController.isDarkMode
//                     ? Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 1),
//                         child: commonDivider(context),
//                       )
//                     : const SizedBox(),
//                 tabTitleWidget(context),
//                 commonDivider(context),
//                 tableDetailWidget(context),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   PreferredSize commonAppBar(BuildContext context, GameListingController con) {
//     return PreferredSize(
//         preferredSize: const Size.fromHeight(100.0),
//         child: Container(
//           height: Get.height * .098,
//           alignment: Alignment.bottomCenter,
//           color: Theme.of(context).secondaryHeaderColor,
//           child: Padding(
//             padding:
//                 EdgeInsets.symmetric(horizontal: Get.width * .02, vertical: 5),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                     child: InkWell(
//                   onTap: () {
//                     // selectGameController.isOpen = false;
//                     widget.sportKey == 'MLB'
//                         ? gameListingController.setIsBack(false)
//                         : widget.sportKey == 'NFL'
//                             ? gameListingController.setIsBackNFL(false)
//                             : gameListingController.setIsBackNCAA(false);
//                     con.timer = null;
//                     con.timerNCAA = null;
//                     FocusScope.of(context).unfocus();
//                     Get.delete<GameListingController>();
//                     Get.back();
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.all(10),
//                     child: SvgPicture.asset(
//                       Assets.imagesBackArrow,
//                       height: MediaQuery.of(context).size.height * .02,
//                       alignment: Alignment.centerLeft,
//                     ),
//                   ),
//                 )),
//                 Expanded(
//                   child: SvgPicture.asset(Assets.imagesLogo,
//                       height: MediaQuery.of(context).size.height * .025,
//                       fit: BoxFit.contain),
//                 ),
//                 Expanded(
//                   child: widget.sportKey.appCommonText(
//                       color: whiteColor,
//                       align: TextAlign.end,
//                       weight: FontWeight.w700,
//                       size: Get.height * .024),
//                 ),
//               ],
//             ),
//           ),
//         ));
//   }
//
//   tableDetailWidget(BuildContext context) {
//     return Expanded(
//         child: GetBuilder<GameListingController>(
//       initState: (state) {},
//       builder: (controller) {
//         return controller.isLoading.value
//             ? const SizedBox()
//             : (controller.sportKey == 'MLB'
//                             ? controller.mlbSportEventsList
//                             : controller.sportKey == 'NFL'
//                                 ? controller.nflSportEventsList
//                                 : controller.ncaaSportEventsList)
//                         .isEmpty &&
//                     !controller.isPagination
//                 ? emptyDataWidget(context)
//                 : RefreshIndicator(
//                     onRefresh: () async {
//                       return await getResponse(false);
//                     },
//                     color: Theme.of(context).disabledColor,
//                     child: Column(
//                       children: [
//                         (MediaQuery.of(context).size.height * .01).H(),
//                         /*  commonTextFiled(
//                           context,
//                           controller: controller.searchCon,
//                           ctrl: controller,
//                           onChanged: (p0) {
//                             controller.searchData(p0);
//                           },
//                         ).paddingSymmetric(
//                             horizontal:
//                                 MediaQuery.of(context).size.width * .02),*/
//                         Expanded(
//                           child: controller.searchCon.text.isEmpty
//                               ? ListView.builder(
//                                   padding: EdgeInsets.zero,
//                                   itemCount: (controller.sportKey == 'MLB'
//                                               ? controller.mlbSportEventsList
//                                               : controller.sportKey == 'NFL'
//                                                   ? controller
//                                                       .nflSportEventsList
//                                                   : controller
//                                                       .ncaaSportEventsList)
//                                           .length +
//                                       1,
//                                   physics:
//                                       const AlwaysScrollableScrollPhysics(),
//                                   itemBuilder: (context, index) {
//                                     try {
//                                       return index ==
//                                               (controller.sportKey == 'MLB'
//                                                       ? controller
//                                                           .mlbSportEventsList
//                                                       : controller.sportKey ==
//                                                               'NFL'
//                                                           ? controller
//                                                               .nflSportEventsList
//                                                           : controller
//                                                               .ncaaSportEventsList)
//                                                   .length
//                                           ? !gameListingController
//                                                       .isLoading.value &&
//                                                   gameListingController
//                                                       .isPagination
//                                               ? Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(8.0),
//                                                   child: Center(
//                                                     child: SizedBox(
//                                                         width: 16,
//                                                         height: 16,
//                                                         child:
//                                                             CircularProgressIndicator(
//                                                           color:
//                                                               Theme.of(context)
//                                                                   .primaryColor,
//                                                         )),
//                                                   ),
//                                                 )
//                                               : const SizedBox()
//                                           : GestureDetector(
//                                               onTap: () {
//                                                 Get.to(SportDetailsScreen(
//                                                   gameDetails: (controller
//                                                               .sportKey ==
//                                                           'MLB'
//                                                       ? controller
//                                                           .mlbSportEventsList
//                                                       : controller.sportKey ==
//                                                               'NFL'
//                                                           ? controller
//                                                               .nflSportEventsList
//                                                           : controller
//                                                               .ncaaSportEventsList)[index],
//                                                   sportKey: widget.sportKey,
//                                                   sportId: widget.sportId,
//                                                   date: widget.date,
//                                                 ));
//                                               },
//                                               child: teamWidget(
//                                                   (controller.sportKey == 'MLB'
//                                                       ? controller
//                                                           .mlbSportEventsList
//                                                       : controller.sportKey ==
//                                                               'NFL'
//                                                           ? controller
//                                                               .nflSportEventsList
//                                                           : controller
//                                                               .ncaaSportEventsList)[index],
//                                                   context,
//                                                   index: index));
//                                     } catch (e) {
//                                       return const SizedBox();
//                                     }
//                                   },
//                                 )
//                               : ListView.builder(
//                                   padding: EdgeInsets.zero,
//                                   itemCount: controller.searchList.length,
//                                   physics:
//                                       const AlwaysScrollableScrollPhysics(),
//                                   itemBuilder: (context, index) {
//                                     try {
//                                       return GestureDetector(
//                                           onTap: () {
//                                             Get.to(SportDetailsScreen(
//                                               gameDetails:
//                                                   controller.searchList[index],
//                                               sportKey: widget.sportKey,
//                                               sportId: widget.sportId,
//                                               date: widget.date,
//                                             ));
//                                           },
//                                           child: teamSearchWidget(
//                                               controller.searchList[index],
//                                               context,
//                                               index: index));
//                                     } catch (e) {
//                                       return const SizedBox();
//                                     }
//                                   },
//                                 ),
//                         ),
//                       ],
//                     ),
//                   );
//       },
//     ));
//   }
//
//   Center emptyDataWidget(BuildContext context) {
//     return Center(
//         child: Stack(
//       children: [
//         SvgPicture.asset(
//           Assets.imagesNodataImage,
//           width: MediaQuery.of(context).size.width * .349,
//           height: MediaQuery.of(context).size.height * .329,
//           fit: BoxFit.contain,
//         ),
//         Positioned(
//           bottom: MediaQuery.of(context).size.height * .07,
//           left: MediaQuery.of(context).size.height * .08,
//           child: GestureDetector(
//               onTap: () {
//                 Get.back();
//               },
//               child: Container(
//                 height: MediaQuery.of(context).size.height * .032,
//                 width: MediaQuery.of(context).size.width * .34,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(5),
//                     color: Theme.of(context).backgroundColor),
//                 child: Center(
//                   child: backButton.appCommonText(
//                       color: whiteColor,
//                       size: mobileView.size.shortestSide < 600
//                           ? MediaQuery.of(context).size.height * .012
//                           : MediaQuery.of(context).size.height * .014,
//                       weight: FontWeight.w500),
//                 ),
//               )),
//         )
//       ],
//     ));
//   }
//
//   teamWidget(SportEvents competitors, BuildContext context, {int index = 0}) {
//     String date = DateFormat.MMMd()
//         .format(DateTime.parse(competitors.scheduled ?? '').toLocal());
//     String dateTime = DateFormat.jm()
//         .format(DateTime.parse(competitors.scheduled ?? '').toLocal());
//     try {
//       return competitors.status == 'closed' && widget.sportKey == "NFL"
//           ? const SizedBox()
//           : competitors.status == 'postponed'
//               ? const SizedBox()
//               : Padding(
//                   padding: EdgeInsets.only(
//                       left: MediaQuery.of(context).size.width * .02,
//                       top: MediaQuery.of(context).size.width * .014,
//                       right: MediaQuery.of(context).size.width * .02),
//                   child: Container(
//                     decoration: BoxDecoration(
//                         color: Theme.of(context).canvasColor,
//                         border: Border.all(
//                             color: isDark || selectGameController.isDarkMode
//                                 ? greyColor
//                                 : dividerColor),
//                         borderRadius: BorderRadius.circular(
//                             MediaQuery.of(context).size.width * .02)),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           flex: 3,
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(
//                                 vertical:
//                                     MediaQuery.of(context).size.height * .006,
//                                 horizontal:
//                                     MediaQuery.of(context).size.width * .02),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   children: [
//                                     commonCachedNetworkImage(
//                                       width: Get.height * .044,
//                                       height: Get.height * .044,
//                                       imageUrl: (gameListingController
//                                                                   .sportKey ==
//                                                               'MLB'
//                                                           ? gameListingController
//                                                               .mlbSportEventsList
//                                                           : gameListingController
//                                                                       .sportKey ==
//                                                                   'NFL'
//                                                               ? gameListingController
//                                                                   .nflSportEventsList
//                                                               : gameListingController
//                                                                   .ncaaSportEventsList)[
//                                                       index]
//                                                   .awayTeam ==
//                                               'North Carolina State Wolfpack'
//                                           ? 'https://a.espncdn.com/i/teamlogos/ncaa/500/152.png'
//                                           : (gameListingController.sportKey ==
//                                                                   'MLB'
//                                                               ? gameListingController
//                                                                   .mlbSportEventsList
//                                                               : gameListingController
//                                                                           .sportKey ==
//                                                                       'NFL'
//                                                                   ? gameListingController
//                                                                       .nflSportEventsList
//                                                                   : gameListingController
//                                                                       .ncaaSportEventsList)[
//                                                           index]
//                                                       .awayTeam ==
//                                                   'Louisiana-Lafayette Ragin Cajuns'
//                                               ? "https://a.espncdn.com/i/teamlogos/ncaa/500/309.png"
//                                               : (gameListingController.sportKey ==
//                                                                   'MLB'
//                                                               ? gameListingController
//                                                                   .mlbSportEventsList
//                                                               : gameListingController
//                                                                           .sportKey ==
//                                                                       'NFL'
//                                                                   ? gameListingController
//                                                                       .nflSportEventsList
//                                                                   : gameListingController
//                                                                       .ncaaSportEventsList)[index]
//                                                           .awayTeam ==
//                                                       'Sam Houston State Bearkats'
//                                                   ? "https://a.espncdn.com/i/teamlogos/ncaa/500/2534.png"
//                                                   : competitors.gameLogoAwayLink,
//                                     ),
//                                     // 10.W(),
//                                     SizedBox(
//                                       width: MediaQuery.of(context).size.width *
//                                           .01,
//                                     ),
//                                     Expanded(
//                                       flex: 2,
//                                       child: Text(
//                                         ((gameListingController.sportKey ==
//                                                         'MLB'
//                                                     ? gameListingController
//                                                         .mlbSportEventsList
//                                                     : gameListingController
//                                                                 .sportKey ==
//                                                             'NFL'
//                                                         ? gameListingController
//                                                             .nflSportEventsList
//                                                         : gameListingController
//                                                             .ncaaSportEventsList)[index]
//                                                 .awayTeam)
//                                             .toString(),
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .labelLarge,
//                                         textAlign: TextAlign.start,
//                                         maxLines: 2,
//                                       ),
//                                     ),
//                                     Text(
//                                       ((gameListingController.sportKey == 'MLB'
//                                                   ? gameListingController
//                                                       .mlbSportEventsList
//                                                   : gameListingController
//                                                               .sportKey ==
//                                                           'NFL'
//                                                       ? gameListingController
//                                                           .nflSportEventsList
//                                                       : gameListingController
//                                                           .ncaaSportEventsList)[index]
//                                               .awayScore)
//                                           .toString(),
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .headlineLarge,
//                                       textAlign: TextAlign.start,
//                                       maxLines: 2,
//                                     )
//                                   ],
//                                 ),
//                                 5.H(),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Expanded(
//                                       flex: 0,
//                                       child: Text(
//                                         '  Vs',
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .labelSmall,
//                                         textAlign: TextAlign.center,
//                                       ),
//                                     ),
//                                     Expanded(
//                                         flex: 4, child: commonDivider(context)),
//                                   ],
//                                 ),
//                                 5.H(),
//                                 Row(
//                                   children: [
//                                     commonCachedNetworkImage(
//                                         width: Get.height * .044,
//                                         height: Get.height * .044,
//                                         imageUrl: (gameListingController
//                                                                     .sportKey ==
//                                                                 'MLB'
//                                                             ? gameListingController
//                                                                 .mlbSportEventsList
//                                                             : gameListingController
//                                                                         .sportKey ==
//                                                                     'NFL'
//                                                                 ? gameListingController
//                                                                     .nflSportEventsList
//                                                                 : gameListingController
//                                                                     .ncaaSportEventsList)[
//                                                         index]
//                                                     .homeTeam ==
//                                                 'North Carolina State Wolfpack'
//                                             ? 'https://a.espncdn.com/i/teamlogos/ncaa/500/152.png'
//                                             : (gameListingController.sportKey ==
//                                                                     'MLB'
//                                                                 ? gameListingController
//                                                                     .mlbSportEventsList
//                                                                 : gameListingController
//                                                                             .sportKey ==
//                                                                         'NFL'
//                                                                     ? gameListingController
//                                                                         .nflSportEventsList
//                                                                     : gameListingController
//                                                                         .ncaaSportEventsList)[
//                                                             index]
//                                                         .homeTeam ==
//                                                     'Louisiana-Lafayette Ragin Cajuns'
//                                                 ? "https://a.espncdn.com/i/teamlogos/ncaa/500/309.png"
//                                                 : (gameListingController.sportKey ==
//                                                                     'MLB'
//                                                                 ? gameListingController
//                                                                     .mlbSportEventsList
//                                                                 : gameListingController
//                                                                             .sportKey ==
//                                                                         'NFL'
//                                                                     ? gameListingController
//                                                                         .nflSportEventsList
//                                                                     : gameListingController
//                                                                         .ncaaSportEventsList)[index]
//                                                             .homeTeam ==
//                                                         'Sam Houston State Bearkats'
//                                                     ? "https://a.espncdn.com/i/teamlogos/ncaa/500/2534.png"
//                                                     : competitors.gameHomeLogoLink),
//                                     // 10.W(),
//                                     SizedBox(
//                                       width: MediaQuery.of(context).size.width *
//                                           .01,
//                                     ),
//                                     Expanded(
//                                       flex: 2,
//                                       child: Text(
//                                         ((gameListingController.sportKey ==
//                                                         'MLB'
//                                                     ? gameListingController
//                                                         .mlbSportEventsList
//                                                     : gameListingController
//                                                                 .sportKey ==
//                                                             'NFL'
//                                                         ? gameListingController
//                                                             .nflSportEventsList
//                                                         : gameListingController
//                                                             .ncaaSportEventsList)[index]
//                                                 .homeTeam)
//                                             .toString(),
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .labelLarge,
//                                         textAlign: TextAlign.start,
//                                         maxLines: 2,
//                                       ),
//                                     ),
//                                     Text(
//                                       (gameListingController.sportKey == 'MLB'
//                                                   ? gameListingController
//                                                       .mlbSportEventsList
//                                                   : gameListingController
//                                                               .sportKey ==
//                                                           'NFL'
//                                                       ? gameListingController
//                                                           .nflSportEventsList
//                                                       : gameListingController
//                                                           .ncaaSportEventsList)[
//                                               index]
//                                           .homeScore
//                                           .toString(),
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .headlineLarge,
//                                       textAlign: TextAlign.start,
//                                       maxLines: 2,
//                                     )
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 1,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               (MediaQuery.of(context).size.height * .005).H(),
//                               Text(
//                                 '$date, $dateTime',
//                                 style: Theme.of(context).textTheme.displaySmall,
//                                 textAlign: TextAlign.center,
//                               ),
//                               competitors.status == 'live'
//                                   ? Container(
//                                       height:
//                                           MediaQuery.of(context).size.height *
//                                               .02,
//                                       width: MediaQuery.of(context).size.width *
//                                           .07,
//                                       decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(105),
//                                           color: redColor),
//                                       child: Center(
//                                         child: 'LIVE'.appCommonText(
//                                             color: whiteColor,
//                                             size: MediaQuery.of(context)
//                                                     .size
//                                                     .height *
//                                                 .012,
//                                             weight: FontWeight.bold),
//                                       ),
//                                     )
//                                   : const SizedBox(),
//                               getWeatherIcon(competitors.weather, context,
//                                   MediaQuery.of(context).size.height * .064)
//                               /* getWeatherIcon(
//                                   competitors.venue?.weather ?? 'Sunny',
//                                   context,
//                                   MediaQuery.of(context).size.height * .064),*/
//                               ,
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 textBaseline: TextBaseline.alphabetic,
//                                 verticalDirection: VerticalDirection.up,
//                                 children: [
//                                   Text(
//                                     competitors.tmpInFahrenheit == 0
//                                         ? "TBD"
//                                         : competitors.tmpInFahrenheit
//                                             .toString()
//                                             .split('.')
//                                             .first,
//                                     style: competitors.tmpInFahrenheit == 0
//                                         ? Theme.of(context)
//                                             .textTheme
//                                             .headlineSmall!
//                                             .copyWith(
//                                                 fontSize: MediaQuery.of(context)
//                                                         .size
//                                                         .height *
//                                                     .014)
//                                         : Theme.of(context)
//                                             .textTheme
//                                             .displayMedium,
//                                   ),
//                                   Text(
//                                     '°F',
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .headlineSmall,
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                         buildExpandedBoxWidget(context,
//                             bottomText:
//                                 competitors.homeSpreadValue.contains('-')
//                                     ? competitors.homeSpreadValue
//                                     : '+${competitors.homeSpreadValue}',
//                             upText: competitors.awaySpreadValue.contains('-')
//                                 ? competitors.awaySpreadValue
//                                 : '+${competitors.awaySpreadValue}'),
//                         buildExpandedBoxWidget(context,
//                             bottomText: competitors.homeMoneyLineValue,
//                             upText: competitors.awayMoneyLineValue),
//                         Expanded(
//                             flex: 1,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Container(
//                                   height:
//                                       MediaQuery.of(context).size.height * .04,
//                                   // width: MediaQuery.of(context).size.width * .09,
//                                   decoration: BoxDecoration(
//                                       color: Theme.of(context).primaryColor,
//                                       borderRadius: BorderRadius.circular(
//                                           MediaQuery.of(context).size.width *
//                                               .008)),
//                                   child: Center(
//                                       child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment: CrossAxisAlignment.end,
//                                     textBaseline: TextBaseline.alphabetic,
//                                     verticalDirection: VerticalDirection.up,
//                                     children: [
//                                       Text('o',
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .bodySmall),
//                                       Text((competitors.awayOUValue).toString(),
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .bodySmall),
//                                     ],
//                                   )),
//                                 ).paddingSymmetric(
//                                   horizontal: mobileView.size.shortestSide < 600
//                                       ? MediaQuery.of(context).size.height *
//                                           .008
//                                       : MediaQuery.of(context).size.height *
//                                           .015,
//                                 ),
//                                 SizedBox(
//                                   height:
//                                       MediaQuery.of(context).size.height * .02,
//                                 ),
//                                 Container(
//                                   height:
//                                       MediaQuery.of(context).size.height * .04,
//                                   // width: MediaQuery.of(context).size.width * .09,
//                                   decoration: BoxDecoration(
//                                       color: Theme.of(context).primaryColor,
//                                       borderRadius: BorderRadius.circular(
//                                           MediaQuery.of(context).size.width *
//                                               .008)),
//                                   child: Center(
//                                       child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment: CrossAxisAlignment.end,
//                                     textBaseline: TextBaseline.alphabetic,
//                                     verticalDirection: VerticalDirection.up,
//                                     children: [
//                                       Text('u',
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .bodySmall),
//                                       Text((competitors.homeOUValue).toString(),
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .bodySmall),
//                                     ],
//                                   )),
//                                 ).paddingSymmetric(
//                                   horizontal: mobileView.size.shortestSide < 600
//                                       ? MediaQuery.of(context).size.height *
//                                           .008
//                                       : MediaQuery.of(context).size.height *
//                                           .015,
//                                 )
//                               ],
//                             )),
//                       ],
//                     ),
//                   ),
//                 );
//     } catch (e) {
//       return const SizedBox();
//     }
//   }
//
//   teamSearchWidget(SportEvents competitors, BuildContext context,
//       {int index = 0}) {
//     String date = DateFormat.MMMd()
//         .format(DateTime.parse(competitors.scheduled ?? '').toLocal());
//     String dateTime = DateFormat.jm()
//         .format(DateTime.parse(competitors.scheduled ?? '').toLocal());
//     try {
//       return competitors.status == 'closed' && widget.sportKey == "NFL"
//           ? const SizedBox()
//           : competitors.status == 'postponed'
//               ? const SizedBox()
//               : Padding(
//                   padding: EdgeInsets.only(
//                       left: MediaQuery.of(context).size.width * .02,
//                       top: MediaQuery.of(context).size.width * .014,
//                       right: MediaQuery.of(context).size.width * .02),
//                   child: Container(
//                     decoration: BoxDecoration(
//                         color: Theme.of(context).canvasColor,
//                         border: Border.all(
//                             color: isDark || selectGameController.isDarkMode
//                                 ? greyColor
//                                 : dividerColor),
//                         borderRadius: BorderRadius.circular(
//                             MediaQuery.of(context).size.width * .02)),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           flex: 3,
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(
//                                 vertical:
//                                     MediaQuery.of(context).size.height * .006,
//                                 horizontal:
//                                     MediaQuery.of(context).size.width * .02),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   children: [
//                                     commonCachedNetworkImage(
//                                       width: Get.height * .044,
//                                       height: Get.height * .044,
//                                       imageUrl: gameListingController
//                                                   .searchList[index].awayTeam ==
//                                               'North Carolina State Wolfpack'
//                                           ? 'https://a.espncdn.com/i/teamlogos/ncaa/500/152.png'
//                                           : gameListingController
//                                                       .searchList[index]
//                                                       .awayTeam ==
//                                                   'Louisiana-Lafayette Ragin Cajuns'
//                                               ? "https://a.espncdn.com/i/teamlogos/ncaa/500/309.png"
//                                               : gameListingController
//                                                           .searchList[index]
//                                                           .awayTeam ==
//                                                       'Sam Houston State Bearkats'
//                                                   ? "https://a.espncdn.com/i/teamlogos/ncaa/500/2534.png"
//                                                   : competitors
//                                                       .gameLogoAwayLink,
//                                     ),
//                                     // 10.W(),
//                                     SizedBox(
//                                       width: MediaQuery.of(context).size.width *
//                                           .01,
//                                     ),
//                                     Expanded(
//                                       flex: 2,
//                                       child: Text(
//                                         (gameListingController
//                                                 .searchList[index].awayTeam)
//                                             .toString(),
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .labelLarge,
//                                         textAlign: TextAlign.start,
//                                         maxLines: 2,
//                                       ),
//                                     ),
//                                     Text(
//                                       (gameListingController
//                                               .searchList[index].awayScore)
//                                           .toString(),
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .headlineLarge,
//                                       textAlign: TextAlign.start,
//                                       maxLines: 2,
//                                     )
//                                   ],
//                                 ),
//                                 5.H(),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Expanded(
//                                       flex: 0,
//                                       child: Text(
//                                         '  Vs',
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .labelSmall,
//                                         textAlign: TextAlign.center,
//                                       ),
//                                     ),
//                                     Expanded(
//                                         flex: 4, child: commonDivider(context)),
//                                   ],
//                                 ),
//                                 5.H(),
//                                 Row(
//                                   children: [
//                                     commonCachedNetworkImage(
//                                         width: Get.height * .044,
//                                         height: Get.height * .044,
//                                         imageUrl: gameListingController
//                                                     .searchList[index]
//                                                     .homeTeam ==
//                                                 'North Carolina State Wolfpack'
//                                             ? 'https://a.espncdn.com/i/teamlogos/ncaa/500/152.png'
//                                             : gameListingController
//                                                         .searchList[index]
//                                                         .homeTeam ==
//                                                     'Louisiana-Lafayette Ragin Cajuns'
//                                                 ? "https://a.espncdn.com/i/teamlogos/ncaa/500/309.png"
//                                                 : gameListingController
//                                                             .searchList[index]
//                                                             .homeTeam ==
//                                                         'Sam Houston State Bearkats'
//                                                     ? "https://a.espncdn.com/i/teamlogos/ncaa/500/2534.png"
//                                                     : competitors
//                                                         .gameHomeLogoLink),
//                                     // 10.W(),
//                                     SizedBox(
//                                       width: MediaQuery.of(context).size.width *
//                                           .01,
//                                     ),
//                                     Expanded(
//                                       flex: 2,
//                                       child: Text(
//                                         (gameListingController
//                                                 .searchList[index].homeTeam)
//                                             .toString(),
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .labelLarge,
//                                         textAlign: TextAlign.start,
//                                         maxLines: 2,
//                                       ),
//                                     ),
//                                     Text(
//                                       gameListingController
//                                           .searchList[index].homeScore
//                                           .toString(),
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .headlineLarge,
//                                       textAlign: TextAlign.start,
//                                       maxLines: 2,
//                                     )
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 1,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               (MediaQuery.of(context).size.height * .005).H(),
//                               Text(
//                                 '$date, $dateTime',
//                                 style: Theme.of(context).textTheme.displaySmall,
//                                 textAlign: TextAlign.center,
//                               ),
//                               competitors.status == 'live'
//                                   ? Container(
//                                       height:
//                                           MediaQuery.of(context).size.height *
//                                               .02,
//                                       width: MediaQuery.of(context).size.width *
//                                           .07,
//                                       decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(105),
//                                           color: redColor),
//                                       child: Center(
//                                         child: 'LIVE'.appCommonText(
//                                             color: whiteColor,
//                                             size: MediaQuery.of(context)
//                                                     .size
//                                                     .height *
//                                                 .012,
//                                             weight: FontWeight.bold),
//                                       ),
//                                     )
//                                   : const SizedBox(),
//                               getWeatherIcon(competitors.weather, context,
//                                   MediaQuery.of(context).size.height * .064)
//                               /* getWeatherIcon(
//                                   competitors.venue?.weather ?? 'Sunny',
//                                   context,
//                                   MediaQuery.of(context).size.height * .064),*/
//                               ,
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 textBaseline: TextBaseline.alphabetic,
//                                 verticalDirection: VerticalDirection.up,
//                                 children: [
//                                   Text(
//                                     competitors.tmpInFahrenheit == 0
//                                         ? "TBD"
//                                         : competitors.tmpInFahrenheit
//                                             .toString()
//                                             .split('.')
//                                             .first,
//                                     style: competitors.tmpInFahrenheit == 0
//                                         ? Theme.of(context)
//                                             .textTheme
//                                             .headlineSmall!
//                                             .copyWith(
//                                                 fontSize: MediaQuery.of(context)
//                                                         .size
//                                                         .height *
//                                                     .014)
//                                         : Theme.of(context)
//                                             .textTheme
//                                             .displayMedium,
//                                   ),
//                                   Text(
//                                     '°F',
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .headlineSmall,
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                         buildExpandedBoxWidget(context,
//                             bottomText:
//                                 competitors.homeSpreadValue.contains('-')
//                                     ? competitors.homeSpreadValue
//                                     : '+${competitors.homeSpreadValue}',
//                             upText: competitors.awaySpreadValue.contains('-')
//                                 ? competitors.awaySpreadValue
//                                 : '+${competitors.awaySpreadValue}'),
//                         buildExpandedBoxWidget(context,
//                             bottomText: competitors.homeMoneyLineValue,
//                             upText: competitors.awayMoneyLineValue),
//                         Expanded(
//                             flex: 1,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Container(
//                                   height:
//                                       MediaQuery.of(context).size.height * .04,
//                                   // width: MediaQuery.of(context).size.width * .09,
//                                   decoration: BoxDecoration(
//                                       color: Theme.of(context).primaryColor,
//                                       borderRadius: BorderRadius.circular(
//                                           MediaQuery.of(context).size.width *
//                                               .008)),
//                                   child: Center(
//                                       child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment: CrossAxisAlignment.end,
//                                     textBaseline: TextBaseline.alphabetic,
//                                     verticalDirection: VerticalDirection.up,
//                                     children: [
//                                       Text('o',
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .bodySmall),
//                                       Text((competitors.awayOUValue).toString(),
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .bodySmall),
//                                     ],
//                                   )),
//                                 ).paddingSymmetric(
//                                   horizontal: mobileView.size.shortestSide < 600
//                                       ? MediaQuery.of(context).size.height *
//                                           .008
//                                       : MediaQuery.of(context).size.height *
//                                           .015,
//                                 ),
//                                 SizedBox(
//                                   height:
//                                       MediaQuery.of(context).size.height * .02,
//                                 ),
//                                 Container(
//                                   height:
//                                       MediaQuery.of(context).size.height * .04,
//                                   // width: MediaQuery.of(context).size.width * .09,
//                                   decoration: BoxDecoration(
//                                       color: Theme.of(context).primaryColor,
//                                       borderRadius: BorderRadius.circular(
//                                           MediaQuery.of(context).size.width *
//                                               .008)),
//                                   child: Center(
//                                       child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment: CrossAxisAlignment.end,
//                                     textBaseline: TextBaseline.alphabetic,
//                                     verticalDirection: VerticalDirection.up,
//                                     children: [
//                                       Text('u',
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .bodySmall),
//                                       Text((competitors.homeOUValue).toString(),
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .bodySmall),
//                                     ],
//                                   )),
//                                 ).paddingSymmetric(
//                                   horizontal: mobileView.size.shortestSide < 600
//                                       ? MediaQuery.of(context).size.height *
//                                           .008
//                                       : MediaQuery.of(context).size.height *
//                                           .015,
//                                 )
//                               ],
//                             )),
//                       ],
//                     ),
//                   ),
//                 );
//     } catch (e) {
//       return const SizedBox();
//     }
//   }
//
//   Container tabTitleWidget(BuildContext context) {
//     return Container(
//         height: MediaQuery.of(context).size.height * .05,
//         decoration:
//             BoxDecoration(color: Theme.of(context).secondaryHeaderColor),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Expanded(
//                 flex: 3,
//                 child: game.appCommonText(
//                     color: whiteColor,
//                     weight: FontWeight.w600,
//                     size: MediaQuery.of(context).size.height * .017),
//               ),
//               Expanded(
//                 flex: 1,
//                 child: time.appCommonText(
//                     color: whiteColor,
//                     weight: FontWeight.w600,
//                     size: MediaQuery.of(context).size.height * .017),
//               ),
//               Expanded(
//                 flex: 1,
//                 child: spread.appCommonText(
//                     color: whiteColor,
//                     weight: FontWeight.w600,
//                     size: MediaQuery.of(context).size.height * .017),
//               ),
//               Expanded(
//                 flex: 1,
//                 child: moneyLine.appCommonText(
//                     color: whiteColor,
//                     weight: FontWeight.w600,
//                     size: MediaQuery.of(context).size.height * .017),
//               ),
//               Expanded(
//                 flex: 1,
//                 child: overUnder.appCommonText(
//                     color: whiteColor,
//                     weight: FontWeight.w600,
//                     size: MediaQuery.of(context).size.height * .017),
//               ),
//             ],
//           ),
//         ));
//   }
// }
