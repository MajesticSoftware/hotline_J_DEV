import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hotlines/utils/extension.dart';

import '../../../generated/assets.dart';
import '../../../theme/app_color.dart';
import '../../../utils/app_progress.dart';
import '../../widgets/common_widget.dart';
import '../../widgets/text_field_widget.dart';
import '../log_in_module/log_in_screen.dart';
import 'forgot_pass_cntr.dart';

// ignore: must_be_immutable
class ForgotPassScreen extends StatelessWidget {
  ForgotPassScreen({Key? key}) : super(key: key);
  ForgotPassController forgotPassController = Get.put(ForgotPassController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(19),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: GetBuilder<ForgotPassController>(builder: (controller) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    20.h.H(),
                    GestureDetector(
                      onTap: () {
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
                        30.h.H(),
                        SvgPicture.asset(
                          Assets.imagesLogo,
                          fit: BoxFit.contain,
                        ).paddingSymmetric(
                            horizontal:
                                MediaQuery.of(context).size.height * .07),
                        30.h.H(),
                        'Email'.appCommonText(
                            color: whiteColor,
                            weight: FontWeight.w400,
                            size: 20.h,
                            align: TextAlign.start),
                        10.h.H(),
                        CommonTextField(
                            controller: controller.emailController,
                            hintText: 'Enter Email ',
                            keyboardType: TextInputType.emailAddress,
                            suffixIcon: const SizedBox()),
                        30.h.H(),
                        CommonAppButton(
                            onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              controller.forgotPassResponse(context);
                            },
                            radius: 15.r,
                            title: 'Request'),
                        30.h.H(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            'Remember Password?  '.appCommonText(
                                size: 25.h,
                                weight: FontWeight.w500,
                                color: whiteColor),
                            GestureDetector(
                              onTap: () {
                                Get.to(LogInScreen());
                              },
                              child: 'Login'.appCommonText(
                                  size: 20.h,
                                  weight: FontWeight.w700,
                                  color: whiteColor,
                                  decoration: TextDecoration.underline),
                            )
                          ],
                        ),
                      ],
                    ).paddingSymmetric(
                        horizontal: MediaQuery.of(context).size.height * .05),
                  ],
                );
              }),
            ),
          ),
          Obx(() => forgotPassController.isLoading.value
              ? const AppProgress()
              : Container())
        ],
      ),
    );
  }
}
