import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hotlines/constant/shred_preference.dart';
import 'package:hotlines/model/user_model.dart';
import 'package:hotlines/theme/helper.dart';
import 'package:hotlines/utils/extension.dart';

import '../../../constant/app_strings.dart';
import '../../../model/response_item.dart';
import '../../../network/auth_repo.dart';
import '../../sports/gameListing/game_listing_screen.dart';

class LogInController extends GetxController {
  TextEditingController emailCon = TextEditingController();
  TextEditingController passCon = TextEditingController();
  RxBool isLoading = false.obs;
  login() async {
    if (emailCon.text.isEmpty) {
      showAppSnackBar('Please enter email');
    } else if (!emailCon.text.isValidEmail()) {
      showAppSnackBar('Please enter valid email');
    } else if (passCon.text.isEmpty) {
      showAppSnackBar('Please enter password');
    } else if (passCon.text.length < 6) {
      showAppSnackBar('Password must be at least six character');
    } else {
      isLoading.value = true;
      ResponseItem result =
          ResponseItem(data: null, message: errorText.tr, status: false);
      result = await UserStartupRepo().userLogin(
        email: emailCon.text.trim().toString(),
        password: passCon.text.trim().toString(),
      );
      try {
        isLoading.value = true;
        if (result.status) {
          if (result.data != null) {
            UserModel response = UserModel.fromJson(result.toJson());
            if (response.data != null) {
              PreferenceManager.setUserData(response.data!);
              PreferenceManager.setIsLogin(true);
              Get.offAll(SelectGameScreen());
              emailCon.clear();
              passCon.clear();
            }
          }
        } else {
          isLoading.value = false;
          showAppSnackBar(result.message);
        }
      } catch (e) {
        isLoading.value = false;
        showAppSnackBar(errorText);
      }
      isLoading.value = false;
      update();
    }
  }
}
