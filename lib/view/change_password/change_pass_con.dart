import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../constant/app_strings.dart';
import '../../constant/shred_preference.dart';
import '../../model/change_pass_model.dart';
import '../../model/response_item.dart';
import '../../network/auth_repo.dart';
import '../../theme/helper.dart';

class ChangePassController extends GetxController {
  TextEditingController oldPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController confPassController = TextEditingController();
  RxBool isLoading = false.obs;

  void changePassResponse(BuildContext context) async {
    if (oldPassController.text == '' || oldPassController.text.isEmpty) {
      showAppSnackBar('Old password must be required!');
    } else if (newPassController.text == '' || newPassController.text.isEmpty) {
      showAppSnackBar('Please enter new Password!');
    } else if (confPassController.text == '' ||
        confPassController.text.isEmpty) {
      showAppSnackBar('Please enter confirm Password!');
    } else if (newPassController.text != confPassController.text) {
      showAppSnackBar('New Password and Confirm Password must be same!');
    } else {
      isLoading.value = true;
      ResponseItem result =
          ResponseItem(data: null, message: errorText.tr, status: false);
      result = await UserStartupRepo().changePassword(
        oldPassController.text.trim().toString(),
        newPassController.text.trim().toString(),
      );
      try {
        if (result.status) {
          log('RESPONSE--${result.refreshToken}');
          ChangePassResModel response =
              ChangePassResModel.fromJson(result.toJson());
          Get.back();
          showAppSnackBar(response.msg, status: true);
          PreferenceManager.setAuthToken(response.newToken);
          oldPassController.clear();
          newPassController.clear();
          confPassController.clear();
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

  bool _isOldPass = true;

  bool get isOldPass => _isOldPass;

  set isOldPass(bool value) {
    _isOldPass = value;
    update();
  }

  bool _isNewPass = true;

  bool get isNewPass => _isNewPass;

  set isNewPass(bool value) {
    _isNewPass = value;
    update();
  }

  bool _isConPass = true;

  bool get isConPass => _isConPass;

  set isConPass(bool value) {
    _isConPass = value;
    update();
  }
}
