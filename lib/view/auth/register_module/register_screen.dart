import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hotlines/utils/extension.dart';
import 'package:hotlines/view/auth/register_module/register_controller.dart';

import '../../../generated/assets.dart';
import '../../widgets/common_widget.dart';
import '../../widgets/text_field_widget.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  final RegisterCon registerCon = Get.put(RegisterCon());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      body: GetBuilder<RegisterCon>(builder: (ctrl) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.imagesAppLogo,
              height: 200.h,
              width: 200.h,
              fit: BoxFit.contain,
            ).paddingSymmetric(horizontal: 50.h),
            100.h.H(),
            CommonTextField(
              controller: ctrl.emailCon,
              hintText: 'Email',
            ).paddingSymmetric(horizontal: 100.h),
            20.w.H(),
            CommonTextField(
              controller: ctrl.passCon,
              hintText: 'Password',
            ).paddingSymmetric(horizontal: 100.h),
            30.w.H(),
            CommonAppButton(
              title: 'Register',
              onTap: () {},
            ).paddingSymmetric(horizontal: 100.h)
          ],
        );
      }),
    );
  }
}
