import 'dart:developer';
import 'package:collection/collection.dart';
import 'package:hotlines/model/game_listing.dart';
import 'package:get/get.dart';
import 'package:hotlines/model/mlb_injuries_model.dart';
import 'package:hotlines/model/nba_player_profile_model.dart';
import 'package:hotlines/model/nfl_injury_model.dart';

import 'package:hotlines/utils/utils.dart';
import 'package:intl/intl.dart';

import '../../../constant/constant.dart';
import '../../../model/depth_chart_model.dart';
import '../../../model/game_model.dart';

import '../../../model/hotlines_data_model.dart' as hotlines;
import '../../../model/mlb_statics_model.dart' as stat;
import '../../../model/nba_roster_model.dart';
import '../../../model/nfl_statics_model.dart';
import '../../../model/nfl_team_record_model.dart';
import '../../../model/player_profile_model.dart';
import '../../../model/player_profile_nfl_model.dart';
import '../../../model/response_item.dart';
import '../../../model/roster_model.dart';
import '../../../model/team_record_model.dart';
import '../../../network/game_listing_repo.dart';
import '../../../theme/helper.dart';

class GameDetailsController extends GetxController {
  List<String> awayQb = [];
  List<String> homeQb = [];
  List<String> homeDefense = [];
  List<String> awayDefense = [];

