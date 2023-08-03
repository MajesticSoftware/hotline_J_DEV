import 'dart:developer';

import 'package:get/get.dart';
import 'package:hotlines/model/mlb_box_score_model.dart';
import 'package:hotlines/model/mlb_statics_model.dart';

import '../../../constant/constant.dart';
import '../../../model/game_listing.dart';
import '../../../model/response_item.dart';
import '../../../model/weather_model.dart';
import '../../../network/game_listing_repo.dart';

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
        GameListingDataModel response =
            GameListingDataModel.fromJson(result.data);
        if (response.sportEvents != null) {
          sportEventsList.addAll(response.sportEvents ?? []);
        }
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
      String homeTeamId = '',
      String awayTeamId = '',
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
        if (game != null) {
          if (game.id == gameId) {
            sportEventsList[index].venue?.temp = game.weather?.forecast?.tempF;
            sportEventsList[index].venue?.weather =
                game.weather?.forecast?.tempF;
            if (game.home?.id == homeTeamId) {
              sportEventsList[index].homeScore = (game.home?.runs).toString();
              sportEventsList[index].homeWin = (game.home?.win).toString();
              sportEventsList[index].homeLoss = (game.home?.loss).toString();
            }
            if (game.away?.id == awayTeamId) {
              sportEventsList[index].awayScore = (game.away?.runs).toString();
              sportEventsList[index].awayWin = (game.away?.win).toString();
              sportEventsList[index].awayLoss = (game.away?.loss).toString();
            }
          }
        }
      } else {
        isLoading.value = false;
        showAppSnackBar(
          result.message,
        );
      }
    } catch (e) {
      isLoading.value = false;
      log('ERORE1----$e');
      showAppSnackBar(
        errorText,
      );
    }
    update();
  }

  ///other apis
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
    result = await GameListingRepo().gameListingsWithLogo(year, sportKey);
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
                        if (element.competitors[0].qualifier == 'home') {
                          homeTeam = element.competitors[0];
                        } else {
                          awayTeam = element.competitors[0];
                        }
                        if (element.competitors[1].qualifier == 'away') {
                          awayTeam = element.competitors[1];
                        } else {
                          homeTeam = element.competitors[1];
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
