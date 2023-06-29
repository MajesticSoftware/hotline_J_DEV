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
        if (gameDetails.isNotEmpty) {
          for (int i = 0; i < gameDetails.first.results.length; i++) {
            log('element.venue.city--${gameDetails.first.results[i].venue.city}');
            // ignore: use_build_context_synchronously
            weatherDetailsResponse(context,
                cityName: gameDetails.first.results[i].venue.city.isNotEmpty
                    ? gameDetails.first.results[i].venue.city
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
        if (gameDetails.isNotEmpty) {
          for (int i = 0; i < gameDetails.first.results.length; i++) {
            log('element.venue.city--${gameDetails.first.results[i].venue.city}');
            // ignore: use_build_context_synchronously
            weatherDetailsResponse(context,
                cityName: gameDetails.first.results[i].venue.city.isNotEmpty
                    ? gameDetails.first.results[i].venue.city
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

  List<int> _weatherData = [];

  List<int> get weatherData => _weatherData;

  set weatherData(List<int> value) {
    _weatherData = value;
    update();
  }

  List<int> _temp = [];

  List<int> get temp => _weatherData;

  set temp(List<int> value) {
    _weatherData = value;
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
            gameDetails.first.results[index].venue.weather =
                (element.id ?? 0.0).toInt();
          }
        }
        final tempData = response.main;
        if (tempData != null) {
          gameDetails.first.results[index].venue.temp =
              (tempData.temp ?? 0.0).toInt();
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
