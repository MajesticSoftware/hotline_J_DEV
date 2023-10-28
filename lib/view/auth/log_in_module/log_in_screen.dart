import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hotlines/utils/extension.dart';
import 'package:hotlines/view/auth/register_module/register_screen.dart';

import '../../../generated/assets.dart';
import '../../../theme/app_color.dart';
import '../../widgets/common_widget.dart';
import '../../widgets/text_field_widget.dart';
import 'log_in_controller.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({Key? key}) : super(key: key);
  final LogInController logInController = Get.put(LogInController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      body: GetBuilder<LogInController>(builder: (ctrl) {
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
                obscureText: true,
                controller: ctrl.passCon,
                hintText: 'Password',
              ).paddingSymmetric(
                  horizontal: MediaQuery.of(context).size.height * .07),
              50.h.H(),
              CommonAppButton(
                title: 'LogIn',
                radius: 5,
                onTap: () {
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
              70.h.H(),
              CommonAppButton(
                title: Platform.isIOS
                    ? ' Sign in with Apple'
                    : 'Sign in with Google',
                textColor: whiteColor,
                buttonColor: Colors.black,
                icon: Icon(Platform.isIOS ? Icons.apple : Icons.g_mobiledata,
                    color: whiteColor,
                    size: Platform.isIOS
                        ? MediaQuery.of(context).size.height * .025
                        : MediaQuery.of(context).size.height * .04),
                radius: 100.r,
                onTap: () {},
              ).paddingSymmetric(
                  horizontal: MediaQuery.of(context).size.height * .07),
            ],
          ),
        );
      }),
    );
  }
}
