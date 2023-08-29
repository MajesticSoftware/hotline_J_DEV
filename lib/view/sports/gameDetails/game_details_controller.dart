import 'dart:developer';

import 'package:get/get.dart';
import 'package:hotlines/model/mlb_injuries_model.dart';

import '../../../constant/constant.dart';
import '../../../model/DET_KC_model.dart';
import '../../../model/game_listing.dart';
import '../../../model/hotlines_data_model.dart';
import '../../../model/mlb_statics_model.dart' as stat;
import '../../../model/nfl_statics_model.dart';
import '../../../model/player_profile_model.dart';
import '../../../model/response_item.dart';
import '../../../network/game_listing_repo.dart';
import '../../../theme/helper.dart';

class GameDetailsController extends GetxController {
  List offensive = [
    'Offensive DVOA',
    'Points Per Game',
    'Scoring Efficiency',
    'Redzone Efficiency',
    'Rushing Yards',
    'Passing Yards',
    'Rushing TDs/game',
    'Passing TDs/game',
    'TO/game',
    '3rd Down Efficiency',
    '4th Down Efficiency',
    'Field goal Percentage',
  ];
  List hittingMLB = [
    'Runs Scored',
    'Hits',
    'HRs (Homeruns)',
    'RBI’s (Runs Batted In)',
    'Walks',
    'Strike Outs',
    'Stolen Bases',
    'Batting Average',
    'Slugging Percentage (SLG)',
    'On-Base + Slugging (OPS)',
    'Ground Into Double Play',
    'At Bats per home run',
  ];
  List defensive = [
    'Defensive DVOA',
    'Points Allowed/Game',
    'Opponent Scoring Efficiency',
    'Opponent Redzone Efficiency',
    'Rushing Yards Allowed',
    'Passing Yards Allowed',
    'Rushing TDs Allowed/game',
    'Passing TDs Allowed/game',
    'TO Generated/game',
    'Opponent 3rd Down Efficiency',
    'Opponent 4th Down Efficiency',
  ];
  List pitchingMLB = [
    'Earned Run Average (ERA)',
    'Shut Outs',
    'Save Percentage',
    'Blown Saves',
    'Quality Starts',
    'Runs Allowed',
    'Home runs Allowed',
    'Walks Allowed',
    'Strike Outs',
    'Walks & Hits Per Innings Pitched (WHIP)',
    'Opponents Batting Average',
    'Ground into Double Play',
    /*  'Strike Out Per 9 innings Pitched',
    'Walks Per 9 Innings Pitched',
    'Strike out to walk ratio',*/
  ];
  List teamPitcherMLB = [
    'W-L',
    'ERA',
    'WHIP',
    'IP',
    'H',
    'K',
    'BB',
    'HR',
  ];
  List teamBattingMLB = [
    'HRs',
    'Avg',
    'RBI',
  ];
  bool _isTab = true;

  bool get isTab => _isTab;

  set isTab(bool value) {
    _isTab = value;

    update();
  }

  int _isExpand = -1;

  int get isExpand => _isExpand;

  set isExpand(int value) {
    _isExpand = value;
    update();
  }

  /*int _isExpand1 = -1;

  int get isExpand1 => _isExpand1;

  set isExpand1(int value) {
    _isExpand1 = value;
    update();
  }*/

  RxBool isLoading = false.obs;
  stat.Statistics? mlbStaticsHomeList;
  stat.Statistics? mlbStaticsAwayList;
  List<stat.Players> mlbPlayerPitchingData = [];
  List mlbHomeHittingList = [];
  List mlbHomePitchingList = [];
  List mlbAwayHittingList = [];
  List mlbAwayPitchingList = [];
  List<MLBStaticsDataModel> mlbAwayPlayerBattingList = [];
  List<MLBStaticsDataModel> mlbHomePlayerBattingList = [];
  List<MLBPitchingStaticsModel> mlbAwayPlayerPitchingList = [];
  List<MLBPitchingStaticsModel> mlbHomePlayerPitchingList = [];
  List<HitterPlayerStatMainModel> hitterHomePlayerMainList = [];
  String _whipHome = '0';
  String get whipHome => _whipHome;
  set whipHome(String value) {
    _whipHome = value;
    update();
  }

  String _whipAway = '0';

  String get whipAway => _whipAway;

