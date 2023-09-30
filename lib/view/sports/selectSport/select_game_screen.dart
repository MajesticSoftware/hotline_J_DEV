import 'dart:developer';

import 'package:animation_list/animation_list.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotlines/utils/animated_search.dart';
import 'package:intl/intl.dart';

import '../../../constant/app_strings.dart';
import '../../../constant/shred_preference.dart';
import '../../../extras/constants.dart';
import '../../../model/game_listing.dart';
import '../../../utils/app_progress.dart';
import '../gameDetails/game_details_screen.dart';
import '../gameListing/game_listing_con.dart';
import 'selecte_game_con.dart';
import '../../../generated/assets.dart';
import '../../../model/game_model.dart';
import '../../../model/leauge_model.dart';
import '../../../theme/helper.dart';
import '../../../theme/theme.dart';
import '../../../utils/utils.dart';
import '../gameListing/game_listing_screen.dart';

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
          // resizeToAvoidBottomInset: false,
          floatingActionButton: buildAnimSearchBar(controller, context)
              .paddingSymmetric(horizontal: Get.width * .05),
          /* InkWell(
                onTap: () {
                  showDataAlert(context);
                },
                child: Container(
                  height: Get.height * .14,
                  width: Get.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      color: Theme.of(context).primaryColor),
                  child: Center(
                    child: gambling.appCommonText(
                        color: Theme.of(context).cardColor,
                        size: 30.sp,
                        weight: FontWeight.w700,
                        align: TextAlign.center),
                  ),
                ),
              ).paddingAll(24.w),*/
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: commonAppBar(context, controller),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      sportsLeagueList.length,
                      (index) {
                        return commonImageWidget(
                          sportsLeagueList[index].image,
                          sportsLeagueList[index].gameImage,
                          sportsLeagueList[index].gameName,
                          isComingSoon: sportsLeagueList[index].isAvailable,
                          context,
                          index,
                          onTap: sportsLeagueList[index].isAvailable == true
                              ? () {
                                  toggle = 0;
                                  controller.date =
                                      sportsLeagueList[index].date;
                                  controller.sportKey =
                                      sportsLeagueList[index].key;
                                  controller.apiKey =
                                      sportsLeagueList[index].apiKey;
                                  controller.sportId =
                                      sportsLeagueList[index].sportId;
                                  controller.sportKey == 'MLB'
                                      ? controller.setIsBack(false)
                                      : controller.setIsBack1(false);
                                  Future.delayed(const Duration(seconds: 0),
                                      () {
                                    gameListingController.getResponse(
                                        true, sportsLeagueList[index].key);
                                  });
                                }
                              : () {},
                        );
                      },
                    )).paddingAll(
                  20.w,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: isDark || selectGameController.isDarkMode
                        ? blackColor
                        : whiteColor,
                  ),
                  height: MediaQuery.of(context).size.height / 1.78.h,
                  width: Get.width,
                  clipBehavior: Clip.antiAlias,
                  child: tableDetailWidget(context, controller.sportKey),
                ).paddingSymmetric(
                    horizontal: MediaQuery.of(context).size.width * .03),
              ],
            ),
          ));
    });
  }

  AnimSearchBar buildAnimSearchBar(
      GameListingController controller, BuildContext context) {
    return AnimSearchBar(
      rtl: true,
      autoFocus: true,
      width: Get.width,
      color: yellowColor,
      style: defaultTextStyle(
          size: MediaQuery.sizeOf(context).height * .02,
          color: isDark || selectGameController.isDarkMode
              ? greyColor
              : whiteColor),
      searchIconColor: appColor,
      textFieldColor:
          isDark || selectGameController.isDarkMode ? whiteColor : boxColor,
      helpText: 'Search team here...',
      helpTextColor:
          isDark || selectGameController.isDarkMode ? greyColor : whiteColor,
      textFieldIconColor:
          isDark || selectGameController.isDarkMode ? greyColor : whiteColor,
      textController: controller.searchCon,
      onSuffixTap: () {
        controller.searchCon.clear();
        controller.update();
      },
      onSubmitted: (String text) {
        controller.searchData(text);
        controller.update();
      },
    );
  }

  Widget commonImageWidget(String image, String gameImage, String gameName,
      BuildContext context, int index,
      {void Function()? onTap, bool isComingSoon = false}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: Get.height * .05,
          margin: EdgeInsets.only(right: index == 2 ? 0 : 20.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              image: gameListingController.sportKey == gameName
                  ? DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.cover,
                    )
                  : DecorationImage(
                      image: AssetImage(image),
                      colorFilter: ColorFilter.mode(
                          Theme.of(context)
                              .scaffoldBackgroundColor
                              .withOpacity(0.6),
                          BlendMode.dstATop),
                      fit: BoxFit.cover,
                    )),
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: SvgPicture.asset(
                    gameImage,
                    height: MediaQuery.of(context).size.height * .14,
                    width: MediaQuery.of(context).size.height * .14,
                    fit: BoxFit.contain,
                  )),
              (MediaQuery.of(context).size.height * .01).W(),
              Expanded(
                flex: 3,
                child: gameName.appCommonText(
                    color: Colors.white,
                    align: TextAlign.start,
                    size: MediaQuery.of(context).size.height * .018,
                    weight: FontWeight.w700),
              )
            ],
          ).paddingSymmetric(horizontal: 20.w),
        ),
      ),
    );
  }

  showDataAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    10.0,
                  ),
                ),
              ),
              iconPadding: EdgeInsets.zero,
              icon: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    splashRadius: 0.1,
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.clear,
                      color: Theme.of(context).dividerColor,
                    )),
              ),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              contentPadding: const EdgeInsets.only(
                top: 10.0,
              ),
              title: Text(
                gambling,
                textAlign: TextAlign.center,
                style: GoogleFonts.nunitoSans(
                    color: Theme.of(context).highlightColor,
                    fontWeight: FontWeight.w700,
                    fontSize: Get.height * .024),
              ),
              content: SizedBox(
                height: Get.height * .6,
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                          gamblingList.length,
                          (index) => Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width * .02,
                                    vertical:
                                        MediaQuery.of(context).size.height *
                                            .002),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 0,
                                      child: Image.asset(
                                        Assets.imagesFire,
                                        alignment: Alignment.centerLeft,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .028,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .028,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .02,
                                    ),
                                    Expanded(
                                      child: RichText(
                                        text: index == 11
                                            ? TextSpan(
                                                text: 'Juice (also known as ',
                                                style: GoogleFonts.nunitoSans(
                                                  color: Theme.of(context)
                                                      .highlightColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: Get.height * .016,
                                                ),
                                                children: [
                                                    linkTextWidget(context,
                                                        text: 'vigorish',
                                                        link:
                                                            'https://www.forbes.com/betting/sports-betting/what-is-the-vig-in-betting/'),
                                                    TextSpan(
                                                      text: ' or “vig”)',
                                                      style: GoogleFonts
                                                          .nunitoSans(
                                                        color: Theme.of(context)
                                                            .highlightColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            Get.height * .016,
                                                      ),
                                                    ),
                                                    textSpanCommonWidget(
                                                        context,
                                                        title: ':'),
                                                    textSpanUnBoldText(
                                                        index, context,
                                                        text:
                                                            ' The amount charged by sportsbooks for taking a bet. If a bet is offered at -110, bettors would need to wager \$110 to win \$100. The \$10 on the \$110 bet is the juice. This can also be called the rake.'),
                                                  ])
                                            : TextSpan(
                                                text: '${gamblingList[index]}'
                                                    .toString()
                                                    .split(':')
                                                    .first
                                                    .toString(),
                                                style: GoogleFonts.nunitoSans(
                                                  color: Theme.of(context)
                                                      .highlightColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: Get.height * .016,
                                                ),
                                                children: index == 6
                                                    ? [
                                                        textSpanCommonWidget(
                                                            context,
                                                            title: ':'),
                                                        textSpanUnBoldText(
                                                            index, context,
                                                            text:
                                                                'The expected straight-up winner of any game or event. Favorites are priced with a '),
                                                        linkTextWidget(context,
                                                            text:
                                                                'negative number',
                                                            link:
                                                                'https://www.forbes.com/betting/guide/plus-minus-odds/'),
                                                        textSpanUnBoldText(
                                                            index, context,
                                                            text:
                                                                ' and are considered to be “giving points” on the spread.'),
                                                      ]
                                                    : index == 7
                                                        ? [
                                                            textSpanCommonWidget(
                                                                context,
                                                                title: ':'),
                                                            textSpanUnBoldText(
                                                                index, context,
                                                                text:
                                                                    ' A wager on something that will take place longer-term than a wager on an individual game or event. Examples include '),
                                                            linkTextWidget(
                                                                context,
                                                                text:
                                                                    'preseason bets',
                                                                link:
                                                                    'https://www.forbes.com/betting/nfl/futures-odds/'),
                                                            textSpanUnBoldText(
                                                                index, context,
                                                                text:
                                                                    ' on whether a team will win a championship or which player will win awards, such as MVP.'),
                                                          ]
                                                        : index == 8
                                                            ? [
                                                                textSpanCommonWidget(
                                                                    context,
                                                                    title: ':'),
                                                                textSpanUnBoldText(
                                                                    index,
                                                                    context,
                                                                    text:
                                                                        ' Making a bet on the opposite side of an original wager to minimize risk and guarantee at least some return. An example would be making a large futures wager on a football team to win the '),
                                                                linkTextWidget(
                                                                    context,
                                                                    text:
                                                                        'Super Bowl',
                                                                    link:
                                                                        'https://www.forbes.com/betting/nfl/how-to-bet-on-the-super-bowl/'),
                                                                textSpanUnBoldText(
                                                                    index,
                                                                    context,
                                                                    text:
                                                                        ', then betting against that team in the Super Bowl itself.'),
                                                              ]
                                                            : index == 10
                                                                ? [
                                                                    textSpanCommonWidget(
                                                                        context,
                                                                        title:
                                                                            ':'),
                                                                    textSpanUnBoldText(
                                                                        index,
                                                                        context,
                                                                        text:
                                                                            ' A bet made on an event after it has started. This is also called a '),
                                                                    linkTextWidget(
                                                                        context,
                                                                        text:
                                                                            'live bet.',
                                                                        link:
                                                                            'https://www.forbes.com/betting/guide/in-game/'),
                                                                  ]
                                                                : index == 15
                                                                    ? [
                                                                        textSpanCommonWidget(
                                                                            context,
                                                                            title:
                                                                                ':'),
                                                                        textSpanUnBoldText(
                                                                            index,
                                                                            context,
                                                                            text:
                                                                                ' A '),
                                                                        linkTextWidget(
                                                                            context,
                                                                            text:
                                                                                'straight bet',
                                                                            link:
                                                                                'https://www.forbes.com/betting/guide/moneyline/'),
                                                                        textSpanUnBoldText(
                                                                            index,
                                                                            context,
                                                                            text:
                                                                                ' made simply on a contest’s outcome with no point spread involved. Favorites have negative odds, while underdogs are listed with positive odds.'),
                                                                      ]
                                                                    : index ==
                                                                            16
                                                                        ? [
                                                                            textSpanCommonWidget(context,
                                                                                title: ':'),
                                                                            textSpanUnBoldText(index,
                                                                                context,
                                                                                text: ' The measure of '),
                                                                            linkTextWidget(context,
                                                                                text: 'how much a bettor can win',
                                                                                link: 'https://www.forbes.com/betting/sports-betting/how-sports-betting-odds-work/#:~:text=First%2C%20sports%20betting%20odds%20outline%20a%20particular%20game,small%20cut%20on%20both%20sides%20of%20a%20line.'),
                                                                            textSpanUnBoldText(index,
                                                                                context,
                                                                                text: ' on a specific wager, per \$100 in American odds. For example, a bettor will win \$124 with a \$100 bet at +124 odds but must wager \$124 to win \$100 if the odds are -124.'),
                                                                          ]
                                                                        : index ==
                                                                                17
                                                                            ? [
                                                                                textSpanCommonWidget(context, title: ':'),
                                                                                textSpanUnBoldText(index, context, text: '  This can be a number posted on how many scoring units will be scored in a game or match, as well as how many games a team will win during a season. If a football game’s '),
                                                                                linkTextWidget(context, text: 'over/under', link: 'https://www.forbes.com/betting/sports-betting/what-is-over-under-betting/'),
                                                                                textSpanUnBoldText(index, context, text: ' is 43.5 and the two teams combine to score 44 points, bets on the over are paid out. If a baseball team’s preseason win total over/under is 82.5, and it wins 81 games, futures bets on the under are paid out.'),
                                                                              ]
                                                                            : index == 18
                                                                                ? [
                                                                                    textSpanCommonWidget(context, title: ':'),
                                                                                    textSpanUnBoldText(index, context, text: ' A single wager that involves the bettor making multiple bets and '),
                                                                                    linkTextWidget(context, text: 'tying them into one.', link: 'https://www.forbes.com/betting/sports-betting/what-is-a-parlay-bet/'),
                                                                                    textSpanUnBoldText(index, context, text: ' The payouts of parlays are typically larger than a wager on a single game because each individual bet must win in order for a parlay to pay out.'),
                                                                                  ]
                                                                                : index == 21
                                                                                    ? [
                                                                                        textSpanCommonWidget(context, title: ':'),
                                                                                        textSpanUnBoldText(index, context, text: ' A bet made on something that may occur during a game that isn’t necessarily tied to the game’s outcome. These bets are often closely tied to the game itself, like a wager on whether or not an individual player will '),
                                                                                        linkTextWidget(context, text: 'score a touchdown.', link: 'https://www.forbes.com/betting/sports-betting/what-is-a-prop-bet/'),
                                                                                        textSpanUnBoldText(index, context, text: ' There are also props that are only loosely connected to the game, like wagers on a football game’s opening '),
                                                                                        linkTextWidget(context, text: 'coin toss.', link: 'https://www.forbes.com/betting/nfl/coin-toss/'),
                                                                                      ]
                                                                                    : index == 24
                                                                                        ? [
                                                                                            textSpanCommonWidget(context, title: ':'),
                                                                                            textSpanUnBoldText(index, context, text: ' A '),
                                                                                            linkTextWidget(context, text: 'specific parlay type', link: 'https://www.forbes.com/betting/sports-betting/what-is-same-game-parlay/'),
                                                                                            textSpanUnBoldText(index, context, text: ' that combines multiple wagers from the same sporting event into one bet. Like traditional parlays, SGPs are usually difficult to win.'),
                                                                                          ]
                                                                                        : [
                                                                                            textSpanCommonWidget(context, title: ':'),
                                                                                            textSpanUnBoldText(index, context, text: gamblingList[index].toString().split(':').last.toString()),
                                                                                          ],
                                              ),
                                      ),
                                    )
                                  ],
                                ),
                              ))),
                ),
              ));
        });
  }

  Widget tableDetailWidget(BuildContext context, String sportKey) {
    return GetBuilder<GameListingController>(
        initState: (state) async {},
        builder: (controller) {
          // log('length--${controller.sportEventsList.length}');
          return Stack(
            children: [
              tabTitleWidget(context),
              controller.isLoading.value
                  ? const SizedBox()
                  : controller.sportEventsList.isEmpty &&
                          !controller.isLoading.value
                      ? emptyDataWidget(context)
                      : RefreshIndicator(
                          onRefresh: () async {
                            gameListingController.getResponse(true, sportKey);
                          },
                          color: Theme.of(context).disabledColor,
                          child: Column(
                            children: [
                              80.w.H(),
                              controller.searchCon.text.isEmpty
                                  ? Expanded(
                                      child: AnimationList(
                                          duration: 1500,
                                          reBounceDepth: 30,
                                          primary: false,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          // shrinkWrap: true,
                                          // clipBehavior: Clip.hardEdge,
                                          children: List.generate(
                                              controller.sportEventsList.length,
                                              (index) => GestureDetector(
                                                  onTap: () {
                                                    log('ON TAP---$index');
                                                    toggle = 0;
                                                    controller.searchCon
                                                        .clear();
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                    Get.to(
                                                        SportDetailsScreen(
                                                          gameDetails: controller
                                                                  .sportEventsList[
                                                              index],
                                                          sportKey: controller
                                                              .sportKey,
                                                          sportId: controller
                                                              .sportId,
                                                          date: controller.date,
                                                        ),
                                                        transition: Transition
                                                            .cupertino,
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    500));
                                                  },
                                                  child: teamWidget(
                                                      controller
                                                              .sportEventsList[
                                                          index],
                                                      context,
                                                      index:
                                                          index)))).paddingOnly(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .01),
                                    )
                                  : Expanded(
                                      child: AnimationList(
                                          duration: 1500,
                                          reBounceDepth: 10.0,
                                          children: List.generate(
                                              controller.searchList.length,
                                              (index) => InkWell(
                                                  onTap: () {
                                                    log('ON TAP');
                                                    toggle = 0;
                                                    controller.searchCon
                                                        .clear();
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                    Get.to(SportDetailsScreen(
                                                      gameDetails: controller
                                                          .searchList[index],
                                                      sportKey:
                                                          controller.sportKey,
                                                      sportId:
                                                          controller.sportId,
                                                      date: controller.date,
                                                    ));
                                                  },
                                                  child: teamSearchWidget(
                                                      controller
                                                          .searchList[index],
                                                      context,
                                                      index:
                                                          index)))).paddingOnly(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .01),
                                    ),
                            ],
                          ),
                        ),
              Obx(() => controller.isLoading.value
                  ? const AppProgress()
                  : const SizedBox())
            ],
          );
        });
  }

  Widget emptyDataWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: Get.width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(
                Assets.imagesNodataImage,
                width: MediaQuery.of(context).size.width * .349,
                height: MediaQuery.of(context).size.height * .329,
                fit: BoxFit.fill,
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height * .07,
                width: MediaQuery.of(context).size.width * .34,
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
                            size: mobileView.size.shortestSide < 600
                                ? MediaQuery.of(context).size.height * .012
                                : MediaQuery.of(context).size.height * .014,
                            weight: FontWeight.w500),
                      ),
                    )),
              )
            ],
          ),
        ),
      ],
    );
  }

  teamWidget(SportEvents competitors, BuildContext context, {int index = 0}) {
    String date = DateFormat.MMMd()
        .format(DateTime.parse(competitors.scheduled ?? '').toLocal());
    String dateTime = DateFormat.jm()
        .format(DateTime.parse(competitors.scheduled ?? '').toLocal());
    try {
      return competitors.status == 'closed' &&
              gameListingController.sportKey == "NFL"
          ? const SizedBox()
          : competitors.status == 'postponed'
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
                                vertical:
                                    MediaQuery.of(context).size.height * .006,
                                horizontal:
                                    MediaQuery.of(context).size.width * .02),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Stack(
                                      clipBehavior: Clip.none,
                                      alignment: Alignment.topRight,
                                      children: [
                                        commonCachedNetworkImage(
                                          width: Get.height * .044,
                                          height: Get.height * .044,
                                          imageUrl: gameListingController
                                                      .sportEventsList[index]
                                                      .awayTeam ==
                                                  'North Carolina State Wolfpack'
                                              ? 'https://a.espncdn.com/i/teamlogos/ncaa/500/152.png'
                                              : gameListingController
                                                          .sportEventsList[
                                                              index]
                                                          .awayTeam ==
                                                      'Louisiana-Lafayette Ragin Cajuns'
                                                  ? "https://a.espncdn.com/i/teamlogos/ncaa/500/309.png"
                                                  : gameListingController
                                                              .sportEventsList[
                                                                  index]
                                                              .awayTeam ==
                                                          'Sam Houston State Bearkats'
                                                      ? "https://a.espncdn.com/i/teamlogos/ncaa/500/2534.png"
                                                      : competitors
                                                          .gameLogoAwayLink,
                                        ),
                                        Positioned(
                                          top: -8.w,
                                          right: -2.w,
                                          child: Text(
                                            gameListingController
                                                        .sportEventsList[index]
                                                        .awayRank ==
                                                    '0'
                                                ? ''
                                                : gameListingController
                                                    .sportEventsList[index]
                                                    .awayRank,
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .018,
                                              foreground: Paint()
                                                ..style = PaintingStyle.stroke
                                                ..strokeWidth = 6
                                                ..color = whiteColor,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: -6,
                                          right: -3,
                                          child: (gameListingController
                                                          .sportEventsList[
                                                              index]
                                                          .awayRank ==
                                                      '0'
                                                  ? ''
                                                  : gameListingController
                                                      .sportEventsList[index]
                                                      .awayRank)
                                              .appCommonText(
                                                  letterSpacing: 1,
                                                  color: (num.tryParse(gameListingController
                                                                  .sportEventsList[
                                                                      index]
                                                                  .awayRank) ??
                                                              0) <=
                                                          12
                                                      ? Colors.green
                                                      : (num.tryParse(gameListingController
                                                                      .sportEventsList[
                                                                          index]
                                                                      .awayRank) ??
                                                                  0) >=
                                                              15
                                                          ? redColor
                                                          : Colors.amber,
                                                  size: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      .019,
                                                  weight: FontWeight.bold),
                                        )
                                      ],
                                    ),

                                    // 10.W(),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .01,
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        (gameListingController
                                                .sportEventsList[index]
                                                .awayTeam)
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                        textAlign: TextAlign.start,
                                        maxLines: 2,
                                      ),
                                    ),
                                    Text(
                                      (gameListingController
                                              .sportEventsList[index].awayScore)
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge,
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall,
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
                                    Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        commonCachedNetworkImage(
                                            width: Get.height * .044,
                                            height: Get.height * .044,
                                            imageUrl: gameListingController
                                                        .sportEventsList[index]
                                                        .homeTeam ==
                                                    'North Carolina State Wolfpack'
                                                ? 'https://a.espncdn.com/i/teamlogos/ncaa/500/152.png'
                                                : gameListingController
                                                            .sportEventsList[
                                                                index]
                                                            .homeTeam ==
                                                        'Louisiana-Lafayette Ragin Cajuns'
                                                    ? "https://a.espncdn.com/i/teamlogos/ncaa/500/309.png"
                                                    : gameListingController
                                                                .sportEventsList[
                                                                    index]
                                                                .homeTeam ==
                                                            'Sam Houston State Bearkats'
                                                        ? "https://a.espncdn.com/i/teamlogos/ncaa/500/2534.png"
                                                        : competitors
                                                            .gameHomeLogoLink),
                                        Positioned(
                                          top: -8,
                                          right: -2,
                                          child: Text(
                                            gameListingController
                                                        .sportEventsList[index]
                                                        .homeRank ==
                                                    '0'
                                                ? ''
                                                : gameListingController
                                                    .sportEventsList[index]
                                                    .homeRank,
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .018,
                                              foreground: Paint()
                                                ..style = PaintingStyle.stroke
                                                ..strokeWidth = 6
                                                ..color = whiteColor,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: -8,
                                          right: -3,
                                          child: (gameListingController
                                                          .sportEventsList[
                                                              index]
                                                          .homeRank ==
                                                      '0'
                                                  ? ''
                                                  : gameListingController
                                                      .sportEventsList[index]
                                                      .homeRank)
                                              .appCommonText(
                                                  letterSpacing: 1,
                                                  color: (num.tryParse(gameListingController
                                                                  .sportEventsList[
                                                                      index]
                                                                  .homeRank) ??
                                                              0) <=
                                                          12
                                                      ? Colors.green
                                                      : (num.tryParse(gameListingController
                                                                      .sportEventsList[
                                                                          index]
                                                                      .homeRank) ??
                                                                  0) >=
                                                              15
                                                          ? redColor
                                                          : Colors.amber,
                                                  size: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      .019,
                                                  weight: FontWeight.bold),
                                        )
                                      ],
                                    ),

                                    // 10.W(),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .01,
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        (gameListingController
                                                .sportEventsList[index]
                                                .homeTeam)
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                        textAlign: TextAlign.start,
                                        maxLines: 2,
                                      ),
                                    ),
                                    Text(
                                      gameListingController
                                          .sportEventsList[index].homeScore
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge,
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
                              (MediaQuery.of(context).size.height * .005).H(),
                              Text(
                                '$date, $dateTime',
                                style: Theme.of(context).textTheme.displaySmall,
                                textAlign: TextAlign.center,
                              ),
                              competitors.status == 'live'
                                  ? Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .02,
                                      width: MediaQuery.of(context).size.width *
                                          .07,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(105),
                                          color: redColor),
                                      child: Center(
                                        child: 'LIVE'.appCommonText(
                                            color: whiteColor,
                                            size: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .012,
                                            weight: FontWeight.bold),
                                      ),
                                    )
                                  : const SizedBox(),
                              getWeatherIcon(
                                  competitors.venue?.weather ?? 805,
                                  context,
                                  MediaQuery.of(context).size.height * .064)
                              /* getWeatherIcon(
                                  competitors.venue?.weather ?? 'Sunny',
                                  context,
                                  MediaQuery.of(context).size.height * .064),*/
                              ,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                textBaseline: TextBaseline.alphabetic,
                                verticalDirection: VerticalDirection.up,
                                children: [
                                  Text(
                                    '${competitors.venue?.tmpInFahrenheit == 0 ? "TBD" : competitors.venue?.tmpInFahrenheit.toString().split('.').first ?? 0}',
                                    style: competitors.venue?.tmpInFahrenheit ==
                                            0
                                        ? Theme.of(context)
                                            .textTheme
                                            .headlineSmall!
                                            .copyWith(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .014)
                                        : Theme.of(context)
                                            .textTheme
                                            .displayMedium,
                                  ),
                                  Text(
                                    '°F',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        buildExpandedBoxWidget(context,
                            bottomText:
                                competitors.homeSpreadValue.contains('-')
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
                                  height:
                                      MediaQuery.of(context).size.height * .04,
                                  // width: MediaQuery.of(context).size.width * .09,
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
                                ).paddingSymmetric(
                                  horizontal: mobileView.size.shortestSide < 600
                                      ? MediaQuery.of(context).size.height *
                                          .008
                                      : MediaQuery.of(context).size.height *
                                          .015,
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .02,
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * .04,
                                  // width: MediaQuery.of(context).size.width * .09,
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
                                ).paddingSymmetric(
                                  horizontal: mobileView.size.shortestSide < 600
                                      ? MediaQuery.of(context).size.height *
                                          .008
                                      : MediaQuery.of(context).size.height *
                                          .015,
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

  teamSearchWidget(SportEvents competitors, BuildContext context, {index = 0}) {
    String date = DateFormat.MMMd()
        .format(DateTime.parse(competitors.scheduled ?? '').toLocal());
    String dateTime = DateFormat.jm()
        .format(DateTime.parse(competitors.scheduled ?? '').toLocal());
    try {
      return competitors.status == 'closed' &&
              gameListingController.sportKey == "NFL"
          ? const SizedBox()
          : competitors.status == 'postponed'
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
                                vertical:
                                    MediaQuery.of(context).size.height * .006,
                                horizontal:
                                    MediaQuery.of(context).size.width * .02),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Stack(
                                      clipBehavior: Clip.none,
                                      alignment: Alignment.topRight,
                                      children: [
                                        commonCachedNetworkImage(
                                          width: Get.height * .044,
                                          height: Get.height * .044,
                                          imageUrl: gameListingController
                                                      .searchList[index]
                                                      .awayTeam ==
                                                  'North Carolina State Wolfpack'
                                              ? 'https://a.espncdn.com/i/teamlogos/ncaa/500/152.png'
                                              : gameListingController
                                                          .searchList[index]
                                                          .awayTeam ==
                                                      'Louisiana-Lafayette Ragin Cajuns'
                                                  ? "https://a.espncdn.com/i/teamlogos/ncaa/500/309.png"
                                                  : gameListingController
                                                              .searchList[index]
                                                              .awayTeam ==
                                                          'Sam Houston State Bearkats'
                                                      ? "https://a.espncdn.com/i/teamlogos/ncaa/500/2534.png"
                                                      : competitors
                                                          .gameLogoAwayLink,
                                        ),
                                        Positioned(
                                          top: -8.w,
                                          right: -2.w,
                                          child: Text(
                                            gameListingController
                                                        .searchList[index]
                                                        .awayRank ==
                                                    '0'
                                                ? ''
                                                : gameListingController
                                                    .searchList[index].awayRank,
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .018,
                                              foreground: Paint()
                                                ..style = PaintingStyle.stroke
                                                ..strokeWidth = 6
                                                ..color = whiteColor,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: -6,
                                          right: -3,
                                          child: (gameListingController
                                                          .searchList[index]
                                                          .awayRank ==
                                                      '0'
                                                  ? ''
                                                  : gameListingController
                                                      .searchList[index]
                                                      .awayRank)
                                              .appCommonText(
                                                  letterSpacing: 1,
                                                  color: (num.tryParse(gameListingController
                                                                  .searchList[
                                                                      index]
                                                                  .awayRank) ??
                                                              0) <=
                                                          12
                                                      ? Colors.green
                                                      : (num.tryParse(gameListingController
                                                                      .searchList[
                                                                          index]
                                                                      .awayRank) ??
                                                                  0) >=
                                                              15
                                                          ? redColor
                                                          : Colors.amber,
                                                  size: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      .019,
                                                  weight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    // 10.W(),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .01,
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        (gameListingController
                                                .searchList[index].awayTeam)
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                        textAlign: TextAlign.start,
                                        maxLines: 2,
                                      ),
                                    ),
                                    Text(
                                      (gameListingController
                                              .searchList[index].awayScore)
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge,
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall,
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
                                    Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        commonCachedNetworkImage(
                                            width: Get.height * .044,
                                            height: Get.height * .044,
                                            imageUrl: gameListingController
                                                        .searchList[index]
                                                        .homeTeam ==
                                                    'North Carolina State Wolfpack'
                                                ? 'https://a.espncdn.com/i/teamlogos/ncaa/500/152.png'
                                                : gameListingController
                                                            .searchList[index]
                                                            .homeTeam ==
                                                        'Louisiana-Lafayette Ragin Cajuns'
                                                    ? "https://a.espncdn.com/i/teamlogos/ncaa/500/309.png"
                                                    : gameListingController
                                                                .searchList[
                                                                    index]
                                                                .homeTeam ==
                                                            'Sam Houston State Bearkats'
                                                        ? "https://a.espncdn.com/i/teamlogos/ncaa/500/2534.png"
                                                        : competitors
                                                            .gameHomeLogoLink),
                                        Positioned(
                                          top: -8,
                                          right: -2,
                                          child: Text(
                                            gameListingController
                                                        .searchList[index]
                                                        .homeRank ==
                                                    '0'
                                                ? ''
                                                : gameListingController
                                                    .searchList[index].homeRank,
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .018,
                                              foreground: Paint()
                                                ..style = PaintingStyle.stroke
                                                ..strokeWidth = 6
                                                ..color = whiteColor,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: -8,
                                          right: -3,
                                          child: (gameListingController
                                                          .searchList[index]
                                                          .homeRank ==
                                                      '0'
                                                  ? ''
                                                  : gameListingController
                                                      .searchList[index]
                                                      .homeRank)
                                              .appCommonText(
                                                  letterSpacing: 1,
                                                  color: (num.tryParse(gameListingController
                                                                  .searchList[
                                                                      index]
                                                                  .homeRank) ??
                                                              0) <=
                                                          12
                                                      ? Colors.green
                                                      : (num.tryParse(gameListingController
                                                                      .searchList[
                                                                          index]
                                                                      .homeRank) ??
                                                                  0) >=
                                                              15
                                                          ? redColor
                                                          : Colors.amber,
                                                  size: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      .019,
                                                  weight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    // 10.W(),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .01,
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        (gameListingController
                                                .searchList[index].homeTeam)
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                        textAlign: TextAlign.start,
                                        maxLines: 2,
                                      ),
                                    ),
                                    Text(
                                      gameListingController
                                          .searchList[index].homeScore
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge,
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
                              (MediaQuery.of(context).size.height * .005).H(),
                              Text(
                                '$date, $dateTime',
                                style: Theme.of(context).textTheme.displaySmall,
                                textAlign: TextAlign.center,
                              ),
                              competitors.status == 'live'
                                  ? Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .02,
                                      width: MediaQuery.of(context).size.width *
                                          .07,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(105),
                                          color: redColor),
                                      child: Center(
                                        child: 'LIVE'.appCommonText(
                                            color: whiteColor,
                                            size: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .012,
                                            weight: FontWeight.bold),
                                      ),
                                    )
                                  : const SizedBox(),
                              getWeatherIcon(
                                  competitors.venue?.weather ?? 805,
                                  context,
                                  MediaQuery.of(context).size.height * .064)
                              /* getWeatherIcon(
                                  competitors.venue?.weather ?? 'Sunny',
                                  context,
                                  MediaQuery.of(context).size.height * .064),*/
                              ,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                textBaseline: TextBaseline.alphabetic,
                                verticalDirection: VerticalDirection.up,
                                children: [
                                  Text(
                                    '${competitors.venue?.tmpInFahrenheit == 0 ? "TBD" : competitors.venue?.tmpInFahrenheit.toString().split('.').first ?? 0}',
                                    style: competitors.venue?.tmpInFahrenheit ==
                                            0
                                        ? Theme.of(context)
                                            .textTheme
                                            .headlineSmall!
                                            .copyWith(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .014)
                                        : Theme.of(context)
                                            .textTheme
                                            .displayMedium,
                                  ),
                                  Text(
                                    '°F',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        buildExpandedBoxWidget(context,
                            bottomText:
                                competitors.homeSpreadValue.contains('-')
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
                                  height:
                                      MediaQuery.of(context).size.height * .04,
                                  // width: MediaQuery.of(context).size.width * .09,
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
                                ).paddingSymmetric(
                                  horizontal: mobileView.size.shortestSide < 600
                                      ? MediaQuery.of(context).size.height *
                                          .008
                                      : MediaQuery.of(context).size.height *
                                          .015,
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .02,
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * .04,
                                  // width: MediaQuery.of(context).size.width * .09,
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
                                ).paddingSymmetric(
                                  horizontal: mobileView.size.shortestSide < 600
                                      ? MediaQuery.of(context).size.height *
                                          .008
                                      : MediaQuery.of(context).size.height *
                                          .015,
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

  PreferredSize commonAppBar(
      BuildContext context, GameListingController controller) {
    return PreferredSize(
        preferredSize: Size.fromHeight(125.w),
        child: AnimatedContainer(
          alignment: Alignment.bottomCenter,
          color: Theme.of(context).secondaryHeaderColor,
          duration: const Duration(milliseconds: 500),
          child: Padding(
            padding: EdgeInsets.only(bottom: 27.w, left: 24.w, right: 24.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                transperWidget(context),
                Expanded(
                  child: SvgPicture.asset(Assets.imagesLogo,
                      height: 34.w, fit: BoxFit.contain),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                          color: isDark || controller.isDarkMode
                              ? blackColor
                              : Colors.transparent,
                          width: 2),
                      color: isDark || controller.isDarkMode
                          ? blackColor
                          : dividerColor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          PreferenceManager.setIsDarkMod(false);
                          Get.changeThemeMode(ThemeMode.light);
                          controller.isDarkMode = false;
                          isDark = false;
                          controller.update();
                        },
                        child: Padding(
                          padding: EdgeInsets.all(2.sp),
                          child: Container(
                            width: 40.w,
                            height: 36.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(8.r)),
                                color: isDark || controller.isDarkMode
                                    ? blackColor
                                    : whiteColor),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  Assets.imagesSunLight,
                                  // ignore: deprecated_member_use
                                  color: isDark || controller.isDarkMode
                                      ? darkSunColor
                                      : blackColor,
                                  width: 24.w,
                                  height: 24.w,
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
                          controller.isDarkMode = true;
                          isDark = true;
                          controller.update();
                        },
                        child: Container(
                          width: 40.w,
                          height: 36.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.horizontal(
                                  right: Radius.circular(8.r)),
                              color: isDark || controller.isDarkMode
                                  ? darkBackGroundColor
                                  : dividerColor),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                Assets.imagesMoon,
                                // ignore: deprecated_member_use
                                color: isDark || controller.isDarkMode
                                    ? whiteColor
                                    : greyDarkColor,
                                width: 24.w,
                                height: 24.w,
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
        ));
  }

  transperWidget(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .033,
      decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(MediaQuery.of(context).size.width * .005),
          border: Border.all(color: Colors.transparent, width: 2),
          color: Colors.transparent),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * .002),
              child: Container(
                width: MediaQuery.of(context).size.width * .039,
                height: MediaQuery.of(context).size.height * .04,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(
                            MediaQuery.of(context).size.width * .005)),
                    color: Colors.transparent),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      Assets.imagesSunLight,
                      // ignore: deprecated_member_use
                      color: Colors.transparent,
                      width: MediaQuery.of(context).size.width * .02,
                      height: MediaQuery.of(context).size.height * .02,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: MediaQuery.of(context).size.width * .039,
              height: MediaQuery.of(context).size.height * .04,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(
                          MediaQuery.of(context).size.width * .005)),
                  color: Colors.transparent),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    Assets.imagesMoon,
                    // ignore: deprecated_member_use
                    color: Colors.transparent,
                    width: MediaQuery.of(context).size.width * .02,
                    height: MediaQuery.of(context).size.height * .02,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container tabTitleWidget(BuildContext context) {
    return Container(
        // height: MediaQuery.of(context).size.height * .05,
        decoration:
            BoxDecoration(color: Theme.of(context).secondaryHeaderColor),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
