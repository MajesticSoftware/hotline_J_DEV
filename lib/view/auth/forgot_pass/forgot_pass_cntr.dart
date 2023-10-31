import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hotlines/utils/extension.dart';
import 'package:hotlines/view/auth/forgot_pass/reset_password_screen.dart';
import 'package:hotlines/view/auth/log_in_module/log_in_screen.dart';

import '../../../constant/app_strings.dart';
import '../../../constant/shred_preference.dart';
import '../../../model/forgot_pass_model.dart';
import '../../../model/reset_pass_model.dart';
import '../../../model/response_item.dart';
import '../../../network/auth_repo.dart';
import '../../../theme/helper.dart';

class ForgotPassController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController verifyCodeController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  RxBool isLoading = false.obs;
  void forgotPassResponse(BuildContext context) async {
    if (emailController.text == '' || emailController.text.isEmpty) {
      showAppSnackBar('Email must be required!');
    } else if (!emailController.text.isValidEmail()) {
      showAppSnackBar('Please enter valid email!');
    } else {
      isLoading.value = true;
      ResponseItem result =
          ResponseItem(data: null, message: errorText.tr, status: false);
      result = await UserStartupRepo()
          .forgotPassword(email: emailController.text.trim().toString());
      try {
        if (result.status) {
          log('result.data===${result.status}');
          ForgotPasswordResModel response =
              ForgotPasswordResModel.fromJson(result.toJson());
          PreferenceManager.setUserEmail(emailController.text);
          Get.to(ReSetPasswordScreen());
          emailController.clear();
          showAppSnackBar(response.msg, status: true);
          isLoading.value = false;
        } else {
          isLoading.value = false;
          showAppSnackBar(result.message);
        }
      } catch (e) {
        showAppSnackBar(errorText);
      }

      update();
    }
  }

  void reSendResponse(BuildContext context) async {
    isLoading.value = true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await UserStartupRepo()
        .forgotPassword(email: PreferenceManager.getUserEmail());
    try {
      if (result.status) {
        log('result.data===${result.status}');
        ForgotPasswordResModel response =
            ForgotPasswordResModel.fromJson(result.toJson());
        showAppSnackBar(response.msg, status: true);
        isLoading.value = false;
      } else {
        isLoading.value = false;
        showAppSnackBar(result.message);
      }
    } catch (e) {
      showAppSnackBar(errorText);

      update();
    }
  }

  void resetPassResponse(BuildContext context) async {
    if (verifyCodeController.text == '' || verifyCodeController.text.isEmpty) {
      showAppSnackBar('Verification code must be required!');
    } else if (newPassController.text == '' || newPassController.text.isEmpty) {
      showAppSnackBar('New Password must be required!');
    } else if (confirmPassController.text == '' ||
        confirmPassController.text.isEmpty) {
      showAppSnackBar('Confirm Password must be required!');
    } else if (confirmPassController.text != newPassController.text) {
      showAppSnackBar('ConfirmPassword and Password must be same!');
    } else {
      isLoading.value = true;
      ResponseItem result =
          ResponseItem(data: null, message: errorText.tr, status: false);
      result = await UserStartupRepo().resetPassword(
          email: PreferenceManager.getUserEmail().toString(),
          code: verifyCodeController.text.trim().toString(),
          password: newPassController.text.trim().toString());
      try {
        if (result.status) {
          log('result.data===${result.status}');
          ResetPasswordResModel response =
              ResetPasswordResModel.fromJson(result.toJson());
          Get.to(LogInScreen());
          showAppSnackBar(response.msg, status: true);
          confirmPassController.clear();
          verifyCodeController.clear();
          newPassController.clear();
          isLoading.value = false;
        } else {
          isLoading.value = false;
          showAppSnackBar(result.message);
        }
      } catch (e) {
        isLoading.value = false;
        showAppSnackBar(errorText);
      }

      update();
    }
  }

  bool _newPass = true;

  bool get newPass => _newPass;

  set newPass(bool value) {
    _newPass = value;
    update();
  }

  bool _conPass = true;

  bool get conPass => _conPass;

  set conPass(bool value) {
    _conPass = value;
    update();
  }
}
