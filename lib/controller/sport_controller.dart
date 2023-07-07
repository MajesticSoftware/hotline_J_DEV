import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotlines/extras/base_api_helper.dart';
import 'package:hotlines/network/game_repo.dart';

import '../constant/app_strings.dart';
import '../model/game_detail_model.dart';
import '../model/game_team_logo.dart';
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

  List<Competition> _games = [];

  List<Competition> get games => _games;

  set games(List<Competition> value) {
    _games = value;
    update();
  }

  String _gameLogo = '';

  String get gameLogo => _gameLogo;

  set gameLogo(String value) {
    _gameLogo = value;
    update();
  }

  void gameListingsWithLogoResponse(
      BuildContext context, String year, String sportKey) async {
    isLoading.value = true;

    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameRepo().gameListingsWithLogo(year, sportKey);
    // result = await BaseApiHelper.jasonRequestNew(sportKey);
    try {
      Map<String, dynamic> data = result.data;
      if (result.status) {
        try {
          data.forEach((key, value) {
            if (result.data[key] != null) {
              (result.data[key]['games']).forEach((games) {
                games['competitions'].forEach((teams) {
                  teams['competitors'].forEach((details) {
                    for (var element in gameDetails) {
                      if (element.teams.home.abbreviation ==
                              details['team']['abbreviation'] ||
                          element.teams.home.team ==
                              details['team']['displayName']) {
                        element.homeGameLogo = details['team']['logo'];
                        if (details['records'] != null) {
                          details['records'].forEach((records) {
                            if (records['type'] == 'total') {
                              element.spreadHomeRecord = records['summary'];
                            }
                          });
                        }

                        element.homeScore = details['score'];
                      }
                      if (element.teams.away.abbreviation ==
                          details['team']['abbreviation']) {
                        element.awayGameLogo = details['team']['logo'];
                        element.awayScore = details['score'];
                        if (details['records'] != null) {
                          details['records'].forEach((records) {
                            if (records['type'] == 'total') {
                              element.spreadAwayRecord = records['summary'];
                            }
                          });
                        }
                      }
                    }
                  });
                });
              });
            }
          });
        } catch (e) {
          log('error--$e');
        }
        isLoading.value = false;
      } else {
        isLoading.value = false;
        // ignore: use_build_context_synchronously
        showAppSnackBar(errorText, context);
      }
    } catch (e) {
      isLoading.value = false;
      // ignore: use_build_context_synchronously
      showAppSnackBar(errorText, context);
    }
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

  Future gameListingsResponse(BuildContext context,
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
