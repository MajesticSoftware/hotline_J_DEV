import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hotlines/extras/constants.dart';
import 'package:hotlines/theme/app_color.dart';
import 'package:hotlines/utils/extension.dart';
import 'package:hotlines/view/profile_module/profile_controller.dart';

import '../../extras/request_constants.dart';
import '../../generated/assets.dart';
import '../../theme/helper.dart';
import '../../utils/app_progress.dart';
import '../../utils/file_picker_utils.dart';
import '../widgets/common_widget.dart';
import '../widgets/text_field_widget.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  final ProfileController profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      /*appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.arrow_back_ios, size: 28.h)),
        title:
            'Profile'.appCommonText(color: whiteColor, weight: FontWeight.w700),
      ),*/
      body: Stack(
        children: [
          GetBuilder<ProfileController>(builder: (ctrl) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SafeArea(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
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
                  40.h.H(),
                  SvgPicture.asset(
                    Assets.imagesLogo,
                    fit: BoxFit.contain,
                  ).paddingSymmetric(horizontal: 130.h),
                  (mobileView.size.shortestSide < 600 ? 20 : 50).h.H(),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ctrl.imageFile == null && ctrl.profileImage.isEmpty
                          ? Container(
                              height: MediaQuery.of(context).size.height * .15,
                              width: MediaQuery.of(context).size.height * .15,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Theme.of(context)
                                          .secondaryHeaderColor),
                                  image: const DecorationImage(
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
                                              .15,
                                      width:
                                          MediaQuery.of(context).size.height *
                                              .15),
                                )
                              : IgnorePointer(
                                  ignoring: false,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .15,
                                        width:
                                            MediaQuery.of(context).size.height *
                                                .15,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Theme.of(context)
                                                  .secondaryHeaderColor),
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
                                                    .15,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .15,
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
                          bottom: -10.w,
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
                  60.h.H(),
                  CommonTextField(
                    controller: ctrl.nameCon,
                    hintText: 'Name',
                  ).paddingSymmetric(
                      horizontal: MediaQuery.of(context).size.height * .06),
                  25.w.H(),
                  CommonTextField(
                    readOnly: true,
                    controller: ctrl.emailCon,
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
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
                  CommonAppButton(
                    title: 'Update Profile',
                    radius: 100,
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      ctrl.updateUserProfile();
                    },
                  ).paddingSymmetric(
                      horizontal: MediaQuery.of(context).size.height * .06),
                  10.h.H(),
                ],
              ),
            );
          }),
          Obx(
            () => profileController.isLoading.value
                ? const AppProgress()
                : const SizedBox(),
          )
        ],
      ),
    );
  }
}