  set whipAway(String value) {
    _whipAway = value;
    update();
  }

  String _homeBb = '0';
  String get homeBb => _homeBb;

  set homeBb(String value) {
    _homeBb = value;
    update();
  }

  String _awayBb = '0';
  String get awayBb => _awayBb;

  set awayBb(String value) {
    _awayBb = value;
    update();
  }

  String _homeIp = '0';
  String get homeIp => _homeIp;

  set homeIp(String value) {
    _homeIp = value;
    update();
  }

  String _awayIp = '0';
  String get awayIp => _awayIp;

  set awayIp(String value) {
    _awayIp = value;
    update();
  }

  String _homeH = '0';
  String get homeH => _homeH;

  set homeH(String value) {
    _homeH = value;
    update();
  }

  String _awayKk = '0';
  String get awayKk => _awayKk;

  set awayKk(String value) {
    _awayKk = value;
    update();
  }

  String _awayH = '0';
  String get awayH => _awayH;

  set awayH(String value) {
    _awayH = value;
    update();
  }

  String _homeKk = '0';

  String get homeKk => _homeKk;

  set homeKk(String value) {
    _homeKk = value;
    update();
  }

  ///PLAYER PROFILE
  Future profileHomeResponse(
      {String homeTeamId = '', bool isLoad = false}) async {
    isLoading.value = !isLoad ? false : true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result =
        await GameListingRepo().mlbPlayerPitcherStatsRepo(playerId: homeTeamId);
    try {
      if (result.status) {
        if (result.data != null) {
          PlayerProfileModel response =
              PlayerProfileModel.fromJson(result.data);
          final playerData = response.player;

          for (var player in playerData.seasons) {
            if (player.type == 'REG' && player.year == DateTime.now().year) {
              whipHome =
                  player.totals.statistics.pitching.overall.whip.toString();
              homeBb =
                  (player.totals.statistics.pitching.overall.onbase?.bb ?? "0")
                      .toString();
              homeKk =
                  (player.totals.statistics.pitching.overall.outcome?.ktotal ??
                          "0")
                      .toString();
              homeH =
                  (player.totals.statistics.pitching.overall.onbase?.h ?? "0")
                      .toString();
              homeIp = player.totals.statistics.pitching.overall.ip1.toString();
            }
          }
        } else {
          isLoading.value = false;
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

  Future profileAwayResponse(
      {String awayTeamId = '', bool isLoad = false}) async {
    isLoading.value = !isLoad ? false : true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result =
        await GameListingRepo().mlbPlayerPitcherStatsRepo(playerId: awayTeamId);
    try {
      if (result.status) {
        if (result.data != null) {
          PlayerProfileModel response =
              PlayerProfileModel.fromJson(result.data);
          final playerData = response.player;
          for (var player in playerData.seasons) {
            if (player.type == 'REG' && player.year == DateTime.now().year) {
              whipAway =
                  player.totals.statistics.pitching.overall.whip.toString();
              awayBb =
                  (player.totals.statistics.pitching.overall.onbase?.bb ?? "0")
                      .toString();
              awayKk =
                  (player.totals.statistics.pitching.overall.outcome?.ktotal ??
                          "0")
                      .toString();
              awayH =
                  (player.totals.statistics.pitching.overall.onbase?.h ?? "0")
                      .toString();
              awayIp = player.totals.statistics.pitching.overall.ip1.toString();
            }
          }
        } else {
          isLoading.value = false;
        }
      } else {
        isLoading.value = false;
        showAppSnackBar(
          result.message,
        );
      }
    } catch (e) {
      isLoading.value = false;
      log('ERORE13333----$e');
      showAppSnackBar(
        errorText,
      );
    }
    update();
  }

  ///MLB STATICS
  Future mlbStaticsHomeTeamResponse(
      {String homeTeamId = '', bool isLoad = false}) async {
    isLoading.value = !isLoad ? false : true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo()
        .mlbStaticsRepo(teamId: homeTeamId, seasons: '2023');
    try {
      mlbHomePlayerBattingList.clear();

      hitterHomePlayerMainList.clear();
      if (result.status) {
        stat.MLBStaticsModel response =
            stat.MLBStaticsModel.fromJson(result.data);
        if (response.statistics != null) {
          mlbStaticsHomeList = response.statistics;
          mlbPlayerPitchingData = response.players ?? [];
          var homeHitting = mlbStaticsHomeList?.hitting?.overall;
          var homePitching = mlbStaticsHomeList?.pitching?.overall;
          for (var player in mlbPlayerPitchingData) {
            if (player.statistics?.hitting != null) {
              if (player.position != "P") {
                hitterHomePlayerMainList.add(
                  HitterPlayerStatMainModel(
                      playerName: '${player.firstName?[0]}. ${player.lastName}',
                      avg: '${player.statistics?.hitting?.overall?.avg}',
                      bb: '${player.statistics?.hitting?.overall?.onbase?.bb}',
                      hAbValue:
                          '${player.statistics?.hitting?.overall?.onbase?.h}-${player.statistics?.hitting?.overall?.ab}',
                      hr: '${player.statistics?.hitting?.overall?.onbase?.hr}',
                      position: '${player.position}',
                      rbi: '${player.statistics?.hitting?.overall?.rbi}',
                      sb:
                          '${player.statistics?.hitting?.overall?.steal?.stolen}',
                      obp: 'OBP',
                      obpValue: '${player.statistics?.hitting?.overall?.obp}',
                      hAb: 'H-AB',
                      slg: 'SLG',
                      slgValue: '${player.statistics?.hitting?.overall?.slg}',
                      run: 'Runs',
                      runValue:
                          '${player.statistics?.hitting?.overall?.runs?.total}',
                      totalBase: 'Total Bases',
                      totalBaseValue:
                          '${player.statistics?.hitting?.overall?.onbase?.tb}',
                      stolenBase: 'Stolen Bases',
                      ab: '${player.statistics?.hitting?.overall?.ab}',
                      stolenBaseValue:
                          '${player.statistics?.hitting?.overall?.steal?.stolen}'),
                );
              }
            }
          }

          mlbHomeHittingList = [
            '${homeHitting?.runs?.total ?? "0"}',
            '${homeHitting?.onbase?.h ?? "0"}',
            '${homeHitting?.onbase?.hr ?? "0"}',
            '${homeHitting?.rbi ?? "0"}',
            '${homeHitting?.onbase?.bb ?? "0"}',
            '${homeHitting?.outs?.ktotal ?? "0"}',
            '${homeHitting?.steal?.stolen ?? "0"}',
            homeHitting?.avg ?? "0",
            '.${(homeHitting?.slg ?? 0).toString().split('.').last}',
            '${homeHitting?.ops ?? '0'}',
            '${homeHitting?.outs?.gidp ?? '0'}',
            homeHitting?.abhr?.toStringAsFixed(2) ?? "0",
          ];
          mlbHomePitchingList = [
            '${homePitching?.era ?? '0'}',
            '${homePitching?.games?.shutout ?? '0'}',
            '.${(((homePitching?.games?.save ?? 0) / (homePitching?.games?.svo ?? 0)).toStringAsFixed(3).split('.').last)}',
            '${homePitching?.games?.blownSave ?? '0'}',
            '${homePitching?.games?.qstart ?? '0'}',
            '${homePitching?.runs?.total ?? '0'}',
            '${homePitching?.onbase?.hr ?? '0'}',
            '${homePitching?.onbase?.bb ?? '0'}',
            '${homePitching?.outs?.ktotal ?? '0'}',
            '${homePitching?.whip ?? "0"}',
            '.${(homePitching?.oba ?? 0).toString().split('.').last}',
            '${homePitching?.outs?.gidp ?? "0"}',
          ];
        }
      } else {
        isLoading.value = false;

        showAppSnackBar(
          result.message,
        );
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      log('ERORE STATIC----$e');
      showAppSnackBar(
        errorText,
      );
    }
    update();
  }

  List<HitterPlayerStatMainModel> hitterAwayPlayerMainList = [];
  Future mlbStaticsAwayTeamResponse(
      {String awayTeamId = '', bool isLoad = false}) async {
    isLoading.value = !isLoad ? false : true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo()
        .mlbStaticsRepo(teamId: awayTeamId, seasons: '2023');
    try {
      mlbAwayPlayerBattingList.clear();

      hitterAwayPlayerMainList.clear();
      if (result.status) {
        stat.MLBStaticsModel response =
            stat.MLBStaticsModel.fromJson(result.data);
        if (response.statistics != null) {
          mlbStaticsAwayList = response.statistics;
          mlbPlayerPitchingData = response.players ?? [];
        }
        var awayHitting = mlbStaticsAwayList?.hitting?.overall;
        var awayPitching = mlbStaticsAwayList?.pitching?.overall;
        for (var player in mlbPlayerPitchingData) {
          if (player.statistics?.hitting != null) {
            if (player.position != 'P') {
              hitterAwayPlayerMainList.add(
                HitterPlayerStatMainModel(
                    bb: '${player.statistics?.hitting?.overall?.onbase?.bb}',
                    playerName: '${player.firstName?[0]}. ${player.lastName}',
                    avg: '${player.statistics?.hitting?.overall?.avg}',
                    hAbValue:
                        '${player.statistics?.hitting?.overall?.onbase?.h}-${player.statistics?.hitting?.overall?.ab}',
                    hr: '${player.statistics?.hitting?.overall?.onbase?.hr}',
                    position: '${player.position}',
                    rbi: '${player.statistics?.hitting?.overall?.rbi}',
                    sb: '${player.statistics?.hitting?.overall?.steal?.stolen}',
                    obp: 'OBP',
                    obpValue: '${player.statistics?.hitting?.overall?.obp}',
                    hAb: 'H-AB',
                    slg: 'SLG',
                    slgValue: '${player.statistics?.hitting?.overall?.slg}',
                    run: 'Runs',
                    runValue:
                        '${player.statistics?.hitting?.overall?.runs?.total}',
                    totalBase: 'Total Bases',
                    totalBaseValue:
                        '${player.statistics?.hitting?.overall?.onbase?.tb}',
                    stolenBase: 'Stolen Bases',
                    ab: '${player.statistics?.hitting?.overall?.ab}',
                    stolenBaseValue:
                        '${player.statistics?.hitting?.overall?.steal?.stolen}'),
              );
            }
          }
        }

        mlbAwayHittingList = [
          '${awayHitting?.runs?.total ?? "0"}',
          '${awayHitting?.onbase?.h ?? "0"}',
          '${awayHitting?.onbase?.hr ?? "0"}',
          '${awayHitting?.rbi ?? "0"}',
          '${awayHitting?.onbase?.bb ?? "0"}',
          '${awayHitting?.outs?.ktotal ?? "0"}',
          '${awayHitting?.steal?.stolen ?? "0"}',
          awayHitting?.avg ?? "0",
          '.${(awayHitting?.slg.toString().split('.').last)}',
          '${awayHitting?.ops ?? '0'}',
          '${awayHitting?.outs?.gidp ?? '0'}',
          awayHitting?.abhr?.toStringAsFixed(2) ?? "0",
        ];
        mlbAwayPitchingList = [
          '${awayPitching?.era ?? '0'}',
          '${awayPitching?.games?.shutout ?? '0'}',
          '.${(((awayPitching?.games?.save ?? 0) / (awayPitching?.games?.svo ?? 0)).toStringAsFixed(3).split('.').last)}',
          '${awayPitching?.games?.blownSave ?? '0'}',
          '${awayPitching?.games?.qstart ?? '0'}',
          '${awayPitching?.runs?.total ?? '0'}',
          '${awayPitching?.onbase?.hr ?? '0'}',
          '${awayPitching?.onbase?.bb ?? '0'}',
          '${awayPitching?.outs?.ktotal ?? '0'}',
          '${awayPitching?.whip ?? "0"}',
          '.${(awayPitching?.oba ?? 0).toString().split('.').last}',
          '${awayPitching?.outs?.gidp ?? "0"}',
        ];

        // isLoading.value = false;
      } else {
        isLoading.value = false;
        showAppSnackBar(
          result.message,
        );
      }
    } catch (e) {
      isLoading.value = false;
      log('ERROR STATIC ----$e');
      showAppSnackBar(
        errorText,
      );
    }
    update();
  }

  ///NFL STATICS
  TeamRecords? nflStaticsHomeList;
  TeamRecords? nflStaticsAwayList;
  List nflHomeOffensiveList = [];
  List nflHomeDefensiveList = [];
  List nflAwayOffensiveList = [];
  List nflAwayDefensiveList = [];
  Future nflStaticsHomeTeamResponse(
      {String homeTeamId = '', bool isLoad = false}) async {
    isLoading.value = !isLoad ? false : true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo()
        .nflStaticsRepo(teamId: homeTeamId, seasons: '2023');
    try {
      if (result.status) {
        if (result.data != null) {
          NFLStaticsModel response = NFLStaticsModel.fromJson(result.data);
          if (response.season != null) {
            if (response.season?.team?.teamRecords != null) {
              nflStaticsHomeList = response.season?.team?.teamRecords;
              var offenciveData = nflStaticsHomeList?.record;
              var defenciveData = nflStaticsHomeList?.opponents;
              nflHomeOffensiveList = [
                '0',
                '0',
                '0',
                offenciveData?.efficiency?.redzone ?? '0',
                offenciveData?.rushing ?? '0',
                offenciveData?.passing ?? '0',
                '0',
                '0',
                '0',
                offenciveData?.efficiency?.thirddown ?? '0',
                offenciveData?.efficiency?.fourthdown ?? '0',
                '0'
              ];
              nflHomeDefensiveList = [
                '0',
                '0',
                '0',
                defenciveData?.efficiency?.redzone ?? "0",
                defenciveData?.rushing ?? '0',
                defenciveData?.passing ?? '0',
                '0',
                '0',
                '0',
                defenciveData?.efficiency?.thirddown ?? '0',
                defenciveData?.efficiency?.fourthdown ?? '0',
              ];
            }
          }
        } else {
          isLoading.value = false;
          // showAppSnackBar(
          //   result.message,
          // );
        }
      } else {
        isLoading.value = false;
        showAppSnackBar(
          result.message,
        );
      }

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      log('ERORE1----$e');
      showAppSnackBar(
        errorText,
      );
    }
    update();
  }

  Future nflStaticsAwayTeamResponse(
      {String awayTeamId = '', bool isLoad = false}) async {
    isLoading.value = !isLoad ? false : true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo()
        .nflStaticsRepo(teamId: awayTeamId, seasons: '2023');
    try {
      if (result.status) {
        if (result.data != null) {
          NFLStaticsModel response = NFLStaticsModel.fromJson(result.data);
          if (response.season != null) {
            if (response.season?.team?.teamRecords != null) {
              nflStaticsAwayList = response.season?.team?.teamRecords;
              var offenciveData = response.season?.team?.teamRecords?.record;
              var defenciveData = response.season?.team?.teamRecords?.opponents;
              nflAwayOffensiveList = [
                '0',
                '0',
                '0',
                offenciveData?.efficiency?.redzone ?? '0',
                offenciveData?.rushing ?? '0',
                offenciveData?.passing ?? '0',
                '0',
                '0',
                '0',
                offenciveData?.efficiency?.thirddown ?? '0',
                offenciveData?.efficiency?.fourthdown ?? '0',
                '0',
              ];
              nflAwayDefensiveList = [
                '0',
                '0',
                '0',
                defenciveData?.efficiency?.redzone ?? "0",
                defenciveData?.rushing ?? '0',
                defenciveData?.passing ?? '0',
                '0',
                '0',
                '0',
                defenciveData?.efficiency?.thirddown ?? '0',
                defenciveData?.efficiency?.fourthdown ?? '0',
              ];
            }
          }
        } else {
          isLoading.value = false;
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

  ///HOTLINES DATA
  List<HotlinesModel> _hotlinesFData = [];

  List<HotlinesModel> get hotlinesFData => _hotlinesFData;

  set hotlinesFData(List<HotlinesModel> value) {
    _hotlinesFData = value;
    update();
  }

  List<HotlinesModel> _hotlinesMData = [];
  List<HotlinesModel> hotlinesMainData = [];
  List<HotlinesModel> _hotlinesDData = [];
  List<HotlinesModel> hotlinesFinalData = [];
  List<HotlinesModel> _hotlinesData = [];
  List<HotlinesModel> get hotlinesData => _hotlinesData;
  set hotlinesData(List<HotlinesModel> value) {
    _hotlinesData = value.toSet().toList();
    update();
  }

  String hotlinesOdd = '';
  String hotlinesDecimal = '';
  String hotlinesDec = '';
  String hotlinesType = '';
  bool _isHotlines = false;
  bool get isHotlines => _isHotlines;
  set isHotlines(bool value) {
    _isHotlines = value;
    update();
  }

  Future hotlinesDataResponse(
      {String awayTeamId = '',
      String sportId = '',
      String date = '',
      bool isLoad = false,
      int start = 0,
      String homeTeamId = ''}) async {
    isHotlines = true;
    isLoading.value = !isLoad ? false : true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo()
        .hotlinesDataRepo(sportId: sportId, date: date, start: start);
    try {
      isHotlines = true;
      if (result.status) {
        HotlinesDataModel response = HotlinesDataModel.fromJson(result.data);
        final sportScheduleSportEventsPlayersProps =
            response.sportScheduleSportEventsPlayersProps;
        if (sportScheduleSportEventsPlayersProps != null) {
          for (var event in sportScheduleSportEventsPlayersProps) {
            if (event.sportEvent?.competitors?[0].id == homeTeamId &&
                event.sportEvent?.competitors?[1].id == awayTeamId) {
              event.playersProps?.forEach((playersProp) {
                playersProp.markets?.forEach((market) {
                  market.books?.forEach((book) {
                    if (book.id == 'sr:book:18186' ||
                        book.id == 'sr:book:18149' ||
                        book.id == 'sr:book:17324') {
                      book.outcomes?.forEach((outcome) {
                        if (outcome.oddsAmerican != null) {
                          if (!int.parse(outcome.oddsAmerican ?? '')
                              .isNegative) {
                            hotlinesMainData.add(HotlinesModel(
                                teamName:
                                    '${playersProp.player?.name?.split(',').last.removeAllWhitespace ?? ''} ${playersProp.player?.name?.split(',').first.removeAllWhitespace ?? ''} ${outcome.type.toString().capitalizeFirst} ${outcome.total} ${market.name?.split('(').first.toString().capitalize}',
                                tittle: market.name
                                        ?.split('(')
                                        .first
                                        .toString()
                                        .capitalize ??
                                    '',
                                playerName:
                                    playersProp.player?.name?.split(',').last ??
                                        '',
                                bookId: book.id ?? '',
                                value: '${outcome.oddsAmerican}'));
                            hotlinesFData.clear();
                            hotlinesDData.clear();
                            hotlinesMData.clear();
                            hotlinesMainData.sort((a, b) => int.parse(b.value)
                                .compareTo(int.parse(a.value)));
                            for (var element in hotlinesMainData) {
                              if (element.bookId == 'sr:book:18149') {
                                if (!(hotlinesDData.indexWhere((fData) =>
                                        fData.playerName ==
                                        element.playerName) >=
                                    0)) {
                                  if (!(hotlinesDData.indexWhere((fData) =>
                                          fData.tittle == element.tittle) >=
                                      0)) {
                                    hotlinesDData.add(element);
                                  }
                                }
                              }
                              if (element.bookId == 'sr:book:17324') {
                                if (!(hotlinesMData.indexWhere((fData) =>
                                        fData.playerName ==
                                        element.playerName) >=
                                    0)) {
                                  if (!(hotlinesMData.indexWhere((fData) =>
                                          fData.tittle == element.tittle) >=
                                      0)) {
                                    hotlinesMData.add(element);
                                  }
                                }
                              }
                              if (element.bookId == 'sr:book:18186') {
                                if (hotlinesFData.indexWhere((fData) =>
                                        fData.playerName !=
                                        element.playerName) >=
                                    0) {
                                  if (hotlinesFData.indexWhere((fData) =>
                                          fData.tittle != element.tittle) >=
                                      0) {
                                    hotlinesFData.add(element);
                                  }
                                }
                              }
                            }
                          }
                        }
                      });
                    }
                  });
                });
              });
            }
          }
          hotlinesData.clear();
          if (hotlinesDData.isNotEmpty) {
            hotlinesDData.sort(
                (a, b) => int.parse(b.value).compareTo(int.parse(a.value)));
            for (int i = 0; i < 2; i++) {
              hotlinesData.add(hotlinesDData[i]);
            }
          }
          if (hotlinesMData.isNotEmpty) {
            hotlinesMData.sort(
                (a, b) => int.parse(b.value).compareTo(int.parse(a.value)));
            for (var main in hotlinesMData) {
              if (!(hotlinesData.indexWhere(
                      (element) => element.playerName == main.playerName) >=
                  0)) {
                if (hotlinesData.length <= 3) {
                  hotlinesData.add(main);
                } else {
                  break;
                }
              }
            }
          }
          if (hotlinesFData.isNotEmpty) {
            hotlinesFData.sort(
                (a, b) => int.parse(b.value).compareTo(int.parse(a.value)));
            for (var main in hotlinesFData) {
              if (!(hotlinesData.indexWhere(
                      (element) => element.playerName == main.playerName) >=
                  0)) {
                if (hotlinesData.length <= 5) {
                  hotlinesData.add(main);
                } else {
                  break;
                }
              }
            }
          }
          hotlinesData
              .sort((a, b) => int.parse(b.value).compareTo(int.parse(a.value)));
          update();
        }
      } else {
        isHotlines = false;
        showAppSnackBar(
          result.message,
        );
      }
      // isHotlines.value = false;
    } catch (e) {
      isHotlines = false;
      log('ERROR>>>>>>>>----$e');
      // showAppSnackBar(
      //   errorText,
      // );
    }
    update();
    return hotlinesFinalData;
  }

  ///MLB INJURY REPORT
  Future mlbInjuriesResponse(
      {String awayTeamId = '',
      String homeTeamId = '',
      SportEvents? sportEvent,
      bool isLoad = false}) async {
    isLoading.value = !isLoad ? false : true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo().mlbInjuriesRepo();
    try {
      sportEvent?.homeTeamInjuredPlayer.clear();
      sportEvent?.awayTeamInjuredPlayer.clear();
      if (result.status) {
        MLBInjuriesModel response = MLBInjuriesModel.fromJson(result.data);
        if (response.teams != null) {
          response.teams?.forEach((team) {
            if (team.id == awayTeamId) {
              team.players?.forEach((player) {
                if (player.status != 'A') {
                  sportEvent?.awayTeamInjuredPlayer.add(
                      '${player.firstName?[0]}. ${player.lastName}(${player.status})');
                }
              });
            }
            if (team.id == homeTeamId) {
              team.players?.forEach((player) {
                if (player.status != 'A') {
                  sportEvent?.homeTeamInjuredPlayer.add(
                      '${player.firstName?[0]}. ${player.lastName}(${player.status})');
                }
              });
            }
          });
        }
        // isLoading.value = false;
      } else {
        isLoading.value = false;
        showAppSnackBar(
          result.message,
        );
      }
    } catch (e) {
      isLoading.value = false;
      log('ERROR1----$e');
      showAppSnackBar(
        errorText,
      );
    }
    update();
  }

  List<HotlinesModel> get hotlinesMData => _hotlinesMData;

  set hotlinesMData(List<HotlinesModel> value) {
    _hotlinesMData = value;
    update();
  }

  List<HotlinesModel> get hotlinesDData => _hotlinesDData;

  set hotlinesDData(List<HotlinesModel> value) {
    _hotlinesDData = value;
    update();
  }
}

///MLB STATICS MODEL
class MLBStaticsDataModel {
  String hrsValue;
  String avgValue;
  String rbiValue;
  String playerName;

  MLBStaticsDataModel(
      {required this.hrsValue,
      required this.avgValue,
      required this.rbiValue,
      required this.playerName});
}

class MLBPitchingStaticsModel {
  String playerName;
  String wl;
  String era;
  String whip;
  String ip;
  String h;
  String k;
  String bb;
  String hr;

  MLBPitchingStaticsModel({
    required this.playerName,
    required this.wl,
    required this.era,
    required this.whip,
    required this.ip,
    required this.h,
    required this.k,
    required this.bb,
    required this.hr,
  });
}

class HitterPlayerStatMainModel {
  String playerName;
  String position;
  String hr;
  String rbi;
  String sb;
  String bb;
  String avg;
  String run;
  String runValue;
  String totalBase;
  String totalBaseValue;
  String stolenBase;
  String stolenBaseValue;
  String obp;
  String obpValue;
  String slg;
  String slgValue;
  String hAb;
  String ab;
  String hAbValue;
  HitterPlayerStatMainModel({
    required this.playerName,
    required this.position,
    required this.hr,
    required this.rbi,
    required this.sb,
    required this.bb,
    required this.avg,
    required this.run,
    required this.runValue,
    required this.totalBase,
    required this.totalBaseValue,
    required this.stolenBase,
    required this.stolenBaseValue,
    required this.obp,
    required this.obpValue,
    required this.slg,
    required this.slgValue,
    required this.hAb,
    required this.ab,
    required this.hAbValue,
  });
}
