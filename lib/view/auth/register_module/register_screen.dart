import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hotlines/theme/app_color.dart';
import 'package:hotlines/theme/helper.dart';
import 'package:hotlines/utils/app_progress.dart';
import 'package:hotlines/utils/extension.dart';
import 'package:hotlines/utils/layouts.dart';
import 'package:hotlines/view/auth/log_in_module/log_in_screen.dart';
import 'package:hotlines/view/auth/register_module/register_controller.dart';

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
          GetBuilder<RegisterCon>(builder: (ctrl) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  60.h.H(),
                  SvgPicture.asset(
                    Assets.imagesLogo,
                    fit: BoxFit.contain,
                  ).paddingSymmetric(
                      horizontal: MediaQuery.of(context).size.height * .13),
                  20.h.H(),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ctrl.imageFile == null && ctrl.profileImage.isEmpty
                          ? Container(
                              height: MediaQuery.of(context).size.height * .13,
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
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .13,
                                        width:
                                            MediaQuery.of(context).size.height *
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
                                  height:
                                      MediaQuery.of(context).size.height * .05,
                                  width:
                                      MediaQuery.of(context).size.height * .05,
                                )),
                          ))
                    ],
                  ),
                  40.h.H(),
                  CommonTextField(
                    controller: ctrl.nameCon,
                    hintText: 'Name',
                  ).paddingSymmetric(
                      horizontal: MediaQuery.of(context).size.height * .06),
                  25.w.H(),
                  CommonTextField(
                    controller: ctrl.emailCon,
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                  ).paddingSymmetric(
                      horizontal: MediaQuery.of(context).size.height * .06),
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
                  ).paddingSymmetric(
                      horizontal: MediaQuery.of(context).size.height * .06),
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
                        iconDisabledColor: appColor,
                        iconEnabledColor: appColor,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        hint: (ctrl.selectedSpot.isEmpty
                                ? 'Favorite Spots'
                                : ctrl.selectedSpot)
                            .appCommonText(
                                color: appColor,
                                weight: ctrl.selectedSpot.isEmpty
                                    ? FontWeight.w500
                                    : FontWeight.w700,
                                size:
                                    MediaQuery.of(context).size.height * .018),
                        items: ctrl.spotsList.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: value.appCommonText(
                                color: appColor,
                                size: MediaQuery.of(context).size.height * .018,
                                weight: FontWeight.w800),
                          );
                        }).toList(),
                        onChanged: (value) {
                          ctrl.selectedSpot = value!;
                          ctrl.update();
                        },
                      ),
                    ),
                  ).paddingSymmetric(
                      horizontal: MediaQuery.of(context).size.height * .06),
                  50.h.H(),
                  Row(
                    children: [
                      SizedBox(
                        width: 20.h,
                        height: 20.h,
                        child: Checkbox(
                          hoverColor: whiteColor,
                          checkColor: Theme.of(context).secondaryHeaderColor,
                          activeColor: whiteColor,
                          onChanged: (value) {
                            ctrl.isCheck = !ctrl.isCheck;
                            ctrl.update();
                          },
                          value: ctrl.isCheck,
                        ),
                      ),
                      20.0.h.W(),
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
                                decoration: TextDecoration.underline),
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
                                fontWeight: FontWeight.w800,
                                fontSize:
                                    MediaQuery.of(context).size.height * .02,
                                decoration: TextDecoration.underline),
                          ),
                        ]),
                        maxLines: 2,
                        // overflow: TextOverflow.ellipsis,
                      )),
                    ],
                  ).paddingSymmetric(
                      horizontal: MediaQuery.of(context).size.height * .06),
                  20.h.H(),
                  CommonAppButton(
                    title: 'Register',
                    radius: 5,
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      ctrl.registration();
                    },
                  ).paddingSymmetric(
                      horizontal: MediaQuery.of(context).size.height * .06),
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
                      onTap: () {},
                    ).paddingSymmetric(
                        horizontal: MediaQuery.of(context).size.height * .06),
                  ),
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
            () => registerCon.isLoading.value
                ? const AppProgress()
                : const SizedBox(),
          )
        ],
      ),
    );
  }
}
