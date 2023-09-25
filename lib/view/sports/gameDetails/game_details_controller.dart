import 'dart:developer';
import 'package:hotlines/model/game_listing.dart';
import 'package:get/get.dart';
import 'package:hotlines/model/mlb_injuries_model.dart';
import 'package:hotlines/model/nfl_injury_model.dart';
import 'package:hotlines/model/ranking_model.dart';
import 'package:hotlines/utils/utils.dart';

import '../../../constant/constant.dart';
import '../../../model/game_model.dart';

import '../../../model/hotlines_data_model.dart' as hotlines;
import '../../../model/mlb_statics_model.dart' as stat;
import '../../../model/nfl_statics_model.dart';
import '../../../model/nfl_team_record_model.dart';
import '../../../model/player_profile_model.dart';
import '../../../model/response_item.dart';
import '../../../model/team_record_model.dart';
import '../../../network/game_listing_repo.dart';
import '../../../theme/helper.dart';

class GameDetailsController extends GetxController {
  List offensive = [
    'Points Per Game',
    'Redzone Efficiency',
    'Rushing Yards/Game',
    'Passing Yards/Game',
    'Rushing TDs/Game',
    'Passing TDs/Game',
    '3rd Down Efficiency',
    '4th Down Efficiency',
    'Field goal Percentage',
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
    'Opponent Redzone Efficiency',
    'Rushing Yards Allowed/Game',
    'Passing Yards Allowed/Game',
    'Rushing TDs Allowed/Game',
    'Passing TDs Allowed/Game',
    'Opponent 3rd Down Efficiency',
    'Opponent 4th Down Efficiency',
    'Field goal Percentage',
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
    "Fumbles",
  ];

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
  }

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
                '${(double.parse((offenciveData?.efficiency?.redzone?.pct ?? "0").toString()).toStringAsFixed(1))}%',
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
                '${(double.parse((offenciveData?.efficiency?.thirddown?.pct ?? "0").toString()).toStringAsFixed(1))}%',
                '${(double.parse((offenciveData?.efficiency?.fourthdown?.pct ?? "0").toString()).toStringAsFixed(1))}%',
                (double.parse(((offenciveData?.fieldGoals?.made ?? 0) /
                            (offenciveData?.fieldGoals?.attempts ?? 0) *
                            100)
                        .toString())
                    .toStringAsFixed(1)),
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
                '${(double.parse((defenciveData?.efficiency?.redzone?.pct ?? "0").toString()).toStringAsFixed(1))}%',
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
                '${(double.parse((defenciveData?.efficiency?.thirddown?.pct ?? "0").toString()).toStringAsFixed(1))}%',
                '${(double.parse((defenciveData?.efficiency?.fourthdown?.pct ?? "0").toString()).toStringAsFixed(1))}%',
                (double.parse(((defenciveData?.fieldGoals?.made ?? 0) /
                            (defenciveData?.fieldGoals?.attempts ?? 0) *
                            100)
                        .toString())
                    .toStringAsFixed(1)),
              ];
              gameDetails.homeRunningBackPlayer.clear();
              gameDetails.homeReceiversPlayer.clear();
              if (response.players != null) {
                response.players?.forEach((player) {
                  if (player.position == 'RB' && player.gamesPlayed != 0) {
                    gameDetails.homeRunningBackPlayer.add(player);
                    // runningBacksHomeList.add(RunningBacks(carries: carries, yard: yard, avgCarry: avgCarry, tds: tds, longestRun: longestRun, fumbles: fumbles))
                  }
                  if (player.position == 'WR' && player.gamesPlayed != 0) {
                    gameDetails.homeReceiversPlayer.add(player);
                  }
                  if (player.position == 'QB' && player.gamesStarted != 0) {
                    num totalPlay = player.gamesPlayed ?? 1;
                    gameDetails.homePassingYard =
                        ((int.parse(player.passing?.yards.toString() ?? "0") /
                                totalPlay)
                            .toStringAsFixed(1));
                    gameDetails.homePassingTds = ((int.parse(
                                player.passing?.touchdowns.toString() ?? "0") /
                            totalPlay)
                        .toStringAsFixed(2));
                    gameDetails.homeRushingYard =
                        ((int.parse(player.rushing?.yards.toString() ?? "0") /
                                totalPlay)
                            .toStringAsFixed(1));
                    gameDetails.homeRushingTds = ((int.parse(
                                player.rushing?.touchdowns.toString() ?? "0") /
                            totalPlay)
                        .toStringAsFixed(2));
                    gameDetails.homeFumble =
                        (player.fumbles?.fumbles ?? "0").toString();
                    /* gameDetails.homeQbr =
                        (player.fumbles?. ?? "0").toString();*/
                    gameDetails.homePlayerName =
                        (player.name ?? "0").toString();
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
                '${(double.parse((offenciveData?.efficiency?.redzone?.pct ?? "0").toString()).toStringAsFixed(1))}%',
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
                '${(double.parse((offenciveData?.efficiency?.thirddown?.pct ?? "0").toString()).toStringAsFixed(1))}%',
                '${(double.parse((offenciveData?.efficiency?.fourthdown?.pct ?? "0").toString()).toStringAsFixed(1))}%',
                (double.parse(((offenciveData?.fieldGoals?.made ?? 0) /
                            (offenciveData?.fieldGoals?.attempts ?? 0) *
                            100)
                        .toString())
                    .toStringAsFixed(1)),
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
                '${(double.parse((defenciveData?.efficiency?.redzone?.pct ?? "0").toString()).toStringAsFixed(1))}%',
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
                '${(double.parse((defenciveData?.efficiency?.thirddown?.pct ?? "0").toString()).toStringAsFixed(1))}%',
                '${(double.parse((defenciveData?.efficiency?.fourthdown?.pct ?? "0").toString()).toStringAsFixed(1))}%',
                (double.parse(((defenciveData?.fieldGoals?.made ?? 0) /
                            (defenciveData?.fieldGoals?.attempts ?? 0) *
                            100)
                        .toString())
                    .toStringAsFixed(1)),
              ];
              gameDetails.awayReceiversPlayer.clear();
              gameDetails.awayRunningBackPlayer.clear();
              if (response.players != null) {
                response.players?.forEach((player) {
                  if (player.position == 'RB' && player.gamesPlayed != 0) {
                    gameDetails.awayRunningBackPlayer.add(player);
                  }
                  if (player.position == 'WR' && player.gamesPlayed != 0) {
                    gameDetails.awayReceiversPlayer.add(player);
                  }
                  if (player.position == 'QB' && player.gamesStarted != 0) {
                    num totalPlay = player.gamesPlayed ?? 1;
                    gameDetails.awayPassingYard =
                        ((int.parse(player.passing?.yards.toString() ?? "0") /
                                totalPlay)
                            .toStringAsFixed(1));
                    gameDetails.awayPassingTds = ((int.parse(
                                player.passing?.touchdowns.toString() ?? "0") /
                            totalPlay)
                        .toStringAsFixed(2));
                    gameDetails.awayRushingYard =
                        ((int.parse(player.rushing?.yards.toString() ?? "0") /
                                totalPlay)
                            .toStringAsFixed(1));
                    gameDetails.awayRushingTds = ((int.parse(
                                player.rushing?.touchdowns.toString() ?? "0") /
                            totalPlay)
                        .toStringAsFixed(2));
                    gameDetails.awayFumble =
                        (player.fumbles?.fumbles ?? "0").toString();
                    /* gameDetails.awayQbr =
                        (player.fumbles?. ?? "0").toString();*/
                    gameDetails.awayInterCaption =
                        (player.passing?.interceptions ?? "0").toString();
                    gameDetails.awayPlayerName = (player.name ?? "").toString();
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
        // showAppSnackBar(
        //   result.message,
        // );
      }
      isHotlines = false;
      isLoading.value = false;
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
      for (int i = 1; i <= 10; i += 5) {
        log('i====$i');
        await hotlinesDataResponse(
                awayTeamId: awayTeam?.id ?? "",
                sportId: sportId,
                date: date,
                start: i,
                isLoad: isLoad,
                homeTeamId: homeTeam?.id ?? "")
            .then((value) {
          isHotlines = false;
        });
        if (hotlinesData.isNotEmpty) {
          isHotlines = false;
          update();
          break;
        }
      }
    }
    if (sportKey == 'NFL') {
      isLoading.value = true;
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
      for (int i = 1; i <= 10; i += 5) {
        log('i====$i');
        await hotlinesDataResponse(
                awayTeamId: awayTeam?.id ?? "",
                sportId: sportId,
                date: date,
                start: i,
                isLoad: isLoad,
                homeTeamId: homeTeam?.id ?? "")
            .then((value) {
          isHotlines = false;
          isLoading.value = false;
        });

        if (hotlinesData.isNotEmpty) {
          isHotlines = false;
          isLoading.value = false;
          update();
          break;
        }
      }
    }
    if (sportKey == 'NCAA') {
      isLoading.value = true;

      ncaaGameRanking(
              isLoad: false,
              gameDetails: gameDetails,
              homeTeamId: replaceId(homeTeam?.uuids ?? ''),
              awayTeamId: replaceId(awayTeam?.uuids ?? ''))
          .then((value) {
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
      });
      for (int i = 1; i <= 10; i += 5) {
        log('i====$i');
        await hotlinesDataResponse(
                awayTeamId: awayTeam?.id ?? "",
                sportId: sportId,
                date: date,
                start: i,
                isLoad: isLoad,
                homeTeamId: homeTeam?.id ?? "")
            .then((value) {
          isHotlines = false;
          isLoading.value = false;
        });
        if (hotlinesData.isNotEmpty) {
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
