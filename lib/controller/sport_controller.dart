import 'dart:developer';
import 'package:get/get.dart';
import 'package:hotlines/extras/base_api_helper.dart';
import 'package:hotlines/model/mlb_game_listing_model.dart';
import 'package:hotlines/network/game_repo.dart';

import '../constant/app_strings.dart';
import '../model/game_listing_model.dart' as g;
import '../model/response_item.dart';
import '../model/weather_model.dart';
import '../theme/helper.dart';

class SportController extends GetxController {
  List<g.Games> _gameDetails = [];

  List<g.Games> get gameDetails => _gameDetails;

  set gameDetails(List<g.Games> value) {
    _gameDetails = value;
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
                      log('element.home?.alias---${gameDetails}');
                      for (var element in gameDetails) {
                        if ((element.home?.alias ?? '') ==
                                details['team']['abbreviation'] ||
                            (element.home?.name ?? "") ==
                                details['team']['displayName']) {
                          element.home?.homeGameLogo = details['team']['logo'];

                          element.home?.homeScore = details['score'];
                        }
                        if ((element.away?.alias ?? "") ==
                            details['team']['abbreviation']) {
                          element.away?.awayGameLogo = details['team']['logo'];
                          element.away?.awayScore = details['score'];
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

  ///Api call
  /*Future<void> getSportDataFromJson() async {
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
            weatherDetailsResponse(
                cityName: gameDetails[i].venue.city.isNotEmpty
                    ? gameDetails[i].venue.city
                    : 'california',
                index: i);
          }
        }

        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      showAppSnackBar(
        errorText,
      );
    }
    update();
  }*/

  RxBool isLoading = false.obs;

/*  Future gameListingsResponse(
      {String sportKey = '', String date = "", bool isLoad = false}) async {
    isLoading.value = !isLoad ? false : true;
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

            weatherDetailsResponse(
                cityName: gameDetails[i].venue.city.isNotEmpty
                    ? gameDetails[i].venue.city
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
      showAppSnackBar(
        errorText,
      );
    }
    update();
  }*/

  weatherDetailsResponse({String cityName = '', required int index}) async {
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
            gameDetails[index].venue?.weather = (element.id ?? 0.0).toInt();
          }
        }
        final tempData = response.main;
        if (tempData != null) {
          gameDetails[index].venue?.temp = (tempData.temp ?? 0.0).toInt();
        }
      } else {
        // showAppSnackBar(
        //   result.message,
        // );
      }
    } catch (e) {
      showAppSnackBar(
        errorText,
      );
    }
    update();
  }

  ///SPOT-RADAR API IMPLEMENTATION
  // List<Games> gameDetails = [];
  Future gameListingsApiResponse(
      {String sportKey = '',
      String year = "",
      bool isLoad = false,
      String key = ''}) async {
    isLoading.value = !isLoad ? false : true;
    gameDetails.clear();
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result =
        await GameRepo().gameListingsApi(year, sportKey.toLowerCase(), key);
    try {
      if (result.status) {
        if (sportKey == 'MLB') {
          gameDetails = result.data['games'];
        } else {
          g.GameListingModel response =
              g.GameListingModel.fromJson(result.data);
          gameDetails.clear();
          if (response.weeks != null) {
            gameDetails = response.weeks?[0].games ?? [];
          }
        }

        if (gameDetails.isNotEmpty) {
          for (int i = 0; i < gameDetails.length; i++) {
            log('element.venue.city--${gameDetails[i].venue?.city ?? ''}');

            weatherDetailsResponse(
                cityName: gameDetails[i].venue!.city!.isNotEmpty
                    ? (gameDetails[i].venue?.city).toString()
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
      showAppSnackBar(
        errorText,
      );
    }
    update();
  }

  ///MLB GAME LISTING
  List<Games> _mlbGame = [];

  List<Games> get mlbGame => _mlbGame;

  set mlbGame(List<Games> value) {
    _mlbGame = value;
    update();
  }

  Future mlbGameListingsApiResponse(
      {String sportKey = '',
      String year = "",
      bool isLoad = false,
      String key = ''}) async {
    isLoading.value = !isLoad ? false : true;
    mlbGame.clear();
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result =
        await GameRepo().mlbGameListingsApi(year, sportKey.toLowerCase(), key);
    try {
      if (result.status) {
        MLBGameListingModel response =
            MLBGameListingModel.fromJson(result.data);
        mlbGame.clear();
        if (response.games.isNotEmpty) {
          mlbGame = response.games;
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
      showAppSnackBar(
        errorText,
      );
    }
    update();
  }

  ///MLB BOX SCORE
  Future mlbGameBoxScoreResponse(
      {String sportKey = '',
      String year = "",
      bool isLoad = false,
      String key = ''}) async {
    isLoading.value = !isLoad ? false : true;
    mlbGame.clear();
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result =
        await GameRepo().mlbGameListingsApi(year, sportKey.toLowerCase(), key);
    try {
      if (result.status) {
        MLBGameListingModel response =
            MLBGameListingModel.fromJson(result.data);
        mlbGame.clear();
        if (response.games.isNotEmpty) {
          mlbGame = response.games;
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
      showAppSnackBar(
        errorText,
      );
    }
    update();
  }
}
