import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hotlines/model/mlb_box_score_model.dart';
import 'package:hotlines/model/weather_model.dart';
import 'package:intl/intl.dart';
import '../../../constant/constant.dart';
import '../../../model/game_listing.dart';
import '../../../model/ncaa_boxcore_model.dart';
import '../../../model/response_item.dart';
import '../../../network/game_listing_repo.dart';

import '../../../theme/helper.dart';
import '../../../utils/extension.dart';

class GameListingController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController searchCon = TextEditingController();
  List<SportEvents> sportEventsList = [];
  List<SportEvents> _searchList = [];

  List<SportEvents> get searchList => _searchList;

  set searchList(List<SportEvents> value) {
    _searchList = value;
    update();
  }

  searchData(String text) {
    searchList.clear();
    if (text.isNotEmpty) {
      for (var element in sportEventsList) {
        if (element.homeTeam
                .toString()
                .toLowerCase()
                .contains(text.trim().toString().toLowerCase()) ||
            element.awayTeam
                .toString()
                .toLowerCase()
                .contains(text.trim().toString().toLowerCase())) {
          if (searchList.length > 4) {
            searchList.clear();
          }
          searchList.add(element);
        }
      }
    }
    update();
  }

  List<SportEvents> todayEventsList = [];
  List<SportEvents> tomorrowEventsList = [];

  ///GAME LISTING API
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
            // log('UTC TIME---> ${time.toUtc()} |||| ${DateTime.now().toUtc()}');
            var difference =
                (time.toUtc().difference((DateTime.now().toUtc())));
            // log('difference----->>  ${difference.inHours}');
            if (event.season?.id == 'sr:season:100127' &&
                sportKey == 'MLB' &&
                (difference.inHours >= (-6))) {
              todayEventsList.add(event);
            } else if (event.season?.id == 'sr:season:102797' &&
                sportKey == 'NFL' &&
                (difference.inHours >= (-6))) {
              todayEventsList.add(event);
            } else if (event.season?.id == 'sr:season:101983' &&
                sportKey == 'NCAA' &&
                (difference.inHours >= (-6))) {
              todayEventsList.add(event);
            }
          }
        }
        todayEventsList.sort((a, b) => DateTime.parse(a.scheduled ?? "")
            .day
            .compareTo(DateTime.parse(b.scheduled ?? "").day));
      } else {
        isLoading.value = false;
        // showAppSnackBar(
        //   result.message,
        // );
      }
    } catch (e) {
      isLoading.value = false;
      log('ERORE----$e');
      showAppSnackBar(result.message);
    }
    update();
  }

  Future gameListingTomorrowApiRes(
      {String sportId = '',
      String date = "",
      String sportKey = "",
      bool isLoad = false,
      String key = ''}) async {
    // isLoading.value = !isLoad ? false : true;
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
        tomorrowEventsList.sort((a, b) => DateTime.parse(a.scheduled ?? "")
            .day
            .compareTo(DateTime.parse(b.scheduled ?? "").day));
      } else {
        isLoading.value = false;
        // showAppSnackBar(
        //   result.message,
        // );
      }
    } catch (e) {
      isLoading.value = false;
      log('ERORE----$e');
      showAppSnackBar(result.message);
    }
    update();
  }

  ///GET ALL EVENT BY HOME AWAY FILTER
  getAllEventList(String sportKey) async {
    sportEventsList.clear();
    sportEventsList = todayEventsList + tomorrowEventsList;
    sportEventsList.sort((a, b) => DateTime.parse(a.scheduled ?? "")
        .day
        .compareTo(DateTime.parse(b.scheduled ?? "").day));
    isLoading.value = false;
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

      if (event.consensus != null) {
        ///MONEY LINES
        if (event.markets.isNotEmpty) {
          for (var marketData in event.markets) {
            if (marketData.oddsTypeId == 4) {
              int fanDuelIndex = marketData.books
                  .indexWhere((element) => element.id == 'sr:book:18186');
              for (var bookData in marketData.books) {
                if (fanDuelIndex >= 0) {
                  if (bookData.id == 'sr:book:18186') {
                    if (bookData.outcomes?[0].type == 'home') {
                      event.homeSpread =
                          bookData.outcomes?[0].spread.toString() ?? '00';
                    }
                    if (bookData.outcomes?[1].type == 'away') {
                      event.awaySpread =
                          bookData.outcomes?[1].spread.toString() ?? '00';
                    }
                  }
                } else if (bookData.id == 'sr:book:28901') {
                  if (bookData.outcomes?[0].type == 'home') {
                    event.homeSpread =
                        bookData.outcomes?[0].spread.toString() ?? '';
                  }
                  if (bookData.outcomes?[1].type == 'away') {
                    event.awaySpread =
                        bookData.outcomes?[1].spread.toString() ?? '';
                  }
                } else if (bookData.id == 'sr:book:17324') {
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
        }
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
            /*if (consensus.name == 'run_line_current' ||
                consensus.name == 'spread_current') {
              event.homeSpread = '${consensus.spread}'.toString();
              event.awaySpread = '${consensus.spread}'.toString();
            }*/
          });
        }
      }
    }
  }

  bool _isBack = false;

  bool get isBack => _isBack;

  setIsBack(bool value) {
    _isBack = value;
    update();
  }

  bool _isBack1 = false;

  bool get isBack1 => _isBack1;

  setIsBack1(bool value) {
    _isBack1 = value;
    update();
  }

  ///BOX SCORE API
  Future boxScoreResponse(
      {String gameId = '',
      String homeTeamId = '',
      String awayTeamId = '',
      bool isLoad = false,
      String key = '',
      required int index}) async {
    // isLoading.value = !isLoad ? false : true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo().boxScoreRepo(gameId: gameId);
    try {
      if (result.status) {
        MLBBoxScoreModel response = MLBBoxScoreModel.fromJson(result.data);
        final game = response.game;
        if (game != null) {
          if (game.id == gameId) {
            // sportEventsList[index].venue?.temp =
            //     int.parse((game.weather?.forecast?.tempF ?? '0').toString());
            sportEventsList[index].inning =
                game.outcome?.currentInning.toString() ?? '';
            sportEventsList[index].inningHalf =
                game.outcome?.currentInningHalf.toString() ?? '';

            // sportEventsList[index].venue?.weather =
            //     game.weather?.forecast?.condition;
            if (game.home?.id == homeTeamId) {
              sportEventsList[index].homeScore = (game.home?.runs).toString();
              sportEventsList[index].homeWin = (game.home?.win).toString();
              sportEventsList[index].homeLoss = (game.home?.loss).toString();
              sportEventsList[index].homePlayerId =
                  (game.home?.probablePitcher?.id ?? "").toString();
              sportEventsList[index].wlHome =
                  ('${game.home?.probablePitcher?.win ?? '0'}-${game.home?.probablePitcher?.loss ?? '0'}')
                      .toString();
              sportEventsList[index].eraHome =
                  (game.home?.probablePitcher?.era ?? '0').toString();
              sportEventsList[index].homePlayerName =
                  ('${game.home?.probablePitcher?.preferredName?[0]}. ${game.home?.probablePitcher?.lastName}')
                      .toString();
            }
            if (game.away?.id == awayTeamId) {
              sportEventsList[index].awayScore = (game.away?.runs).toString();
              sportEventsList[index].awayWin = (game.away?.win).toString();
              sportEventsList[index].awayLoss = (game.away?.loss).toString();
              sportEventsList[index].awayPlayerId =
                  (game.away?.probablePitcher?.id ?? "").toString();
              sportEventsList[index].wlAway =
                  ('${game.away?.probablePitcher?.win ?? '0'}-${game.away?.probablePitcher?.loss ?? "0"}')
                      .toString();
              sportEventsList[index].eraAway =
                  (game.away?.probablePitcher?.era ?? '0').toString();
              sportEventsList[index].awayPlayerName =
                  ('${game.away?.probablePitcher?.preferredName?[0]}. ${game.away?.probablePitcher?.lastName}')
                      .toString();
            }
          }
        }
      } else {
        // showAppSnackBar(
        //   result.message,
        // );
      }
    } catch (e) {
      log('ERORE1----$e');
      // showAppSnackBar(
      //   errorText,
      // );
    }

    update();
  }

  Future boxScoreResponseNCAA(
      {String gameId = '',
      bool isLoad = false,
      String key = '',
      int index = 0}) async {
    isLoading.value = !isLoad ? false : true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result =
        await GameListingRepo().boxScoreRepoNCAA(gameId: gameId, sportKey: key);
    try {
      if (result.status) {
        NCAABoxScoreModel response = NCAABoxScoreModel.fromJson(result.data);
        final game = response;
        if (game.id == gameId) {
          String down = (game.situation?.down ?? "").toString();
          if ((down) == '1') {
            down = '${down}st';
          } else if ((down).toString().endsWith('1') &&
              !(down).toString().startsWith('1')) {
            down = '${down}st';
          } else if ((down).toString().endsWith('2') &&
              !(down).toString().startsWith('1')) {
            down = '${down}nd';
          } else if ((down).toString().endsWith('3') &&
              !(down).toString().startsWith('1')) {
            down = '${down}rd';
          } else {
            down = down;
          }
          /*sportEventsList[index].venue?.temp =
              int.parse((game.weather?.temp ?? '0').toString());
          sportEventsList[index].venue?.weather = game.weather?.condition;*/
          sportEventsList[index].inning = (game.quarter ?? "0").toString();
          sportEventsList[index].inningHalf = "Q";
          if (game.situation != null) {
            sportEventsList[index].currentTime =
                'Q${(game.quarter ?? "0")} ${game.situation?.clock ?? ""}, $down & ${game.situation?.yfd ?? ""}';
          } else {
            sportEventsList[index].currentTime = '';
          }

          sportEventsList[index].homeScore =
              (game.summary?.home?.points ?? "0").toString();
          sportEventsList[index].homeWin =
              (game.summary?.home?.record?.wins ?? "0").toString();
          sportEventsList[index].homeLoss =
              '${game.summary?.home?.record?.losses ?? "0"}'.toString();

          sportEventsList[index].awayScore =
              (game.summary?.away?.points ?? "0").toString();
          sportEventsList[index].awayWin =
              (game.summary?.away?.record?.wins ?? "0").toString();
          sportEventsList[index].awayLoss =
              (game.summary?.away?.record?.losses ?? "0").toString();
        }
      } else {
        // isLoading.value = false;
        // showAppSnackBar(
        //   result.message,
        // );
      }
    } catch (e) {
      // isLoading.value = false;
      // log('ERORE1----$e');
      // showAppSnackBar(
      //   errorText,
      // );
    }

    update();
  }

  bool _isPagination = false;

  bool get isPagination => _isPagination;

  set isPagination(bool value) {
    _isPagination = value;
    update();
  }

  ///GAME LISTING FOR ALL GAME
  Timer? timer;
  Timer? timerNCAA;
  getGameListingForNCAAGame(bool isLoad,
      {String apiKey = '',
      String sportKey = '',
      String date = '',
      String sportId = ''}) {
    gameListingTodayApiRes(
            key: apiKey,
            isLoad: isLoad,
            sportKey: sportKey,
            date: date,
            sportId: sportId)
        .then((value) async {
      tomorrowEventsList.clear();
      for (int i = 1; i <= 4; i++) {
        isPagination = true;
        gameListingTomorrowApiRes(
                key: apiKey,
                isLoad: isLoad,
                sportKey: sportKey,
                date: DateFormat('yyyy-MM-dd')
                    .format(DateTime.parse(date).add(Duration(days: i))),
                sportId: sportId)
            .then((value) {
          if (i == 4) {
            isPagination = false;
          }
          getAllEventList(sportKey);
          if (sportEventsList.isNotEmpty) {
            for (int i = 0; i < sportEventsList.length; i++) {
              if (sportEventsList[i].uuids != null) {
                getWeather(
                  sportEventsList[i].venue?.cityName ?? "",
                  index: i,
                );
                boxScoreResponseNCAA(
                    key: sportKey,
                    gameId: replaceId(sportEventsList[i].uuids ?? ''),
                    index: i);
              }
            }
          }
          gameListingsWithLogoResponse(DateTime.now().year.toString(), sportKey,
              isLoad: true);
        });
      }
      if (todayEventsList.isNotEmpty) {
        timerNCAA = Timer.periodic(const Duration(minutes: 1), (t) {
          if (isBack) {
            t.cancel();
            timerNCAA?.cancel();
            timerNCAA = null;
          } else {
            for (int i = 0; i < todayEventsList.length; i++) {
              if (DateTime.parse(todayEventsList[i].scheduled ?? "").day ==
                  DateTime.now().day) {
                if (todayEventsList[i].uuids != null) {
                  boxScoreResponseNCAA(
                      key: sportKey,
                      gameId: replaceId(todayEventsList[i].uuids ?? ''),
                      index: i);
                }
              }
            }
          }
        });
      }
    });
  }

  getGameListingForNFLGame(bool isLoad,
      {String apiKey = '',
      String sportKey = '',
      String date = '',
      String sportId = ''}) async {
    gameListingTodayApiRes(
            key: apiKey,
            isLoad: isLoad,
            sportKey: sportKey,
            date: date,
            sportId: sportId)
        .then((value) async {
      tomorrowEventsList.clear();
      for (int i = 1; i <= 6; i++) {
        isPagination = true;
        gameListingTomorrowApiRes(
                key: apiKey,
                isLoad: isLoad,
                sportKey: sportKey,
                date: DateFormat('yyyy-MM-dd')
                    .format(DateTime.parse(date).add(Duration(days: i))),
                sportId: sportId)
            .then((value) {
          if (i == 6) {
            isPagination = false;
          }
          getAllEventList(sportKey);
          if (sportEventsList.isNotEmpty) {
            for (int i = 0; i < sportEventsList.length; i++) {
              if (sportEventsList[i].uuids != null) {
                getWeather(
                  sportEventsList[i].venue?.cityName ?? "",
                  index: i,
                );
                boxScoreResponseNCAA(
                    key: sportKey,
                    gameId: replaceId(sportEventsList[i].uuids ?? ''),
                    index: i);
              }
            }
          }
          gameListingsWithLogoResponse(DateTime.now().year.toString(), sportKey,
              isLoad: true);
          // break;
          // }
        });
      }
      if (todayEventsList.isNotEmpty) {
        timerNCAA = Timer.periodic(const Duration(minutes: 1), (t) {
          if (isBack) {
            t.cancel();
            timerNCAA?.cancel();
            timerNCAA = null;
          } else {
            log('TODAY DATE---${todayEventsList.length}');
            for (int i = 0; i < todayEventsList.length; i++) {
              if (DateTime.parse(todayEventsList[i].scheduled ?? "").day ==
                  DateTime.now().day) {
                if (todayEventsList[i].uuids != null) {
                  boxScoreResponseNCAA(
                      key: sportKey,
                      gameId: replaceId(todayEventsList[i].uuids ?? ''),
                      index: i);
                }
              }
            }
          }
        });
      }
    });
  }

  @override
  void dispose() {
    timer = null;
    timerNCAA = null;
    super.dispose();
  }

  @override
  void onClose() {
    timer = null;
    timerNCAA = null;
    super.onClose();
    log('I am closed');
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
    gameListingTodayApiRes(
            key: apiKey,
            isLoad: isLoad,
            sportKey: sportKey,
            date: date,
            sportId: sportId)
        .then((value) async {
      gameListingTomorrowApiRes(
              key: apiKey,
              isLoad: isLoad,
              sportKey: sportKey,
              date: formatted,
              sportId: sportId)
          .then((value) {
        getAllEventList(sportKey);
        if (sportEventsList.isNotEmpty) {
          for (int i = 0; i < sportEventsList.length; i++) {
            if (sportEventsList[i].uuids != null) {
              getWeather(
                sportEventsList[i].venue?.cityName ?? "",
                index: i,
              );
              boxScoreResponse(
                  homeTeamId: replaceId(
                          sportEventsList[i].competitors[0].uuids ?? '') ??
                      "",
                  awayTeamId: replaceId(
                          sportEventsList[i].competitors[1].uuids ?? '') ??
                      "",
                  gameId: replaceId(sportEventsList[i].uuids ?? ''),
                  index: i);
            }
          }
        }
        if (todayEventsList.isNotEmpty) {
          timer = Timer.periodic(const Duration(minutes: 1), (t) {
            if (isBack) {
              t.cancel();
              timer?.cancel();
              timer = null;
            } else {
              log('TODAY DATE---${todayEventsList.length}');
              for (int i = 0; i < todayEventsList.length; i++) {
                if (DateTime.parse(todayEventsList[i].scheduled ?? "").day ==
                    DateTime.now().day) {
                  if (todayEventsList[i].uuids != null) {
                    boxScoreResponse(
                        homeTeamId: replaceId(
                                todayEventsList[i].competitors[0].uuids ??
                                    '') ??
                            "",
                        awayTeamId: replaceId(
                                todayEventsList[i].competitors[1].uuids ??
                                    '') ??
                            "",
                        gameId: replaceId(todayEventsList[i].uuids ?? ''),
                        index: i);
                  }
                }
              }
            }
          });
        }
        gameListingsWithLogoResponse(DateTime.now().year.toString(), sportKey,
            isLoad: isLoad);
      });
    });
  }

  ///other apis
  void gameListingsWithLogoResponse(String year, String sportKey,
      {bool isLoad = false}) async {
    // isLoading.value = !isLoad ? false : true;

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

  void getWeather(String cityName, {bool isLoad = false, int index = 0}) async {
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo().getWeather(cityName.split(',').first);
    try {
      if (result.status) {
        if (result.data != null) {
          sportEventsList[index].venue?.weather =
              result.data['weather'][0]['id'];
          sportEventsList[index].venue?.temp = result.data['main']['temp'] ?? 0;
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
      showAppSnackBar(e.toString());
    }
    update();
  }
}
