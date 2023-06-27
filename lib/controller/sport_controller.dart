import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotlines/extras/base_api_helper.dart';
import 'package:hotlines/network/game_repo.dart';

import '../constant/app_strings.dart';
import '../model/game_detail_model.dart';
import '../model/response_item.dart';
import '../theme/helper.dart';

class SportController extends GetxController {
  List<GameDetailsModel> _gameDetails = [];

  List<GameDetailsModel> get gameDetails => _gameDetails;

  set gameDetails(List<GameDetailsModel> value) {
    _gameDetails = value;
    update();
  }

  ///Api call
  Future<void> getSportDataFromJson(BuildContext context) async {
    isLoading.value = true;
    gameDetails.clear();
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await BaseApiHelper.jasonRequest();
    try {
      if (result.status) {
        GameDetailsModel response = GameDetailsModel.fromJson(result.data);
        gameDetails.clear();
        gameDetails.add(response);
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      // ignore: use_build_context_synchronously
      showAppSnackBar(errorText, context);
    }
    update();
  }

  RxBool isLoading = false.obs;
  void gameDetailsResponse(BuildContext context, {String sportKey = ''}) async {
    isLoading.value = true;
    gameDetails.clear();
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameRepo().gameDetails(sportKey, '2023-09-07,2023-09-24');
    try {
      if (result.status) {
        GameDetailsModel response = GameDetailsModel.fromJson(result.data);
        gameDetails.clear();
        gameDetails.add(response);
        isLoading.value = false;
      } else {
        isLoading.value = false;
        // ignore: use_build_context_synchronously
        showAppSnackBar(result.message, context);
      }
    } catch (e) {
      isLoading.value = false;
      // ignore: use_build_context_synchronously
      showAppSnackBar(errorText, context);
    }
    update();
  }
}
