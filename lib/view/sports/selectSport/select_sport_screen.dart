import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constant/app_strings.dart';
import '../../../constant/shred_preference.dart';
import '../../../extras/constants.dart';
import 'selecte_game_con.dart';
import '../../../generated/assets.dart';
import '../../../model/DET_KC_model.dart';
import '../../../model/leauge_model.dart';
import '../../../theme/helper.dart';
import '../../../theme/theme.dart';
import '../../../utils/utils.dart';
import '../gameListing/game_listing_screen.dart';

// ignore: must_be_immutable
class SelectSportScreen extends StatelessWidget {
  SelectSportScreen({Key? key}) : super(key: key);
  SelectGameController selectGameController = Get.find();
  bool isDark = false;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectGameController>(builder: (controller) {
      isDark = PreferenceManager.getIsDarkMode() ?? false;
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: commonAppBar(context, controller),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .01,
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.height * .0),
                child: Wrap(
                    runSpacing: 0,
                    alignment: WrapAlignment.start,
                    spacing: Get.height * .02,
                    children: List.generate(
                      sportsLeagueList.length,
                      (index) => commonImageWidget(
                        sportsLeagueList[index].image,
                        isComingSoon: sportsLeagueList[index].isAvailable,
                        context,
                        onTap: sportsLeagueList[index].isAvailable == true
                            ? () {
                                Get.to(GameListingScreen(
                                  sportKey: sportsLeagueList[index].key,
                                  date: sportsLeagueList[index].date,
                                  keys: sportsLeagueList[index].apiKey,
                                  sportId: sportsLeagueList[index].sportId,
                                ));
                              }
                            : () {},
                      ),
                    )),
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                showDataAlert(context);
              },
              child: Container(
                height: MediaQuery.of(context).size.height * .045,
                width: MediaQuery.of(context).size.width * .26,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.height * .005),
                    color: Theme.of(context).primaryColor),
                child: Center(
                  child: gambling.appCommonText(
                      color: Theme.of(context).cardColor,
                      size: Get.height * .016,
                      weight: FontWeight.w400,
                      align: TextAlign.center),
                ),
              ),
            ),
            SizedBox(
              height: Get.height * .015,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: wantToDownloadTheAppOnYourDevice,
                        style: TextStyle(
                            fontSize: Get.height * .022,
                            color: darkGreyColor,
                            fontWeight: FontWeight.w400),
                        children: [
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => launchInBrowser(Uri.parse(
                                    'https://www.hotlinesmd.com/contact')),
                              text: modileView.size.shortestSide < 600
                                  ? '\n$contactUs'
                                  : contactUs,
                              style: TextStyle(
                                  fontSize: Get.height * .022,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w700))
                        ]),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Get.height * .015,
            ),
            (modileView.size.shortestSide < 600 ? mobileMsg : msg)
                .appCommonText(
                    color: Theme.of(context).dividerColor,
                    size: Get.height * .016,
                    weight: FontWeight.w300,
                    fontStyle: FontStyle.italic,
                    align: TextAlign.center),
            SizedBox(
              height: Get.height * .02,
            )
          ],
        ),
      );
    });
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

  PreferredSize commonAppBar(
      BuildContext context, SelectGameController controller) {
    return PreferredSize(
        preferredSize: const Size.fromHeight(147.0),
        child: Container(
          height: MediaQuery.of(context).size.height * .12,
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * .04,
                  width: MediaQuery.of(context).size.width * .086,
                  child: SvgPicture.asset(Assets.imagesThemeDark,
                      // ignore: deprecated_member_use
                      color: Colors.transparent),
                ),
                SvgPicture.asset(Assets.imagesLogo,
                    height: MediaQuery.of(context).size.height * .025,
                    fit: BoxFit.fill),
                // selectGame.appCommonText(
                //     color: whiteColor,
                //     size: MediaQuery.of(context).size.height * .03,
                //     weight: FontWeight.w700),
                Container(
                  height: MediaQuery.of(context).size.height * .033,
                  // width: MediaQuery.of(context).size.width * .099,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.width * .005),
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
                          width: MediaQuery.of(context).size.width * .039,
                          height: MediaQuery.of(context).size.height * .04,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.horizontal(
                                  right: Radius.circular(
                                      MediaQuery.of(context).size.width *
                                          .005)),
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
                                width: MediaQuery.of(context).size.width * .02,
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
        ));
  }
}