  List offensive = [
    'Points Per Game',
    'Rushing Yards/Game',
    'Passing Yards/Game',
    'Rushing TDs/Game',
    'Passing TDs/Game',
    'Redzone Efficiency',
    '3rd Down Efficiency',
    '4th Down Efficiency',
    'Field goal Percentage',
    'Turnovers / Game',
  ];
  List nbaOffensive = [
    'Points Per Game',
  ];
  List hittingMLB = [
    'Runs Scored/Game',
    'Hits/Game',
    'HRs (Homeruns)/Game',
    'RBI’s (Runs Batted In)/Game',
    'Walks/Game',
    'Strike Outs/Game',
    'Stolen Bases/Game',
    'Batting Average',
    'Slugging Percentage (SLG)',
    'On-Base + Slugging (OPS)',
    'Ground Into Double Play/Game',
    'At Bats per home run',
  ];
  List defensive = [
    'Points Allowed/Game',
    'Rushing Yards Allowed/Game',
    'Passing Yards Allowed/Game',
    'Rushing TDs Allowed/Game',
    'Passing TDs Allowed/Game',
    'Opponent Redzone Efficiency',
    'Opponent 3rd Down Efficiency',
    'Opponent 4th Down Efficiency',
    'Field goal Percentage',
    'Turnovers Created/ Game'
  ];
  List nbaDefensive = [
    'Points Allowed/Game',
  ];
  List pitchingMLB = [
    'Earned Run Average (ERA)',
    'Shut Outs',
    'Save Percentage',
    'Blown Saves',
    'Quality Starts',
    'Runs Allowed/Game',
    'Home runs Allowed/Game',
    'Walks Allowed/Game',
    'Strike Outs/Game',
    'Walks & Hits Per Innings Pitched (WHIP)',
    'Opponents Batting Average',
    'Ground into Double Play/Game',
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
  List teamQuarterBacks = [
    'Passing Yards/Game',
    'Passing TDs/Game',
    'Rushing Yards/Game',
    'Rushing TDs/Game',
    'Interceptions',
  ];
  List teamQuarterBacksDefence = [
    'Passing Yards Allowed/Game',
    'Passing TDs Allowed/Game',
    'Rushing Yards Allowed/Game',
    'Rushing TDs Allowed/Game',
    'Interceptions',
  ];
  /*bool _isQuarterBacksTab = true;

  bool get isQuarterBacksTab => _isQuarterBacksTab;

  set isQuarterBacksTab(bool value) {
    _isQuarterBacksTab = value;
    update();
  }

  bool _isInjuriesTab = true;

  bool get isInjuriesTab => _isInjuriesTab;

  set isInjuriesTab(bool value) {
    _isInjuriesTab = value;
    update();
  }

  bool _isTab = true;

  bool get isTab => _isTab;

  set isTab(bool value) {
    _isTab = value;

    update();
  }

  bool _isTab1 = true;

  bool get isTab1 => _isTab1;

  set isTab1(bool value) {
    _isTab1 = value;

    update();
  }*/

  bool _isTeamReportTab = true;

  bool get isTeamReportTab => _isTeamReportTab;

  set isTeamReportTab(bool value) {
    _isTeamReportTab = value;
    update();
  }

  int _isExpand = -1;

  int get isExpand => _isExpand;

  set isExpand(int value) {
    _isExpand = value;
    update();
  }

  RxBool isLoading = false.obs;
  stat.Statistics? mlbStaticsHomeList;
  stat.Statistics? mlbStaticsAwayList;
  List<stat.Players> mlbPlayerPitchingData = [];
  List mlbHomeHittingList = [];
  List mlbHomePitchingList = [];
  List mlbAwayHittingList = [];
  List mlbAwayPitchingList = [];

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
    // isLoading.value = !isLoad ? false : true;
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
                  (player.totals.statistics.pitching.overall.outs?.ktotal ??
                          "0")
                      .toString();
              homeH =
                  (player.totals.statistics.pitching.overall.onbase?.h ?? "0")
                      .toString();
              homeIp = player.totals.statistics.pitching.overall.ip2.toString();
            }
          }
        }
      } else {
        // isLoading.value = false;
        // showAppSnackBar(
        //   result.message,
        // );
      }
    } catch (e) {
      // isLoading.value = false;
      log('ERROR PROFILE HOME RES------------$e');
      showAppSnackBar(
        errorText,
      );
    }
    update();
  }

  Future profileHomeTeamResponse(
      {String playerId = '', String sportKey = '', bool isLoad = false}) async {
    // isLoading.value = !isLoad ? false : true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo()
        .playerProfileRepo(playerId: playerId, sportKey: sportKey);
    try {
      if (result.status) {
        if (result.data != null) {
          NFLProfileModel response = NFLProfileModel.fromJson(result.data);
          final playerData = response.seasons;
          if (playerData != null) {
            for (var element in playerData) {
              if (element.year == DateTime.now().year &&
                  element.type == "REG") {
                if (element.teams != null) {
                  element.teams?.forEach((static) {
                    num totalPlay = static.statistics?.gamesPlayed ?? 1;
                    homeQb = [
                      ((int.parse(static.statistics?.passing?.yards
                                      .toString() ??
                                  "0") /
                              totalPlay)
                          .toStringAsFixed(1)),
                      ((int.parse(static.statistics?.passing?.touchdowns
                                      .toString() ??
                                  "0") /
                              totalPlay)
                          .toStringAsFixed(2)),
                      ((int.parse(static.statistics?.rushing?.yards
                                      .toString() ??
                                  "0") /
                              totalPlay)
                          .toStringAsFixed(1)),
                      ((int.parse(static.statistics?.rushing?.touchdowns
                                      .toString() ??
                                  "0") /
                              totalPlay)
                          .toStringAsFixed(2)),
                      (static.statistics?.passing?.interceptions ?? "0")
                          .toString(),
                    ];
                  });
                }
              }
            }
          }
        }
      } else {
        // isLoading.value = false;
        // showAppSnackBar(
        //   result.message,
        // );
      }
    } catch (e) {
      // isLoading.value = false;
      log('ERROR PROFILE NFL HOME RES------------$e');
      showAppSnackBar(
        errorText,
      );
    }
    update();
  }

  Future profileAwayTeamResponse(
      {String playerId = '', String sportKey = '', bool isLoad = false}) async {
    // isLoading.value = !isLoad ? false : true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo()
        .playerProfileRepo(playerId: playerId, sportKey: sportKey);
    try {
      if (result.status) {
        if (result.data != null) {
          NFLProfileModel response = NFLProfileModel.fromJson(result.data);
          final playerData = response.seasons;
          if (playerData != null) {
            for (var element in playerData) {
              if (element.year == DateTime.now().year &&
                  element.type == "REG") {
                if (element.teams != null) {
                  element.teams?.forEach((static) {
                    num totalPlay = static.statistics?.gamesPlayed ?? 1;
                    awayQb = [
                      ((int.parse(static.statistics?.passing?.yards
                                      .toString() ??
                                  "0") /
                              totalPlay)
                          .toStringAsFixed(1)),
                      ((int.parse(static.statistics?.passing?.touchdowns
                                      .toString() ??
                                  "0") /
                              totalPlay)
                          .toStringAsFixed(2)),
                      ((int.parse(static.statistics?.rushing?.yards
                                      .toString() ??
                                  "0") /
                              totalPlay)
                          .toStringAsFixed(1)),
                      ((int.parse(static.statistics?.rushing?.touchdowns
                                      .toString() ??
                                  "0") /
                              totalPlay)
                          .toStringAsFixed(2)),
                      (static.statistics?.passing?.interceptions ?? "0")
                          .toString(),
                    ];
                  });
                }
              }
            }
          }
        }
      } else {
        // isLoading.value = false;
        // showAppSnackBar(
        //   result.message,
        // );
      }
    } catch (e) {
      // isLoading.value = false;
      log('ERROR PROFILE NFL AWAY RES------------$e');
      showAppSnackBar(
        errorText,
      );
    }
    update();
  }

  Future profileAwayResponse(
      {String awayTeamId = '', bool isLoad = false}) async {
    // isLoading.value = !isLoad ? false : true;
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
                  (player.totals.statistics.pitching.overall.outs?.ktotal ??
                          "0")
                      .toString();
              awayH =
                  (player.totals.statistics.pitching.overall.onbase?.h ?? "0")
                      .toString();
              awayIp = player.totals.statistics.pitching.overall.ip2.toString();
            }
          }
        } else {
          // isLoading.value = false;
        }
      } else {
        // isLoading.value = false;
        // showAppSnackBar(
        //   result.message,
        // );
      }
    } catch (e) {
      // isLoading.value = false;
      log('ERROR PROFILE AWAY RES----$e');
      showAppSnackBar(
        errorText,
      );
    }
    update();
  }

  ///MLB STATICS
  Future mlbStaticsHomeTeamResponse(
      {String homeTeamId = '',
      bool isLoad = false,
      required SportEvents gameDetails}) async {
    // isLoading.value = !isLoad ? false : true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo().mlbStaticsRepo(
        teamId: homeTeamId, seasons: DateTime.now().year.toString());
    try {
      hitterHomePlayerMainList.clear();
      if (result.status) {
        stat.MLBStaticsModel response =
            stat.MLBStaticsModel.fromJson(result.data);
        if (response.statistics != null) {
          mlbStaticsHomeList = response.statistics;
          mlbPlayerPitchingData = response.players ?? [];
          var homeHitting = mlbStaticsHomeList?.hitting?.overall;
          var homePitching = mlbStaticsHomeList?.pitching?.overall;
          int totalGame = int.parse(gameDetails.homeLoss) +
                      int.parse(gameDetails.homeWin) ==
                  0
              ? 1
              : int.parse(gameDetails.homeLoss) +
                  int.parse(gameDetails.homeWin);
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
                      run: 'Runs/Game',
                      runValue: ((int.parse(player
                                      .statistics?.hitting?.overall?.runs?.total
                                      .toString() ??
                                  "0") /
                              totalGame)
                          .toStringAsFixed(2)),
                      totalBase: 'Total Bases/Game',
                      totalBaseValue: ((int.parse(player
                                      .statistics?.hitting?.overall?.onbase?.tb
                                      .toString() ??
                                  "0") /
                              totalGame)
                          .toStringAsFixed(2)),
                      stolenBase: 'Stolen Bases/Game',
                      ab: '${player.statistics?.hitting?.overall?.ab}',
                      stolenBaseValue: ((int.parse(
                                  player.statistics?.hitting?.overall?.steal?.stolen.toString() ?? "0") /
                              totalGame)
                          .toStringAsFixed(2))),
                );
              }
            }
          }

          mlbHomeHittingList = [
            ((int.parse(homeHitting?.runs?.total.toString() ?? "0") / totalGame)
                .toStringAsFixed(2)),
            ((int.parse(homeHitting?.onbase?.h.toString() ?? "0") / totalGame)
                .toStringAsFixed(2)),
            ((int.parse(homeHitting?.onbase?.hr.toString() ?? "0") / totalGame)
                .toStringAsFixed(2)),
            ((int.parse(homeHitting?.rbi.toString() ?? "0") / totalGame)
                .toStringAsFixed(2)),
            ((int.parse(homeHitting?.onbase?.bb.toString() ?? "0") / totalGame)
                .toStringAsFixed(2)),
            ((int.parse(homeHitting?.outs?.ktotal.toString() ?? "0") /
                    totalGame)
                .toStringAsFixed(2)),
            ((int.parse(homeHitting?.steal?.stolen.toString() ?? "0") /
                    totalGame)
                .toStringAsFixed(2)),
            homeHitting?.avg ?? "0",
            '.${(homeHitting?.slg ?? 0).toString().split('.').last}',
            '${homeHitting?.ops ?? '0'}',
            ((int.parse(homeHitting?.outs?.gidp.toString() ?? "0") / totalGame)
                .toStringAsFixed(2)),
            homeHitting?.abhr?.toStringAsFixed(2) ?? "0",
          ];
          mlbHomePitchingList = [
            '${homePitching?.era ?? '0'}',
            '${homePitching?.games?.shutout ?? '0'}',
            '.${(((homePitching?.games?.save ?? 0) / (homePitching?.games?.svo ?? 0)).toStringAsFixed(3).split('.').last)}',
            '${homePitching?.games?.blownSave ?? '0'}',
            '${homePitching?.games?.qstart ?? '0'}',
            ((int.parse(homePitching?.runs?.total.toString() ?? "0") /
                    totalGame)
                .toStringAsFixed(2)),
            ((int.parse(homePitching?.onbase?.hr.toString() ?? "0") / totalGame)
                .toStringAsFixed(2)),
            ((int.parse(homePitching?.onbase?.bb.toString() ?? "0") / totalGame)
                .toStringAsFixed(2)),
            ((int.parse(homePitching?.outs?.ktotal.toString() ?? "0") /
                    totalGame)
                .toStringAsFixed(2)),
            '${homePitching?.whip ?? "0"}',
            '.${(homePitching?.oba ?? 0).toString().split('.').last}',
            ((int.parse(homePitching?.outs?.gidp.toString() ?? "0") / totalGame)
                .toStringAsFixed(2)),
          ];
        }
      } else {
        // isLoading.value = false;

        // showAppSnackBar(
        //   result.message,
        // );
      }
      // isLoading.value = false;
    } catch (e) {
      // isLoading.value = false;
      log('ERROR HOME STATIC RES ----$e');
      // showAppSnackBar(
      //   result.message,
      // );
    }
    update();
  }

  List<HitterPlayerStatMainModel> hitterAwayPlayerMainList = [];
  Future mlbStaticsAwayTeamResponse(
      {String awayTeamId = '',
      bool isLoad = false,
      required SportEvents gameDetails}) async {
    // isLoading.value = !isLoad ? false : true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo().mlbStaticsRepo(
        teamId: awayTeamId, seasons: DateTime.now().year.toString());
    try {
      hitterAwayPlayerMainList.clear();
      if (result.status) {
        stat.MLBStaticsModel response =
            stat.MLBStaticsModel.fromJson(result.data);
        if (response.statistics != null) {
          mlbStaticsAwayList = response.statistics;
          mlbPlayerPitchingData = response.players ?? [];
        }
        int totalGame = int.parse(gameDetails.awayLoss) +
                    int.parse(gameDetails.awayWin) ==
                0
            ? 1
            : int.parse(gameDetails.awayLoss) + int.parse(gameDetails.awayWin);
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
                    run: 'Runs/Game',
                    runValue: ((int.parse(player
                                    .statistics?.hitting?.overall?.runs?.total
                                    .toString() ??
                                "0") /
                            totalGame)
                        .toStringAsFixed(2)),
                    totalBase: 'Total Bases/Game',
                    totalBaseValue: ((int.parse(player
                                    .statistics?.hitting?.overall?.onbase?.tb
                                    .toString() ??
                                "0") /
                            totalGame)
                        .toStringAsFixed(2)),
                    stolenBase: 'Stolen Bases/Game',
                    ab: '${player.statistics?.hitting?.overall?.ab}',
                    stolenBaseValue: ((int.parse(
                                player.statistics?.hitting?.overall?.steal?.stolen.toString() ?? "0") /
                            totalGame)
                        .toStringAsFixed(2))),
              );
            }
          }
        }

        mlbAwayHittingList = [
          ((int.parse(awayHitting?.runs?.total.toString() ?? "0") / totalGame)
              .toStringAsFixed(2)),
          ((int.parse(awayHitting?.onbase?.h.toString() ?? "0") / totalGame)
              .toStringAsFixed(2)),
          ((int.parse(awayHitting?.onbase?.hr.toString() ?? "0") / totalGame)
              .toStringAsFixed(2)),
          ((int.parse(awayHitting?.rbi.toString() ?? "0") / totalGame)
              .toStringAsFixed(2)),
          ((int.parse(awayHitting?.onbase?.bb.toString() ?? "0") / totalGame)
              .toStringAsFixed(2)),
          ((int.parse(awayHitting?.outs?.ktotal.toString() ?? "0") / totalGame)
              .toStringAsFixed(2)),
          ((int.parse(awayHitting?.steal?.stolen.toString() ?? "0") / totalGame)
              .toStringAsFixed(2)),
          awayHitting?.avg ?? "0",
          '.${(awayHitting?.slg.toString().split('.').last)}',
          '${awayHitting?.ops ?? '0'}',
          ((int.parse(awayHitting?.outs?.gidp.toString() ?? "0") / totalGame)
              .toStringAsFixed(2)),
          awayHitting?.abhr?.toStringAsFixed(2) ?? "0",
        ];
        mlbAwayPitchingList = [
          '${awayPitching?.era ?? '0'}',
          '${awayPitching?.games?.shutout ?? '0'}',
          '.${(((awayPitching?.games?.save ?? 0) / (awayPitching?.games?.svo ?? 0)).toStringAsFixed(3).split('.').last)}',
          '${awayPitching?.games?.blownSave ?? '0'}',
          '${awayPitching?.games?.qstart ?? '0'}',
          ((int.parse(awayPitching?.runs?.total.toString() ?? "0") / totalGame)
              .toStringAsFixed(2)),
          ((int.parse(awayPitching?.onbase?.hr.toString() ?? "0") / totalGame)
              .toStringAsFixed(2)),
          ((int.parse(awayPitching?.onbase?.bb.toString() ?? "0") / totalGame)
              .toStringAsFixed(2)),
          ((int.parse(awayPitching?.outs?.ktotal.toString() ?? "0") / totalGame)
              .toStringAsFixed(2)),
          '${awayPitching?.whip ?? "0"}',
          '.${(awayPitching?.oba ?? 0).toString().split('.').last}',
          ((int.parse(awayPitching?.outs?.gidp.toString() ?? "0") / totalGame)
              .toStringAsFixed(2)),
        ];

        // isLoading.value = false;
      } else {
        // isLoading.value = false;
        // showAppSnackBar(
        //   result.message,
        // );
      }
    } catch (e) {
      // isLoading.value = false;
      log('ERROR AWAY STATIC RES -------$e');
      showAppSnackBar(
        errorText,
      );
    }
    update();
  }

  ///NFL STATICS
  List<String> nflHomeOffensiveList = [];
  List<String> nflHomeDefensiveList = [];
  List<String> nflAwayOffensiveList = [];
  List<String> nflAwayDefensiveList = [];
  List<RunningBacks> runningBacksAwayList = [];
  List<RunningBacks> runningBacksHomeList = [];
  Future nflStaticsHomeTeamResponse(
      {String homeTeamId = '',
      required SportEvents gameDetails,
      bool isLoad = false,
      String sportKey = ''}) async {
    // isLoading.value = !isLoad ? false : true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo().nflStaticsRepo(
        teamId: homeTeamId,
        seasons: DateTime.now().year.toString(),
        sportKey: sportKey);
    try {
      if (result.status) {
        if (result.data != null) {
          NFLStaticsModel response = NFLStaticsModel.fromJson(result.data);
          List<num> gameStart = [];
          if (response.season != null) {
            if (response.record != null) {
              var offenciveData = response.record;
              var defenciveData = response.opponents;
              num totalGame = offenciveData?.gamesPlayed ?? 1;
              String offensivePoint = ((((int.parse(
                                  offenciveData?.touchdowns?.total.toString() ??
                                      "0") *
                              6) +
                          (int.parse(
                                  offenciveData?.fieldGoals?.made.toString() ??
                                      "0") *
                              3) +
                          (int.parse(offenciveData?.extraPoints?.kicks?.made
                                      .toString() ??
                                  "0") *
                              1)) /
                      totalGame)
                  .toStringAsFixed(2));
              nflHomeOffensiveList = [
                offensivePoint,
                ((int.parse(offenciveData?.rushing?.yards.toString() ?? "0") /
                        totalGame)
                    .toStringAsFixed(1)),
                ((int.parse(offenciveData?.passing?.yards.toString() ?? "0") /
                        totalGame)
                    .toStringAsFixed(1)),
                ((int.parse(offenciveData?.rushing?.touchdowns.toString() ??
                            "0") /
                        totalGame)
                    .toStringAsFixed(2)),
                ((int.parse(offenciveData?.passing?.touchdowns.toString() ??
                            "0") /
                        totalGame)
                    .toStringAsFixed(2)),
                '${(double.parse((offenciveData?.efficiency?.redzone?.pct ?? "0").toString()).toStringAsFixed(1))}%',
                '${(double.parse((offenciveData?.efficiency?.thirddown?.pct ?? "0").toString()).toStringAsFixed(1))}%',
                '${(double.parse((offenciveData?.efficiency?.fourthdown?.pct ?? "0").toString()).toStringAsFixed(1))}%',
                (double.parse(((offenciveData?.fieldGoals?.made ?? 0) /
                            (offenciveData?.fieldGoals?.attempts ?? 0) *
                            100)
                        .toString())
                    .toStringAsFixed(1)),
                (((offenciveData?.interceptions?.interceptions ?? 0) +
                            (offenciveData?.fumbles?.lostFumbles ?? 0)) /
                        totalGame)
                    .toStringAsFixed(1)
              ];
              String defensivePoint = ((((int.parse(
                                  defenciveData?.touchdowns?.total.toString() ??
                                      "0") *
                              6) +
                          (int.parse(
                                  defenciveData?.fieldGoals?.made.toString() ??
                                      "0") *
                              3) +
                          (int.parse(defenciveData?.extraPoints?.kicks?.made
                                      .toString() ??
                                  "0") *
                              1)) /
                      totalGame)
                  .toStringAsFixed(2));
              nflHomeDefensiveList = [
                defensivePoint,
                ((int.parse(defenciveData?.rushing?.yards.toString() ?? "0") /
                        totalGame)
                    .toStringAsFixed(1)),
                ((int.parse(defenciveData?.passing?.yards.toString() ?? "0") /
                        totalGame)
                    .toStringAsFixed(1)),
                ((int.parse(defenciveData?.rushing?.touchdowns.toString() ??
                            "0") /
                        totalGame)
                    .toStringAsFixed(2)),
                ((int.parse(defenciveData?.passing?.touchdowns.toString() ??
                            "0") /
                        totalGame)
                    .toStringAsFixed(2)),
                '${(double.parse((defenciveData?.efficiency?.redzone?.pct ?? "0").toString()).toStringAsFixed(1))}%',
                '${(double.parse((defenciveData?.efficiency?.thirddown?.pct ?? "0").toString()).toStringAsFixed(1))}%',
                '${(double.parse((defenciveData?.efficiency?.fourthdown?.pct ?? "0").toString()).toStringAsFixed(1))}%',
                (double.parse(((defenciveData?.fieldGoals?.made ?? 0) /
                            (defenciveData?.fieldGoals?.attempts ?? 0) *
                            100)
                        .toString())
                    .toStringAsFixed(1)),
                (((defenciveData?.defense?.interceptions ?? 0) +
                            (defenciveData?.defense?.fumbleRecoveries ?? 0)) /
                        totalGame)
                    .toStringAsFixed(1)
              ];
              homeDefense = [
                ((int.parse(defenciveData?.passing?.yards.toString() ?? "0") /
                        totalGame)
                    .toStringAsFixed(1)),
                ((int.parse(defenciveData?.passing?.touchdowns.toString() ??
                            "0") /
                        totalGame)
                    .toStringAsFixed(2)),
                ((int.parse(defenciveData?.rushing?.yards.toString() ?? "0") /
                        totalGame)
                    .toStringAsFixed(1)),
                ((int.parse(defenciveData?.rushing?.touchdowns.toString() ??
                            "0") /
                        totalGame)
                    .toStringAsFixed(2)),
                (offenciveData?.defense?.interceptions ?? "0").toString(),
              ];
              gameDetails.homeRunningBackPlayer.clear();
              gameDetails.homeReceiversPlayer.clear();
              if (response.players != null) {
                response.players?.forEach((player) {
                  if (player.position == 'RB' && player.gamesPlayed != 0) {
                    gameDetails.homeRunningBackPlayer.add(player);
                    // runningBacksHomeList.add(RunningBacks(carries: carries, yard: yard, avgCarry: avgCarry, tds: tds, longestRun: longestRun, fumbles: fumbles))
                  }
                  if (player.position == 'WR' && player.gamesPlayed != 0 ||
                      player.position == 'TE' && player.gamesPlayed != 0) {
                    gameDetails.homeReceiversPlayer.add(player);
                  }
                  if (sportKey == "NCAA") {
                    if (player.position == 'QB' && player.gamesStarted != 0) {
                      gameStart.add(player.gamesStarted ?? 0);
                      num gameStartNum = gameStart.max;
                      if (gameStartNum == player.gamesStarted) {
                        num totalPlay = player.gamesPlayed ?? 1;
                        homeQb = [
                          ((int.parse(player.passing?.yards.toString() ?? "0") /
                                  totalPlay)
                              .toStringAsFixed(1)),
                          ((int.parse(player.passing?.touchdowns.toString() ??
                                      "0") /
                                  totalPlay)
                              .toStringAsFixed(2)),
                          ((int.parse(player.rushing?.yards.toString() ?? "0") /
                                  totalPlay)
                              .toStringAsFixed(1)),
                          ((int.parse(player.rushing?.touchdowns.toString() ??
                                      "0") /
                                  totalPlay)
                              .toStringAsFixed(2)),
                          (player.passing?.interceptions ?? "0").toString(),
                          // (player.fumbles?.fumbles ?? "0").toString(),
                        ];
                        gameDetails.homePlayerName =
                            (player.name ?? "").toString();
                      }
                    }
                  }
                });
              }
              gameDetails.homeRunningBackPlayer.sort((a, b) =>
                  (b.rushing?.yards ?? 0).compareTo(a.rushing?.yards ?? 0));
              gameDetails.homeReceiversPlayer.sort((a, b) =>
                  (b.receiving?.yards ?? 0).compareTo(a.receiving?.yards ?? 0));
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
        // showAppSnackBar(
        //   result.message,
        // );
      }

      // isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      log('ERROR NFL HOME STATICS-----------$e');
      showAppSnackBar(
        errorText,
      );
    }
    update();
  }

  ///NBA ROSTER PLAYER STATICS
  Future nbaRosterStaticsHomeResponse(
      {String homeTeamId = '',
      required SportEvents gameDetails,
      bool isLoad = false,
      String sportKey = ''}) async {
    isLoading.value = !isLoad ? false : true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo().nbaRosterRepo(
        teamId: homeTeamId,
        seasons: DateTime.now().year.toString(),
        sportKey: sportKey);
    gameDetails.homeRushingPlayerName.clear();
    gameDetails.homeRushingPlayer.clear();
    try {
      if (result.status) {
        if (result.data != null) {
          NBARosterModel response = NBARosterModel.fromJson(result.data);
          if (response.id == homeTeamId) {
            response.players?.forEach((player) async {
              if (player.status == 'ACT') {
                gameDetails.homeRushingPlayerName.add(player);
              }
            });
          }
        } else {
          isLoading.value = false;
        }
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      log('ERROR NBA HOME STATICS-----------$e');
      showAppSnackBar(
        errorText,
      );
    }
    update();
  }

  Future nbaRosterStaticsAwayResponse(
      {String awayTeamId = '',
      required SportEvents gameDetails,
      bool isLoad = false,
      String sportKey = ''}) async {
    isLoading.value = !isLoad ? false : true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo().nbaRosterRepo(
        teamId: awayTeamId,
        seasons: DateTime.now().year.toString(),
        sportKey: sportKey);
    gameDetails.awayRushingPlayerName.clear();
    gameDetails.awayRushingPlayer.clear();
    try {
      if (result.status) {
        if (result.data != null) {
          NBARosterModel response = NBARosterModel.fromJson(result.data);
          if (response.id == awayTeamId) {
            response.players?.forEach((player) async {
              if (player.status == 'ACT') {
                gameDetails.awayRushingPlayerName.add(player);
              }
            });
          }
        } else {
          isLoading.value = false;
        }
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      log('ERROR NBA HOME STATICS-----------$e');
      showAppSnackBar(
        errorText,
      );
    }
    update();
  }

  RxBool isLoadPlayStatAway = false.obs;

  ///NBA Away PLAYER PROFILE
  Future nbaAwayPlayerProfileResponse(
      {String playerId = '',
      required SportEvents gameDetails,
      bool isLoad = false,
      String sportKey = ''}) async {
    isLoadPlayStatAway.value = !isLoad ? false : true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo().nbaPlayerProfileRepo(
        playerId: playerId,
        seasons: DateTime.now().year.toString(),
        sportKey: sportKey);

    try {
      if (result.status) {
        if (result.data != null) {
          NBAPlayerProfileModel response =
              NBAPlayerProfileModel.fromJson(result.data);
          if (response.seasons != null) {
            response.seasons?.forEach((season) {
              if (season.year == DateTime.now().year) {
                season.teams?.forEach((team) {
                  gameDetails.awayRushingPlayer.add(team.average!);
                });
              }
            });
          }
        } else {
          isLoadPlayStatAway.value = false;
        }
      } else {
        isLoadPlayStatAway.value = false;
        // showAppSnackBar(
        //   result.message,
        // );
      }
    } catch (e) {
      isLoadPlayStatAway.value = false;
      log('ERROR isLoadPlayStat AWAY STATICS------$e');
      showAppSnackBar(
        errorText,
      );
    }
    update();
  }

  RxBool isLoadPlayStatHome = false.obs;

  ///NBA HOME PLAYER PROFILE
  Future nbaHomePlayerProfileResponse(
      {String playerId = '',
      required SportEvents gameDetails,
      bool isLoad = false,
      String sportKey = ''}) async {
    isLoadPlayStatHome.value = !isLoad ? false : true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo().nbaPlayerProfileRepo(
        playerId: playerId,
        seasons: DateTime.now().year.toString(),
        sportKey: sportKey);
    try {
      if (result.status) {
        if (result.data != null) {
          NBAPlayerProfileModel response =
              NBAPlayerProfileModel.fromJson(result.data);
          if (response.seasons != null) {
            response.seasons?.forEach((season) {
              if (season.year == DateTime.now().year) {
                season.teams?.forEach((team) {
                  gameDetails.homeRushingPlayer.add(team.average!);
                });
              }
            });
          }
        } else {
          isLoadPlayStatHome.value = false;
        }
      } else {
        isLoadPlayStatHome.value = false;
        // showAppSnackBar(
        //   result.message,
        // );
      }
    } catch (e) {
      isLoadPlayStatHome.value = false;
      log('ERROR isLoadPlayStat AWAY STATICS------$e');
      showAppSnackBar(
        errorText,
      );
    }
    update();
  }

  List<StartingQBModel> qbsList = [
    StartingQBModel(
      playerId: "f2f29019-7306-4b1c-a9d8-e9f802cb06e0",
      playerName: "Jake Browning",
      teamId: "ad4ae08f-d808-42d5-a1e6-e9bc4e34d123",
    ),
    StartingQBModel(
      playerId: "dabb52c0-455b-48fe-996b-abf758120623",
      playerName: "Gardner Minshew",
      teamId: "82cf9565-6eb9-4f01-bdbd-5aa0d472fcd9",
    ),
    StartingQBModel(
      playerId: "a1ae8db0-eb91-11ed-a4cb-cd397e2b413c",
      playerName: "Tommy DeVito",
      teamId: "04aa1c9d-66da-489d-b16a-1dee3f2eec4d",
    ),
    StartingQBModel(
      playerId: "4c8a2f7e-f982-4eca-9d52-cf53df6985a4",
      playerName: "Will Levis",
      teamId: "d26a1ca5-722d-4274-8f97-c92e49c96315",
    ),
    StartingQBModel(
      playerId: "dd5a6b6e-ffae-45a5-b8e6-718a9251f374",
      playerName: "Kyler Murray",
      teamId: "de760528-1dc0-416a-a978-b510d20692ff",
    ),
    StartingQBModel(
      playerId: "d66ae3ad-8a60-47e7-a3b2-18a1e8377e1b",
      playerName: "Dorian Thompson-Robinson",
      teamId: "d5a2eb42-8065-4174-ab79-0a6fa820e35e",
    ),
    StartingQBModel(
      playerId: "15bedebc-839e-450a-86f6-1f5ad1f4f820",
      playerName: "Joshua Dobbs",
      teamId: "33405046-04ee-4058-a950-d606f8c30852",
    ),
  ];

  Future depthChartResponse(
      {String homeTeamId = '',
      String awayTeamId = '',
      required SportEvents gameDetails,
      bool isLoad = false,
      String sportKey = ''}) async {
    // isLoading.value = !isLoad ? false : true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo().depthChartRepo(sportKey: sportKey);

    int homeInd = qbsList.indexWhere((element) => element.teamId == homeTeamId);
    if (homeInd >= 0) {
      gameDetails.homePlayerName = qbsList[homeInd].playerName;
      gameDetails.homePlayerId = qbsList[homeInd].playerId;
    } else {
      try {
        if (result.status) {
          if (result.data != null) {
            DepthChartModel response = DepthChartModel.fromJson(result.data);
            if (response.teams != null) {
              int homeIndex = response.teams!
                  .indexWhere((element) => element.id == homeTeamId);
              if ((homeIndex) >= 0) {
                response.teams![homeIndex].offense?.forEach((position) {
                  if (position.position?.name == 'QB') {
                    position.position?.players?.forEach((player) {
                      if (player.depth == 1 && player.position == "QB") {
                        gameDetails.homePlayerName =
                            (player.name ?? "").toString();
                        gameDetails.homePlayerId = (player.id ?? "").toString();
                      }
                    });
                  }
                });
              }
            }
          } else {
            showAppSnackBar(
              result.message,
            );
            isLoading.value = false;
          }
        } else {
          isLoading.value = false;
          showAppSnackBar(
            result.message,
          );
        }

        // isLoading.value = false;
      } catch (e) {
        isLoading.value = false;
        log('ERROR NFL HOME STATICS-----------$e');
        showAppSnackBar(
          errorText,
        );
      }
    }
    int awayInd = qbsList.indexWhere((element) => element.teamId == awayTeamId);
    if (awayInd >= 0) {
      gameDetails.awayPlayerName = qbsList[awayInd].playerName;
      gameDetails.awayPlayerId = qbsList[awayInd].playerId;
    } else {
      try {
        if (result.status) {
          if (result.data != null) {
            DepthChartModel response = DepthChartModel.fromJson(result.data);
            if (response.teams != null) {
              int awayIndex = response.teams!
                  .indexWhere((element) => element.id == awayTeamId);
              if ((awayIndex) >= 0) {
                response.teams![awayIndex].offense?.forEach((position) {
                  if (position.position?.name == 'QB') {
                    position.position?.players?.forEach((player) {
                      if (player.depth == 1 && player.position == "QB") {
                        gameDetails.awayPlayerName =
                            (player.name ?? "").toString();
                        gameDetails.awayPlayerId = (player.id ?? "").toString();
                      }
                    });
                  }
                });
              }
            }
          } else {
            showAppSnackBar(
              result.message,
            );
            isLoading.value = false;
          }
        } else {
          isLoading.value = false;
          showAppSnackBar(
            result.message,
          );
        }

        // isLoading.value = false;
      } catch (e) {
        isLoading.value = false;
        log('ERROR NFL HOME STATICS-----------$e');
        showAppSnackBar(
          errorText,
        );
      }
    }
    update();
  }

  Future nflStaticsAwayTeamResponse(
      {String awayTeamId = '',
      required SportEvents gameDetails,
      bool isLoad = false,
      String sportKey = ''}) async {
    // isLoading.value = !isLoad ? false : true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo().nflStaticsRepo(
        teamId: awayTeamId,
        seasons: DateTime.now().year.toString(),
        sportKey: sportKey);
    try {
      if (result.status) {
        if (result.data != null) {
          NFLStaticsModel response = NFLStaticsModel.fromJson(result.data);
          List<num> gameStart = [];
          if (response.season != null) {
            if (response.record != null) {
              var offenciveData = response.record;
              var defenciveData = response.opponents;
              num totalGame = offenciveData?.gamesPlayed ?? 1;
              String offensivePoint = ((((int.parse(
                                  offenciveData?.touchdowns?.total.toString() ??
                                      "0") *
                              6) +
                          (int.parse(
                                  offenciveData?.fieldGoals?.made.toString() ??
                                      "0") *
                              3) +
                          (int.parse(offenciveData?.extraPoints?.kicks?.made
                                      .toString() ??
                                  "0") *
                              1)) /
                      totalGame)
                  .toStringAsFixed(2));
              nflAwayOffensiveList = [
                offensivePoint,
                ((int.parse(offenciveData?.rushing?.yards.toString() ?? "0") /
                        totalGame)
                    .toStringAsFixed(1)),
                ((int.parse(offenciveData?.passing?.yards.toString() ?? "0") /
                        totalGame)
                    .toStringAsFixed(1)),
                ((int.parse(offenciveData?.rushing?.touchdowns.toString() ??
                            "0") /
                        totalGame)
                    .toStringAsFixed(2)),
                ((int.parse(offenciveData?.passing?.touchdowns.toString() ??
                            "0") /
                        totalGame)
                    .toStringAsFixed(2)),
                '${(double.parse((offenciveData?.efficiency?.redzone?.pct ?? "0").toString()).toStringAsFixed(1))}%',
                '${(double.parse((offenciveData?.efficiency?.thirddown?.pct ?? "0").toString()).toStringAsFixed(1))}%',
                '${(double.parse((offenciveData?.efficiency?.fourthdown?.pct ?? "0").toString()).toStringAsFixed(1))}%',
                (double.parse(((offenciveData?.fieldGoals?.made ?? 0) /
                            (offenciveData?.fieldGoals?.attempts ?? 0) *
                            100)
                        .toString())
                    .toStringAsFixed(1)),
                (((offenciveData?.interceptions?.interceptions ?? 0) +
                            (offenciveData?.fumbles?.lostFumbles ?? 0)) /
                        totalGame)
                    .toStringAsFixed(1)
              ];
              String defensivePoint = ((((int.parse(
                                  defenciveData?.touchdowns?.total.toString() ??
                                      "0") *
                              6) +
                          (int.parse(
                                  defenciveData?.fieldGoals?.made.toString() ??
                                      "0") *
                              3) +
                          (int.parse(defenciveData?.extraPoints?.kicks?.made
                                      .toString() ??
                                  "0") *
                              1)) /
                      totalGame)
                  .toStringAsFixed(2));

              nflAwayDefensiveList = [
                defensivePoint,
                ((int.parse(defenciveData?.rushing?.yards.toString() ?? "0") /
                        totalGame)
                    .toStringAsFixed(1)),
                ((int.parse(defenciveData?.passing?.yards.toString() ?? "0") /
                        totalGame)
                    .toStringAsFixed(1)),
                ((int.parse(defenciveData?.rushing?.touchdowns.toString() ??
                            "0") /
                        totalGame)
                    .toStringAsFixed(2)),
                ((int.parse(defenciveData?.passing?.touchdowns.toString() ??
                            "0") /
                        totalGame)
                    .toStringAsFixed(2)),
                '${(double.parse((defenciveData?.efficiency?.redzone?.pct ?? "0").toString()).toStringAsFixed(1))}%',
                '${(double.parse((defenciveData?.efficiency?.thirddown?.pct ?? "0").toString()).toStringAsFixed(1))}%',
                '${(double.parse((defenciveData?.efficiency?.fourthdown?.pct ?? "0").toString()).toStringAsFixed(1))}%',
                (double.parse(((defenciveData?.fieldGoals?.made ?? 0) /
                            (defenciveData?.fieldGoals?.attempts ?? 0) *
                            100)
                        .toString())
                    .toStringAsFixed(1)),
                (((defenciveData?.defense?.interceptions ?? 0) +
                            (defenciveData?.defense?.fumbleRecoveries ?? 0)) /
                        totalGame)
                    .toStringAsFixed(1)
              ];
              awayDefense = [
                ((int.parse(defenciveData?.passing?.yards.toString() ?? "0") /
                        totalGame)
                    .toStringAsFixed(1)),
                ((int.parse(defenciveData?.passing?.touchdowns.toString() ??
                            "0") /
                        totalGame)
                    .toStringAsFixed(2)),
                ((int.parse(defenciveData?.rushing?.yards.toString() ?? "0") /
                        totalGame)
                    .toStringAsFixed(1)),
                ((int.parse(defenciveData?.rushing?.touchdowns.toString() ??
                            "0") /
                        totalGame)
                    .toStringAsFixed(2)),
                (offenciveData?.defense?.interceptions ?? "0").toString(),
              ];
              gameDetails.awayReceiversPlayer.clear();
              gameDetails.awayRunningBackPlayer.clear();
              if (response.players != null) {
                response.players?.forEach((player) {
                  if (player.position == 'RB' && player.gamesPlayed != 0) {
                    gameDetails.awayRunningBackPlayer.add(player);
                  }
                  if (player.position == 'WR' && player.gamesPlayed != 0 ||
                      player.position == 'TE' && player.gamesPlayed != 0) {
                    gameDetails.awayReceiversPlayer.add(player);
                  }
                  if (sportKey == "NCAA") {
                    if (player.position == 'QB' && player.gamesStarted != 0) {
                      gameStart.add(player.gamesStarted ?? 0);
                      num gameStartNum = gameStart.max;
                      if (gameStartNum == player.gamesStarted) {
                        num totalPlay = player.gamesPlayed ?? 1;
                        awayQb = [
                          ((int.parse(player.passing?.yards.toString() ?? "0") /
                                  totalPlay)
                              .toStringAsFixed(1)),
                          ((int.parse(player.passing?.touchdowns.toString() ??
                                      "0") /
                                  totalPlay)
                              .toStringAsFixed(2)),
                          ((int.parse(player.rushing?.yards.toString() ?? "0") /
                                  totalPlay)
                              .toStringAsFixed(1)),
                          ((int.parse(player.rushing?.touchdowns.toString() ??
                                      "0") /
                                  totalPlay)
                              .toStringAsFixed(2)),
                          (player.passing?.interceptions ?? "0").toString(),
                          // (player.fumbles?.fumbles ?? "0").toString(),
                        ];

                        gameDetails.awayPlayerName =
                            (player.name ?? "").toString();
                      }
                    }
                  }
                });
              }
              gameDetails.awayRunningBackPlayer.sort((a, b) =>
                  (b.rushing?.yards ?? 0).compareTo(a.rushing?.yards ?? 0));
              gameDetails.awayReceiversPlayer.sort((a, b) =>
                  (b.receiving?.yards ?? 0).compareTo(a.receiving?.yards ?? 0));
            }
          }
        } else {
          isLoading.value = false;
        }
      } else {
        isLoading.value = false;
        // showAppSnackBar(
        //   result.message,
        // );
      }
    } catch (e) {
      isLoading.value = false;
      log('ERROR NFL AWAY STATICS------$e');
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

  int _hotlinesIndex = 0;

  int get hotlinesIndex => _hotlinesIndex;

  set hotlinesIndex(int value) {
    _hotlinesIndex = value;
    update();
  }

  List<HotlinesModel> _hotlinesMData = [];
  List<HotlinesModel> hotlinesMainData = [];
  List<HotlinesModel> _hotlinesDData = [];
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
      if (result.status) {
        hotlines.HotlinesDataModel response =
            hotlines.HotlinesDataModel.fromJson(result.data);
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
                                teamId: playersProp.player?.competitorId ?? "",
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
                                if (!(hotlinesFData.indexWhere((fData) =>
                                        fData.playerName ==
                                        element.playerName) >=
                                    0)) {
                                  if (!(hotlinesFData.indexWhere((fData) =>
                                          fData.tittle == element.tittle) >=
                                      0)) {
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

          List<HotlinesModel> hotlinesFinalData = [];
          hotlinesFinalData = hotlinesDData + hotlinesFData + hotlinesMData;
          hotlinesData.clear();
          hotlinesFinalData
              .sort((a, b) => int.parse(b.value).compareTo(int.parse(a.value)));
          if (hotlinesFinalData.isNotEmpty) {
            hotlinesData.add(hotlinesFinalData[0]);
            for (int i = 1; i < hotlinesFinalData.length; i++) {
              if (!(hotlinesData.indexWhere((element) =>
                      element.teamName == hotlinesFinalData[i].teamName) >=
                  0)) {
                if (hotlinesData
                        .where((element) =>
                            element.bookId == hotlinesFinalData[i].bookId)
                        .toList()
                        .length <
                    2) {
                  if (hotlinesData
                          .where((element) =>
                              element.teamId == hotlinesFinalData[i].teamId)
                          .toList()
                          .length <
                      3) {
                    hotlinesData.add(hotlinesFinalData[i]);
                  }
                }
              }
            }
          }
          /*  if (hotlinesDData.isNotEmpty) {
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
          }*/
          hotlinesData
              .sort((a, b) => int.parse(b.value).compareTo(int.parse(a.value)));
          update();
        }
      } else {
        isHotlines = false;
        // showAppSnackBar(
        //   result.message,
        // );
      }
    } catch (e) {
      isHotlines = false;
      isLoading.value = false;
      log('ERROR HOTLINES DATA------$e');
      // showAppSnackBar(
      //   errorText,
      // );
    }
    update();
    return hotlinesData;
  }

  ///GET NCAA AND NFL RECORDS
  Future recordsOfNCAAAndNFL({
    String homeId = '',
    String awayId = '',
    bool isLoad = false,
    required SportEvents sportEvent,
    String key = '',
  }) async {
    // isLoading.value = !isLoad ? false : true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo().recordRepoNCAA(sportKey: key);
    try {
      if (result.status) {
        if (key == 'NFL') {
          NFLTeamRecordModel response =
              NFLTeamRecordModel.fromJson(result.data);
          final game = response.conferences;
          if (game != null) {
            for (var element in game) {
              element.divisions?.forEach((division) {
                division.teams?.forEach((team) {
                  if (team.id == homeId) {
                    sportEvent.homeWin = (team.wins ?? "0").toString();
                    sportEvent.homeLoss = '${team.losses ?? "0"}'.toString();
                  }
                  if (team.id == awayId) {
                    sportEvent.awayWin = (team.wins ?? "0").toString();
                    sportEvent.awayLoss = '${team.losses ?? "0"}'.toString();
                  }
                });
              });
            }
          }
        } else {
          TeamRecordModel response = TeamRecordModel.fromJson(result.data);
          final game = response.divisions;
          if (game != null) {
            for (var element in game) {
              element.conferences?.forEach((division) {
                division.teams?.forEach((team) {
                  if (team.id == homeId) {
                    sportEvent.homeWin = (team.wins ?? "0").toString();
                    sportEvent.homeLoss = '${team.losses ?? "0"}'.toString();
                  }
                  if (team.id == awayId) {
                    sportEvent.awayWin = (team.wins ?? "0").toString();
                    sportEvent.awayLoss = '${team.losses ?? "0"}'.toString();
                  }
                });
              });
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
      log('ERROR RECORD NFL && NCAA--------$e');
      // showAppSnackBar(
      //   errorText,
      // );
    }

    update();
  }

  ///MLB INJURY REPORT
  Future mlbInjuriesResponse(
      {String awayTeamId = '',
      String homeTeamId = '',
      String sportKey = '',
      SportEvents? sportEvent,
      bool isLoad = false}) async {
    // isLoading.value = !isLoad ? false : true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo().mlbInjuriesRepo(sportKey);
    try {
      sportEvent?.homeTeamInjuredPlayer.clear();
      sportEvent?.awayTeamInjuredPlayer.clear();
      if (result.status) {
        if (sportKey == "MLB") {
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
        } else {
          NFLInjuryModel response = NFLInjuryModel.fromJson(result.data);
          if (response.teams != null) {
            response.teams?.forEach((team) {
              if (team.id == awayTeamId) {
                team.players?.forEach((player) {
                  if (player.position != 'A') {
                    sportEvent?.awayTeamInjuredPlayer.add(
                        '${player.name?[0]}. ${player.name?.split(' ').last}(${((player.injuries ?? []).isNotEmpty) ? (player.injuries?[0].practice?.status) : ""})');
                  }
                });
              }
              if (team.id == homeTeamId) {
                team.players?.forEach((player) {
                  if (player.position != 'A') {
                    sportEvent?.homeTeamInjuredPlayer.add(
                        '${player.name?[0]}. ${player.name?.split(' ').last}(${((player.injuries ?? []).isNotEmpty) ? (player.injuries?[0].practice?.status) : ""})');
                  }
                });
              }
            });
          }
        }
        // isLoading.value = false;
      } else {
        isLoading.value = false;
        // showAppSnackBar(
        //   result.message,
        // );
      }
    } catch (e) {
      isLoading.value = false;
      log('ERROR MLB INJURIES-----$e');
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

  ///GET RESPONSE
  Future getResponse(
      {required bool isLoad,
      required String sportId,
      required String date,
      required String hotLinesDate,
      required SportEvents gameDetails,
      required String sportKey,
      Competitors? homeTeam,
      Competitors? awayTeam}) async {
    hotlinesDData.clear();
    hotlinesFData.clear();
    hotlinesMData.clear();
    hotlinesData.clear();
    if (sportKey == 'MLB') {
      mlbStaticsAwayTeamResponse(
          isLoad: false,
          awayTeamId: replaceId(awayTeam?.uuids ?? ''),
          gameDetails: gameDetails);
      mlbStaticsHomeTeamResponse(
          isLoad: false,
          homeTeamId: replaceId(homeTeam?.uuids ?? ''),
          gameDetails: gameDetails);
      mlbInjuriesResponse(
          isLoad: false,
          sportEvent: gameDetails,
          awayTeamId: replaceId(awayTeam?.uuids ?? ''),
          homeTeamId: replaceId(homeTeam?.uuids ?? ''));
      if ((gameDetails.awayPlayerId).isNotEmpty) {
        profileAwayResponse(
          isLoad: false,
          awayTeamId: gameDetails.awayPlayerId,
        );
      }
      if ((gameDetails.homePlayerId).isNotEmpty) {
        profileHomeResponse(
          isLoad: false,
          homeTeamId: gameDetails.homePlayerId,
        );
      }
      hotlinesDataResponse(
              awayTeamId: awayTeam?.id ?? "",
              sportId: sportId,
              date: date,
              start: 0,
              isLoad: isLoad,
              homeTeamId: homeTeam?.id ?? "")
          .then((value) async {
        for (int i = 1; i <= 2; i++) {
          log('i====$i');
          await hotlinesDataResponse(
                  awayTeamId: awayTeam?.id ?? "",
                  sportId: sportId,
                  date: DateFormat('yyyy-MM-dd')
                      .format(DateTime.parse(date).add(Duration(days: i))),
                  start: 0,
                  isLoad: isLoad,
                  homeTeamId: homeTeam?.id ?? "")
              .then((value) {
            isHotlines = false;
            isLoading.value = false;
          });
          if (hotlinesData.isNotEmpty) {
            isHotlines = false;
            update();
            break;
          }
        }
      });
    }
    if (sportKey == 'NFL') {
      isLoading.value = true;
      depthChartResponse(
              gameDetails: gameDetails,
              isLoad: false,
              sportKey: sportKey,
              awayTeamId: awayTeam?.abbreviation == 'LV'
                  ? '7d4fcc64-9cb5-4d1b-8e75-8a906d1e1576'
                  : replaceId(awayTeam?.uuids ?? ''),
              homeTeamId: homeTeam?.abbreviation == 'LV'
                  ? '7d4fcc64-9cb5-4d1b-8e75-8a906d1e1576'
                  : replaceId(homeTeam?.uuids ?? ''))
          .then((value) {
        if (gameDetails.homePlayerId.isNotEmpty) {
          profileHomeTeamResponse(
              sportKey: sportKey,
              playerId: gameDetails.homePlayerId,
              isLoad: isLoad);
        }
        if (gameDetails.awayPlayerId.isNotEmpty) {
          profileAwayTeamResponse(
              sportKey: sportKey,
              playerId: gameDetails.awayPlayerId,
              isLoad: isLoad);
        }
      });
      nflStaticsAwayTeamResponse(
          isLoad: false,
          gameDetails: gameDetails,
          sportKey: sportKey,
          awayTeamId: awayTeam?.abbreviation == 'LV'
              ? '7d4fcc64-9cb5-4d1b-8e75-8a906d1e1576'
              : replaceId(awayTeam?.uuids ?? ''));
      recordsOfNCAAAndNFL(
          isLoad: false,
          sportEvent: gameDetails,
          key: sportKey,
          awayId: awayTeam?.abbreviation == 'LV'
              ? '7d4fcc64-9cb5-4d1b-8e75-8a906d1e1576'
              : replaceId(awayTeam?.uuids ?? ''),
          homeId: homeTeam?.abbreviation == 'LV'
              ? '7d4fcc64-9cb5-4d1b-8e75-8a906d1e1576'
              : replaceId(homeTeam?.uuids ?? ''));
      nflStaticsHomeTeamResponse(
          isLoad: false,
          gameDetails: gameDetails,
          sportKey: sportKey,
          homeTeamId: homeTeam?.abbreviation == 'LV'
              ? '7d4fcc64-9cb5-4d1b-8e75-8a906d1e1576'
              : replaceId(homeTeam?.uuids ?? ''));
      mlbInjuriesResponse(
          isLoad: false,
          sportEvent: gameDetails,
          awayTeamId: awayTeam?.abbreviation == 'LV'
              ? '7d4fcc64-9cb5-4d1b-8e75-8a906d1e1576'
              : replaceId(awayTeam?.uuids ?? ''),
          homeTeamId: homeTeam?.abbreviation == 'LV'
              ? '7d4fcc64-9cb5-4d1b-8e75-8a906d1e1576'
              : replaceId(homeTeam?.uuids ?? ''));
      hotlinesData.clear();
      for (int i = 0; i <= 15; i += 5) {
        log('i====$i');
        hotlinesDataResponse(
                awayTeamId: awayTeam?.id ?? "",
                sportId: sportId,
                date: DateFormat('yyyy-MM-dd')
                    .format(DateTime.parse(hotLinesDate)),
                start: i,
                isLoad: isLoad,
                homeTeamId: homeTeam?.id ?? "")
            .then((value) {
          Future.delayed(const Duration(seconds: 3), () {
            isHotlines = false;
            isLoading.value = false;
          });
        });
        if (hotlinesData.isNotEmpty && i == 15) {
          isHotlines = false;
          isLoading.value = false;
          update();
          break;
        }
      }
    }
    if (sportKey == 'NCAA') {
      isLoading.value = true;
      depthChartResponse(
              gameDetails: gameDetails,
              isLoad: false,
              sportKey: sportKey,
              awayTeamId: awayTeam?.abbreviation == 'LV'
                  ? '7d4fcc64-9cb5-4d1b-8e75-8a906d1e1576'
                  : replaceId(awayTeam?.uuids ?? ''),
              homeTeamId: homeTeam?.abbreviation == 'LV'
                  ? '7d4fcc64-9cb5-4d1b-8e75-8a906d1e1576'
                  : replaceId(homeTeam?.uuids ?? ''))
          .then((value) {
        if (gameDetails.homePlayerId.isNotEmpty) {
          profileHomeTeamResponse(
              sportKey: sportKey,
              playerId: gameDetails.homePlayerId,
              isLoad: isLoad);
        }
        if (gameDetails.awayPlayerId.isNotEmpty) {
          profileAwayTeamResponse(
              sportKey: sportKey,
              playerId: gameDetails.awayPlayerId,
              isLoad: isLoad);
        }
      });
      recordsOfNCAAAndNFL(
          isLoad: false,
          sportEvent: gameDetails,
          key: sportKey,
          awayId: awayTeam?.abbreviation == 'LV'
              ? '7d4fcc64-9cb5-4d1b-8e75-8a906d1e1576'
              : replaceId(awayTeam?.uuids ?? ''),
          homeId: homeTeam?.abbreviation == 'LV'
              ? '7d4fcc64-9cb5-4d1b-8e75-8a906d1e1576'
              : replaceId(homeTeam?.uuids ?? ''));
      nflStaticsAwayTeamResponse(
          isLoad: false,
          gameDetails: gameDetails,
          sportKey: sportKey,
          awayTeamId: replaceId(awayTeam?.uuids ?? ''));
      nflStaticsHomeTeamResponse(
          isLoad: false,
          gameDetails: gameDetails,
          sportKey: sportKey,
          homeTeamId: replaceId(homeTeam?.uuids ?? ''));
      for (int i = 0; i <= 15; i += 5) {
        log('i====$i');
        hotlinesDataResponse(
                awayTeamId: awayTeam?.id ?? "",
                sportId: sportId,
                date: DateFormat('yyyy-MM-dd')
                    .format(DateTime.parse(hotLinesDate)),
                start: i,
                isLoad: isLoad,
                homeTeamId: homeTeam?.id ?? "")
            .then((value) {
          Future.delayed(const Duration(seconds: 3), () {
            isHotlines = false;
            isLoading.value = false;
          });
        });
        if (hotlinesData.isNotEmpty && i == 15) {
          isHotlines = false;
          isLoading.value = false;
          update();
          break;
        }
      }
    }
    if (sportKey == 'NBA' || sportKey == "NCAAB") {
      isHotlines = true;
      if (sportKey == 'NBA') {
        await nbaRosterStaticsHomeResponse(
          gameDetails: gameDetails,
          sportKey: sportKey,
          isLoad: isLoad,
          homeTeamId: replaceId(homeTeam?.uuids ?? ''),
        );
        await nbaRosterStaticsAwayResponse(
            gameDetails: gameDetails,
            sportKey: sportKey,
            isLoad: isLoad,
            awayTeamId: replaceId(awayTeam?.uuids ?? ''));
        gameDetails.awayRushingPlayer.clear();
        for (var player in gameDetails.awayRushingPlayerName) {
          await nbaAwayPlayerProfileResponse(
                  gameDetails: gameDetails,
                  sportKey: sportKey,
                  isLoad: isLoad,
                  playerId: player.id ?? "")
              .then((value) => isLoadPlayStatAway.value = false);
        }
        gameDetails.homeRushingPlayer.clear();
        for (var player in gameDetails.homeRushingPlayerName) {
          await nbaHomePlayerProfileResponse(
                  gameDetails: gameDetails,
                  sportKey: sportKey,
                  isLoad: isLoad,
                  playerId: player.id ?? "")
              .then((value) => isLoadPlayStatHome.value = false);
        }
      }

      for (int i = 0; i <= 15; i += 5) {
        log('i====$i');
        hotlinesDataResponse(
                awayTeamId: awayTeam?.id ?? "",
                sportId: sportId,
                date: DateFormat('yyyy-MM-dd')
                    .format(DateTime.parse(hotLinesDate)),
                start: i,
                isLoad: isLoad,
                homeTeamId: homeTeam?.id ?? "")
            .then((value) {
          Future.delayed(const Duration(seconds: 3), () {
            isHotlines = false;
            isLoading.value = false;
          });
        });
        if (hotlinesData.isNotEmpty && i == 15) {
          isHotlines = false;
          isLoading.value = false;
          update();
          break;
        }
      }
    }
    update();
  }
}

class StartingQBModel {
  String playerId;
  String playerName;
  String teamId;
  StartingQBModel(
      {required this.playerId, required this.playerName, required this.teamId});
}
