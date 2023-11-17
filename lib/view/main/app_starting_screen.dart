import 'dart:async';
import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotlines/generated/assets.dart';
import 'package:hotlines/theme/app_color.dart';
import 'package:hotlines/utils/extension.dart';
import 'package:hotlines/view/widgets/game_widget.dart';

import '../../constant/shred_preference.dart';
import '../../extras/constants.dart';
import '../../theme/helper.dart';
import '../../utils/deep_linking.dart';
import '../auth/log_in_module/log_in_screen.dart';
import '../sports/gameListing/game_listing_screen.dart';

class AppStartScreen extends StatefulWidget {
  const AppStartScreen({Key? key}) : super(key: key);

  @override
  State<AppStartScreen> createState() => _AppStartScreenState();
}

class _AppStartScreenState extends State<AppStartScreen> {
  @override
  void initState() {
    super.initState();
    FlutterBranchSdk.validateSDKIntegration();
    Future.delayed(Duration.zero, () {
      DeepLinkingUtils().listenDeepLinkData(context);
    });
    DeepLinkingUtils().initializeDeepLinkData();
  }

  @override
  void dispose() {
    super.dispose();
    DeepLinkingUtils().streamSubscriptionDeepLink?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: whiteColor,
        ),
        child: GestureDetector(
          child: 'Explore sports'.appCommonText(
              weight: FontWeight.w700, color: appColor, size: 20.h),
          onTap: () {
            PreferenceManager.setIsFirstLoaded(true);
            Get.offAll(SelectGameScreen());
          },
        ).paddingSymmetric(vertical: 10),
      ).paddingSymmetric(horizontal: MediaQuery.of(context).size.width * .03),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.h.H(),
            Center(
              child: SvgPicture.asset(Assets.imagesLogo,
                  height: 70.w, fit: BoxFit.contain),
            ),
            25.h.H(),
            "Getting Started:".appCommonText(
                weight: FontWeight.bold, color: yellowColor, size: 25),
            20.h.H(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  Assets.imagesBall,
                  height: MediaQuery.of(Get.context!).size.width * .055,
                  fit: BoxFit.contain,
                ),
                10.h.W(),
                Expanded(
                    child: RichText(
                  text: TextSpan(
                      text: 'Pick a Sport - SEC football fan? Jump to ',
                      style: GoogleFonts.nunitoSans(
                        color: whiteColor,
                        fontWeight: FontWeight.w400,
                        fontSize:
                            MediaQuery.of(Get.context!).size.height * .022,
                      ),
                      children: [
                        TextSpan(
                          text: 'NCAAF. ',
                          style: GoogleFonts.nunitoSans(
                            color: whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize:
                                MediaQuery.of(Get.context!).size.height * .022,
                          ),
                        ),
                        TextSpan(
                          text: 'Baltimore Ravens fan? Jump to ',
                          style: GoogleFonts.nunitoSans(
                            color: whiteColor,
                            fontWeight: FontWeight.w400,
                            fontSize:
                                MediaQuery.of(Get.context!).size.height * .022,
                          ),
                        ),
                        TextSpan(
                          text: 'NFL ',
                          style: GoogleFonts.nunitoSans(
                            color: whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize:
                                MediaQuery.of(Get.context!).size.height * .022,
                          ),
                        ),
                        TextSpan(
                          text: 'to see their next game.',
                          style: GoogleFonts.nunitoSans(
                            color: whiteColor,
                            fontWeight: FontWeight.w400,
                            fontSize:
                                MediaQuery.of(Get.context!).size.height * .022,
                          ),
                        ),
                      ]),
                ))
              ],
            ),
            10.h.H(),
            dialogCard(
                image: Assets.imagesPopcorn,
                title:
                    'Pick a Game - Have a favorite team? Click into their next game to see how they stack up against the competition.'),
            dialogCard(
                image: Assets.imagesBook,
                title:
                    'Learn - We provide you with head to head matchups and analysis to give you insights on trends.'),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  Assets.imagesHeart,
                  height: MediaQuery.of(Get.context!).size.width * .055,
                  fit: BoxFit.contain,
                ),
                10.W(),
                Expanded(
                    child: RichText(
                  text: TextSpan(
                      text: 'Share - Love HotlinesCB? ',
                      style: GoogleFonts.nunitoSans(
                        color: whiteColor,
                        fontWeight: FontWeight.w400,
                        fontSize:
                            MediaQuery.of(Get.context!).size.height * .022,
                      ),
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // DeepLinkingUtils().generateDeepLink(context);
                            },
                          text: 'Share with your friends!',
                          style: GoogleFonts.nunitoSans(
                            color: whiteColor,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            fontSize:
                                MediaQuery.of(Get.context!).size.height * .022,
                          ),
                        ),
                      ]),
                ))
              ],
            ),
          ],
        ).paddingSymmetric(
            horizontal: MediaQuery.of(context).size.width * .05,
            vertical: MediaQuery.of(context).size.width * .03),
      ),
    );
  }
}
