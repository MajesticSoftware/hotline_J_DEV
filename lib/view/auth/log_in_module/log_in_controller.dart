import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hotlines/constant/shred_preference.dart';
import 'package:hotlines/theme/helper.dart';
import 'package:hotlines/utils/extension.dart';

import '../../sports/gameListing/game_listing_screen.dart';

class LogInController extends GetxController {
  TextEditingController emailCon = TextEditingController();
  TextEditingController passCon = TextEditingController();

  login() {
    if (emailCon.text.isEmpty) {
      showAppSnackBar('Please enter email');
    } else if (!emailCon.text.isValidEmail()) {
      showAppSnackBar('Please enter valid email');
    } else if (passCon.text.isEmpty) {
      showAppSnackBar('Please enter password');
    } else if (passCon.text.length < 6) {
      showAppSnackBar('Password must be at least six character');
    } else {
      PreferenceManager.setIsLogin(true);
      Get.to(SelectGameScreen());
    }
  }
}
