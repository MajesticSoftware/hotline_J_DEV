import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hotlines/constant/shred_preference.dart';
import 'package:hotlines/model/user_model.dart';
import 'package:hotlines/theme/helper.dart';
import 'package:hotlines/utils/extension.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../constant/app_strings.dart';
import '../../../model/response_item.dart';
import '../../../network/auth_repo.dart';
import '../../sports/gameListing/game_listing_screen.dart';

class LogInController extends GetxController {
  bool isShowPass = true;
  bool isCheck = false;
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
    }
    /*else if (!isCheck) {
      showAppSnackBar('Please accept term and conditions.');
    }*/
    else {
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
              PreferenceManager().saveSubscription(response.data!);
              PreferenceManager.setIsLogin(true);
              /*PreferenceManager.getIsFirstLoaded() == null
                  ? Get.offAll(const AppStartScreen())
                  :*/
              Get.offAll(SelectGameScreen());
              emailCon.clear();
              passCon.clear();
              isCheck = false;
            }
          }
        } else {
          isLoading.value = false;
          showAppSnackBar(result.message);
        }
      } catch (e) {
        isLoading.value = false;
        showAppSnackBar(e.toString());
      }
      isLoading.value = false;
      update();
    }
  }

  void appleLogin() async {
    if (Platform.isIOS) {
      try {
        final credential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
        );
        log("credential : $credential");
        log("credential :---- ${credential.authorizationCode}");
        socialLogin(
            fullName: credential.givenName ?? "",
            userEmail: credential.email ?? "",
            loginType: 'apple',
            authorizationCode: credential.authorizationCode,
            socialId: credential.userIdentifier ?? "");
      } catch (e) {
        log('$e');
      }
    } else {}
  }

  void googleSignIn() async {
    try {
      GoogleSignIn signIn = GoogleSignIn(
        scopes: <String>[
          'email',
        ],
      );
      signIn.signIn().then((detail) {
        var name = detail!.displayName!.split(" ");
        socialLogin(
            userEmail: detail.email,
            loginType: 'google',
            socialId: detail.id,
            fullName: detail.displayName ?? "",
            authorizationCode: detail.serverAuthCode!);
        log('details--${detail.id}---$name---${detail.email}');
      });
    } catch (e) {
      isLoading.value = false;
      showAppSnackBar(e.toString());
    }
  }

  void socialLogin(
      {String userEmail = "",
      String socialId = '',
      String loginType = '',
      String authorizationCode = '',
      String fullName = ''}) async {
    try {
      isLoading.value = true;
      ResponseItem result =
          ResponseItem(data: null, message: errorText.tr, status: false);
      result = await UserStartupRepo().socialUserLogin(
          loginType: loginType,
          socialId: socialId,
          email: userEmail,
          authorizationCode: authorizationCode,
          userName: fullName);
      try {
        isLoading.value = true;
        if (result.status) {
          if (result.data != null) {
            UserModel response = UserModel.fromJson(result.toJson());
            if (response.data != null) {
              PreferenceManager.setUserData(response.data!);
              PreferenceManager.setIsLogin(true);
             /* PreferenceManager.getIsFirstLoaded() == null
                  ? Get.offAll(const AppStartScreen())
                  :*/ Get.offAll(SelectGameScreen());
            }
          }
        } else {
          isLoading.value = false;
          showAppSnackBar(result.message);
        }
      } catch (e) {
        isLoading.value = false;
        showAppSnackBar(e.toString());
      }
      isLoading.value = false;
      update();
    } catch (e) {
      isLoading.value = false;
      showAppSnackBar(e.toString());
    }
  }

  void socialRegistration(
      {String userEmail = '',
      String socialId = '',
      String authorizationCode = '',
      String fullName = ''}) async {
    log('LOGIN SOCIAL');

    ResponseItem result =
        ResponseItem(data: null, message: errorText, status: false);
    result = await UserStartupRepo().socialUserRegistration(
        authorizationCode: authorizationCode,
        loginType: 'apple',
        email: userEmail,
        socialId: socialId,
        fullName: fullName);
    isLoading.value = true;
    try {
      if (result.status) {
        if (result.data != null) {
          UserModel user = UserModel.fromJson(result.toJson());
          if (user.data != null) {
            PreferenceManager.setUserData(user.data!);
            PreferenceManager.setIsLogin(true);
            Get.offAll(SelectGameScreen());
          }
          isLoading.value = false;
        }
      } else {
        isLoading.value = false;
        showAppSnackBar(result.message);
      }
    } catch (e) {
      isLoading.value = false;
      showAppSnackBar(e.toString());
    }
    isLoading.value = false;
    update();
  }
}
