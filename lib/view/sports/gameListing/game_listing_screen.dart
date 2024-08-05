import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hotlines/constant/app_strings.dart';
import 'package:hotlines/utils/deep_linking.dart';
import 'package:hotlines/view/sports/gameDetails/game_details_controller.dart';
import 'package:hotlines/view/sports/gameListing/game_listing_con.dart';
import 'package:hotlines/view/subscription/subscription_controller.dart';
import 'package:hotlines/view/widgets/game_widget.dart';
import 'package:intl/intl.dart';

import '../../../constant/shred_preference.dart';
import '../../../extras/constants.dart';
import '../../../extras/request_constants.dart';
import '../../../generated/assets.dart';
import '../../../model/game_listing.dart';
import '../../../theme/helper.dart';
import '../../../theme/theme.dart';
import '../../../utils/animated_search.dart';
import '../../../utils/app_progress.dart';
import '../../../utils/utils.dart';
import '../../auth/log_in_module/log_in_screen.dart';
import '../../change_password/change_pass_screen.dart';
import '../../profile_module/profile_screen.dart';
import '../../term_of_service/privacy_policy.dart';
import '../../term_of_service/term_service_screen.dart';
import '../../widgets/common_dialog.dart';

// ignore: must_be_immutable
class SelectGameScreen extends StatelessWidget {
  SelectGameScreen({Key? key}) : super(key: key);

