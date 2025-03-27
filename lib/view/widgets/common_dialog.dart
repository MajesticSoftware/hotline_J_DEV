import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotlines/model/game_model.dart';
import 'package:hotlines/theme/helper.dart';
import 'package:hotlines/utils/extension.dart';

import '../../constant/app_strings.dart';
import '../../generated/assets.dart';
import '../../theme/app_color.dart';
import 'common_widget.dart';

class DialogWidget {
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
                      size: MediaQuery.of(context).size.height * .03,
                      color: Theme.of(context).dividerColor,
                    )),
              ),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 10.w,
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
}

Widget exitApp(BuildContext context,
    {void Function()? onTap,bool isUpdateApp=false, String subtitle = '', String title = '',String? buttonText,String? cancelText}) {
  return AlertDialog(
    title: title.appCommonText(
        color: Theme.of(context).secondaryHeaderColor, weight: FontWeight.bold, size: 28.h),
    content: subtitle.appCommonText(
        color: blackColor.withOpacity(.8), weight: FontWeight.w600, size: 20.h,align: TextAlign.center),
   // actionsPadding: const EdgeInsets.only(bottom: 20),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
    actionsAlignment: MainAxisAlignment.center,
    actions:isUpdateApp?
    <Widget>[   Center(
      child: CommonAppButton(
          onTap:onTap??(){},
          radius: 15.r,
          title: 'Update'),
    ),]: <Widget>[
      Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(false);
                },
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: Theme.of(context).secondaryHeaderColor),
                    child: (cancelText?? noText).appCommonText(
                        color: whiteColor,
                        weight: FontWeight.w700,
                        size: 22.h).paddingSymmetric(vertical: 10.h)),
              ),
            ),
            10.W(),
            Expanded(
              child: GestureDetector(
                onTap: onTap,
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: Theme.of(context).secondaryHeaderColor),
                    child: ( buttonText??yesText).appCommonText(
                        color: whiteColor,
                        weight: FontWeight.w700,
                        size: 22.h).paddingSymmetric(vertical: 10.h)),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
