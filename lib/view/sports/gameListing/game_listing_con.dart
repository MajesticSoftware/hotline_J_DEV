import 'dart:developer';

import 'package:get/get.dart';
import 'package:hotlines/model/mlb_box_score_model.dart';

import '../../../constant/constant.dart';
import '../../../model/game_listing.dart';
import '../../../model/response_item.dart';
import '../../../model/weather_model.dart';
import '../../../network/game_listing_repo.dart';
import '../../../network/game_repo.dart';
import '../../../theme/helper.dart';

class GameListingController extends GetxController {
  RxBool isLoading = false.obs;

  List<SportEvents> sportEventsList = [];

  Future gameListingApiRes(
      {String sportId = '',
      String date = "",
      bool isLoad = false,
      String key = ''}) async {
    isLoading.value = !isLoad ? false : true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo()
        .gameListingRepo(key: key, date: date, spotId: sportId);
    try {
      if (result.status) {
        sportEventsList.clear();
        GameListingDataModel response =
            GameListingDataModel.fromJson(result.data);
        if (response.sportEvents != null) {
          sportEventsList = response.sportEvents ?? [];
        }
        if (sportEventsList.isNotEmpty) {
          for (int i = 0; i < sportEventsList.length; i++) {
            // boxScoreResponse(
            //     gameId: sportEventsList[i].uuids ??
            //         'f6dfdb4f-9305-4974-80fc-0503c5e5c1af',
            //     index: i);
            weatherDetailsResponse(
                cityName: sportEventsList[i].venue?.cityName != null
                    ? (sportEventsList[i].venue?.cityName ?? 'california')
                        .toString()
                    : 'california',
                index: i);
          }
        }
        isLoading.value = false;
      } else {
        isLoading.value = false;
        showAppSnackBar(
          result.message,
        );
      }
    } catch (e) {
      isLoading.value = false;
      log('ERORE----$e');
      showAppSnackBar(
        errorText,
      );
    }
    update();
  }

  Future boxScoreResponse(
      {String gameId = '',
      bool isLoad = false,
      String key = '',
      int index = 0}) async {
    isLoading.value = !isLoad ? false : true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo().boxScoreRepo(gameId: gameId);
    try {
      if (result.status) {
        MLBBoxScoreModel response = MLBBoxScoreModel.fromJson(result.data);
        final game = response.game;
        if (game.id == gameId) {
          sportEventsList[index].venue?.temp = game.weather.forecast.tempF;
          // sportEventsList[index].season. = game.weather.forecast.tempF;
        }
        isLoading.value = false;
      } else {
        isLoading.value = false;
        showAppSnackBar(
          result.message,
        );
      }
    } catch (e) {
      isLoading.value = false;
      log('ERORE----$e');
      showAppSnackBar(
        errorText,
      );
    }
    update();
  }

  weatherDetailsResponse({String cityName = '', required int index}) async {
    Map<String, dynamic> weatherData = {"temp": 0, "weather": 0};
    weatherData.clear();
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo().weatherDetails(cityName);
    try {
      if (result.status) {
        WeatherDataModel response = WeatherDataModel.fromJson(result.data);
        final weather = response.weather;
        if (weather != null) {
          for (var element in weather) {
            sportEventsList[index].venue?.weather = (element.id ?? 0.0).toInt();
          }
        }
        final tempData = response.main;
        if (tempData != null) {
          sportEventsList[index].venue?.temp = (tempData.temp ?? 0.0).toInt();
        }
      } else {
        showAppSnackBar(
          result.message,
        );
      }
    } catch (e) {
      showAppSnackBar(
        errorText,
      );
    }
    update();
  }

  void gameListingsWithLogoResponse(String year, String sportKey,
      {bool isLoad = false}) async {
    isLoading.value = !isLoad ? false : true;

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
              if (result.data[key]['games'] != null) {
                (result.data[key]['games']).forEach((games) {
                  games['competitions'].forEach((teams) {
                    teams['competitors'].forEach((details) {
                      for (var element in sportEventsList) {
                        Competitors? homeTeam;
                        Competitors? awayTeam;
                        if (element.competitors?[0].qualifier == 'home') {
                          homeTeam = element.competitors?[0];
                        } else {
                          awayTeam = element.competitors?[0];
                        }
                        if (element.competitors?[1].qualifier == 'away') {
                          awayTeam = element.competitors?[1];
                        } else {
                          homeTeam = element.competitors?[1];
                        }
                        if ((homeTeam?.abbreviation ?? '') ==
                                details['team']['abbreviation'] ||
                            (homeTeam?.name ?? "") ==
                                details['team']['displayName']) {
                          element.homeGameLogo = details['team']['logo'];
                        }
                        if ((awayTeam?.abbreviation ?? "") ==
                            details['team']['abbreviation']) {
                          element.awayGameLogo = details['team']['logo'];
                        }
                      }
                    });
                  });
                });
              }
            }
          });
        } catch (e) {
          log('error--$e');
        }
        isLoading.value = false;
      } else {
        isLoading.value = false;
        showAppSnackBar(
          errorText,
        );
      }
    } catch (e) {
      isLoading.value = false;
      showAppSnackBar(
        errorText,
      );
    }
    update();
  }
}
