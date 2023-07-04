import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotlines/extras/base_api_helper.dart';
import 'package:hotlines/network/game_repo.dart';

import '../constant/app_strings.dart';
import '../model/game_detail_model.dart';
import '../model/response_item.dart';
import '../model/weather_model.dart';
import '../theme/helper.dart';

class SportController extends GetxController {
  List<Result> _gameDetails = [];

  List<Result> get gameDetails => _gameDetails;

  set gameDetails(List<Result> value) {
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
        if (response.results.isNotEmpty) {
          gameDetails = response.results;
        }
        if (gameDetails.isNotEmpty) {
          for (int i = 0; i < gameDetails.length; i++) {
            log('element.venue.city--${gameDetails[i].venue.city}');
            // ignore: use_build_context_synchronously
            weatherDetailsResponse(context,
                cityName: gameDetails[i].venue.city.isNotEmpty
                    ? gameDetails[i].venue.city
                    : 'california',
                index: i);
            // element.venue.weather = weather["temp"];
            // element.venue.weather = weather["weather"];
          }
        }

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

  void gameListingsResponse(BuildContext context,
      {String sportKey = '', String date = ""}) async {
    isLoading.value = true;
    gameDetails.clear();
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameRepo().gameListings(sportKey, date);
    try {
      if (result.status) {
        GameDetailsModel response = GameDetailsModel.fromJson(result.data);
        gameDetails.clear();
        if (response.results.isNotEmpty) {
          gameDetails = response.results;
        }
        if (gameDetails.isNotEmpty) {
          for (int i = 0; i < gameDetails.length; i++) {
            log('element.venue.city--${gameDetails[i].venue.city}');
            // ignore: use_build_context_synchronously
            weatherDetailsResponse(context,
                cityName: gameDetails[i].venue.city.isNotEmpty
                    ? gameDetails[i].venue.city
                    : 'california',
                index: i);
            // element.venue.weather = weather["temp"];
            // element.venue.weather = weather["weather"];
          }
        }

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

  weatherDetailsResponse(BuildContext context,
      {String cityName = '', required int index}) async {
    Map<String, dynamic> weatherData = {"temp": 0, "weather": 0};
    weatherData.clear();
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameRepo().weatherDetails(cityName);
    try {
      if (result.status) {
        WeatherDataModel response = WeatherDataModel.fromJson(result.data);
        final weather = response.weather;
        if (weather != null) {
          for (var element in weather) {
            gameDetails[index].venue.weather = (element.id ?? 0.0).toInt();
          }
        }
        final tempData = response.main;
        if (tempData != null) {
          gameDetails[index].venue.temp = (tempData.temp ?? 0.0).toInt();
        }
      } else {
        // ignore: use_build_context_synchronously
        showAppSnackBar(result.message, context);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      showAppSnackBar(errorText, context);
    }
    update();
  }
}
