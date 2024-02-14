import 'dart:developer';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hotlines/theme/app_color.dart';
import 'package:hotlines/theme/helper.dart';
import 'package:hotlines/utils/app_progress.dart';
import 'package:hotlines/utils/extension.dart';
import 'package:hotlines/utils/layouts.dart';
import 'package:hotlines/view/auth/log_in_module/log_in_controller.dart';
import 'package:hotlines/view/auth/log_in_module/log_in_screen.dart';
import 'package:hotlines/view/auth/register_module/register_controller.dart';
import 'package:hotlines/view/term_of_service/privacy_policy.dart';
import 'package:hotlines/view/term_of_service/term_service_screen.dart';

import '../../../constant/shred_preference.dart';
import '../../../extras/request_constants.dart';
import '../../../generated/assets.dart';
import '../../../utils/file_picker_utils.dart';
import '../../main/app_starting_screen.dart';
import '../../widgets/common_widget.dart';
import '../../widgets/text_field_widget.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  final RegisterCon registerCon = Get.put(RegisterCon());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      body: Stack(
        children: [
          SafeArea(
            child: GetBuilder<RegisterCon>(builder: (ctrl) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      Assets.imagesLogo,
                      fit: BoxFit.contain,
                    ).paddingSymmetric(
                        horizontal: MediaQuery.of(context).size.height * .13),
                    10.h.H(),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ctrl.imageFile == null && ctrl.profileImage.isEmpty
                            ? Container(
                                height:
                                    MediaQuery.of(context).size.height * .13,
                                width: MediaQuery.of(context).size.height * .13,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image:
                                            AssetImage(Assets.imagesConatctPro),
                                        fit: BoxFit.fill)))
                            : ctrl.imageFile == null
                                ? IgnorePointer(
                                    ignoring: false,
                                    child: commonCachedNetworkImage(
                                        imageUrl:
                                            '${AppUrls.imageUrl}${ctrl.profileImage}',
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .13,
                                        width:
                                            MediaQuery.of(context).size.height *
                                                .13),
                                  )
                                : IgnorePointer(
                                    ignoring: false,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .13,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .13,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.file(
                                            ctrl.imageFile!,
                                            fit: BoxFit.fill,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      .13,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      .13,
                                                  decoration: const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          image: AssetImage(Assets
                                                              .imagesConatctPro),
                                                          fit: BoxFit.fill)));
                                            },
                                          )),
                                    ),
                                  ),
                        Positioned(
                            bottom: -15.w,
                            right: 0,
                            child: AbsorbPointer(
                              absorbing: false,
                              child: GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    PickFile().openImageChooser(
                                        context: context,
                                        onImageChose: (File? newFile) {
                                          if (newFile != null) {
                                            ctrl.addImage(newFile);
                                          }
                                        });
                                  },
                                  child: SvgPicture.asset(
                                    Assets.imagesCamera,
                                    height: MediaQuery.of(context).size.height *
                                        .05,
                                    width: MediaQuery.of(context).size.height *
                                        .05,
                                  )),
                            ))
                      ],
                    ),
                    40.h.H(),
                    CommonTextField(
                      controller: ctrl.nameCon,
                      hintText: 'Name',
                    ).paddingSymmetric(horizontal: 60.h),
                    25.w.H(),
                    CommonTextField(
                      controller: ctrl.emailCon,
                      hintText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                    ).paddingSymmetric(horizontal: 60.h),
                    25.w.H(),
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
                    ).paddingSymmetric(horizontal: 60.h),
                    25.w.H(),
                    DropdownButtonHideUnderline(
                      child: Container(
                        height: MediaQuery.of(context).size.height * .05,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: whiteColor),
                        child: DropdownButton<String>(
                          dropdownColor: whiteColor,
                          isExpanded: true,
                          borderRadius: BorderRadius.circular(5),
                          iconDisabledColor:
                              Theme.of(context).secondaryHeaderColor,
                          iconEnabledColor:
                              Theme.of(context).secondaryHeaderColor,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          hint: (ctrl.selectedSpot.isEmpty
                                  ? 'Favorite Sports'
                                  : ctrl.selectedSpot)
                              .appCommonText(
                                  color: Theme.of(context).secondaryHeaderColor,
                                  weight: ctrl.selectedSpot.isEmpty
                                      ? FontWeight.w500
                                      : FontWeight.w700,
                                  size: MediaQuery.of(context).size.height *
                                      .018),
                          items: ctrl.spotsList.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: value.appCommonText(
                                  color: Theme.of(context).secondaryHeaderColor,
                                  size:
                                      MediaQuery.of(context).size.height * .018,
                                  weight: FontWeight.w800),
                            );
                          }).toList(),
                          onChanged: (value) {
                            ctrl.selectedSpot = value!;
                            log('ctrl.selectedSpot---${ctrl.selectedSpot}');
                            PreferenceManager.setFavoriteSport(/*value*/"NBA");
                            ctrl.update();
                          },
                        ),
                      ),
                    ).paddingSymmetric(horizontal: 60.h),
                    50.h.H(),
                    Row(
                      children: [
                        SizedBox(
                          width: 20.h,
                          height: 20.h,
                          child: Transform.scale(
                            scale: 1.3.h,
                            child: Checkbox(
                              hoverColor: whiteColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                              side: MaterialStateBorderSide.resolveWith(
                                    (states) => const BorderSide(width: 1.0, color: whiteColor),
                              ),
                              checkColor:
                                  Theme.of(context).secondaryHeaderColor,
                              activeColor: whiteColor,
                              onChanged: (value) {
                                ctrl.isCheck = !ctrl.isCheck;
                                ctrl.update();
                              },
                              value: ctrl.isCheck,
                            ),
                          ),
                        ),
                        15.0.h.W(),
                        Expanded(
                            child: Text.rich(
                          TextSpan(children: [
                            TextSpan(
                              text: 'By registering, I agree to the ',
                              style: TextStyle(
                                  color: whiteColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize:
                                      MediaQuery.of(context).size.height * .02),
                            ),
                            TextSpan(
                              text: 'privacy policy ',
                              style: TextStyle(
                                  color: whiteColor,
                                  fontWeight: FontWeight.w800,
                                  fontSize:
                                      MediaQuery.of(context).size.height * .02,
                                  decoration: TextDecoration.underline,decorationColor: whiteColor),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.to(const PrivacyPolicyScreen());
                                },
                            ),
                            TextSpan(
                              text: 'and ',
                              style: TextStyle(
                                  color: whiteColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize:
                                      MediaQuery.of(context).size.height * .02),
                            ),
                            TextSpan(
                                text: 'terms of service.',
                                style: TextStyle(
                                    color: whiteColor,
                                    fontWeight: FontWeight.w800,decorationColor: whiteColor,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            .02,
                                    decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.to(const TermOfServiceScreen());
                                  }),
                          ]),

                          // overflow: TextOverflow.ellipsis,
                        )),
                      ],
                    ).paddingSymmetric(horizontal: 60.h),
                    20.h.H(),
                    CommonAppButton(
                      title: 'Register',
                      radius: 5,
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        ctrl.registration();
                      },
                    ).paddingSymmetric(horizontal: 60.h),
                    10.h.H(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        'Already have an account?  '.appCommonText(
                            color: whiteColor,
                            weight: FontWeight.w500,
                            size: MediaQuery.of(context).size.height * .02),
                        GestureDetector(
                          onTap: () {
                            Get.to(LogInScreen());
                          },
                          child: 'Login'.appCommonText(
                              color: whiteColor,
                              weight: FontWeight.w800,
                              size: MediaQuery.of(context).size.height * .02,
                              ),
                        ),
                      ],
                    ),
                    50.h.H(),
                    CommonAppButton(
                      title: Platform.isIOS
                          ? ' Sign in with Apple'
                          : '  Sign in with Google',
                      textColor: whiteColor,
                      buttonColor: Colors.black,
                      icon: Platform.isIOS
                          ? Icon(Icons.apple,
                              color: whiteColor,
                              size: MediaQuery.of(context).size.height * .025)
                          : SvgPicture.asset(Assets.imagesGoogleIcon,
                              color: whiteColor),
                      radius: 100.r,
                      onTap: () {
                        Platform.isIOS
                            ? Get.find<LogInController>().appleLogin()
                            : Get.find<LogInController>().googleSignIn();
                      },
                    ).paddingSymmetric(horizontal: 60.h),
                    20.h.H(),
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
                        horizontal: MediaQuery.of(context).size.height * .07),
                    20.h.H(),
                    GestureDetector(
                      onTap: () {
                        Get.to(const AppStartScreen());
                        PreferenceManager.setSubscriptionRecUrl("");
                      },
                      child: 'Skip for now'.appCommonText(
                          color: whiteColor,
                          weight: FontWeight.w800,
                          size: MediaQuery.of(context).size.height * .02,
                          decoration: TextDecoration.underline),
                    ),
                    50.h.H(),
                  ],
                ),
              );
            }),
          ),
          Obx(
                () => registerCon.isLoading.value
                ? const AppProgress()
                : const SizedBox(),
          )
        ],
      ),
    );
  }
}
