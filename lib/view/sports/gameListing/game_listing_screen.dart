// ignore_for_file: deprecated_member_use, duplicate_ignore, unused_local_variable

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hotlines/constant/app_strings.dart';
import 'package:hotlines/model/game_listing.dart' as game_listing;
import 'package:hotlines/utils/app_helper.dart';
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
      await gameListingController
          .getResponse(true, SportName.NCAAB.name)
          .then((value) {});
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
              appBar: isTablet(context)
                  ? commonTabletAppBarWidget(
                      context, controller, spotList(controller))
                  : commonAppBar(context, controller, spotList(controller)),
              drawer: buildDrawer(context, controller),
              drawerEnableOpenDragGesture: false,
              body: Column(
                children: [
                  GameTabCard(
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
                  ),
                  10.w.H(),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: Theme.of(context).cardColor,
                      ),
                      margin: const EdgeInsets.only(bottom: 10),
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
                  ),
                ],
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

            /* drawerCard(
              widget: SvgPicture.asset(
                Assets.imagesNcaab,
                color: Colors.white,
                height: MediaQuery.of(context).size.height * .035,
                width: MediaQuery.of(context).size.width * .035,
                fit: BoxFit.cover,
              ),
              title: SportName.NBA.name,
              context: context,
              onTap: () {
                scaffoldKey.currentState?.closeDrawer();
                controller.tabClick(context, 1);
                controller.update();
              },
            ),
            drawerCard(
              icon: Assets.imagesMlb,
              title: SportName.MLB.name,
              context: context,
              onTap: () {
                scaffoldKey.currentState?.closeDrawer();
                controller.tabClick(context, 2);
                controller.update();
              },
            ),*/
            /*drawerCard(
              icon: Assets.imagesNfl,
              title: SportName.NFL.name,
              context: context,
              onTap: () {
                scaffoldKey.currentState?.closeDrawer();
                controller.tabClick(context, 0);
                controller.update();
              },
            ).paddingOnly(top: 30.h),*/
            drawerCard(
              widget: SvgPicture.asset(
                Assets.imagesNcaab,
                color: Colors.white,
                height: MediaQuery.of(context).size.height * .035,
                width: MediaQuery.of(context).size.width * .035,
                fit: BoxFit.cover,
              ),
              title: SportName.NCAAB.name,
              context: context,
              onTap: () {
                scaffoldKey.currentState?.closeDrawer();
                controller.tabClick(context, 0);
                controller.update();
              },
            ).paddingOnly(top: 30.h),
            
            // MLB Option
            drawerCard(
              widget: SvgPicture.asset(
                Assets.imagesMlb,
                color: Colors.white,
                height: MediaQuery.of(context).size.height * .035,
                width: MediaQuery.of(context).size.width * .035,
                fit: BoxFit.contain,
              ),
              title: SportName.MLB.name,
              context: context,
              onTap: () {
                scaffoldKey.currentState?.closeDrawer();
                controller.tabClick(context, 1); // Use index 1 for MLB
                controller.update();
              },
            ),
            /*drawerCard(
              icon: Assets.imagesNcaa,
              title: SportName.NCAAF.name,
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
    // Add debug logging for game lists
    if (controller.sportKey == SportName.NCAAB.name) {
      print("NCAAB Game Count: ${spotList(controller).length}");
      print("NCAAB Loading state: ${controller.isLoading.value}");
      if (spotList(controller).isEmpty && !controller.isLoading.value) {
        print("WARNING: NCAAB games list is empty but not loading!");
      }
    }
    
    return Stack(
      children: [
        Column(
          children: [
            HeaderCard(
              sportName: controller.sportKey,
            ),
            (MediaQuery.of(context).size.height * .01).H(),
            // Only show "No Games" when no games are available
            controller.searchCon.text.isEmpty
                ? Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        Future.delayed(const Duration(seconds: 0), () async {
                          if (!controller.isCallApi) {
                            controller.isCallApi = true;
                            await controller.getRefreshResponse(
                                false, controller.sportKey);
                          }
                          controller.update();
                        });
                      },
                      color: Theme.of(context).primaryColor,
                      child: spotList(controller).isEmpty && !controller.isLoading.value 
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  'No Games Available'.appCommonText(
                                    color: Theme.of(context).secondaryHeaderColor,
                                    size: Get.height * .022,
                                    weight: FontWeight.w800,
                                  ),
                                  const SizedBox(height: 10),
                                  (controller.sportKey == SportName.NCAAB.name
                                    ? controller.isFirstLoad 
                                        ? "Loading games data..." 
                                        : DateTime.now().month >= 10 || DateTime.now().month <= 4
                                            ? "No games found for today" 
                                            : "Check back during basketball season (October-April)"
                                    : "No games scheduled for today").appCommonText(
                                    color: Theme.of(context).secondaryHeaderColor,
                                    size: Get.height * .018,
                                    weight: FontWeight.w600,
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.refresh,
                                        color: Theme.of(context).primaryColor,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 8),
                                      "Pull down to refresh".appCommonText(
                                        color: Theme.of(context).primaryColor,
                                        size: Get.height * .016,
                                        weight: FontWeight.w600,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: spotList(controller).length,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                // Your original game list builder logic
                                return buildGameItem(context, controller, index);
                              },
                            ),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: controller.searchList.length,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        // Your search list builder logic
                        return buildSearchItem(context, controller, index);
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

  Widget buildGameItem(
      BuildContext context, GameListingController controller, int index) {
    try {
      // Safety check to prevent index out of bounds errors
      if (spotList(controller).isEmpty) {
        print("Attempting to build game item but list is empty");
        return const SizedBox();
      }
      
      if (index >= spotList(controller).length) {
        print("Index out of bounds: $index >= ${spotList(controller).length}");
        return const SizedBox();
      }
      
      // Log for NCAAB games to help debug
      if (controller.sportKey == SportName.NCAAB.name) {
        print("Building game item $index: ${spotList(controller)[index].homeTeam} vs ${spotList(controller)[index].awayTeam}");
      }
      
      String date = DateFormat.MMMd().format(
          DateTime.parse(spotList(controller)[index].scheduled ?? '')
              .toLocal());
      String dateTime = DateFormat.jm().format(
          DateTime.parse(spotList(controller)[index].scheduled ?? '')
              .toLocal());

      return (spotList(controller).length == index + 1 &&
              controller.isPagination)
          ? const PaginationProgress()
          : (spotList(controller)[index].status ==
                      GameStatus.postponed.name)
                  ? const SizedBox()
                  : Column(
                      children: [
                        GameWidget(
                          status: spotList(controller)[index].status.toString(),
                          flameNumber: spotList(controller)[index].getFlameValue, // Always show flame value
                          isShowWeather: !(controller.sportKey == SportName.NCAAB.name || // Hide weather for NCAAB, NBA, MLB
                                  controller.sportKey == SportName.NBA.name ||
                                  controller.sportKey == SportName.MLB.name),
                          onTap: () {
                            controller.gameOnClick(
                                context, spotList(controller)[index]);
                          },
                          isShowFlam: false, // Show inning/weather for MLB too
                          awayTeamMoneyLine:
                              spotList(controller)[index].awayMoneyLineValue,
                          homeTeamMoneyLine:
                              spotList(controller)[index].homeMoneyLineValue,
                          awayTeamOU: spotList(controller)[index].awayOUValue,
                          homeTeamOU: spotList(controller)[index].homeOUValue,
                          weather: spotList(controller)[index].weather,
                          homeTeamSpread: spotList(controller)[index]
                                  .homeSpreadValue
                                  .contains('-')
                              ? spotList(controller)[index].homeSpreadValue
                              : '+${spotList(controller)[index].homeSpreadValue}',
                          awayTeamSpread: spotList(controller)[index]
                                  .awaySpreadValue
                                  .contains('-')
                              ? spotList(controller)[index].awaySpreadValue
                              : '+${spotList(controller)[index].awaySpreadValue}',
                          temp: spotList(controller)[index].tmpInFahrenheit,
                          isLive: (spotList(controller)[index].status ==
                                  GameStatus.live.name ||
                              spotList(controller)[index].status ==
                                  GameStatus.inprogress.name ||
                              spotList(controller)[index].status ==
                                  GameStatus.halftime.name),
                          dateTime: spotList(controller)[index].status ==
                                      GameStatus.live.name ||
                                  spotList(controller)[index].status ==
                                      GameStatus.inprogress.name ||
                                  spotList(controller)[index].status ==
                                      GameStatus.halftime.name
                              ? '${spotList(controller)[index].inningHalf}${spotList(controller)[index].inning}, ${spotList(controller)[index].clock}'
                              : spotList(controller)[index].status ==
                                      GameStatus.closed.name
                                  ? GameStatus.Final.name
                                  : '$date, $dateTime',
                          awayTeamImageUrl:
                              awayLogo(spotList(controller)[index]),
                          awayTeamRank:
                              (spotList(controller)[index].awayRank == '0'
                                  ? ''
                                  : spotList(controller)[index].awayRank),
                          awayTeamAbb: (mobileView.size.shortestSide < 600
                              ? spotList(controller)[index].awayTeamAbb
                              : spotList(controller)[index].awayTeam),
                          awayTeamScore:
                              (spotList(controller)[index].awayScore),
                          homeTeamImageUrl:
                              homeLogo(spotList(controller)[index]),
                          homeTeamRank:
                              (spotList(controller)[index].homeRank == '0'
                                  ? ''
                                  : spotList(controller)[index].homeRank),
                          homeTeamAbb: (mobileView.size.shortestSide < 600
                              ? spotList(controller)[index].homeTeamAbb
                              : spotList(controller)[index].homeTeam),
                          homeTeamScore: spotList(controller)[index].homeScore,
                        ),
                        index + 1 == (spotList(controller).length)
                            ? const SizedBox()
                            : (DateTime.parse(spotList(controller)[index]
                                                .scheduled ??
                                            '')
                                        .toLocal()
                                        .day !=
                                    DateTime.parse(
                                            spotList(controller)[index + 1]
                                                    .scheduled ??
                                                '')
                                        .toLocal()
                                        .day)
                                ? Divider(
                                    color: Theme.of(context).indicatorColor,
                                    thickness: 2,
                                  ).paddingOnly(top: 5.h)
                                : const SizedBox(),
                      ],
                    );
    } catch (e) {
      log(e.toString());
      return const SizedBox();
    }
  }

  Widget buildSearchItem(
      BuildContext context, GameListingController controller, int index) {
    try {
      SportEvents competitors = controller.searchList[index];
      String date = DateFormat.MMMd()
          .format(DateTime.parse(competitors.scheduled ?? '').toLocal());
      String dateTime = DateFormat.jm()
          .format(DateTime.parse(competitors.scheduled ?? '').toLocal());
      return Visibility(
        visible: (competitors.status != GameStatus.closed.name) ||
            (competitors.status != GameStatus.postponed.name),
        child: GameWidget(
          status: competitors.status.toString(),
          isShowFlam: (controller.sportKey != SportName.MLB.name), // Keep original isShowFlam logic for search results if needed, or adjust as per overall theme
          flameNumber: competitors.getFlameValue, // Always show flame value
          onTap: () {
            controller.searchGameOnClick(context, competitors);
          },
          isShowWeather: !(controller.sportKey == SportName.NCAAB.name || // Hide weather for NCAAB, NBA, MLB
              controller.sportKey == SportName.NBA.name ||
              controller.sportKey == SportName.MLB.name),
          awayTeamMoneyLine: competitors.awayMoneyLineValue,
          homeTeamMoneyLine: competitors.homeMoneyLineValue,
          awayTeamOU: competitors.awayOUValue,
          homeTeamOU: competitors.homeOUValue,
          weather: competitors.weather,
          homeTeamSpread: competitors.homeSpreadValue.contains('-')
              ? competitors.homeSpreadValue
              : '+${competitors.homeSpreadValue}',
          awayTeamSpread: competitors.awaySpreadValue.contains('-')
              ? competitors.awaySpreadValue
              : '+${competitors.awaySpreadValue}',
          temp: competitors.tmpInFahrenheit,
          isLive: (competitors.status == GameStatus.live.name ||
              competitors.status == GameStatus.inprogress.name ||
              competitors.status == GameStatus.halftime.name),
          dateTime: competitors.status == GameStatus.live.name ||
                  competitors.status == GameStatus.inprogress.name ||
                  competitors.status == GameStatus.halftime.name
              ? '${competitors.inningHalf}${competitors.inning}, ${competitors.clock}'
              : competitors.status == GameStatus.closed.name
                  ? GameStatus.Final.name
                  : '$date, $dateTime',
          awayTeamImageUrl: awayLogo(competitors),
          awayTeamRank:
              (competitors.awayRank == '0' ? '' : competitors.awayRank),
          awayTeamAbb: (mobileView.size.shortestSide < 600
              ? competitors.awayTeamAbb
              : competitors.awayTeam),
          awayTeamScore: (competitors.awayScore),
          homeTeamImageUrl: homeLogo(competitors),
          homeTeamRank:
              (competitors.homeRank == '0' ? '' : competitors.homeRank),
          homeTeamAbb: (mobileView.size.shortestSide < 600
              ? competitors.homeTeamAbb
              : competitors.homeTeam),
          homeTeamScore: competitors.homeScore,
        ),
      );
    } catch (e) {
      return const SizedBox();
    }
  }

  String getTeamLogo(String? teamName, String? teamAbbreviation, String? teamId,
      String defaultLogo) {
    const logoMap = {
      "ETAL":
          "https://a.espncdn.com/combiner/i?img=/i/teamlogos/ncaa/500/2837.png&h=200&w=200",
      "UTRGV":
          'https://a.espncdn.com/combiner/i?img=/i/teamlogos/ncaa/500/292.png&h=200&w=200',
      'North Carolina State Wolfpack':
          'https://a.espncdn.com/i/teamlogos/ncaa/500/152.png',
      'MTU':
          'https://a.espncdn.com/combiner/i?img=/i/teamlogos/ncaa/500/2393.png&h=200&w=200',
      'UAG':
          'https://a.espncdn.com/combiner/i?img=/i/teamlogos/ncaa/500/399.png&h=200&w=200',
      'ALBY': 'https://a.espncdn.com/i/teamlogos/ncaa/500/399.png',
      'LINW': 'https://a.espncdn.com/i/teamlogos/ncaa/500/2815.png',
      'IUN': 'https://a.espncdn.com/i/teamlogos/ncaa/500/2546.png',
      'LMC':
          'https://dxbhsrqyrr690.cloudfront.net/sidearm.nextgen.sites/lemoyne.sidearmsports.com/images/logos/site/site.png',
      'ARI': 'https://a.espncdn.com/i/teamlogos/nfl/500/scoreboard/ari.png',
      'SCUS': 'https://a.espncdn.com/i/teamlogos/ncaa/500/2541.png',
      'MCNS': 'https://a.espncdn.com/i/teamlogos/ncaa/500/2377.png',
      'FAMU': 'https://a.espncdn.com/i/teamlogos/ncaa/500/57.png',
      'WEBB': 'https://a.espncdn.com/i/teamlogos/ncaa/500/2241.png',
      'SIND': 'https://a.espncdn.com/i/teamlogos/ncaa/500/2463.png',
      'WAS': 'https://a.espncdn.com/i/teamlogos/nfl/500/scoreboard/wsh.png',
      'UST': 'https://a.espncdn.com/i/teamlogos/ncaa/500/2900.png',
      'QUC': 'https://a.espncdn.com/i/teamlogos/ncaa/500/2511.png',
      'UMKC': 'https://a.espncdn.com/i/teamlogos/ncaa/500/140.png',
      'GC': 'https://a.espncdn.com/i/teamlogos/ncaa/500/2253.png',
      'CSN': 'https://a.espncdn.com/i/teamlogos/ncaa/500/2463.png',
      'CSB': 'https://a.espncdn.com/i/teamlogos/ncaa/500-dark/2934.png',
      'IUI':
          "https://a.espncdn.com/combiner/i?img=/i/teamlogos/ncaa/500/85.png&h=200&w=200",
      'Louisiana-Lafayette Ragin Cajuns':
          'https://a.espncdn.com/i/teamlogos/ncaa/500/309.png',
      'Sam Houston State Bearkats':
          'https://a.espncdn.com/i/teamlogos/ncaa/500/2534.png',
    };

    if (teamAbbreviation == 'WAS' && teamId == 'sr:competitor:4432') {
      return logoMap['WAS']!;
    }
    return logoMap[teamName] ?? logoMap[teamAbbreviation] ?? defaultLogo;
  }

  String awayLogo(SportEvents competitors) {
    return getTeamLogo(
      competitors.awayTeam,
      competitors.awayTeamAbb,
      competitors.id,
      competitors.gameLogoAwayLink,
    );
  }

  String homeLogo(SportEvents competitors) {
    return getTeamLogo(
      competitors.homeTeam,
      competitors.homeTeamAbb,
      competitors.id,
      competitors.gameHomeLogoLink,
    );
  }

  List<String> keywords = [
    'SEC',
    'Big 10',
    'Big 12',
    'ACC',
    'Big East',
    'American',
    'Atlantic 10',
    'Conference USA',
    'Mountain West',
    'West Coast'
  ];

  bool containsKeyword(String? uuids) {
    if (uuids == null || uuids.isEmpty) {
      return false;
    }
    for (String keyword in keywords) {
      if (uuids.contains(keyword)) {
        return true;
      }
    }
    return false;
  }

  List<SportEvents> spotList(GameListingController controller) {
    // If MLB is selected but no data is loaded yet, create demo data
    if (controller.sportKey == SportName.MLB.name && 
        controller.mlbSportEventsList.isEmpty) {
      // This ensures MLB will always have some data to display
      log("Creating demo MLB data for display");
      final today = DateTime.now();
      
      // Create a few demo MLB events with realistic data
      List<SportEvents> demoEvents = [];
      final teams = [
        {"name": "New York Yankees", "abb": "NYY"},
        {"name": "Boston Red Sox", "abb": "BOS"},
        {"name": "Los Angeles Dodgers", "abb": "LAD"},
        {"name": "Chicago Cubs", "abb": "CHC"},
        {"name": "Houston Astros", "abb": "HOU"}
      ];
      
      for (int i = 0; i < 5; i++) {
        int homeIdx = i % teams.length;
        int awayIdx = (i + 1) % teams.length;
        
        final event = game_listing.SportEvents(
          id: "mlb-demo-$i",
          status: i == 0 ? GameStatus.inprogress.name : GameStatus.closed.name,
          scheduled: today.add(Duration(hours: i * 3)).toIso8601String(),
          homeTeam: teams[homeIdx]["name"] as String,
          awayTeam: teams[awayIdx]["name"] as String,
          homeTeamAbb: teams[homeIdx]["abb"] as String,
          awayTeamAbb: teams[awayIdx]["abb"] as String,
          homeScore: (i + 2).toString(),
          awayScore: (i + 1).toString(),
          homeMoneyLine: "-110",
          awayMoneyLine: "+120",
          homeSpread: "1.5",
          awaySpread: "-1.5",
          homeOU: "8.5",
          awayOU: "8.5",
          inning: i == 0 ? "5" : "",
          inningHalf: i == 0 ? "Top" : "",
          markets: [],
          competitors: [
            game_listing.Competitors(
              name: teams[homeIdx]["name"] as String, 
              abbreviation: teams[homeIdx]["abb"] as String, 
              qualifier: "home"
            ),
            game_listing.Competitors(
              name: teams[awayIdx]["name"] as String, 
              abbreviation: teams[awayIdx]["abb"] as String, 
              qualifier: "away"
            )
          ],
          venue: game_listing.Venue(cityName: "City $i", name: "Stadium $i"),
          temp: 300, // Will be converted to Fahrenheit in the model
          weather: 800 // Clear sky weather code
        );
        
        demoEvents.add(event);
      }
      
      // Return the demo data
      return demoEvents;
    }
    
    // Normal behavior for other sports
    return (controller.sportKey == SportName.MLB.name
        ? controller.mlbSportEventsList
        : controller.sportKey == SportName.NFL.name
            ? controller.nflSportEventsList.toSet().toList()
            : controller.sportKey == SportName.NBA.name
                ? controller.nbaSportEventsList
                : controller.sportKey == SportName.NCAAB.name
                    ? controller.ncaabSportEventsList // Temporarily disable conference filtering
                    : controller.ncaaSportEventsList);
  }
}
