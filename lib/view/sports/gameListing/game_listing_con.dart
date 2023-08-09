import 'dart:developer';

import 'package:get/get.dart';
import 'package:hotlines/model/mlb_box_score_model.dart';
import 'package:hotlines/model/mlb_statics_model.dart';
import 'package:intl/intl.dart';

import '../../../constant/constant.dart';
import '../../../model/game_listing.dart';
import '../../../model/response_item.dart';
import '../../../model/weather_model.dart';
import '../../../network/game_listing_repo.dart';

import '../../../theme/helper.dart';

class GameListingController extends GetxController {
  RxBool isLoading = false.obs;

  List<SportEvents> sportEventsList = [];
  List<SportEvents> todayEventsList = [];
  List<SportEvents> tomorrowEventsList = [];

  Future gameListingTodayApiRes(
      {String sportId = '',
      String date = "",
      String sportKey = "",
      bool isLoad = false,
      String key = ''}) async {
    isLoading.value = !isLoad ? false : true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo()
        .gameListingRepo(key: key, date: date, spotId: sportId);
    try {
      todayEventsList.clear();
      if (result.status) {
        GameListingDataModel response =
            GameListingDataModel.fromJson(result.data);
        final sportEvents = response.sportEvents;
        if (sportEvents != null) {
          for (var event in sportEvents) {
            DateTime time = (DateTime.parse(event.scheduled ?? ''));
            log('UTC TIME---> ${time.toUtc()} |||| ${DateTime.now().toUtc()}');
            var difference =
                (time.toUtc().difference((DateTime.now().toUtc())));
            log('difference----->>  ${difference.inHours}');
            if (event.season?.id == 'sr:season:100127' &&
                sportKey == 'MLB' &&
                (difference.inHours >= (-6))) {
              todayEventsList.add(event);
            } else if (event.season?.id == 'sr:season:102797' &&
                sportKey == 'NFL') {
              todayEventsList.add(event);
            } else if (event.season?.id == 'sr:season:101983' &&
                sportKey == 'NCAA') {
              todayEventsList.add(event);
            }
          }
        }
      } else {
        isLoading.value = false;
        // showAppSnackBar(
        //   result.message,
        // );
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

  Future gameListingTomorrowApiRes(
      {String sportId = '',
      String date = "",
      String sportKey = "",
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
        final sportEvents = response.sportEvents;
        if (sportEvents != null) {
          for (var event in sportEvents) {
            if (event.season?.id == 'sr:season:100127' &&
                sportKey == 'MLB' &&
                DateTime.parse(event.scheduled ?? '').toLocal().day !=
                    DateTime.now().add(const Duration(days: 1)).toLocal().day) {
              tomorrowEventsList.add(event);
            } else if (event.season?.id == 'sr:season:102797' &&
                sportKey == 'NFL') {
              tomorrowEventsList.add(event);
            } else if (event.season?.id == 'sr:season:101983' &&
                sportKey == 'NCAA') {
              tomorrowEventsList.add(event);
            }
          }
        }
      } else {
        isLoading.value = false;
        // showAppSnackBar(
        //   result.message,
        // );
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

  getAllEventList(String sportKey) {
    sportEventsList.clear();
    sportEventsList = todayEventsList + tomorrowEventsList;
    log('sportEventsList----${sportEventsList.length}');
    for (var event in sportEventsList) {
      if (event.competitors.isNotEmpty) {
        if (event.competitors[0].qualifier == 'home') {
          event.homeTeam = event.competitors[0].name ?? '';
        } else {
          event.awayTeam = event.competitors[0].name ?? '';
        }
        if (event.competitors[1].qualifier == 'away') {
          event.awayTeam = event.competitors[1].name ?? '';
        } else {
          event.homeTeam = event.competitors[1].name ?? '';
        }
      }
      /* if (event.markets.isNotEmpty) {
        for (var marketData in event.markets) {
          ///MONEY LINES
          if (marketData.oddsTypeId == 1) {
            for (var bookData in marketData.books) {
              int fanDuelIndex = marketData.books
                  .indexWhere((element) => element.name == 'FanDuel');
              if (fanDuelIndex >= 0) {
                if (bookData.name.isNotEmpty) {
                  if (bookData.name == 'FanDuel') {
                    if (bookData.outcomes?[0].type == 'home') {
                      event.homeMoneyLine =
                          bookData.outcomes?[0].odds.toString() ?? '00';
                    }
                    if (bookData.outcomes?[1].type == 'away') {
                      event.awayMoneyLine =
                          bookData.outcomes?[1].odds.toString() ?? '00';
                    }
                  }
                }
              } else if (bookData.name == 'Bet365NewJersey') {
                if (bookData.outcomes?[0].type == 'home') {
                  event.homeMoneyLine =
                      bookData.outcomes?[0].odds.toString() ?? '';
                }
                if (bookData.outcomes?[1].type == 'away') {
                  event.awayMoneyLine =
                      bookData.outcomes?[1].odds.toString() ?? '';
                }
              } else if (bookData.name == 'MGM') {
                if (bookData.outcomes?[0].type == 'home') {
                  event.homeMoneyLine =
                      bookData.outcomes?[0].odds.toString() ?? '';
                }
                if (bookData.outcomes?[1].type == 'away') {
                  event.awayMoneyLine =
                      bookData.outcomes?[1].odds.toString() ?? '';
                }
              }
            }
          }

          ///OVER-UNDER
          if (marketData.oddsTypeId == 3) {
            for (var bookData in marketData.books) {
              int fanDuelIndex = marketData.books
                  .indexWhere((element) => element.name == 'FanDuel');
              if (fanDuelIndex >= 0) {
                if (bookData.name == 'FanDuel') {
                  if (bookData.outcomes?[0].type == 'over') {
                    event.awayOU =
                        bookData.outcomes?[0].total.toString() ?? '00';
                  }
                  if (bookData.outcomes?[1].type == 'under') {
                    event.homeOU =
                        bookData.outcomes?[1].total.toString() ?? '00';
                  }
                }
              } else if (bookData.name == 'Bet365NewJersey') {
                if (bookData.outcomes?[0].type == 'over') {
                  event.awayOU = bookData.outcomes?[0].total.toString() ?? '';
                }
                if (bookData.outcomes?[1].type == 'under') {
                  event.homeOU = bookData.outcomes?[1].total.toString() ?? '';
                }
              } else if (bookData.name == 'MGM') {
                if (bookData.outcomes?[0].type == 'over') {
                  event.awayOU = bookData.outcomes?[0].total.toString() ?? '';
                }
                if (bookData.outcomes?[1].type == 'under') {
                  event.homeOU = bookData.outcomes?[1].total.toString() ?? '';
                }
              }
            }
          }

          ///SPREAD
          if (marketData.oddsTypeId == 4) {
            for (var bookData in marketData.books) {
              int fanDuelIndex = marketData.books
                  .indexWhere((element) => element.name == 'FanDuel');
              if (fanDuelIndex >= 0) {
                if (bookData.name == 'FanDuel') {
                  if (bookData.outcomes?[0].type == 'home') {
                    event.homeSpread =
                        bookData.outcomes?[0].spread.toString() ?? '00';
                  }
                  if (bookData.outcomes?[1].type == 'away') {
                    event.awaySpread =
                        bookData.outcomes?[1].spread.toString() ?? '00';
                  }
                }
              } else if (bookData.name == 'Bet365NewJersey') {
                if (bookData.outcomes?[0].type == 'home') {
                  event.homeSpread =
                      bookData.outcomes?[0].spread.toString() ?? '';
                }
                if (bookData.outcomes?[1].type == 'away') {
                  event.awaySpread =
                      bookData.outcomes?[1].spread.toString() ?? '';
                }
              } else if (bookData.name == 'MGM') {
                if (bookData.outcomes?[0].type == 'home') {
                  event.homeSpread =
                      bookData.outcomes?[0].spread.toString() ?? '';
                }
                if (bookData.outcomes?[1].type == 'away') {
                  event.awaySpread =
                      bookData.outcomes?[1].spread.toString() ?? '';
                }
              }
            }
          }
        }
      }*/
      if (event.consensus != null) {
        ///MONEY LINES
        if (event.consensus?.lines != null) {
          event.consensus?.lines?.forEach((consensus) {
            if (consensus.name == 'moneyline_current') {
              consensus.outcomes?.forEach((lines) {
                if (lines.type == 'home') {
                  event.homeMoneyLine = lines.odds.toString();
                }
                if (lines.type == 'away') {
                  event.awayMoneyLine = lines.odds.toString();
                }
              });
            }
            if (consensus.name == 'total_current') {
              event.homeOU = consensus.total.toString();
              event.awayOU = consensus.total.toString();
            }
            if (consensus.name == 'run_line_current' ||
                consensus.name == 'spread_current') {
              event.homeSpread = '${consensus.spread}'.toString();
              event.awaySpread = '${consensus.spread}'.toString();
              /*   if (int.parse(event.homeMoneyLine).isNegative) {
                event.homeSpread = '-${consensus.spread}'.toString();
              } else {
                event.homeSpread = '${consensus.spread}'.toString();
              }
              if (int.parse(event.awayMoneyLine).isNegative) {
                if (int.parse(consensus.spread ?? '').isNegative) {
                  event.awaySpread = '${consensus.spread}'.toString();
                } else {
                  event.awaySpread = '-${consensus.spread}'.toString();
                }
              } else {
                event.awaySpread = consensus.spread.toString();
              }*/
            }
          });
        }
      }
    }
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
    // try {
    if (result.status) {
      MLBBoxScoreModel response = MLBBoxScoreModel.fromJson(result.data);
      final game = response.game;
      if (game != null) {
        if (game.id == gameId) {
          sportEventsList[index].venue?.temp = game.weather?.forecast?.tempF;
          sportEventsList[index].inning = game.finals?.inning.toString() ?? '';
          sportEventsList[index].inningHalf =
              game.finals?.inningHalf?.toUpperCase().toString() ?? '';

          sportEventsList[index].venue?.weather =
              game.weather?.forecast?.condition;
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
    // } catch (e) {
    //   isLoading.value = false;
    //   log('ERORE1----$e');
    //   showAppSnackBar(
    //     errorText,
    //   );
    // }
    update();
  }

  getGameListingForNCAAGame(bool isLoad,
      {String apiKey = '',
      String sportKey = '',
      String date = '',
      String sportId = ''}) async {
    // final DateTime now =
    // DateTime.parse(widget.date).add(const Duration(days: 1));
    // final DateFormat formatter = DateFormat('yyyy-MM-dd');
    // final String formatted = formatter.format(now);
    tomorrowEventsList.clear();
    await gameListingTodayApiRes(
            key: apiKey,
            isLoad: isLoad,
            sportKey: sportKey,
            date: date,
            sportId: sportId)
        .then((value) async {
      await gameListingTomorrowApiRes(
              key: apiKey,
              isLoad: isLoad,
              sportKey: sportKey,
              date: '2023-08-31',
              sportId: sportId)
          .then((value) async {
        await gameListingTomorrowApiRes(
                key: apiKey,
                isLoad: isLoad,
                sportKey: sportKey,
                date: '2023-09-01',
                sportId: sportId)
            .then((value) async {
          await gameListingTomorrowApiRes(
                  key: apiKey,
                  isLoad: isLoad,
                  sportKey: sportKey,
                  date: '2023-09-02',
                  sportId: sportId)
              .then((value) {
            getAllEventList(sportKey);
            gameListingsWithLogoResponse('2023', sportKey, isLoad: true);
          });
        });
      });
    });
  }

  getGameListingForNFLGame(bool isLoad,
      {String apiKey = '',
      String sportKey = '',
      String date = '',
      String sportId = ''}) async {
    final DateTime now = DateTime.parse(date).add(const Duration(days: 1));
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);
    tomorrowEventsList.clear();
    await gameListingTodayApiRes(
            key: apiKey,
            isLoad: isLoad,
            sportKey: sportKey,
            date: date,
            sportId: sportId)
        .then((value) async {
      await gameListingTomorrowApiRes(
              key: apiKey,
              isLoad: isLoad,
              sportKey: sportKey,
              date: '2023-09-10',
              sportId: sportId)
          .then((value) async {
        await gameListingTomorrowApiRes(
                key: apiKey,
                isLoad: isLoad,
                sportKey: sportKey,
                date: '2023-09-11',
                sportId: sportId)
            .then((value) async {
          getAllEventList(sportKey);
          gameListingsWithLogoResponse('2023', sportKey, isLoad: true);
        });
      });
    });
  }

  getGameListingForMLBRes(bool isLoad,
      {String apiKey = '',
      String sportKey = '',
      String date = '',
      String sportId = ''}) async {
    final DateTime now = DateTime.parse(date).add(const Duration(days: 1));
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);
    tomorrowEventsList.clear();
    await gameListingTodayApiRes(
            key: apiKey,
            isLoad: isLoad,
            sportKey: sportKey,
            date: date,
            sportId: sportId)
        .then((value) async {
      await gameListingTomorrowApiRes(
              key: apiKey,
              isLoad: isLoad,
              sportKey: sportKey,
              date: formatted,
              sportId: sportId)
          .then((value) async {
        getAllEventList(sportKey);
        if (sportEventsList.isNotEmpty) {
          for (int i = 0; i < sportEventsList.length; i++) {
            int index =
                sportEventsList.indexWhere((element) => element.uuids != null);
            if (index >= 0) {
              boxScoreResponse(
                  homeTeamId: sportEventsList[i].competitors[0].uuids ?? "",
                  awayTeamId: sportEventsList[i].competitors[1].uuids ?? "",
                  gameId: sportEventsList[i].uuids ??
                      '1ec03c45-ce1b-4908-a507-9678e2d14628',
                  index: i);
            }
          }
        }
        gameListingsWithLogoResponse('2023', sportKey, isLoad: isLoad);
      });
    });
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
            // sportEventsList[index].venue?.weather = (element.id ?? 0.0).toInt();
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
                                details['team']['abbreviation'] ||
                            (awayTeam?.name ?? "") ==
                                details['team']['displayName']) {
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
