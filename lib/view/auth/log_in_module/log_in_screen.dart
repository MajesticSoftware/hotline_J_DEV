import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hotlines/constant/shred_preference.dart';
import 'package:hotlines/utils/extension.dart';
import 'package:hotlines/view/auth/register_module/register_screen.dart';
import 'package:hotlines/view/sports/gameListing/game_listing_screen.dart';

import '../../../generated/assets.dart';
import '../../../theme/app_color.dart';
import '../../../utils/app_progress.dart';
import '../../../utils/layouts.dart';
import '../../main/app_starting_screen.dart';
import '../../widgets/common_widget.dart';
import '../../widgets/text_field_widget.dart';
import '../forgot_pass/forgot_pass_screen.dart';
import 'log_in_controller.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({Key? key}) : super(key: key);
  final LogInController logInController = Get.put(LogInController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      body: Stack(
        children: [
          GetBuilder<LogInController>(builder: (ctrl) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  150.h.H(),
                  SvgPicture.asset(
                    Assets.imagesAppLogo,
                    fit: BoxFit.contain,
                  ).paddingSymmetric(
                      horizontal: MediaQuery.of(context).size.height * .05),
                  60.h.H(),
                  CommonTextField(
                    controller: ctrl.emailCon,
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                  ).paddingSymmetric(
                      horizontal: MediaQuery.of(context).size.height * .07),
                  25.h.H(),
                  CommonTextField(
                    obscureText: ctrl.isShowPass,
                    isPasswordField: true,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        ctrl.isShowPass = !ctrl.isShowPass;
                        ctrl.update();
                      },
                      child: Icon(
                          ctrl.isShowPass
                              ? Icons.visibility_off_rounded
                              : Icons.visibility,
                          color: Theme.of(context).secondaryHeaderColor,
                          size: 28.h),
                    ),
                    controller: ctrl.passCon,
                    hintText: 'Password',
                  ).paddingSymmetric(
                      horizontal: MediaQuery.of(context).size.height * .07),
                  10.h.H(),
                  InkWell(
                    onTap: () {
                      Get.to(ForgotPassScreen());
                    },
                    splashColor: Colors.transparent,
                    splashFactory: NoSplash.splashFactory,
                    highlightColor: Colors.transparent,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: 'Forgot Password?'.appCommonText(
                          align: TextAlign.end,
                          color: whiteColor,
                          weight: FontWeight.w700,
                          size: 18.h),
                    ).paddingSymmetric(
                        horizontal: MediaQuery.of(context).size.height * .07),
                  ),
                  100.h.H(),
                  CommonAppButton(
                    title: 'Login',
                    radius: 5,
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      ctrl.login();
                    },
                  ).paddingSymmetric(
                      horizontal: MediaQuery.of(context).size.height * .07),
                  10.h.H(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      "Don't have an account?  ".appCommonText(
                          color: whiteColor,
                          weight: FontWeight.w500,
                          size: MediaQuery.of(context).size.height * .02),
                      GestureDetector(
                        onTap: () {
                          Get.to(RegisterScreen());
                        },
                        child: 'Register'.appCommonText(
                            color: whiteColor,
                            weight: FontWeight.w800,
                            size: MediaQuery.of(context).size.height * .02,
                            decoration: TextDecoration.underline),
                      ),
                    ],
                  ),
                  (Platform.isIOS ? 70 : 0).h.H(),
                  Visibility(
                    visible: Platform.isIOS,
                    child: CommonAppButton(
                      title: Platform.isIOS
                          ? ' Sign in with Apple'
                          : 'Sign in with Google',
                      textColor: whiteColor,
                      buttonColor: Colors.black,
                      icon: Icon(
                          Platform.isIOS ? Icons.apple : Icons.g_mobiledata,
                          color: whiteColor,
                          size: Platform.isIOS
                              ? MediaQuery.of(context).size.height * .025
                              : MediaQuery.of(context).size.height * .04),
                      radius: 100.r,
                      onTap: () {
                        ctrl.appleLogin();
                      },
                    ).paddingSymmetric(
                        horizontal: MediaQuery.of(context).size.height * .07),
                  ),
                  40.h.H(),
                  Row(
                    children: [
                      Expanded(child: commonDivider(context)),
                      15.h.W(),
                      'or'.appCommonText(
                        color: whiteColor,
                        weight: FontWeight.w800,
                        size: MediaQuery.of(context).size.height * .02,
                      ),
                      15.h.W(),
                      Expanded(child: commonDivider(context)),
                    ],
                  ).paddingSymmetric(
                      horizontal: MediaQuery.of(context).size.height * .06),
                  40.h.H(),
                  GestureDetector(
                    onTap: () {
                      PreferenceManager.setSkipLogin(true);
                      PreferenceManager.getIsFirstLoaded() == null
                          ? Get.offAll(const AppStartScreen())
                          : Get.offAll(SelectGameScreen());
                    },
                    child: 'Skip for now'.appCommonText(
                        color: whiteColor,
                        weight: FontWeight.w800,
                        size: MediaQuery.of(context).size.height * .02,
                        decoration: TextDecoration.underline),
                  ),
                ],
              ),
            );
          }),
          Obx(
            () => logInController.isLoading.value
                ? const AppProgress()
                : const SizedBox(),
          )
        ],
      ),
    );
  }
}
