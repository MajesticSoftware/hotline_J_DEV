import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hotlines/model/user_model.dart';
import 'package:hotlines/network/auth_repo.dart';
import 'package:hotlines/utils/extension.dart';

import '../../../constant/app_strings.dart';
import '../../../constant/shred_preference.dart';
import '../../../model/response_item.dart';
import '../../../theme/helper.dart';
import '../../main/app_starting_screen.dart';
import '../../sports/gameListing/game_listing_screen.dart';

class RegisterCon extends GetxController {
  TextEditingController emailCon = TextEditingController();
  TextEditingController nameCon = TextEditingController();
  TextEditingController passCon = TextEditingController();
  List<String> spotsList = ['NFL', 'NCAAF', 'MLB'];
  String selectedSpot = '';
  File? imageFile;
  void addImage(File newImage) {
    imageFile = newImage;
    update();
  }

  clearData() {
    emailCon.clear();
    nameCon.clear();
    passCon.clear();
    imageFile = null;
  }

  RxBool isLoading = false.obs;
  bool isShowPass = true;
  String profileImage = '';
  Future<void> registration() async {
    try {
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
        ResponseItem result =
            ResponseItem(data: null, message: errorText.tr, status: false);
        isLoading.value = true;
        if (imageFile == null) {
          log('imageFile null');
          result = await UserStartupRepo().registrationRepo(
              email: emailCon.text,
              favouriteSport: selectedSpot,
              fullName: nameCon.text,
              password: passCon.text);
        } else {
          result = await UserStartupRepo().registrationRepo(
              email: emailCon.text,
              favouriteSport: selectedSpot,
              fullName: nameCon.text,
              password: passCon.text,
              profileImage: imageFile);
        }
        if (result.status) {
          if (result.data != null) {
            UserModel response = UserModel.fromJson(result.toJson());
            if (response.data != null) {
              profileImage = response.data?.userProfilePic ?? "";
              PreferenceManager.setUserData(response.data!);
              PreferenceManager.getIsFirstLoaded() == null
                  ? Get.offAll(const AppStartScreen())
                  : Get.offAll(SelectGameScreen());
              clearData();
            }
            isLoading.value = false;
          } else {
            isLoading.value = false;
            showAppSnackBar(result.message);
          }
        }
      }
    } catch (e) {
      isLoading.value = false;
      showAppSnackBar(errorText);
    }
    update();
  }
}
