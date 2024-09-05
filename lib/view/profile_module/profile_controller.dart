import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hotlines/constant/shred_preference.dart';

import '../../constant/app_strings.dart';
import '../../model/response_item.dart';
import '../../model/user_model.dart';
import '../../network/auth_repo.dart';
import '../../theme/helper.dart';

class ProfileController extends GetxController {
  TextEditingController emailCon =
      TextEditingController(text: PreferenceManager.getUserEmail() ?? "");
  TextEditingController nameCon =
      TextEditingController(text: PreferenceManager.getUserName() ?? "");
  String profileImage = PreferenceManager.getUserProfile() ?? "";
  String userName = PreferenceManager.getUserProfile() ?? "";
  File? imageFile;

  void addImage(File newImage) {
    imageFile = newImage;
    update();
  }

  List<String> spotsList = [ /*'NBA','NCAAB', 'MLB','NCAAF',*/'NFL'];
  String selectedSpot = /*PreferenceManager.getFavoriteSport() ?? "NBA"*/"NFL";

  RxBool isLoading = false.obs;

  Future<void> updateUserProfile() async {
    try {
      if (nameCon.text.isEmpty) {
        showAppSnackBar('Please enter name');
      } else if (selectedSpot.isEmpty) {
        showAppSnackBar('Please selecte your favorite spots');
      } else {
        ResponseItem result =
            ResponseItem(data: null, message: errorText.tr, status: false);
        isLoading.value = true;
        if (imageFile == null) {
          log('imageFile null');
          result = await UserStartupRepo().updateUserProfile(
              favouriteSport: selectedSpot, fullName: nameCon.text);
        } else {
          result = await UserStartupRepo().updateUserProfile(
              favouriteSport: selectedSpot,
              fullName: nameCon.text,
              profileImage: imageFile);
        }
        if (result.status) {
          if (result.data != null) {
            UserModel response = UserModel.fromJson(result.toJson());
            if (response.data != null) {
              profileImage = response.data?.userProfilePic ?? "";
              userName = response.data?.userName ?? "";
              // PreferenceManager.setUserData(response.data!);
              PreferenceManager.setUserProfile(
                  response.data?.userProfilePic ?? "");
              PreferenceManager.setUserName(response.data?.userName ?? "");
              PreferenceManager.setFavoriteSport(/*response.data?.favouriteSport ?? */"NBA");
              Get.back();
              showAppSnackBar('${response.msg}', status: true);
            }
            isLoading.value = false;
          } else {
            isLoading.value = false;
            showAppSnackBar(result.message);
          }
        } else {
          isLoading.value = false;
          showAppSnackBar(result.message);
        }
      }
    } catch (e) {
      isLoading.value = false;
      showAppSnackBar(e.toString());
    }
    update();
  }
}
