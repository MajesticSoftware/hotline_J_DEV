import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotlines/model/injuries_data_model.dart';

import '../constant/app_strings.dart';
import '../model/response_item.dart';
import '../network/game_repo.dart';
import '../theme/helper.dart';

class GameDetailsController extends GetxController {
  RxBool isLoading = false.obs;
  List<InjuriesDataModel> _injuredAwayPlayerList = [];

  List<InjuriesDataModel> get injuredAwayPlayerList => _injuredAwayPlayerList;

  set injuredAwayPlayerList(List<InjuriesDataModel> value) {
    _injuredAwayPlayerList = value;
    update();
  }

  List<InjuriesDataModel> _injuredHomePlayerList = [];

  List<InjuriesDataModel> get injuredHomePlayerList => _injuredHomePlayerList;

  set injuredHomePlayerList(List<InjuriesDataModel> value) {
    _injuredHomePlayerList = value;
    update();
  }

  void injuriesReportAwayResponse(BuildContext context,
      {String teamHomeName = '', String teamAwayName = ''}) async {
    isLoading.value = true;
    injuredAwayPlayerList.clear();
    injuredHomePlayerList.clear();
    // ResponseItem result =
    //     ResponseItem(data: null, message: errorText.tr, status: false);
    var result = await GameRepo().injuriesReport();
    // try {
    if (result.status) {
      log('result.data---${result.data[0]}');
      List<InjuriesDataModel> response = (result.data as List)
          .map((i) => InjuriesDataModel.fromJson(i))
          .toList();
      if (response.isNotEmpty) {
        response.forEach((element) {
          if (element.collegeDraftTeam == teamAwayName) {
            injuredAwayPlayerList.add(element);
          }
          if (element.collegeDraftTeam == teamHomeName) {
            injuredHomePlayerList.add(element);
          }
        });
      }
      isLoading.value = false;
    } else {
      isLoading.value = false;
      // ignore: use_build_context_synchronously
      showAppSnackBar(result.message, context);
    }
    // } catch (e) {
    //   isLoading.value = false;
    //   // ignore: use_build_context_synchronously
    //   showAppSnackBar(errorText, context);
    // }

    update();
  }
}
