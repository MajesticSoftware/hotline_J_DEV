// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hotlines/theme/app_color.dart';
import 'package:hotlines/utils/extension.dart';

import '../../../constant/app_strings.dart';
import '../../../generated/assets.dart';
import '../../../utils/app_progress.dart';
import '../../widgets/common_widget.dart';
import '../../widgets/text_field_widget.dart';
import '../log_in_module/log_in_screen.dart';
import 'forgot_pass_cntr.dart';

class ReSetPasswordScreen extends StatelessWidget {
  ReSetPasswordScreen({Key? key}) : super(key: key);
  final ForgotPassController forgotPassController =
      Get.put(ForgotPassController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.to(LogInScreen());
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        body: GetBuilder<ForgotPassController>(builder: (controller) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(19),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      20.H(),
                      GestureDetector(
                        onTap: () {
                          controller.confirmPassController.clear();
                          controller.newPassController.clear();
                          controller.emailController.clear();
                          Get.back();
                        },
                        child: SvgPicture.asset(
                          Assets.imagesBackArrow,
                          alignment: Alignment.center,
                          height: 28.h,
                          width: 28.h,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          50.h.H(),
                          verificationCodeText.appCommonText(
                              color: whiteColor,
                              size: 20.h,
                              weight: FontWeight.w400,
                              align: TextAlign.start),
                          5.h.H(),
                          CommonTextField(
                              controller: controller.verifyCodeController,
                              hintText: enterVerificationCodeText,
                              suffixIcon: const SizedBox()),
                          10.H(),
                          newPasswordText.appCommonText(
                              color: whiteColor,
                              weight: FontWeight.w400,
                              size: 20.h),
                          5.H(),
                          CommonTextField(
                            controller: controller.newPassController,
                            hintText: enterNewPasswordText,
                            isPasswordField: true,
                            obscureText: controller.newPass,
                            suffixIcon: InkWell(
                              onTap: () {
                                controller.newPass = !controller.newPass;
                              },
                              child: Icon(
                                  controller.newPass
                                      ? Icons.visibility_off_rounded
                                      : Icons.visibility,
                                  color: Theme.of(context).secondaryHeaderColor,
                                  size: 28.h),
                            ),
                          ),
                          10.H(),
                          confirmPassword.appCommonText(
                              color: whiteColor,
                              size: 20.h,
                              weight: FontWeight.w400,
                              align: TextAlign.start),
                          5.H(),
                          CommonTextField(
                            keyboardType: TextInputType.text,
                            controller: controller.confirmPassController,
                            hintText: enterConfPassword,
                            isPasswordField: true,
                            obscureText: controller.conPass,
                            suffixIcon: InkWell(
                              onTap: () {
                                controller.conPass = !controller.conPass;
                              },
                              child: Icon(
                                  controller.conPass
                                      ? Icons.visibility_off_rounded
                                      : Icons.visibility,
                                  color: Theme.of(context).secondaryHeaderColor,
                                  size: 28.h),
                            ),
                          ),
                          30.H(),
                          CommonAppButton(
                              onTap: () async {
                                FocusManager.instance.primaryFocus?.unfocus();
                                controller.resetPassResponse(context);
                              },
                              title: resetPasswordText),
                          25.H(),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    controller.reSendResponse(context);
                                  },
                                  child: resentCodeText.appCommonText(
                                      size: 16,
                                      weight: FontWeight.bold,
                                      color: whiteColor,
                                      decoration: TextDecoration.underline),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Obx(() => forgotPassController.isLoading.value
                  ? const AppProgress()
                  : Container())
            ],
          );
        }),
      ),
    );
  }
}
