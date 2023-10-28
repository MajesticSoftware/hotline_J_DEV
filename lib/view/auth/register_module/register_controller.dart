import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hotlines/utils/extension.dart';

import '../../../theme/helper.dart';
import '../../sports/gameListing/game_listing_screen.dart';

class RegisterCon extends GetxController {
  TextEditingController emailCon = TextEditingController();
  TextEditingController nameCon = TextEditingController();
  TextEditingController passCon = TextEditingController();
  List<String> spotsList = ['NFL', 'NCAAF', 'MLB'];
  String selectedSpot = '';
  register() {
    if (nameCon.text.isEmpty) {
      showAppSnackBar('Please enter name');
    } else if (emailCon.text.isEmpty) {
      showAppSnackBar('Please enter email');
    } else if (!emailCon.text.isValidEmail()) {
      showAppSnackBar('Please enter valid email');
    } else if (passCon.text.isEmpty) {
      showAppSnackBar('Please enter password');
    } else if (passCon.text.length < 6) {
      showAppSnackBar('Password must be at least six character');
    } else if (selectedSpot.isEmpty) {
      showAppSnackBar('Please selecte your favorite spots');
    } else {
      Get.to(SelectGameScreen());
    }
  }
}
