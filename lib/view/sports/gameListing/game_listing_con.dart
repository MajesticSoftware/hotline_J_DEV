import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hotlines/model/mlb_box_score_model.dart';

import 'package:intl/intl.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../constant/constant.dart';
import '../../../extras/constants.dart';
import '../../../model/game_listing.dart';
import '../../../model/ncaa_boxcore_model.dart';
import '../../../model/ranking_model.dart';
import '../../../model/response_item.dart';

import '../../../network/game_listing_repo.dart';

import '../../../theme/helper.dart';
import '../../../utils/extension.dart';

class GameListingController extends GetxController {
  late final WebViewController webController;

  @override
  void dispose() {
    timer = null;
    timerNCAA = null;
    super.dispose();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(NavigationDelegate(
        onPageFinished: (url) async {
          webController.runJavaScript(
              "document.getElementsByTagName('header')[0].style.display='none'");
          webController.runJavaScript(
              "document.getElementsByTagName('footer')[0].style.display='none'");
        },
      ))
      ..loadRequest(Uri.parse('https://www.hotlinesmd.com/contact'));
  }

  @override
  void onClose() {
    timer = null;
    timerNCAA = null;
    super.onClose();
    log('I am closed');
  }

  String sportId = 'sr:sport:16';
  String sportKey = 'NFL';
  String apiKey = 'brcnsyc4vqhxys2xhm8kbswz';
  String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
  List<String> isSelected = ['NFL'];
  String isSelectedGame = 'NFL';
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  set isDarkMode(bool value) {
    _isDarkMode = value;
    update();
  }

  bool _isSearch = false;

  bool get isSearch => _isSearch;

  set isSearch(bool value) {
    _isSearch = value;
    update();
  }

  RxBool isLoading = false.obs;
  TextEditingController searchCon = TextEditingController();
  List<SportEvents> _ncaaSportEventsList = [];

  List<SportEvents> get ncaaSportEventsList => _ncaaSportEventsList;

  set ncaaSportEventsList(List<SportEvents> value) {
    _ncaaSportEventsList = value;
    update();
  }

  List<SportEvents> _nflSportEventsList = [];

  List<SportEvents> get nflSportEventsList => _nflSportEventsList;

  set nflSportEventsList(List<SportEvents> value) {
    _nflSportEventsList = value;
    update();
  }

  List<SportEvents> _mlbSportEventsList = [];

  List<SportEvents> get mlbSportEventsList => _mlbSportEventsList;

  set mlbSportEventsList(List<SportEvents> value) {
    _mlbSportEventsList = value;
    update();
  }

  List<SportEvents> _searchList = [];

  List<SportEvents> get searchList => _searchList;

  set searchList(List<SportEvents> value) {
    _searchList = value;
    update();
  }

  bool _isPagination = false;

  bool get isPagination => _isPagination;

  set isPagination(bool value) {
    _isPagination = value;
    update();
  }

  bool _isBack = false;

  bool get isBack => _isBack;

  setIsBack(bool value) {
    _isBack = value;
    update();
  }

  bool _isBackNFL = false;

  bool get isBackNFL => _isBackNFL;

  setIsBackNFL(bool value) {
    _isBackNFL = value;
    update();
  }

  bool _isBackNCAA = false;

  bool get isBackNCAA => _isBackNCAA;

  setIsBackNCAA(bool value) {
    _isBackNCAA = value;
    update();
  }

  Future getResponse(bool isLoad, String sportKey) async {
    if (sportKey == 'MLB') {
      return await getGameListingForMLBRes(isLoad,
          apiKey: apiKey, sportKey: sportKey, date: date, sportId: sportId);
    } else if (sportKey == 'NFL') {
      return await getGameListingForNFLGame(isLoad,
          apiKey: apiKey, sportKey: sportKey, date: date, sportId: sportId);
    } else {
      return getGameListingForNCAAGame(isLoad,
          apiKey: apiKey, sportKey: sportKey, date: date, sportId: sportId);
    }
  }

