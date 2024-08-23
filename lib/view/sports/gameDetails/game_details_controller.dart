import 'dart:developer';

import 'package:get/get.dart';
import 'package:hotlines/model/game_listing.dart';
import 'package:hotlines/model/mlb_injuries_model.dart';
import 'package:hotlines/model/nfl_injury_model.dart';
import 'package:hotlines/utils/utils.dart';

import '../../../constant/constant.dart';
import '../../../extras/request_constants.dart';
import '../../../model/game_model.dart';
import '../../../model/hotlines_data_model.dart' as hotlines;
import '../../../model/mlb_statics_model.dart' as stat;
import '../../../model/nba_statics_model.dart';
import '../../../model/ncaab_standings_model.dart';
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
  List shortOffensive = [
    'PPG',
    'RYG',
    'PYG',
    'RTG',
    'PTG',
    'RE',
    '3rdDE',
    '4thDE',
    'FGP',
    'TG',
  ];
  List nbaOffensive = [
    'Points/Game',
    'Rebounds/Game',
    'Assists/Game',
    'Steals/Game',
    'Blocks/Game',
    'Total Turnovers/Game',
    'Fouls/Game',
    'FG att / made / %',
    '3P att / made / %',
    'FT att / made / %',
    'True Shooting',
    'Team PER Off',
  ];
  List shortOffensiveNBA = [
    'PG',
    'RG',
    'AG',
    'SG',
    'BG',
    'TTG',
    'FG',
    'FGG',
    '3PG',
    'FTG',
    'TS',
    'TO',
  ];
  List shortDefensiveNBA = [
    'PAG',
    'ORG',
    'OAG',
    'OSG',
    'OBG',
    'OTTG',
    'OFG',
    'OFGG',
    'O3PG',
    'OFTG',
    'OTS',
    'TD',
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
  List shortFormDefensive = [
    'PAGame',
    'RYAG',
    'PYAG',
    'RTAG',
    'PTAG',
    'ORE',
    'O3rDE',
    'O4thDE',
    'FGP',
    'TCG'
  ];
  List nbaDefensive = [
    'Points Allowed/Game',
    'Opponent Rebounds/Game',
    'Opponent Assists/Game',
    'Opponent Steals/Game',
    'Opponent Blocks/Game',
    'Opponent Total Turnovers/Game',
    'Opponent Fouls/Game',
    'Opponent FG att / made / %',
    'Opponent 3P att / made / %',
    'Opponent FT att / made / %',
    'Opponent True Shooting',
    'Team PER Def',
  ];
  List nbaMobileDefensive = [
    'Points Allowed/Game',
    'Opp Rebounds/Game',
    'Opp Assists/Game',
    'Opp Steals/Game',
    'Opp Blocks/Game',
    'Opp Total Turnovers/Game',
    'Opp Fouls/Game',
    'Opp FG att / made / %',
    'Opp 3P att / made / %',
    'Opp FT att / made / %',
    'Opp True Shooting',
    'Team PER Def',
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
    'Interceptions/Game',
  ];
  List teamQuarterBacksShortForm = [
    'PYG',
    'PTG',
    'RYG',
    'RTG',
    'IG',
  ];
  List teamQuarterBacksDefence = [
    'Passing Yards Allowed/Game',
    'Passing TDs Allowed/Game',
    'Rushing Yards Allowed/Game',
    'Rushing TDs Allowed/Game',
    'Interceptions/Game',
  ];
  List teamQuarterBacksDefenceShortForm = [
    'PYAG',
    'PTAG',
    'RYAG',
    'RTAG',
    'IG',
  ];

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
  List<HitterPlayerStatMainModel> _hitterHomePlayerMainList = [];

  List<HitterPlayerStatMainModel> get hitterHomePlayerMainList =>
      _hitterHomePlayerMainList;

  set hitterHomePlayerMainList(List<HitterPlayerStatMainModel> value) {
    _hitterHomePlayerMainList = value;
    update();
  }

  String _awayPlayerName = '';

  String get awayPlayerName => _awayPlayerName;

  set awayPlayerName(String value) {
    _awayPlayerName = value;
    update();
  }

  String _homePlayerName = '';

  String get homePlayerName => _homePlayerName;

  set homePlayerName(String value) {
    _homePlayerName = value;
    update();
  }

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
          homePlayerName =
              '${playerData.fullName.split(" ").first[0]}. ${playerData.fullName.split(" ").last}';

          for (var player in playerData.seasons) {
            if (player.type == '$SEASONS' && player.year == DateTime.now().year) {
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

  /*Future profileHomeTeamResponse(
      {String playerId = '', String sportKey = '', bool isLoad = false,required SportEvents gameDetails}) async {
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
              if (element.year == DateTime
                  .now()
                  .year &&
                  element.type == "$SEASONS") {
                if (element.teams != null) {
                  element.teams?.forEach((static) {
                    num totalPlay = static.statistics?.gamesPlayed ?? 1;
                    gameDetails.homeQb = [
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
                      ((int.parse(static.statistics?.passing?.interceptions
                          .toString() ??
                          "0") /
                          totalPlay)
                          .toStringAsFixed(2)),
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
      {String playerId = '', String sportKey = '', bool isLoad = false,required SportEvents gameDetails}) async {
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
              if (element.year == DateTime
                  .now()
                  .year &&
                  element.type == "$SEASONS") {
                if (element.teams != null) {
                  element.teams?.forEach((static) {
                    num totalPlay = static.statistics?.gamesPlayed ?? 1;
                    gameDetails.awayQb = [
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
                      ((int.parse(static.statistics?.passing?.interceptions
                          .toString() ??
                          "0") /
                          totalPlay)
                          .toStringAsFixed(2)),
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
  }*/

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
          awayPlayerName =
              '${playerData.fullName.split(" ").first[0]}. ${playerData.fullName.split(" ").last}';

          for (var player in playerData.seasons) {
            if (player.type == '$SEASONS' && player.year == DateTime.now().year) {
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
    result = await GameListingRepo()
        .mlbStaticsRepo(teamId: homeTeamId, seasons: currentYear);
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
                      avg: player.statistics?.hitting?.overall?.avg ?? "0",
                      bb:
                          '${player.statistics?.hitting?.overall?.onbase?.bb ?? "0"}',
                      hAbValue:
                          '${player.statistics?.hitting?.overall?.onbase?.h ?? "0"}-${player.statistics?.hitting?.overall?.ab ?? "0"}',
                      hr:
                          '${player.statistics?.hitting?.overall?.onbase?.hr ?? "0"}',
                      position: player.position ?? "0",
                      rbi: '${player.statistics?.hitting?.overall?.rbi ?? "0"}',
                      sb:
                          '${player.statistics?.hitting?.overall?.steal?.stolen ?? "0"}',
                      obp: 'OBP',
                      obpValue:
                          '${player.statistics?.hitting?.overall?.obp ?? "0"}',
                      hAb: 'H-AB',
                      slg: 'SLG',
                      slgValue:
                          '${player.statistics?.hitting?.overall?.slg ?? "0"}',
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
                      ab: '${player.statistics?.hitting?.overall?.ab ?? "0"}',
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

  List<HitterPlayerStatMainModel> _hitterAwayPlayerMainList = [];

  List<HitterPlayerStatMainModel> get hitterAwayPlayerMainList =>
      _hitterAwayPlayerMainList;

  set hitterAwayPlayerMainList(List<HitterPlayerStatMainModel> value) {
    _hitterAwayPlayerMainList = value;
    update();
  }

  Future mlbStaticsAwayTeamResponse(
      {String awayTeamId = '',
      bool isLoad = false,
      required SportEvents gameDetails}) async {
    // isLoading.value = !isLoad ? false : true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo().mlbStaticsRepo(
      teamId: awayTeamId,
      seasons: currentYear,
    );
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
                    bb:
                        '${player.statistics?.hitting?.overall?.onbase?.bb ?? "0"}',
                    playerName: '${player.firstName?[0]}. ${player.lastName}',
                    avg: player.statistics?.hitting?.overall?.avg ?? "0",
                    hAbValue:
                        '${player.statistics?.hitting?.overall?.onbase?.h ?? "0"}-${player.statistics?.hitting?.overall?.ab ?? "0"}',
                    hr:
                        '${player.statistics?.hitting?.overall?.onbase?.hr ?? "0"}',
                    position: player.position ?? "0",
                    rbi: '${player.statistics?.hitting?.overall?.rbi ?? "0"}',
                    sb:
                        '${player.statistics?.hitting?.overall?.steal?.stolen ?? "0"}',
                    obp: 'OBP',
                    obpValue:
                        '${player.statistics?.hitting?.overall?.obp ?? "0"}',
                    hAb: 'H-AB',
                    slg: 'SLG',
                    slgValue:
                        '${player.statistics?.hitting?.overall?.slg ?? "0"}',
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
                    ab: '${player.statistics?.hitting?.overall?.ab ?? "0"}',
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
          '.${((awayHitting?.slg ?? "0").toString().split('.').last)}',
          '${awayHitting?.ops ?? '0'}',
          ((int.parse(awayHitting?.outs?.gidp.toString() ?? "0") / totalGame)
              .toStringAsFixed(2)),
          awayHitting?.abhr?.toStringAsFixed(2) ?? "0",
        ];
        mlbAwayPitchingList = [
          '${awayPitching?.era ?? '0'}',
          '${awayPitching?.games?.shutout ?? '0'}',
          '.${(((awayPitching?.games?.save ?? 0) / (awayPitching?.games?.svo ?? 1)).toStringAsFixed(3).split('.').last)}',
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
        teamId: homeTeamId, seasons: currentYear, sportKey: sportKey);
    try {
      if (result.status) {
        if (result.data != null) {
          NFLStaticsModel response = NFLStaticsModel.fromJson(result.data);
          if (response.season != null) {
            if (response.record != null) {
              var offenciveData = response.record;
              var defenciveData = response.opponents;
              num totalGame = offenciveData?.gamesPlayed ?? 1;
              gameDetails.homeDefense = [
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
                (int.parse(defenciveData?.defense?.interceptions.toString() ??
                            "0") /
                        totalGame)
                    .toStringAsFixed(2),
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
                  /* if (sportKey == "NCAA") {
                    if (player.position == 'QB' && player.gamesStarted != 0) {
                      gameStart.add(player.gamesStarted ?? 0);
                      num gameStartNum = gameStart.max;
                      if (gameStartNum == player.gamesStarted) {
                        num totalPlay = player.gamesPlayed ?? 1;
                        gameDetails.homeQb = [
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
                          ((int.parse(player.passing?.interceptions
                              .toString() ??
                              "0") /
                              totalPlay)
                              .toStringAsFixed(2)),

                          // (player.fumbles?.fumbles ?? "0").toString(),
                        ];
                        gameDetails.homePlayerName =
                            (player.name ?? "").toString();
                      }
                    }
                  }*/
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

/*  List<StartingQBModel> qbsList = [
    StartingQBModel(
      playerId: "7738fea8-7ea2-4c4c-b589-bca90b070819",
      playerName: "Nick Mullens",
      teamId: "33405046-04ee-4058-a950-d606f8c30852",
    ),
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
      playerId: "64797df2-efd3-4b27-86ee-1d48f7edb09f",
      playerName: "Joe Flacco",
      teamId: "d5a2eb42-8065-4174-ab79-0a6fa820e35e",
    ),
    // StartingQBModel(
    //   playerId: "15bedebc-839e-450a-86f6-1f5ad1f4f820",
    //   playerName: "Joshua Dobbs",
    //   teamId: "33405046-04ee-4058-a950-d606f8c30852",
    // ),
    StartingQBModel(
      playerId: "5891a917-9071-4bc2-a652-7f702c44cbd2",
      playerName: "Aidan O'Connell",
      teamId: "7d4fcc64-9cb5-4d1b-8e75-8a906d1e1576",
    ),
    StartingQBModel(
      playerId: "5891a917-9071-4bc2-a652-7f702c44cbd2",
      playerName: "Aidan O'Connell",
      teamId: "7d4fcc64-9cb5-4d1b-8e75-8a906d1e1576",
    ),
    StartingQBModel(
      playerId: "7a1b8f1a-9024-4897-86b0-01c63e00305e",
      playerName: "Mitch Trubisky",
      teamId: "cb2f9f1f-ac67-424e-9e72-1475cb0ed398",
    ),
    StartingQBModel(
      playerId: "14926860-abef-45a9-b8f6-e66103ca6029",
      playerName: "Bailey Zappe",
      teamId: "97354895-8c77-4fd4-a860-32e62ea7382a",
    ),
    StartingQBModel(
      playerId: "af291d43-a51f-44ce-b8ac-430ec68c78c8",
      playerName: "Easton Stick",
      teamId: "1f6dcffb-9823-43cd-9ff4-e7a8466749b5",
    ),
    StartingQBModel(
      playerId: "2c259733-ec2c-4e3c-bb7b-34dc0d37dc34",
      playerName: "Taylor Heinicke",
      teamId: "e6aa13a4-0055-48a9-bc41-be28dc106929",
    ),

  ];

  Future depthChartResponse({String homeTeamId = '',
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
              int homeIndex = response.teams?.indexWhere(
                      (element) => (element.id ?? 0) == homeTeamId) ??
                  -1;
              if ((homeIndex) >= 0) {
                response.teams?[homeIndex].offense?.forEach((position) {
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
              int awayIndex = response.teams?.indexWhere(
                      (element) => (element.id ?? 0) == awayTeamId) ??
                  -1;
              if ((awayIndex) >= 0) {
                response.teams?[awayIndex].offense?.forEach((position) {
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
  }*/

  ///NFL GAME RANK API
/*  Future nflGameRankApi({String awayTeamId = '',
    String homeTeamId = '',
    required SportEvents gameDetails,
    bool isLoad = false,
    String sportKey = ''}) async {
    ResponseItem result =
    ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo().nflGameRankApi(sportKey);
    try {
      if (result.status) {
        NFLGameRankModel response = NFLGameRankModel.fromJson(result.toJson());
        if (response.data != null) {
          response.data?.forEach((team) {
            if (awayTeamId == replaceId(team.teamId ?? "")) {
              gameDetails.awayPointOffenseRank = team.pointOffenceRank ?? 0;
              gameDetails.awayPointDefenseRank = team.pointsDefenseRank ?? 0;
              gameDetails.awayRushingOffenseRank = team.rushingOffenseRank ?? 0;
              gameDetails.awayRushingDefenseRank = team.rushingDefenseRank ?? 0;
              gameDetails.awayPointOffense = team.pointsOffense ?? 0;
              gameDetails.awayPointDefense = team.pointsDefense ?? 0;
              gameDetails.awayRushingOffense = team.rushingOffense ?? 0;
              gameDetails.awayRushingDefense = team.rushingDefense ?? 0;
              gameDetails.awayPassingYardOffense=team.passingYardOffense??0;
              gameDetails.awayPassingYardDefense=team.passingYardDefense??0;
              gameDetails.awayRushingTDSOffense=team.rushingTDSOffense??0;
              gameDetails.awayRushingTDSDefence=team.rushingTDSDefence??0;
              gameDetails.awayPassingTDSOffense=team.passingTDSOffense??0;
              gameDetails.awayPassingTDSDefence=team.passingTDSDefence??0;
              gameDetails.awayRedZonEfficiencyOffence=team.redzonEfficiencyOffence??0;
              gameDetails.awayOpponentRedZonEfficiency=team.opponentRedzonEfficiency??0;
              gameDetails.awayThirdDownOffence=team.thirdDownOffence??0;
              gameDetails.awayOpponentThirdDown=team.opponentThirdDown??0;
              gameDetails.awayFourthDownOffense=team.fourthDownOffense??0;
              gameDetails.awayOpponentFourthDown=team.opponentFourtDown??0;
              gameDetails.awayFieldGoalOffense=team.fieldGoalOffense??0;
              gameDetails.awayFieldGoalDefense=team.fieldGoalDefense??0;
              gameDetails.awayTernOverOffense=team.ternoverOffense??0;
              gameDetails.awayTernOverDefense=team.ternoverDefense??0;
              gameDetails.awayPassingYardOffenseRank=team.passingYardOffenseRank??0;
              gameDetails.awayPassingYardDefenseRank=team.passingYardDefenseRank??0;
              gameDetails.awayRushingTDSOffenseRank=team.rushingTDSOffenseRank??0;
              gameDetails.awayRushingTDSDefenceRank=team.rushingTDSDefenceRank??0;
              gameDetails.awayPassingTDSOffenseRank=team.passingTDSOffenseRank??0;
              gameDetails.awayPassingTDSDefenceRank=team.passingTDSDefenceRank??0;
              gameDetails.awayRedZonEfficiencyOffenceRank=team.redzonEfficiencyOffenceRank??0;
              gameDetails.awayOpponentRedZonEfficiencyRank=team.opponentRedzonEfficiencyRank??0;
              gameDetails.awayThirdDownOffenceRank=team.thirdDownOffenceRank??0;
              gameDetails.awayOpponentThirdDownRank=team.opponentThirdDownRank??0;
              gameDetails.awayFourthDownOffenseRank=team.fourthDownOffenseRank??0;
              gameDetails.awayOpponentFourthDownRank=team.opponentFourtDownRank??0;
              gameDetails.awayFieldGoalOffenseRank=team.fieldGoalOffenseRank??0;
              gameDetails.awayFieldGoalDefenseRank=team.fieldGoalDefenseRank??0;
              gameDetails.awayTernOverOffenseRank=team.ternoverOffenseRank??0;
              gameDetails.awayTernOverDefenseRank=team.ternoverDefenseRank??0;
              gameDetails.awayInterceptionDefenseRank=team.interceptionDefenseRank??0;
            }
            if (homeTeamId == replaceId(team.teamId ?? "")) {
              gameDetails.homePointOffenseRank = team.pointOffenceRank ?? 0;
              gameDetails.homePointDefenseRank = team.pointsDefenseRank ?? 0;
              gameDetails.homeRushingOffenseRank = team.rushingOffenseRank ?? 0;
              gameDetails.homeRushingDefenseRank = team.rushingDefenseRank ?? 0;
              gameDetails.homePointOffense = team.pointsOffense ?? 0;
              gameDetails.homePointDefense = team.pointsDefense ?? 0;
              gameDetails.homeRushingOffense = team.rushingOffense ?? 0;
              gameDetails.homeRushingDefense = team.rushingDefense ?? 0;
              gameDetails.homePassingYardOffense=team.passingYardOffense??0;
              gameDetails.homePassingYardDefense=team.passingYardDefense??0;
              gameDetails.homeRushingTDSOffense=team.rushingTDSOffense??0;
              gameDetails.homeRushingTDSDefence=team.rushingTDSDefence??0;
              gameDetails.homePassingTDSOffense=team.passingTDSOffense??0;
              gameDetails.homePassingTDSDefence=team.passingTDSDefence??0;
              gameDetails.homeRedZonEfficiencyOffence=team.redzonEfficiencyOffence??0;
              gameDetails.homeOpponentRedZonEfficiency=team.opponentRedzonEfficiency??0;
              gameDetails.homeThirdDownOffence=team.thirdDownOffence??0;
              gameDetails.homeOpponentThirdDown=team.opponentThirdDown??0;
              gameDetails.homeFourthDownOffense=team.fourthDownOffense??0;
              gameDetails.homeOpponentFourthDown=team.opponentFourtDown??0;
              gameDetails.homeFieldGoalOffense=team.fieldGoalOffense??0;
              gameDetails.homeFieldGoalDefense=team.fieldGoalDefense??0;
              gameDetails.homeTernOverOffense=team.ternoverOffense??0;
              gameDetails.homeTernOverDefense=team.ternoverDefense??0;
              gameDetails.homePassingYardOffenseRank=team.passingYardOffenseRank??0;
              gameDetails.homePassingYardDefenseRank=team.passingYardDefenseRank??0;
              gameDetails.homeRushingTDSOffenseRank=team.rushingTDSOffenseRank??0;
              gameDetails.homeRushingTDSDefenceRank=team.rushingTDSDefenceRank??0;
              gameDetails.homePassingTDSOffenseRank=team.passingTDSOffenseRank??0;
              gameDetails.homePassingTDSDefenceRank=team.passingTDSDefenceRank??0;
              gameDetails.homeRedZonEfficiencyOffenceRank=team.redzonEfficiencyOffenceRank??0;
              gameDetails.homeOpponentRedZonEfficiencyRank=team.opponentRedzonEfficiencyRank??0;
              gameDetails.homeThirdDownOffenceRank=team.thirdDownOffenceRank??0;
              gameDetails.homeOpponentThirdDownRank=team.opponentThirdDownRank??0;
              gameDetails.homeFourthDownOffenseRank=team.fourthDownOffenseRank??0;
              gameDetails.homeOpponentFourthDownRank=team.opponentFourtDownRank??0;
              gameDetails.homeFieldGoalOffenseRank=team.fieldGoalOffenseRank??0;
              gameDetails.homeFieldGoalDefenseRank=team.fieldGoalDefenseRank??0;
              gameDetails.homeTernOverOffenseRank=team.ternoverOffenseRank??0;
              gameDetails.homeTernOverDefenseRank=team.ternoverDefenseRank??0;
              gameDetails.homeInterceptionDefenseRank=team.interceptionDefenseRank??0;
            }
          });
        }
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      log('ERROR NFL GAME RANK-----$e');
      showAppSnackBar(errorText);
    }
    update();
  }*/

  /* Future getNFLQBSRank({String awayTeamId = '',
    String homeTeamId = '',
    required SportEvents gameDetails,
    bool isLoad = false,
    String sportKey = ''}) async {
    ResponseItem result =
    ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo().getNFLQBSRank(sportKey);
    try {
      if (result.status) {
        NFLQBsRankModel response = NFLQBsRankModel.fromJson(result.toJson());
        if (response.data != null) {
          response.data?.forEach((element) {
            if (homeTeamId == element.teamId) {
              gameDetails.homePlayerName=element.playerName??"";
              gameDetails.homePlayerId=element.playerId??"";
              gameDetails.homeQb = [
                (element.passingYardOffense??0).toString(),
                (element.passingTDSOffense??0).toString(),
                (element.rushingYardOffense??0).toString(),
                (element.rushingTDsOffense??0).toString(),
                (element.interceptionOffense??0).toString(),
              ];
              gameDetails.homeQbRank = [
                (element.passingYardOffenseRank??0).toString(),
                (element.passingTDSOffenseRank??0).toString(),
                (element.rushingTDsOffenseRank??0).toString(),
                (element.rushingTDsOffenseRank??0).toString(),
                (element.interceptionOffenseRank??0).toString(),
              ];
            }if (awayTeamId == element.teamId) {
              gameDetails.awayPlayerName=element.playerName??"";
              gameDetails.awayPlayerId=element.playerId??"";
              gameDetails.awayQb = [
                (element.passingYardOffense??0).toString(),
                (element.passingTDSOffense??0).toString(),
                (element.rushingYardOffense??0).toString(),
                (element.rushingTDsOffense??0).toString(),
                (element.interceptionOffense??0).toString(),
              ];gameDetails.awayQbRank = [
                (element.passingYardOffenseRank??0).toString(),
                (element.passingTDSOffenseRank??0).toString(),
                (element.rushingTDsOffenseRank??0).toString(),
                (element.rushingTDsOffenseRank??0).toString(),
                (element.interceptionOffenseRank??0).toString(),
              ];
            }
          });
        }

      } else {
        isLoading.value = false;
      }
    } catch (e) {
      log('ERROR NFL GAME RANK-----$e');
      showAppSnackBar(errorText);
    }
    update();
  }*/

  Future nflStaticsAwayTeamResponse(
      {String awayTeamId = '',
      required SportEvents gameDetails,
      bool isLoad = false,
      String sportKey = ''}) async {
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo().nflStaticsRepo(
        teamId: awayTeamId, seasons: currentYear, sportKey: sportKey);
    try {
      if (result.status) {
        if (result.data != null) {
          NFLStaticsModel response = NFLStaticsModel.fromJson(result.data);
          if (response.season != null) {
            if (response.record != null) {
              var offenciveData = response.record;
              var defenciveData = response.opponents;
              num totalGame = offenciveData?.gamesPlayed ?? 1;
              gameDetails.awayDefense = [
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
                ((int.parse(defenciveData?.defense?.interceptions.toString() ??
                            "0") /
                        totalGame)
                    .toStringAsFixed(2)),
                // (offenciveData?.defense?.interceptions ?? "0").toString(),
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
                  /* if (sportKey == "NCAA") {
                    if (player.position == 'QB' && player.gamesStarted != 0) {
                      gameStart.add(player.gamesStarted ?? 0);
                      num gameStartNum = gameStart.max;
                      if (gameStartNum == player.gamesStarted) {
                        num totalPlay = player.gamesPlayed ?? 1;
                        gameDetails.awayQb = [
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
                          ((int.parse(player.passing?.interceptions
                              .toString() ??
                              "0") /
                              totalPlay)
                              .toStringAsFixed(2)),

                          // (player.fumbles?.fumbles ?? "0").toString(),
                        ];

                        gameDetails.awayPlayerName =
                            (player.name ?? "").toString();
                      }
                    }
                  }*/
                });
              }
              gameDetails.awayRunningBackPlayer.sort((a, b) =>
                  (b.rushing?.yards ?? 0).compareTo(a.rushing?.yards ?? 0));
              gameDetails.awayReceiversPlayer.sort((a, b) =>
                  (b.receiving?.yards ?? 0).compareTo(a.receiving?.yards ?? 0));
            }
            update();
          }
        } else {
          isLoading.value = false;
        }
      } else {
        isLoading.value = false;
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

/*  Future getRosterPlayer({String awayTeamId = '',
    required SportEvents gameDetails,
    bool isLoad = false,
    String sportKey = ''}) async {
    ResponseItem result =
    ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo().getRosterPlayer(teamId: awayTeamId);
    try {
      if (result.status) {
        if (result.data != null) {
          NFLRosterPlayerModel response =
          NFLRosterPlayerModel.fromJson(result.data);
          gameDetails.nflAwayReceiversPlayer.clear();
          gameDetails.nflAwayRunningBackPlayer.clear();
          if (response.players != null) {
            for (int i = 0; i <= (response.players!.length); i++) {
              if (response.players?[i].position == 'RB' &&
                  response.players?[i].draft?.team?.id == awayTeamId) {
                gameDetails.nflAwayRunningBackPlayer.add(response.players![i]);
              }
              if (response.players?[i].position == 'WR' &&
                  response.players?[i].draft?.team?.id == awayTeamId ||
                  response.players?[i].position == 'TE' &&
                      response.players?[i].draft?.team?.id == awayTeamId) {
                gameDetails.nflAwayReceiversPlayer.add(response.players![i]);
              }
            }
          } else {
            isLoading.value = false;
          }
        } else {
          isLoading.value = false;
        }
      }
      } catch (e) {
      isLoading.value = false;
      log('ERROR NFL AWAY STATICS------$e');
      showAppSnackBar(
        errorText,
      );
    }
    update();
  }*/

  ///HOTLINES DATA
  // List<HotlinesModel> _hotlinesFData = [];
  //
  // List<HotlinesModel> get hotlinesFData => _hotlinesFData;
  //
  // set hotlinesFData(List<HotlinesModel> value) {
  //   _hotlinesFData = value;
  //   update();
  // }

  int _hotlinesIndex = 0;

  int get hotlinesIndex => _hotlinesIndex;

  set hotlinesIndex(int value) {
    _hotlinesIndex = value;
    update();
  }

  String hotlinesOdd = '';
  String hotlinesDecimal = '';
  String hotlinesDec = '';
  String hotlinesType = '';

  Future hotlinesDataResponse(
      {String awayTeamId = '',
      String sportId = '',
      required SportEvents gameDetails,
      String matchId = '',
      bool isLoad = false,
      String homeTeamId = ''}) async {
    // isHotlines = true;
    isLoading.value = !isLoad ? false : true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo().hotlinesDataRepo(matchId: matchId);
    try {
      if (result.status) {
        hotlines.HotlinesDataModel response =
            hotlines.HotlinesDataModel.fromJson(result.data);
        final sportScheduleSportEventsPlayersProps =
            response.sportEventPlayersProps;
        if (sportScheduleSportEventsPlayersProps != null) {
          sportScheduleSportEventsPlayersProps.playersProps
              ?.forEach((playersProp) {
            playersProp.markets?.forEach((market) {
              market.books?.forEach((book) {
                if (book.id == 'sr:book:18186' ||
                    book.id == 'sr:book:18149' ||
                    book.id == 'sr:book:17324') {
                  book.outcomes?.forEach((outcome) {
                    if (outcome.oddsAmerican != null) {
                      if (!int.parse(outcome.oddsAmerican ?? '').isNegative) {
                        gameDetails.hotlinesMainData.add(HotlinesModel(
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
                                playersProp.player?.name?.split(',').last ?? '',
                            bookId: book.id ?? '',
                            value: '${outcome.oddsAmerican}'));
                        gameDetails.hotlinesFData.clear();
                        gameDetails.hotlinesDData.clear();
                        gameDetails.hotlinesMData.clear();
                        gameDetails.hotlinesMainData.sort((a, b) =>
                            int.parse(b.value).compareTo(int.parse(a.value)));
                        for (var element in gameDetails.hotlinesMainData) {
                          if (element.bookId == 'sr:book:18149') {
                            if (!(gameDetails.hotlinesDData.indexWhere(
                                    (fData) =>
                                        fData.playerName ==
                                        element.playerName) >=
                                0)) {
                              if (!(gameDetails.hotlinesDData.indexWhere(
                                      (fData) =>
                                          fData.tittle == element.tittle) >=
                                  0)) {
                                gameDetails.hotlinesDData.add(element);
                              }
                            }
                          }
                          if (element.bookId == 'sr:book:17324') {
                            if (!(gameDetails.hotlinesMData.indexWhere(
                                    (fData) =>
                                        fData.playerName ==
                                        element.playerName) >=
                                0)) {
                              if (!(gameDetails.hotlinesMData.indexWhere(
                                      (fData) =>
                                          fData.tittle == element.tittle) >=
                                  0)) {
                                gameDetails.hotlinesMData.add(element);
                              }
                            }
                          }
                          if (element.bookId == 'sr:book:18186') {
                            if (!(gameDetails.hotlinesFData.indexWhere(
                                    (fData) =>
                                        fData.playerName ==
                                        element.playerName) >=
                                0)) {
                              if (!(gameDetails.hotlinesFData.indexWhere(
                                      (fData) =>
                                          fData.tittle == element.tittle) >=
                                  0)) {
                                gameDetails.hotlinesFData.add(element);
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

          List<HotlinesModel> hotlinesFinalData = [];
          hotlinesFinalData = gameDetails.hotlinesDData +
              gameDetails.hotlinesFData +
              gameDetails.hotlinesMData;
          gameDetails.hotlinesData = [];
          hotlinesFinalData
              .sort((a, b) => int.parse(b.value).compareTo(int.parse(a.value)));
          if (hotlinesFinalData.isNotEmpty) {
            gameDetails.hotlinesData.add(hotlinesFinalData[0]);
            for (int i = 1; i < hotlinesFinalData.length; i++) {
              if (!(gameDetails.hotlinesData.indexWhere((element) =>
                      element.teamName == hotlinesFinalData[i].teamName) >=
                  0)) {
                if (gameDetails.hotlinesData
                        .where((element) =>
                            element.bookId == hotlinesFinalData[i].bookId)
                        .toList()
                        .length <
                    2) {
                  if (gameDetails.hotlinesData
                          .where((element) =>
                              element.teamId == hotlinesFinalData[i].teamId)
                          .toList()
                          .length <
                      3) {
                    gameDetails.hotlinesData.add(hotlinesFinalData[i]);
                  }
                }
              }
            }
          }
          gameDetails.hotlinesData
              .sort((a, b) => int.parse(b.value).compareTo(int.parse(a.value)));
          update();
        }
      } else {
        // isHotlines = false;
        isLoading.value = false;
        // showAppSnackBar(
        //   result.message,
        // );
      }
    } catch (e) {
      // isHotlines = false;
      isLoading.value = false;
      log('ERROR HOTLINES DATA------$e');
      // showAppSnackBar(
      //   errorText,
      // );
    }
    update();
    isLoading.value = false;
    return gameDetails.hotlinesData;
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
        if (key == 'NFL' || key == "NBA") {
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
        } else if (key == "NCAA") {
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
        } else if (key == "NCAAB") {
          NCAABStandingsModel response =
              NCAABStandingsModel.fromJson(result.data);
          final game = response.conferences;
          if (game != null) {
            for (var element in game) {
              element.teams?.forEach((team) {
                if (team.id == homeId) {
                  sportEvent.homeWin = (team.wins ?? "0").toString();
                  sportEvent.homeLoss = '${team.losses ?? "0"}'.toString();
                }
                if (team.id == awayId) {
                  sportEvent.awayWin = (team.wins ?? "0").toString();
                  sportEvent.awayLoss = '${team.losses ?? "0"}'.toString();
                }
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

  ///NBA STATICS API

  Future staticsAwayNBA({
    String awayId = '',
    bool isLoad = false,
    required SportEvents gameDetails,
    String key = '',
  }) async {
    gameDetails.awayRushingPlayer.clear();
    isLoading.value = !isLoad ? false : true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result =
        await GameListingRepo().nbaStaticsRepo(sportKey: key, teamId: awayId);
    try {
      if (result.status) {
        NBAStaticsModel response = NBAStaticsModel.fromJson(result.data);

        if (response.players != null) {
          response.players?.forEach((player) {
            gameDetails.awayRushingPlayer.add(player);
          });
        }
        (gameDetails.awayRushingPlayer).sort((a, b) =>
            (b.average?.points ?? 0).compareTo((a.average?.points ?? 0)));
        update();
      } else {
        isLoading.value = false;
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

  Future staticsHomeNBA({
    String homeId = '',
    bool isLoad = false,
    required SportEvents gameDetails,
    String sportKey = '',
  }) async {
    gameDetails.homeRushingPlayer.clear();
    isLoading.value = !isLoad ? false : true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo()
        .nbaStaticsRepo(sportKey: sportKey, teamId: homeId);
    try {
      if (result.status) {
        NBAStaticsModel response = NBAStaticsModel.fromJson(result.data);

        if (response.players != null) {
          response.players?.forEach((player) {
            gameDetails.homeRushingPlayer.add(player);
          });
        }
        (gameDetails.homeRushingPlayer).sort((a, b) =>
            (b.average?.points ?? 0).compareTo((a.average?.points ?? 0)));
      } else {
        isLoading.value = false;
      }
      update();
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
        if (sportKey == "NFL") {
          NFLInjuryModel response = NFLInjuryModel.fromJson(result.data);
          if (response.teams != null) {
            response.teams?.forEach((team) {
              if (team.id == awayTeamId) {
                team.players?.forEach((player) {
                  if (player.position != 'A') {
                    sportEvent?.awayTeamInjuredPlayer.add(
                        '${player.name?[0]}. ${player.name?.split(' ').last} - ${player.position} - ${((player.injuries ?? []).isNotEmpty) ? (player.injuries?[0].practice?.status) : ""}');
                  }
                });
              }
              if (team.id == homeTeamId) {
                team.players?.forEach((player) {
                  if (player.position != 'A') {
                    sportEvent?.homeTeamInjuredPlayer.add(
                        '${player.name?[0]}. ${player.name?.split(' ').last} - ${player.position} - ${((player.injuries ?? []).isNotEmpty) ? (player.injuries?[0].practice?.status) : ""}');
                  }
                });
              }
            });
          }
        } else {
          MLBInjuriesModel response = MLBInjuriesModel.fromJson(result.data);
          if (response.teams != null) {
            response.teams?.forEach((team) {
              if (team.id == awayTeamId) {
                team.players?.forEach((player) {
                  if (player.status != 'A') {
                    if (sportKey == "NBA") {
                      sportEvent?.awayTeamInjuredPlayer.add(
                          '${player.firstName?[0]}. ${player.lastName} - ${player.position} - ${player.injuries?.first.status}');
                    } else {
                      sportEvent?.awayTeamInjuredPlayer.add(
                          '${player.firstName?[0]}. ${player.lastName} - ${player.position} - ${player.status}');
                    }
                  }
                });
              }
              if (team.id == homeTeamId) {
                team.players?.forEach((player) {
                  if (player.status != 'A') {
                    if (sportKey == "NBA") {
                      sportEvent?.homeTeamInjuredPlayer.add(
                          '${player.firstName?[0]}. ${player.lastName} - ${player.position} - ${player.injuries?.first.status}');
                    } else {
                      sportEvent?.homeTeamInjuredPlayer.add(
                          '${player.firstName?[0]}. ${player.lastName} - ${player.position} - ${player.status}');
                    }
                  }
                });
              }
            });
          }
        }
        isLoading.value = false;
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
    gameDetails.hotlinesDData.clear();
    gameDetails.hotlinesFData.clear();
    gameDetails.hotlinesMData.clear();
    gameDetails.hotlinesData.clear();

    if (sportKey == 'MLB') {
      awayIp = "0";
      homeIp = "0";
      whipAway = "0";
      whipHome = "0";
      awayKk = "0";
      homeKk = "0";
      awayBb = "0";
      homeBb = "0";
      awayH = "0";
      homeH = "0";
      mlbStaticsAwayTeamResponse(
          isLoad: false,
          awayTeamId: replaceId(awayTeam?.uuids ?? ''),
          gameDetails: gameDetails);
      mlbStaticsHomeTeamResponse(
          isLoad: false,
          homeTeamId: replaceId(homeTeam?.uuids ?? ''),
          gameDetails: gameDetails);
      mlbInjuriesResponse(
          sportKey: 'MLB',
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
      await hotlinesDataResponse(
          awayTeamId: awayTeam?.id ?? "",
          sportId: sportId,
          gameDetails: gameDetails,
          matchId: gameDetails.id ?? "",
          isLoad: isLoad,
          homeTeamId: homeTeam?.id ?? "");
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
          sportKey: "NFL",
          sportEvent: gameDetails,
          awayTeamId: awayTeam?.abbreviation == 'LV'
              ? '7d4fcc64-9cb5-4d1b-8e75-8a906d1e1576'
              : replaceId(awayTeam?.uuids ?? ''),
          homeTeamId: homeTeam?.abbreviation == 'LV'
              ? '7d4fcc64-9cb5-4d1b-8e75-8a906d1e1576'
              : replaceId(homeTeam?.uuids ?? ''));

      /*await hotlinesDataResponse(
          awayTeamId: awayTeam?.id ?? "",
          sportId: sportId,
          gameDetails: gameDetails,
          matchId: gameDetails.id ?? "",
          isLoad: isLoad,
          homeTeamId: homeTeam?.id ?? "");*/
    }
    if (sportKey == 'NCAA') {
      isLoading.value = true;
      recordsOfNCAAAndNFL(
          isLoad: false,
          sportEvent: gameDetails,
          key: sportKey,
          awayId: replaceId(awayTeam?.uuids ?? ''),
          homeId: replaceId(homeTeam?.uuids ?? ''));
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
      hotlinesDataResponse(
          awayTeamId: awayTeam?.id ?? "",
          sportId: sportId,
          gameDetails: gameDetails,
          matchId: gameDetails.id ?? "",
          isLoad: isLoad,
          homeTeamId: homeTeam?.id ?? "");
    }
    if (sportKey == 'NBA' || sportKey == "NCAAB") {
      staticsAwayNBA(
        gameDetails: gameDetails,
        isLoad: isLoad,
        key: sportKey,
        awayId: replaceId(awayTeam?.uuids ?? ''),
      );

      staticsHomeNBA(
        gameDetails: gameDetails,
        isLoad: isLoad,
        sportKey: sportKey,
        homeId: replaceId(homeTeam?.uuids ?? ''),
      );
      recordsOfNCAAAndNFL(
          isLoad: false,
          sportEvent: gameDetails,
          key: sportKey,
          awayId: replaceId(awayTeam?.uuids ?? ''),
          homeId: replaceId(homeTeam?.uuids ?? ''));
      if (sportKey == "NBA") {
        mlbInjuriesResponse(
            isLoad: false,
            sportKey: "NBA",
            sportEvent: gameDetails,
            awayTeamId: replaceId(awayTeam?.uuids ?? ''),
            homeTeamId: replaceId(homeTeam?.uuids ?? ''));
      }
      hotlinesDataResponse(
          awayTeamId: awayTeam?.id ?? "",
          sportId: sportId,
          gameDetails: gameDetails,
          matchId: gameDetails.id ?? "",
          isLoad: isLoad,
          homeTeamId: homeTeam?.id ?? "");
      /*   await nbaRosterStaticsHomeResponse(
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
      }*/
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