  final GameListingController gameListingController =
      Get.put(GameListingController());
  final GameDetailsController gameDetailsController =
      Get.put(GameDetailsController());
  final SubscriptionController subscriptionController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GameListingController>(initState: (state) async {
      // await gameListingController.favoriteGameCall();
      await gameListingController.getResponse(true, "NFL").then((value) {});
      if (PreferenceManager.getIsLogin() ?? false) {
        Future.delayed(Duration.zero)
            .then((value) => gameListingController.getSubscriptionStatus());
      }
    }, builder: (controller) {
      // isDark = PreferenceManager.getIsDarkMode()??false ?? false;
      return Stack(
        children: [
          Scaffold(
              key: scaffoldKey,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar: commonAppBar(context, controller),
              drawer: buildDrawer(context, controller),
              drawerEnableOpenDragGesture: false,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    /*  GameTabCard(
                      onTapContact: () {
                        toggle = 0;
                        if (Platform.isIOS) {
                          controller.launchEmailSubmission();
                        } else {
                          controller.isSelectedGame = 'Contact';
                        }
                        controller.update();
                      },
                      onTapGambling: () {
                        toggle = 0;
                        controller.isSelectedGame = 'Gambling 101';
                        controller.update();
                        // showDataAlert(context);
                      },
                      controller: controller,
                    ),*/
                    20.w.H(),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: Theme.of(context).cardColor,
                      ),
                      height: MediaQuery.of(context).size.height -
                          MediaQuery.of(context).size.height * .13,
                      width: Get.width,
                      clipBehavior: Clip.antiAlias,
                      child: controller.isSelectedGame == 'Betting 101'
                          ? const GamblingCard()
                          : /*controller.isSelectedGame == 'Contact'
                              ? ContactView(
                                  webController: controller.webController,
                                )
                              :*/
                          tableDetailWidget(context, controller),
                    ).paddingSymmetric(
                        horizontal: MediaQuery.of(context).size.width * .03),
                  ],
                ),
              )),
          /* Obx(() => Get.find<SubscriptionController>().isLoading.value
              ? const AppProgress()
              : const SizedBox())*/
        ],
      );
    });
  }

  Drawer buildDrawer(BuildContext context, GameListingController controller) {
    return Drawer(
      width: MediaQuery.of(context).size.height * .35,
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            (PreferenceManager.getIsLogin() ?? false)
                ? GetBuilder<GameListingController>(builder: (con) {
                    return Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          commonCachedNetworkImage(
                            imageUrl:
                                ('${AppUrls.imageUrl}${PreferenceManager.getUserProfile() ?? ""}'),
                            height: MediaQuery.of(context).size.height * .12,
                            width: MediaQuery.of(context).size.height * .12,
                          ),
                          10.h.H(),
                          (PreferenceManager.getUserName() ?? "Name")
                              .toString()
                              .appCommonText(
                                  color: yellowColor,
                                  align: TextAlign.center,
                                  weight: FontWeight.w700,
                                  size:
                                      MediaQuery.of(context).size.height * .02),
                          (PreferenceManager.getUserEmail() ?? 'name@gmail.com')
                              .toString()
                              .appCommonText(
                                  color: yellowColor,
                                  align: TextAlign.center,
                                  weight: FontWeight.w700,
                                  size: MediaQuery.of(context).size.height *
                                      .022),
                        ],
                      ),
                    ).paddingOnly(bottom: 30.h, top: 90.h);
                  })
                : const SizedBox(),
            Visibility(
              visible: (PreferenceManager.getIsLogin() ?? false) == false ||
                  PreferenceManager.getIsLogin() == null,
              child: SvgPicture.asset(
                Assets.imagesLogo,
                fit: BoxFit.contain,
              ).paddingOnly(
                  right: MediaQuery.of(context).size.height * .05,
                  left: MediaQuery.of(context).size.height * .05,
                  top: 50.h),
            ),
            Visibility(
                visible: (PreferenceManager.getIsLogin() ?? false) == true,
                child: commonDivider(context)),
            /*drawerCard(
              widget: SvgPicture.asset(
                Assets.imagesNcaab,
                color: Colors.white,
                height: MediaQuery.of(context).size.height * .035,
                width: MediaQuery.of(context).size.width * .035,
                fit: BoxFit.cover,
              ),
              title: 'NCAAB',
              context: context,
              onTap: () {
                scaffoldKey.currentState?.closeDrawer();
                controller.tabClick(context, 0);
                controller.update();
              },
            ).paddingOnly(top: 30.h),
            drawerCard(
              widget: SvgPicture.asset(
                Assets.imagesNcaab,
                color: Colors.white,
                height: MediaQuery.of(context).size.height * .035,
                width: MediaQuery.of(context).size.width * .035,
                fit: BoxFit.cover,
              ),
              title: 'NBA',
              context: context,
              onTap: () {
                scaffoldKey.currentState?.closeDrawer();
                controller.tabClick(context, 1);
                controller.update();
              },
            ),
            drawerCard(
              icon: Assets.imagesMlb,
              title: 'MLB',
              context: context,
              onTap: () {
                scaffoldKey.currentState?.closeDrawer();
                controller.tabClick(context, 2);
                controller.update();
              },
            ),*/
            drawerCard(
              icon: Assets.imagesNfl,
              title: 'NFL',
              context: context,
              onTap: () {
                scaffoldKey.currentState?.closeDrawer();
                controller.tabClick(context, 0);
                controller.update();
              },
            ).paddingOnly(top: 30.h),
            /*   drawerCard(
              icon: Assets.imagesNcaa,
              title: 'NCAAF',
              context: context,
              onTap: () {
                scaffoldKey.currentState?.closeDrawer();
                controller.tabClick(context, 4);
                controller.update();
              },
            ),*/
            drawerCard(
              widget: Icon(
                Icons.local_fire_department_outlined,
                color: whiteColor,
                size: 35.h,
              ),
              title: 'Betting 101',
              context: context,
              onTap: () {
                scaffoldKey.currentState?.closeDrawer();
                toggle = 0;
                controller.isSelectedGame = 'Betting 101';
              },
            ),
            Visibility(
              visible: (PreferenceManager.getIsLogin() ?? false) == true,
              child: drawerCard(
                widget: Icon(
                  Icons.person_outline_rounded,
                  color: whiteColor,
                  size: 35.h,
                ),
                title: 'Edit Profile',
                context: context,
                onTap: () {
                  scaffoldKey.currentState?.closeDrawer();
                  Get.to(ProfileScreen());
                },
              ),
            ),
            drawerCard(
              widget: Image.asset(
                Assets.imagesSub,
                color: Colors.white,
                height: MediaQuery.of(context).size.height * .06,
                width: MediaQuery.of(context).size.width * .06,
                fit: BoxFit.scaleDown,
              ),
              title: 'Subscription',
              context: context,
              onTap: () {
                subscriptionDialog(
                  context,
                  showButton:
                      (PreferenceManager.getSubscriptionActive() ?? "0") == "1"
                          ? false
                          : true,
                  price: subscriptionController.price,
                  restoreOnTap: () async {
                    await subscriptionController.restorePurchase(context);
                  },
                  onTap: () async {
                    Get.back();

                    if (PreferenceManager.getIsLogin() ?? false) {
                      if (subscriptionController.products.isEmpty) {
                        null;
                      } else {
                        log('ON TAP');
                        await subscriptionController
                            .buyProduct(subscriptionController.products[0]);
                        subscriptionController.update();
                      }
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return exitApp(
                            context,
                            buttonText: 'Login',
                            cancelText: 'Cancel',
                            title: 'Error',
                            subtitle: 'You have to login for Subscription!',
                            onTap: () {
                              Get.offAll(LogInScreen());
                            },
                          );
                        },
                      );
                    }
                  },
                );
              },
            ),
            Visibility(
              visible: (PreferenceManager.getIsLogin() ?? false) == true,
              child: drawerCard(
                widget: Icon(
                  Icons.lock_reset_rounded,
                  color: whiteColor,
                  size: 35.h,
                ),
                title: 'Reset Password',
                context: context,
                onTap: () {
                  scaffoldKey.currentState?.closeDrawer();
                  Get.to(ChangePassScreen());
                },
              ),
            ),
            Visibility(
              visible: (PreferenceManager.getIsLogin() ?? false) == true,
              child: drawerCard(
                widget: Icon(
                  Icons.delete_outline,
                  color: whiteColor,
                  size: 32.h,
                ),
                title: 'Delete Account',
                context: context,
                onTap: () {
                  // scaffoldKey.currentState!.closeDrawer();
                  showDialog(
                    context: context,
                    builder: (context) {
                      return exitApp(
                        context,
                        title: deleteText,
                        subtitle: deleteDialogText,
                        onTap: () {
                          Navigator.of(context).pop(false);
                          scaffoldKey.currentState?.closeDrawer();
                          controller.deleteAc(context);
                        },
                      );
                    },
                  );
                },
              ),
            ),
            drawerCard(
              widget: Icon(
                Icons.event_note_outlined,
                color: whiteColor,
                size: 30.h,
              ),
              title: 'Terms of Service',
              context: context,
              onTap: () {
                scaffoldKey.currentState?.closeDrawer();
                Get.to(const TermOfServiceScreen());
              },
            ),
            drawerCard(
              widget: Icon(
                Icons.privacy_tip_outlined,
                color: whiteColor,
                size: 30.h,
              ),
              title: 'Privacy Policy',
              context: context,
              onTap: () {
                scaffoldKey.currentState?.closeDrawer();
                Get.to(const PrivacyPolicyScreen());
              },
            ),
            drawerCard(
              widget: Icon(
                Icons.logout,
                color: whiteColor,
                size: 30.h,
              ),
              title: 'Logout',
              context: context,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return exitApp(
                      context,
                      title: logOutText,
                      subtitle: logOutDialogText,
                      onTap: () {
                        controller.accountLogOut();
                      },
                    );
                  },
                );
              },
            ),
            drawerCard(
              widget: Icon(
                Icons.share,
                color: whiteColor,
                size: 30.h,
              ),
              title: 'Share with your friends!',
              context: context,
              onTap: () {
                DeepLinkingUtils().generateLink(context);
              },
            ),
            20.h.H(),
            Container(
              width: 110.h,
              height: 50.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.r),
                  border: Border.all(
                      color: PreferenceManager.getIsDarkMode() ?? false
                          ? blackColor
                          : Colors.transparent,
                      width: 2),
                  color: PreferenceManager.getIsDarkMode() ?? false
                      ? blackColor
                      : dividerColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      PreferenceManager.setIsDarkMod(false);
                      Get.changeThemeMode(ThemeMode.light);
                      // controller.isDarkMode = false;
                      // isDark = false;
                      controller.update();
                    },
                    child: Padding(
                      padding: EdgeInsets.all(2.sp),
                      child: Container(
                        width: 45.h,
                        height: 39.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(100.r)),
                            color: PreferenceManager.getIsDarkMode() ?? false
                                ? blackColor
                                : whiteColor),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              Assets.imagesSunLight,
                              // ignore: deprecated_member_use
                              color: PreferenceManager.getIsDarkMode() ?? false
                                  ? darkSunColor
                                  : blackColor,
                              width: 25.h,
                              height: 25.h,
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
                      // controller.isDarkMode = true;
                      // isDark = true;
                      controller.update();
                    },
                    child: Container(
                      width: 45.h,
                      height: 39.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.horizontal(
                              right: Radius.circular(100.r)),
                          color: PreferenceManager.getIsDarkMode() ?? false
                              ? darkBackGroundColor
                              : dividerColor),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            Assets.imagesMoon,
                            // ignore: deprecated_member_use
                            color: PreferenceManager.getIsDarkMode() ?? false
                                ? whiteColor
                                : greyDarkColor,
                            width: 25.h,
                            height: 25.h,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ).paddingSymmetric(
                horizontal: MediaQuery.of(context).size.width * .05),
            40.h.H(),
          ],
        ),
      ),
    );
  }

  Widget tableDetailWidget(
      BuildContext context, GameListingController controller) {
    // log("spotList(controller)--${spotList(controller).length}");
    return Stack(
      children: [
        const HeaderCard(),
        Column(
          children: [
            (MediaQuery.of(context).size.height * .06).H(),
            /*   Visibility(
              visible: (controller.sportKey == 'MLB' &&
                  !(controller.mlbSportEventsList.indexWhere((element) =>
                          DateTime.parse(element.scheduled.toString())
                              toUtc()
                              .day ==
                          DateTime.now().toLocal().day) >=
                      0) &&
                  !controller.isLoading.value &&
                  !controller.isPagination),
              child: Text(
                '\nNo games today',
                style: GoogleFonts.nunitoSans(
                    color: Theme.of(context).highlightColor,
                    fontWeight: FontWeight.bold,
                    fontSize: Get.height * .016),
                textAlign: TextAlign.start,
                maxLines: 2,
              ).paddingOnly(bottom: 15.w),
            ),*/
            (!controller.isLoading.value && controller.isPagination)
                ? const PaginationProgress()
                : (spotList(controller).isEmpty &&
                        !controller.isLoading.value &&
                        !controller.isPagination)
                    ? Expanded(
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              'No Games'.appCommonText(
                                  color: Theme.of(context).secondaryHeaderColor,
                                  size: Get.height * .022,
                                  weight: FontWeight.w800),
                              (controller.sportKey == "NCAA"
                                          ? "'2024 season starts August 24th.'"
                                          : "")
                                  .appCommonText(
                                      color: Theme.of(context)
                                          .secondaryHeaderColor,
                                      size: Get.height * .02,
                                      weight: FontWeight.w800)
                            ],
                          ),
                        ),
                      )
                    : controller.searchCon.text.isEmpty
                        ? Expanded(
                            child: RefreshIndicator(
                            onRefresh: () async {
                              Future.delayed(const Duration(seconds: 0),
                                  () async {
                                if (!controller.isCallApi) {
                                  controller.isCallApi = true;
                                  await controller.getRefreshResponse(
                                      false, controller.sportKey);
                                }
                                controller.update();
                              });
                            },
                            color: Theme.of(context).primaryColor,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: spotList(controller).length,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                try {
                                  String date = DateFormat.MMMd().format(
                                      DateTime.parse(spotList(controller)[index]
                                                  .scheduled ??
                                              '')
                                          .toLocal());
                                  String dateTime = DateFormat.jm().format(
                                      DateTime.parse(spotList(controller)[index]
                                                  .scheduled ??
                                              '')
                                          .toLocal());
                                  return (spotList(controller).length ==
                                              index + 1 &&
                                          controller.isPagination)
                                      ? const PaginationProgress()
                                      : (spotList(controller)[index].status ==
                                              'postponed')
                                          ? const SizedBox()
                                          : Column(
                                              children: [
                                                GameWidget(
                                                  status: spotList(
                                                          controller)[index]
                                                      .status
                                                      .toString(),
                                                  flameNumber: controller
                                                              .sportKey !=
                                                          "MLB"
                                                      ? spotList(
                                                              controller)[index]
                                                          .getFlameValue
                                                      : 0,
                                                  isShowWeather:
                                                      controller.sportKey !=
                                                              "NCAAB" ||
                                                          controller.sportKey !=
                                                              "NBA",
                                                  onTap: () {
                                                    controller.gameOnClick(
                                                        context, index);
                                                  },
                                                  isShowFlam:
                                                      (controller.sportKey !=
                                                          "MLB"),
                                                  awayTeamMoneyLine: spotList(
                                                          controller)[index]
                                                      .awayMoneyLineValue,
                                                  homeTeamMoneyLine: spotList(
                                                          controller)[index]
                                                      .homeMoneyLineValue,
                                                  awayTeamOU: spotList(
                                                          controller)[index]
                                                      .awayOUValue,
                                                  homeTeamOU: spotList(
                                                          controller)[index]
                                                      .homeOUValue,
                                                  weather: spotList(
                                                          controller)[index]
                                                      .weather,
                                                  homeTeamSpread: spotList(
                                                              controller)[index]
                                                          .homeSpreadValue
                                                          .contains('-')
                                                      ? spotList(
                                                              controller)[index]
                                                          .homeSpreadValue
                                                      : '+${spotList(controller)[index].homeSpreadValue}',
                                                  awayTeamSpread: spotList(
                                                              controller)[index]
                                                          .awaySpreadValue
                                                          .contains('-')
                                                      ? spotList(
                                                              controller)[index]
                                                          .awaySpreadValue
                                                      : '+${spotList(controller)[index].awaySpreadValue}',
                                                  temp: spotList(
                                                          controller)[index]
                                                      .tmpInFahrenheit,
                                                  isLive: (spotList(controller)[
                                                                  index]
                                                              .status ==
                                                          'live' ||
                                                      spotList(controller)[
                                                                  index]
                                                              .status ==
                                                          'inprogress' ||
                                                      spotList(controller)[
                                                                  index]
                                                              .status ==
                                                          'halftime'),
                                                  dateTime: (spotList(controller)[
                                                                      index]
                                                                  .status ==
                                                              'live' ||
                                                          spotList(controller)[
                                                                      index]
                                                                  .status ==
                                                              'inprogress' ||
                                                          spotList(controller)[
                                                                      index]
                                                                  .status ==
                                                              'halftime')
                                                      ? (controller.sportKey ==
                                                                  "NCAAB" ||
                                                              controller
                                                                      .sportKey ==
                                                                  "NBA")
                                                          ? '${spotList(controller)[index].inningHalf}${spotList(controller)[index].inning}, ${spotList(controller)[index].clock}'
                                                          : '${spotList(controller)[index].inningHalf}${spotList(controller)[index].inning}, ${spotList(controller)[index].outs}'
                                                      : '$date, $dateTime',
                                                  awayTeamImageUrl: awayLogo(
                                                      spotList(
                                                          controller)[index],
                                                      controller,
                                                      index),
                                                  awayTeamRank:
                                                      (spotList(controller)[
                                                                      index]
                                                                  .awayRank ==
                                                              '0'
                                                          ? ''
                                                          : spotList(controller)[
                                                                  index]
                                                              .awayRank),
                                                  awayTeamAbb: (mobileView.size
                                                              .shortestSide <
                                                          600
                                                      ? spotList(
                                                              controller)[index]
                                                          .awayTeamAbb
                                                      : spotList(
                                                              controller)[index]
                                                          .awayTeam),
                                                  awayTeamScore: (spotList(
                                                          controller)[index]
                                                      .awayScore),
                                                  homeTeamImageUrl: homeLogo(
                                                      spotList(
                                                          controller)[index],
                                                      controller,
                                                      index),
                                                  homeTeamRank:
                                                      (spotList(controller)[
                                                                      index]
                                                                  .homeRank ==
                                                              '0'
                                                          ? ''
                                                          : spotList(controller)[
                                                                  index]
                                                              .homeRank),
                                                  homeTeamAbb: (mobileView.size
                                                              .shortestSide <
                                                          600
                                                      ? spotList(
                                                              controller)[index]
                                                          .homeTeamAbb
                                                      : spotList(
                                                              controller)[index]
                                                          .homeTeam),
                                                  homeTeamScore: spotList(
                                                          controller)[index]
                                                      .homeScore,
                                                ),
                                                spotList(controller).length >= 2
                                                    ? /*(controller.sportKey ==
                                                                "NCAAB" ||
                                                            controller
                                                                    .sportKey ==
                                                                "NBA")
                                                        ? const SizedBox()
                                                        :*/
                                                    index + 1 ==
                                                            (spotList(
                                                                    controller)
                                                                .length)
                                                        ? const SizedBox()
                                                        : (DateTime.parse(spotList(controller)[index]
                                                                            .scheduled ??
                                                                        '')
                                                                    .toLocal()
                                                                    .day !=
                                                                DateTime.parse(
                                                                        spotList(controller)[index + 1].scheduled ??
                                                                            '')
                                                                    .toLocal()
                                                                    .day)
                                                            ? Divider(
                                                                color: Theme.of(
                                                                        context)
                                                                    .indicatorColor,
                                                                thickness: 2,
                                                              ).paddingOnly(
                                                                top: 5.h)
                                                            : const SizedBox()
                                                    : const SizedBox(),
                                              ],
                                            );
                                } catch (e) {
                                  log(e.toString());
                                  return Container(
                                    color: Colors.red,
                                    height: 50,
                                  );
                                }
                              },
                            ),
                          ))
                        : Expanded(
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: controller.searchList.length,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                try {
                                  SportEvents competitors =
                                      controller.searchList[index];
                                  String date = DateFormat.MMMd().format(
                                      DateTime.parse(
                                              competitors.scheduled ?? '')
                                          .toLocal());
                                  String dateTime = DateFormat.jm().format(
                                      DateTime.parse(
                                              competitors.scheduled ?? '')
                                          .toLocal());
                                  return Visibility(
                                    visible: (competitors.status != 'closed') ||
                                        (competitors.status != 'postponed'),
                                    child: GameWidget(
                                      status: competitors.status.toString(),
                                      isShowFlam:
                                          (controller.sportKey != "MLB"),
                                      flameNumber: controller.sportKey != "MLB"
                                          ? competitors.getFlameValue
                                          : 0,
                                      onTap: () {
                                        controller.searchGameOnClick(
                                            context, index);
                                      },
                                      isShowWeather:
                                          controller.sportKey != "NCAAB" ||
                                              controller.sportKey != "NBA",
                                      awayTeamMoneyLine:
                                          competitors.awayMoneyLineValue,
                                      homeTeamMoneyLine:
                                          competitors.homeMoneyLineValue,
                                      awayTeamOU: competitors.awayOUValue,
                                      homeTeamOU: competitors.homeOUValue,
                                      weather: competitors.weather,
                                      homeTeamSpread: competitors
                                              .homeSpreadValue
                                              .contains('-')
                                          ? competitors.homeSpreadValue
                                          : '+${competitors.homeSpreadValue}',
                                      awayTeamSpread: competitors
                                              .awaySpreadValue
                                              .contains('-')
                                          ? competitors.awaySpreadValue
                                          : '+${competitors.awaySpreadValue}',
                                      temp: competitors.tmpInFahrenheit,
                                      isLive: (competitors.status == 'live' ||
                                          competitors.status == "inprogress" ||
                                          competitors.status == "halftime"),
                                      dateTime: (competitors.status == 'live' ||
                                              competitors.status ==
                                                  "inprogress" ||
                                              competitors.status == "halftime")
                                          ? (controller.sportKey == "NCAAB" ||
                                                  controller.sportKey == "NBA")
                                              ? '${competitors.inningHalf}${competitors.inning}, ${competitors.clock}'
                                              : '${competitors.inningHalf}${competitors.inning}, ${competitors.outs}'
                                          : '$date, $dateTime',
                                      awayTeamImageUrl: awayLogo(
                                          competitors, controller, index),
                                      awayTeamRank: (competitors.awayRank == '0'
                                          ? ''
                                          : competitors.awayRank),
                                      awayTeamAbb:
                                          (mobileView.size.shortestSide < 600
                                              ? competitors.awayTeamAbb
                                              : competitors.awayTeam),
                                      awayTeamScore: (competitors.awayScore),
                                      homeTeamImageUrl: homeLogo(
                                          competitors, controller, index),
                                      homeTeamRank: (competitors.homeRank == '0'
                                          ? ''
                                          : competitors.homeRank),
                                      homeTeamAbb:
                                          (mobileView.size.shortestSide < 600
                                              ? competitors.homeTeamAbb
                                              : competitors.homeTeam),
                                      homeTeamScore: competitors.homeScore,
                                    ),
                                  );
                                } catch (e) {
                                  return const SizedBox();
                                }
                              },
                            ),
                          ),
            (MediaQuery.of(context).size.height * .01).H(),
          ],
        ),
        Obx(() =>
            controller.isLoading.value ? const AppProgress() : const SizedBox())
      ],
    );
  }

  String awayLogo(
      SportEvents competitors, GameListingController controller, int index) {
    return competitors.awayTeam == 'North Carolina State Wolfpack'
        ? 'https://a.espncdn.com/i/teamlogos/ncaa/500/152.png'
        : competitors.awayTeamAbb == 'ALBY'
            ? "https://a.espncdn.com/i/teamlogos/ncaa/500/399.png"
            : competitors.awayTeamAbb == 'LINW'
                ? "https://a.espncdn.com/i/teamlogos/ncaa/500/2815.png"
                : competitors.awayTeamAbb == 'IUN'
                    ? "https://a.espncdn.com/i/teamlogos/ncaa/500/2546.png"
                    : competitors.awayTeamAbb == 'LMC'
                        ? "https://dxbhsrqyrr690.cloudfront.net/sidearm.nextgen.sites/lemoyne.sidearmsports.com/images/logos/site/site.png"
                        : competitors.awayTeamAbb == 'ARI'
                            ? "https://a.espncdn.com/i/teamlogos/nfl/500/scoreboard/ari.png"
                            : competitors.awayTeamAbb == 'SCUS'
                                ? "https://a.espncdn.com/i/teamlogos/ncaa/500/2541.png"
                                : competitors.awayTeamAbb == 'MCNS'
                                    ? "https://a.espncdn.com/i/teamlogos/ncaa/500/2377.png"
                                    : competitors.awayTeamAbb == 'FAMU'
                                        ? "https://a.espncdn.com/i/teamlogos/ncaa/500/57.png"
                                        : competitors.awayTeamAbb == 'WEBB'
                                            ? "https://a.espncdn.com/i/teamlogos/ncaa/500/2241.png"
                                            : competitors.awayTeamAbb == 'SIND'
                                                ? "https://a.espncdn.com/i/teamlogos/ncaa/500/2463.png"
                                                : competitors.awayTeamAbb ==
                                                            'WAS' &&
                                                        competitors.id ==
                                                            "sr:competitor:4432"
                                                    ? "https://a.espncdn.com/i/teamlogos/nfl/500/scoreboard/wsh.png"
                                                    : competitors.awayTeamAbb ==
                                                            'UST'
                                                        ? "https://a.espncdn.com/i/teamlogos/ncaa/500/2900.png"
                                                        : competitors
                                                                    .awayTeamAbb ==
                                                                'QUC'
                                                            ? "https://a.espncdn.com/i/teamlogos/ncaa/500/2511.png"
                                                            : competitors
                                                                        .awayTeamAbb ==
                                                                    'UMKC'
                                                                ? "https://a.espncdn.com/i/teamlogos/ncaa/500/140.png"
                                                                : competitors
                                                                            .awayTeamAbb ==
                                                                        'GC'
                                                                    ? "https://a.espncdn.com/i/teamlogos/ncaa/500/2253.png"
                                                                    : competitors.awayTeamAbb ==
                                                                            'CSN'
                                                                        ? "https://a.espncdn.com/i/teamlogos/ncaa/500/2463.png"
                                                                        : competitors.awayTeamAbb ==
                                                                                'CSB'
                                                                            ? "https://a.espncdn.com/i/teamlogos/ncaa/500-dark/2934.png"
                                                                            : competitors.awayTeam == 'Louisiana-Lafayette Ragin Cajuns'
                                                                                ? "https://a.espncdn.com/i/teamlogos/ncaa/500/309.png"
                                                                                : competitors.awayTeam == 'CSB'
                                                                                    ? "https://a.espncdn.com/i/teamlogos/ncaa/500/2934.png"
                                                                                    : competitors.awayTeam == 'Sam Houston State Bearkats'
                                                                                        ? "https://a.espncdn.com/i/teamlogos/ncaa/500/2534.png"
                                                                                        : competitors.gameLogoAwayLink;
  }

  String homeLogo(
      SportEvents competitors, GameListingController controller, int index) {
    return competitors.homeTeam == 'North Carolina State Wolfpack'
        ? 'https://a.espncdn.com/i/teamlogos/ncaa/500/152.png'
        : competitors.homeTeamAbb == 'ALBY'
            ? "https://a.espncdn.com/i/teamlogos/ncaa/500/399.png"
            : competitors.homeTeamAbb == 'LMC'
                ? "https://dxbhsrqyrr690.cloudfront.net/sidearm.nextgen.sites/lemoyne.sidearmsports.com/images/logos/site/site.png"
                : competitors.homeTeamAbb == 'IUN'
                    ? "https://a.espncdn.com/i/teamlogos/ncaa/500/2546.png"
                    : competitors.homeTeamAbb == 'LINW'
                        ? "https://a.espncdn.com/i/teamlogos/ncaa/500/2815.png"
                        : competitors.homeTeamAbb == 'WEBB'
                            ? "https://a.espncdn.com/i/teamlogos/ncaa/500/2241.png"
                            : competitors.homeTeamAbb == 'ARI'
                                ? "https://a.espncdn.com/i/teamlogos/nfl/500/scoreboard/ari.png"
                                : competitors.homeTeamAbb == 'SCUS'
                                    ? "https://a.espncdn.com/i/teamlogos/ncaa/500/2541.png"
                                    : competitors.homeTeamAbb == 'MCNS'
                                        ? "https://a.espncdn.com/i/teamlogos/ncaa/500/2377.png"
                                        : competitors.homeTeamAbb == 'FAMU'
                                            ? "https://a.espncdn.com/i/teamlogos/ncaa/500/57.png"
                                            : competitors.homeTeamAbb == 'UMKC'
                                                ? "https://a.espncdn.com/i/teamlogos/ncaa/500/140.png"
                                                : competitors.homeTeamAbb ==
                                                        'CSN'
                                                    ? "https://a.espncdn.com/i/teamlogos/ncaa/500/2463.png"
                                                    : competitors.homeTeamAbb ==
                                                                'WAS' &&
                                                            competitors.id ==
                                                                "sr:competitor:4432"
                                                        ? "https://a.espncdn.com/i/teamlogos/nfl/500/scoreboard/wsh.png"
                                                        : competitors
                                                                    .homeTeamAbb ==
                                                                'QUC'
                                                            ? "https://a.espncdn.com/i/teamlogos/ncaa/500/2511.png"
                                                            : competitors
                                                                        .homeTeamAbb ==
                                                                    'CSB'
                                                                ? "https://a.espncdn.com/i/teamlogos/ncaa/500-dark/2934.png"
                                                                : competitors
                                                                            .homeTeamAbb ==
                                                                        'SIND'
                                                                    ? "https://a.espncdn.com/i/teamlogos/ncaa/500/2463.png"
                                                                    : competitors.homeTeamAbb ==
                                                                            'UST'
                                                                        ? "https://a.espncdn.com/i/teamlogos/ncaa/500/2900.png"
                                                                        : competitors.homeTeamAbb ==
                                                                                'GC'
                                                                            ? "https://a.espncdn.com/i/teamlogos/ncaa/500/2253.png"
                                                                            : competitors.homeTeamAbb == 'CSB'
                                                                                ? "https://a.espncdn.com/i/teamlogos/ncaa/500/2934.png"
                                                                                : competitors.homeTeam == 'Louisiana-Lafayette Ragin Cajuns'
                                                                                    ? "https://a.espncdn.com/i/teamlogos/ncaa/500/309.png"
                                                                                    : competitors.homeTeam == 'Sam Houston State Bearkats'
                                                                                        ? "https://a.espncdn.com/i/teamlogos/ncaa/500/2534.png"
                                                                                        : competitors.gameHomeLogoLink;
  }

  List<SportEvents> spotList(GameListingController controller) {
    return (controller.sportKey == 'MLB'
        ? controller.mlbSportEventsList
        : controller.sportKey == 'NFL'
            ? controller.nflSportEventsList.toSet().toList()
            : controller.sportKey == 'NBA'
                ? controller.nbaSportEventsList
                : controller.sportKey == 'NCAAB'
                    ? controller.ncaabSportEventsList
                    : controller.ncaaSportEventsList);
  }
}
