
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hotlines/utils/extension.dart';

import '../../constant/app_strings.dart';
import '../../theme/app_color.dart';
import '../../utils/app_progress.dart';
import '../widgets/common_widget.dart';
import '../widgets/text_field_widget.dart';
import 'change_pass_con.dart';

// ignore: must_be_immutable
class ChangePassScreen extends StatelessWidget {
  ChangePassScreen({Key? key}) : super(key: key);
  ChangePassController changePassController = Get.put(ChangePassController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      body: Stack(
        children: [
          GetBuilder<ChangePassController>(builder: (controller) {
            return Column(
              children: [
                SafeArea(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                        splashFactory: NoSplash.splashFactory,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 28.h,
                          color: whiteColor,
                        )),
                  ),
                ).paddingSymmetric(horizontal: 20.h, vertical: 20.h),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          20.h.H(),
                          oldPassword.appCommonText(
                              color: whiteColor,
                              weight: FontWeight.w600,
                              size: 20.h,
                              align: TextAlign.start),
                          5.h.H(),
                          CommonTextField(
                              obscureText: controller.isOldPass,
                              controller: controller.oldPassController,
                              hintText: enterOldPassword,
                              keyboardType: TextInputType.text,
                              isPasswordField: true,
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  controller.isOldPass = !controller.isOldPass;
                                },
                                child: Icon(
                                    controller.isOldPass
                                        ? Icons.visibility_off_rounded
                                        : Icons.visibility,
                                    color:
                                        Theme.of(context).secondaryHeaderColor,
                                    size: 28.h),
                              )),
                          20.h.H(),
                          newPassword.appCommonText(
                              color: whiteColor,
                              weight: FontWeight.w600,
                              size: 20.h,
                              align: TextAlign.start),
                          5.h.H(),
                          CommonTextField(
                              obscureText: controller.isNewPass,
                              controller: controller.newPassController,
                              hintText: enterNewPassword,
                              isPasswordField: true,
                              keyboardType: TextInputType.text,
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    controller.isNewPass =
                                        !controller.isNewPass;
                                  },
                                  child: Icon(
                                      controller.isNewPass
                                          ? Icons.visibility_off_rounded
                                          : Icons.visibility,
                                      color: Theme.of(context)
                                          .secondaryHeaderColor,
                                      size: 28.h))),
                          20.h.H(),
                          confirmPassword.appCommonText(
                              color: whiteColor,
                              weight: FontWeight.w600,
                              size: 20.h,
                              align: TextAlign.start),
                          5.h.H(),
                          CommonTextField(
                              controller: controller.confPassController,
                              hintText: enterConfPassword,
                              obscureText: controller.isConPass,
                              isPasswordField: true,
                              keyboardType: TextInputType.text,
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    controller.isConPass =
                                        !controller.isConPass;
                                  },
                                  child: Icon(
                                      controller.isConPass
                                          ? Icons.visibility_off_rounded
                                          : Icons.visibility,
                                      color: Theme.of(context)
                                          .secondaryHeaderColor,
                                      size: 28.h))),
                          40.h.H(),
                          CommonAppButton(
                              onTap: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                controller.changePassResponse(context);
                              },
                              title: change)
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          }),
          Obx(() => changePassController.isLoading.value
              ? const AppProgress()
              : Container())
        ],
      ),
    );
  }
}
