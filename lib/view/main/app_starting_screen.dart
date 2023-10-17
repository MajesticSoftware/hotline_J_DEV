import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hotlines/generated/assets.dart';
import 'package:hotlines/theme/app_color.dart';
import 'package:hotlines/utils/extension.dart';
import 'package:hotlines/view/widgets/game_widget.dart';

import '../../constant/shred_preference.dart';
import '../sports/gameListing/game_listing_screen.dart';

class AppStartScreen extends StatelessWidget {
  const AppStartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: whiteColor,
        ),
        child: GestureDetector(
          child: 'Explore sports'.appCommonText(
              weight: FontWeight.w700, color: appColor, size: 18),
          onTap: () {
            PreferenceManager.setIsFirstLoaded(true);
            Get.to(SelectGameScreen());
          },
        ).paddingSymmetric(vertical: 10),
      ).paddingSymmetric(horizontal: MediaQuery.of(context).size.width * .03),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.H(),
            Center(
              child: SvgPicture.asset(Assets.imagesLogo,
                  height: 70.w, fit: BoxFit.contain),
            ),
            25.H(),
            "Getting Started:".appCommonText(
                weight: FontWeight.bold, color: yellowColor, size: 25),
            20.H(),
            dialogCard(
                image: Assets.imagesBall,
                title:
                    'Pick a Sport - SEC football fan? Jump to NCAAF. Baltimore Ravens fan? Jump to NFL to see their next game.'),
            dialogCard(
                image: Assets.imagesPopcorn,
                title:
                    'Pick a Game - Have a favorite team? Click into their next game to see how they stack up against the competition.'),
            dialogCard(
                image: Assets.imagesBook,
                title:
                    'Learn - We provide you with head to head matchups and analysis to give you insights on trends.'),
            dialogCard(
                image: Assets.imagesHeart,
                title: 'Share - Love HotlinesCB? Share with your friends!'),
          ],
        ).paddingSymmetric(
            horizontal: MediaQuery.of(context).size.width * .05,
            vertical: MediaQuery.of(context).size.width * .03),
      ),
    );
  }
}
