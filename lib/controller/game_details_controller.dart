import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotlines/model/injuries_data_model.dart';
import 'package:hotlines/model/mlb_injury_report_model.dart';

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

  void nflInjuriesReportResponse(BuildContext context,
      {String teamHomeName = '',
      String teamAwayName = '',
      String league = ''}) async {
    isLoading.value = true;
    injuredAwayPlayerList.clear();
    injuredHomePlayerList.clear();
    mlbInjuredAwayPlayerList.clear();
    mlbInjuredHomePlayerList.clear();
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameRepo().injuriesReport(league: league);
    // try {
    if (result.status) {
      log('result.data---${result.data[0]}');
      List<InjuriesDataModel> response = (result.data as List)
          .map((i) => InjuriesDataModel.fromJson(i))
          .toList();
      if (response.isNotEmpty) {
        for (var element in response) {
          if (element.currentTeam.isNotEmpty) {
            if (element.currentTeam == teamAwayName) {
              injuredAwayPlayerList.add(element);
            }
            if (element.currentTeam == teamHomeName) {
              injuredHomePlayerList.add(element);
            }
          }
        }
      }
      isLoading.value = false;
    } else {
      isLoading.value = false;
      // ignore: use_build_context_synchronously
      // showAppSnackBar('Resource not found', context);
    }
    // } catch (e) {
    //   isLoading.value = false;
    //   // ignore: use_build_context_synchronously
    //   showAppSnackBar(errorText, context);
    // }

    update();
  }

  List<MLBInjuryReportModel> _mlbInjuredAwayPlayerList = [];

  List<MLBInjuryReportModel> get mlbInjuredAwayPlayerList =>
      _mlbInjuredAwayPlayerList;

  set mlbInjuredAwayPlayerList(List<MLBInjuryReportModel> value) {
    _mlbInjuredAwayPlayerList = value;
    update();
  }

  List<MLBInjuryReportModel> _mlbInjuredHomePlayerList = [];

  List<MLBInjuryReportModel> get mlbInjuredHomePlayerList =>
      _mlbInjuredHomePlayerList;

  set mlbInjuredHomePlayerList(List<MLBInjuryReportModel> value) {
    _mlbInjuredHomePlayerList = value;
    update();
  }

  void mlbInjuriesReportResponse(BuildContext context,
      {String teamHomeName = '',
      String teamAwayName = '',
      String league = ''}) async {
    isLoading.value = true;
    injuredAwayPlayerList.clear();
    injuredHomePlayerList.clear();
    mlbInjuredAwayPlayerList.clear();
    mlbInjuredHomePlayerList.clear();
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameRepo().injuriesReport(league: league);
    try {
      if (result.status) {
        log('MLB DATA---${result.data[0]}');
        List<MLBInjuryReportModel> response = (result.data as List)
            .map((i) => MLBInjuryReportModel.fromJson(i))
            .toList();
        if (response.isNotEmpty) {
          for (var element in response) {
            if ((element.team ?? '').isNotEmpty) {
              if (element.team == teamAwayName) {
                mlbInjuredAwayPlayerList.add(element);
              }
              if (element.team == teamHomeName) {
                mlbInjuredHomePlayerList.add(element);
              }
            }
          }
        }
        isLoading.value = false;
      } else {
        isLoading.value = false;
        // ignore: use_build_context_synchronously
        // showAppSnackBar('Resource not found', context);
      }
    } catch (e) {
      isLoading.value = false;
      // ignore: use_build_context_synchronously
      showAppSnackBar(errorText, context);
    }

    update();
  }
}