  searchData(String text) {
    searchList.clear();
    if (text.isNotEmpty) {
      for (var element in (sportKey == 'MLB'
          ? mlbSportEventsList
          : sportKey == 'NFL'
              ? nflSportEventsList
              : ncaaSportEventsList)) {
        if ((mobileView.size.shortestSide < 600
                    ? element.homeTeamAbb
                    : element.homeTeam)
                .toString()
                .toLowerCase()
                .contains(text.trim().toString().toLowerCase()) ||
            (mobileView.size.shortestSide < 600
                    ? element.awayTeamAbb
                    : element.awayTeam)
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

  /* List<SportEvents> get sportEventList => sportEventList
      .where((id) => (getShovlerJobListByIndex(selectedTab) == "ALL"
          ? true
          : (status.status == getShovlerJobListByIndex(selectedTab) ||
              (selectedTab == 2 &&
                  status.isArrive &&
                  status.status == 'ACTIVE'))))
      .toList();*/

  List<SportEvents> _nflTodayEventsList = [];

  List<SportEvents> _mlbTodayEventsList = [];

  List<SportEvents> get mlbTodayEventsList => _mlbTodayEventsList;

  set mlbTodayEventsList(List<SportEvents> value) {
    _mlbTodayEventsList = value;
    update();
  }

  List<SportEvents> _ncaaTodayEventsList = [];
  List<SportEvents> _nflTomorrowEventsList = [];

  List<SportEvents> get nflTomorrowEventsList => _nflTomorrowEventsList;

  set nflTomorrowEventsList(List<SportEvents> value) {
    _nflTomorrowEventsList = value;
    update();
  }

  List<SportEvents> get ncaaTodayEventsList => _ncaaTodayEventsList;

  set ncaaTodayEventsList(List<SportEvents> value) {
    _ncaaTodayEventsList = value;
    update();
  }

  List<SportEvents> get ncaaTomorrowEventsList => _ncaaTomorrowEventsList;

  set ncaaTomorrowEventsList(List<SportEvents> value) {
    _ncaaTomorrowEventsList = value;
    update();
  }

  List<SportEvents> get nflTodayEventsList => _nflTodayEventsList;

  set nflTodayEventsList(List<SportEvents> value) {
    _nflTodayEventsList = value;
    update();
  }

  List<SportEvents> _mlbTomorrowEventsList = [];
  List<SportEvents> get mlbTomorrowEventsList => _mlbTomorrowEventsList;

  set mlbTomorrowEventsList(List<SportEvents> value) {
    _mlbTomorrowEventsList = value;
    update();
  }

  List<SportEvents> _ncaaTomorrowEventsList = [];

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
      if (sportKey == 'MLB') {
        mlbTodayEventsList.clear();
      } else if (sportKey == 'NFL') {
        nflTodayEventsList.clear();
      } else {
        ncaaTodayEventsList.clear();
      }
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
              mlbTodayEventsList.add(event);
            } else if (event.season?.id == 'sr:season:102797' &&
                sportKey == 'NFL' &&
                (difference.inHours >= (-6))) {
              nflTodayEventsList.add(event);
            } else if (event.season?.id == 'sr:season:101983' &&
                sportKey == 'NCAA' &&
                (difference.inHours >= (-6))) {
              ncaaTodayEventsList.add(event);
            }
          }
        }
        (sportKey == 'NFL'
                ? nflTodayEventsList
                : sportKey == 'MLB'
                    ? mlbTodayEventsList
                    : ncaaTodayEventsList)
            .sort((a, b) => DateTime.parse(a.scheduled ?? "")
                .compareTo(DateTime.parse(b.scheduled ?? "")));
      } else {
        isLoading.value = false;
        if (result.message == 'Error in response: No internet connection') {
          showAppSnackBar(
            result.message,
          );
        }
      }
    } catch (e) {
      isLoading.value = false;
      log('ERROR TODAY GAME LISTING--------$e');
      // showAppSnackBar(
      //   result.message,
      // );
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
              mlbTomorrowEventsList.add(event);
            } else if (event.season?.id == 'sr:season:102797' &&
                sportKey == 'NFL') {
              nflTomorrowEventsList.add(event);
            } else if (event.season?.id == 'sr:season:101983' &&
                sportKey == 'NCAA') {
              ncaaTomorrowEventsList.add(event);
            }
          }
        }
        (sportKey == 'NFL'
                ? nflTomorrowEventsList
                : sportKey == 'MLB'
                    ? mlbTomorrowEventsList
                    : ncaaTomorrowEventsList)
            .sort((a, b) => DateTime.parse(a.scheduled ?? "")
                .compareTo(DateTime.parse(b.scheduled ?? "")));
      } else {
        isLoading.value = false;
        // showAppSnackBar(
        //   result.message,
        // );
      }
    } catch (e) {
      isLoading.value = false;
      log('ERROR TOMORROW GAME LISTING-----$e');
      showAppSnackBar(errorText);
    }
    update();
  }

  ///GET ALL EVENT BY HOME AWAY FILTER
  getAllEventList(bool isLoad, String sportKey) async {
    if (sportKey == 'NFL') {
      nflSportEventsList.clear();
      nflSportEventsList = nflTodayEventsList + nflTomorrowEventsList;
      nflSportEventsList.sort((a, b) => DateTime.parse(a.scheduled ?? "")
          .compareTo(DateTime.parse(b.scheduled ?? "")));
      for (var event in nflSportEventsList) {
        if (event.competitors.isNotEmpty) {
          if (event.competitors[0].qualifier == 'home') {
            event.homeTeam = event.competitors[0].name ?? '';
            event.homeTeamAbb = event.competitors[0].abbreviation ?? '';
          } else {
            event.awayTeam = event.competitors[0].name ?? '';
            event.awayTeamAbb = event.competitors[0].abbreviation ?? '';
          }
          if (event.competitors[1].qualifier == 'away') {
            event.awayTeam = event.competitors[1].name ?? '';
            event.awayTeamAbb = event.competitors[1].abbreviation ?? '';
          } else {
            event.homeTeam = event.competitors[1].name ?? '';
            event.homeTeamAbb = event.competitors[1].abbreviation ?? '';
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
    } else if (sportKey == 'MLB') {
      mlbSportEventsList.clear();
      isLoading.value = isLoad;
      mlbSportEventsList = mlbTodayEventsList + mlbTomorrowEventsList;
      mlbSportEventsList.sort((a, b) => DateTime.parse(a.scheduled ?? "")
          .compareTo(DateTime.parse(b.scheduled ?? "")));

      for (var event in mlbSportEventsList) {
        if (event.competitors.isNotEmpty) {
          if (event.competitors[0].qualifier == 'home') {
            event.homeTeam = event.competitors[0].name ?? '';
            event.homeTeamAbb = event.competitors[0].abbreviation ?? '';
          } else {
            event.awayTeam = event.competitors[0].name ?? '';
            event.awayTeamAbb = event.competitors[0].abbreviation ?? '';
          }
          if (event.competitors[1].qualifier == 'away') {
            event.awayTeam = event.competitors[1].name ?? '';
            event.awayTeamAbb = event.competitors[1].abbreviation ?? '';
          } else {
            event.homeTeam = event.competitors[1].name ?? '';
            event.homeTeamAbb = event.competitors[1].abbreviation ?? '';
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
    } else {
      ncaaSportEventsList.clear();
      ncaaSportEventsList = ncaaTodayEventsList + ncaaTomorrowEventsList;
      ncaaSportEventsList.sort((a, b) => DateTime.parse(a.scheduled ?? "")
          .compareTo(DateTime.parse(b.scheduled ?? "")));
      for (var event in ncaaSportEventsList) {
        if (event.competitors.isNotEmpty) {
          if (event.competitors[0].qualifier == 'home') {
            event.homeTeam = event.competitors[0].name ?? '';
            event.homeTeamAbb = event.competitors[0].abbreviation ?? '';
          } else {
            event.awayTeam = event.competitors[0].name ?? '';
            event.awayTeamAbb = event.competitors[0].abbreviation ?? '';
          }
          if (event.competitors[1].qualifier == 'away') {
            event.awayTeam = event.competitors[1].name ?? '';
            event.awayTeamAbb = event.competitors[1].abbreviation ?? '';
          } else {
            event.homeTeam = event.competitors[1].name ?? '';
            event.homeTeamAbb = event.competitors[1].abbreviation ?? '';
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
            mlbSportEventsList[index].inning =
                game.outcome?.currentInning.toString() ?? '';
            mlbSportEventsList[index].inningHalf =
                game.outcome?.currentInningHalf.toString() ?? '';
            if (game.home?.id == homeTeamId) {
              mlbSportEventsList[index].homeScore =
                  (game.home?.runs).toString();
              mlbSportEventsList[index].homeWin = (game.home?.win).toString();
              mlbSportEventsList[index].homeLoss = (game.home?.loss).toString();
              mlbSportEventsList[index].homePlayerId =
                  (game.home?.probablePitcher?.id ?? "").toString();
              mlbSportEventsList[index].wlHome =
                  ('${game.home?.probablePitcher?.win ?? '0'}-${game.home?.probablePitcher?.loss ?? '0'}')
                      .toString();
              mlbSportEventsList[index].eraHome =
                  (game.home?.probablePitcher?.era ?? '0').toString();
              if (game.home?.probablePitcher != null) {
                mlbSportEventsList[index].homePlayerName =
                    ('${game.home?.probablePitcher?.preferredName?[0]}. ${game.home?.probablePitcher?.lastName}')
                        .toString();
              }
            }
            if (game.away?.id == awayTeamId) {
              mlbSportEventsList[index].awayScore =
                  (game.away?.runs).toString();
              mlbSportEventsList[index].awayWin = (game.away?.win).toString();
              mlbSportEventsList[index].awayLoss = (game.away?.loss).toString();
              mlbSportEventsList[index].awayPlayerId =
                  (game.away?.probablePitcher?.id ?? "").toString();
              mlbSportEventsList[index].wlAway =
                  ('${game.away?.probablePitcher?.win ?? '0'}-${game.away?.probablePitcher?.loss ?? "0"}')
                      .toString();
              mlbSportEventsList[index].eraAway =
                  (game.away?.probablePitcher?.era ?? '0').toString();
              if (game.away?.probablePitcher != null) {
                mlbSportEventsList[index].awayPlayerName =
                    ('${game.away?.probablePitcher?.preferredName?[0] ?? ""}. ${game.away?.probablePitcher?.lastName ?? ""}')
                        .toString();
              }
            }
          }
        }
      } else {
        // showAppSnackBar(
        //   result.message,
        // );
      }
    } catch (e) {
      log('ERROR BOX SCORE MLB----$e');
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
    // isLoading.value = !isLoad ? false : true;
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
          if (sportKey == 'NFL') {
            nflSportEventsList[index].inning = (game.quarter ?? "0").toString();
            nflSportEventsList[index].inningHalf = "Q";
            if (game.situation != null) {
              nflSportEventsList[index].currentTime =
                  'Q${(game.quarter ?? "0")} ${game.situation?.clock ?? ""}, $down & ${game.situation?.yfd ?? ""}';
            } else {
              nflSportEventsList[index].currentTime = '';
            }
            nflSportEventsList[index].homeScore =
                (game.summary?.home?.points ?? "0").toString();
            nflSportEventsList[index].awayScore =
                (game.summary?.away?.points ?? "0").toString();
          } else {
            ncaaSportEventsList[index].inning =
                (game.quarter ?? "0").toString();
            ncaaSportEventsList[index].inningHalf = "Q";
            if (game.situation != null) {
              ncaaSportEventsList[index].currentTime =
                  'Q${(game.quarter ?? "0")} ${game.situation?.clock ?? ""}, $down & ${game.situation?.yfd ?? ""}';
            } else {
              ncaaSportEventsList[index].currentTime = '';
            }
            ncaaSportEventsList[index].homeScore =
                (game.summary?.home?.points ?? "0").toString();
            ncaaSportEventsList[index].awayScore =
                (game.summary?.away?.points ?? "0").toString();
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
      log('ERROR BOX SCORE NFL && NCAA--------$e');
      // showAppSnackBar(
      //   errorText,
      // );
    }

    update();
  }

  ///NCAA RANKING
  Future ncaaGameRanking(
      {String awayTeamId = '',
      String homeTeamId = '',
      bool isLoad = false,
      required SportEvents gameDetails}) async {
    // isLoading.value = !isLoad ? false : true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo().ncaaGameRanking();
    try {
      if (result.status) {
        RankingModel response = RankingModel.fromJson(result.data);
        if (response.rankings != null) {
          response.rankings?.forEach((player) {
            if (player.id.toString() == homeTeamId) {
              gameDetails.homeRank = player.rank.toString();
            }
            if (player.id.toString() == awayTeamId) {
              gameDetails.awayRank = player.rank.toString();
            }
          });
        }
      } else {
        isLoading.value = false;
        // showAppSnackBar(
        //   result.message,
        // );
      }
    } catch (e) {
      isLoading.value = false;
      log('ERROR NCAA RANKING-------$e');
      showAppSnackBar(
        errorText,
      );
    }
    update();
  }

  ///GAME LISTING FOR ALL GAME
  Timer? timer;
  Timer? timerNCAA;
  Timer? timerNFL;
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
        .then((value) {
      ncaaTomorrowEventsList.clear();
      for (int i = 1; i <= 6; i++) {
        isPagination = isLoad;
        gameListingTomorrowApiRes(
                key: apiKey,
                isLoad: isLoad,
                sportKey: sportKey,
                date: DateFormat('yyyy-MM-dd')
                    .format(DateTime.parse(date).add(Duration(days: i))),
                sportId: sportId)
            .then((value) async {
          getAllEventList(isLoad, sportKey);
          gameListingsWithLogoResponse(DateTime.now().year.toString(), sportKey,
              isLoad: isLoad);
          if (i == 6) {
            isPagination = false;
          }
          if (ncaaSportEventsList.isNotEmpty) {
            for (int i = 0; i < ncaaSportEventsList.length; i++) {
              if (ncaaSportEventsList[i].uuids != null) {
                getWeather(
                  ncaaSportEventsList[i].venue?.cityName ?? "",
                  index: i,
                );
                boxScoreResponseNCAA(
                    key: sportKey,
                    gameId: replaceId(ncaaSportEventsList[i].uuids ?? ''),
                    index: i);
                ncaaGameRanking(
                  isLoad: false,
                  gameDetails: ncaaSportEventsList[i],
                  homeTeamId: replaceId(
                          ncaaSportEventsList[i].competitors[0].uuids ?? '') ??
                      "",
                  awayTeamId: replaceId(
                          ncaaSportEventsList[i].competitors[1].uuids ?? '') ??
                      "",
                );
              }
            }
          }
        });
      }
      if (ncaaTodayEventsList.isNotEmpty) {
        timerNCAA = Timer.periodic(const Duration(minutes: 1), (t) {
          if (isBackNCAA) {
            t.cancel();
            timerNCAA?.cancel();
            timerNCAA = null;
          } else {
            gameListingTodayApiRes(
                    key: apiKey,
                    isLoad: false,
                    sportKey: sportKey,
                    date: date,
                    sportId: sportId)
                .then((value) {
              ncaaTodayEventsList.sort((a, b) =>
                  DateTime.parse(a.scheduled ?? "")
                      .compareTo(DateTime.parse(b.scheduled ?? "")));

              for (var event in ncaaTodayEventsList) {
                if (event.competitors.isNotEmpty) {
                  if (event.competitors[0].qualifier == 'home') {
                    event.homeTeam = event.competitors[0].name ?? '';
                    event.homeTeamAbb = event.competitors[0].abbreviation ?? '';
                  } else {
                    event.awayTeam = event.competitors[0].name ?? '';
                    event.awayTeamAbb = event.competitors[0].abbreviation ?? '';
                  }
                  if (event.competitors[1].qualifier == 'away') {
                    event.awayTeam = event.competitors[1].name ?? '';
                    event.awayTeamAbb = event.competitors[1].abbreviation ?? '';
                  } else {
                    event.homeTeam = event.competitors[1].name ?? '';
                    event.homeTeamAbb = event.competitors[1].abbreviation ?? '';
                  }
                }

                if (event.consensus != null) {
                  ///MONEY LINES
                  if (event.markets.isNotEmpty) {
                    for (var marketData in event.markets) {
                      if (marketData.oddsTypeId == 4) {
                        int fanDuelIndex = marketData.books.indexWhere(
                            (element) => element.id == 'sr:book:18186');
                        for (var bookData in marketData.books) {
                          if (fanDuelIndex >= 0) {
                            if (bookData.id == 'sr:book:18186') {
                              if (bookData.outcomes?[0].type == 'home') {
                                event.homeSpread =
                                    bookData.outcomes?[0].spread.toString() ??
                                        '00';
                              }
                              if (bookData.outcomes?[1].type == 'away') {
                                event.awaySpread =
                                    bookData.outcomes?[1].spread.toString() ??
                                        '00';
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
              for (int i = 0; i < ncaaTodayEventsList.length; i++) {
                if (DateTime.parse(ncaaTodayEventsList[i].scheduled ?? "")
                            .toLocal()
                            .day ==
                        DateTime.now().day &&
                    ncaaTodayEventsList[i].status != 'closed') {
                  if (ncaaTodayEventsList[i].uuids != null) {
                    boxScoreResponseNCAA(
                        key: sportKey,
                        gameId: replaceId(ncaaTodayEventsList[i].uuids ?? ''),
                        index: i);
                  }
                }
              }
            });
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
        .then((value) {
      nflTomorrowEventsList.clear();
      for (int i = 1; i <= 6; i++) {
        isPagination = isLoad;
        gameListingTomorrowApiRes(
                key: apiKey,
                isLoad: isLoad,
                sportKey: sportKey,
                date: DateFormat('yyyy-MM-dd')
                    .format(DateTime.parse(date).add(Duration(days: i))),
                sportId: sportId)
            .then((value) {
          getAllEventList(isLoad, sportKey);
          if (i == 6) {
            isPagination = false;
          }
          gameListingsWithLogoResponse(DateTime.now().year.toString(), sportKey,
              isLoad: true);
          if (nflSportEventsList.isNotEmpty) {
            for (int i = 0; i < nflSportEventsList.length; i++) {
              if (nflSportEventsList[i].uuids != null) {
                getWeather(
                  nflSportEventsList[i].venue?.cityName ?? "",
                  index: i,
                );
                boxScoreResponseNCAA(
                    key: sportKey,
                    gameId: replaceId(nflSportEventsList[i].uuids ?? ''),
                    index: i);
              }
            }
          }
        });
      }
      if (nflTodayEventsList.isNotEmpty) {
        timerNFL = Timer.periodic(const Duration(minutes: 1), (t) {
          if (isBackNFL) {
            t.cancel();
            timerNFL?.cancel();
            timerNFL = null;
          } else {
            gameListingTodayApiRes(
                    key: apiKey,
                    isLoad: false,
                    sportKey: sportKey,
                    date: date,
                    sportId: sportId)
                .then((value) {
              nflTodayEventsList.sort((a, b) =>
                  DateTime.parse(a.scheduled ?? "")
                      .compareTo(DateTime.parse(b.scheduled ?? "")));
              for (var event in nflTodayEventsList) {
                if (event.competitors.isNotEmpty) {
                  if (event.competitors[0].qualifier == 'home') {
                    event.homeTeam = event.competitors[0].name ?? '';
                    event.homeTeamAbb = event.competitors[0].abbreviation ?? '';
                  } else {
                    event.awayTeam = event.competitors[0].name ?? '';
                    event.awayTeamAbb = event.competitors[0].abbreviation ?? '';
                  }
                  if (event.competitors[1].qualifier == 'away') {
                    event.awayTeam = event.competitors[1].name ?? '';
                    event.awayTeamAbb = event.competitors[1].abbreviation ?? '';
                  } else {
                    event.homeTeam = event.competitors[1].name ?? '';
                    event.homeTeamAbb = event.competitors[1].abbreviation ?? '';
                  }
                }
                if (event.consensus != null) {
                  ///MONEY LINES
                  if (event.markets.isNotEmpty) {
                    for (var marketData in event.markets) {
                      if (marketData.oddsTypeId == 4) {
                        int fanDuelIndex = marketData.books.indexWhere(
                            (element) => element.id == 'sr:book:18186');
                        for (var bookData in marketData.books) {
                          if (fanDuelIndex >= 0) {
                            if (bookData.id == 'sr:book:18186') {
                              if (bookData.outcomes?[0].type == 'home') {
                                event.homeSpread =
                                    bookData.outcomes?[0].spread.toString() ??
                                        '00';
                              }
                              if (bookData.outcomes?[1].type == 'away') {
                                event.awaySpread =
                                    bookData.outcomes?[1].spread.toString() ??
                                        '00';
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
                    });
                  }
                }
              }
              for (int i = 0; i < nflTodayEventsList.length; i++) {
                if (DateTime.parse(nflTodayEventsList[i].scheduled ?? "")
                            .toLocal()
                            .day ==
                        DateTime.now().day &&
                    nflTodayEventsList[i].status != 'closed') {
                  if (nflTodayEventsList[i].uuids != null) {
                    boxScoreResponseNCAA(
                        key: sportKey,
                        gameId: replaceId(nflTodayEventsList[i].uuids ?? ''),
                        index: i);
                  }
                }
              }
            });
          }
        });
      }
    });
  }

  getGameListingForMLBRes(bool isLoad,
      {String apiKey = '',
      String sportKey = '',
      String date = '',
      String sportId = ''}) async {
    mlbTomorrowEventsList.clear();
    gameListingTodayApiRes(
            key: apiKey,
            isLoad: isLoad,
            sportKey: sportKey,
            date: date,
            sportId: sportId)
        .then((value) {
      for (int i = 1; i <= 3; i++) {
        gameListingTomorrowApiRes(
                key: apiKey,
                isLoad: isLoad,
                sportKey: sportKey,
                date: DateFormat('yyyy-MM-dd')
                    .format(DateTime.parse(date).add(Duration(days: i))),
                sportId: sportId)
            .then((value) {
          getAllEventList(isLoad, sportKey);
          if (mlbSportEventsList.isNotEmpty) {
            for (int i = 0; i < mlbSportEventsList.length; i++) {
              getWeather(
                mlbSportEventsList[i].venue?.cityName ?? "",
                index: i,
              );
              if (mlbSportEventsList[i].uuids != null) {
                boxScoreResponse(
                    homeTeamId: replaceId(
                            mlbSportEventsList[i].competitors[0].uuids ?? '') ??
                        "",
                    awayTeamId: replaceId(
                            mlbSportEventsList[i].competitors[1].uuids ?? '') ??
                        "",
                    gameId: replaceId(mlbSportEventsList[i].uuids ?? ''),
                    index: i);
              }
            }
          }
          gameListingsWithLogoResponse(DateTime.now().year.toString(), sportKey,
              isLoad: isLoad);
        });
        if (i == 3) {
          isPagination = false;
        }
      }
      if (mlbTodayEventsList.isNotEmpty) {
        timer = Timer.periodic(const Duration(minutes: 1), (t) {
          if (isBack) {
            t.cancel();
            timer?.cancel();
            timer = null;
          } else {
            gameListingTodayApiRes(
                    key: apiKey,
                    isLoad: false,
                    sportKey: sportKey,
                    date: date,
                    sportId: sportId)
                .then((value) {
              mlbTodayEventsList.sort((a, b) =>
                  DateTime.parse(a.scheduled ?? "")
                      .compareTo(DateTime.parse(b.scheduled ?? "")));
              for (var event in mlbTodayEventsList) {
                if (event.competitors.isNotEmpty) {
                  if (event.competitors[0].qualifier == 'home') {
                    event.homeTeam = event.competitors[0].name ?? '';
                    event.homeTeamAbb = event.competitors[0].abbreviation ?? '';
                  } else {
                    event.awayTeam = event.competitors[0].name ?? '';
                    event.awayTeamAbb = event.competitors[0].abbreviation ?? '';
                  }
                  if (event.competitors[1].qualifier == 'away') {
                    event.awayTeam = event.competitors[1].name ?? '';
                    event.awayTeamAbb = event.competitors[1].abbreviation ?? '';
                  } else {
                    event.homeTeam = event.competitors[1].name ?? '';
                    event.homeTeamAbb = event.competitors[1].abbreviation ?? '';
                  }
                }

                if (event.consensus != null) {
                  ///MONEY LINES
                  if (event.markets.isNotEmpty) {
                    for (var marketData in event.markets) {
                      if (marketData.oddsTypeId == 4) {
                        int fanDuelIndex = marketData.books.indexWhere(
                            (element) => element.id == 'sr:book:18186');
                        for (var bookData in marketData.books) {
                          if (fanDuelIndex >= 0) {
                            if (bookData.id == 'sr:book:18186') {
                              if (bookData.outcomes?[0].type == 'home') {
                                event.homeSpread =
                                    bookData.outcomes?[0].spread.toString() ??
                                        '00';
                              }
                              if (bookData.outcomes?[1].type == 'away') {
                                event.awaySpread =
                                    bookData.outcomes?[1].spread.toString() ??
                                        '00';
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
              for (int i = 0; i < mlbTodayEventsList.length; i++) {
                if (DateTime.parse(mlbTodayEventsList[i].scheduled ?? "")
                            .toLocal()
                            .day ==
                        DateTime.now().day &&
                    mlbTodayEventsList[i].status != 'closed') {
                  if (mlbTodayEventsList[i].uuids != null) {
                    boxScoreResponse(
                        homeTeamId: replaceId(
                                mlbTodayEventsList[i].competitors[0].uuids ??
                                    '') ??
                            "",
                        awayTeamId: replaceId(
                                mlbTodayEventsList[i].competitors[1].uuids ??
                                    '') ??
                            "",
                        gameId: replaceId(mlbTodayEventsList[i].uuids ?? ''),
                        index: i);
                  }
                }
              }
            });
          }
        });
      }
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
                      for (var element in (sportKey == 'MLB'
                          ? mlbSportEventsList
                          : sportKey == 'NFL'
                              ? nflSportEventsList
                              : ncaaSportEventsList)) {
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
        // showAppSnackBar(
        //   errorText,
        // );
      }
    } catch (e) {
      isLoading.value = false;
      // showAppSnackBar(
      //   errorText,
      // );
    }
    update();
  }

  Future getWeather(String cityName,
      {bool isLoad = false, int index = 0}) async {
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo().getWeather(cityName.split(',').first);
    try {
      if (result.status) {
        if (result.data != null) {
          (sportKey == 'MLB'
                  ? mlbSportEventsList
                  : sportKey == 'NFL'
                      ? nflSportEventsList
                      : ncaaSportEventsList)[index]
              .weather = result.data['weather'][0]['id'];
          (sportKey == 'MLB'
                  ? mlbSportEventsList
                  : sportKey == 'NFL'
                      ? nflSportEventsList
                      : ncaaSportEventsList)[index]
              .temp = result.data['main']['temp'] ?? 0;
        }
      } else {
        isLoading.value = false;
        // showAppSnackBar(
        //   result.message,
        // );
      }
    } catch (e) {
      isLoading.value = false;
      log('ERROR WEATHER----$e');
      // showAppSnackBar(e.toString());
    }
    update();
  }
}
