import 'dart:developer';

import 'package:get/get.dart';
import 'package:hotlines/model/injuries_data_model.dart';
import 'package:hotlines/model/mlb_injury_report_model.dart';
import 'package:hotlines/model/nfl_ranking_model.dart';
import 'package:hotlines/model/nfl_stat_model.dart';
import 'package:hotlines/model/nfl_win_losses_record_model.dart';

import '../constant/app_strings.dart';
import '../model/response_item.dart';
import '../network/game_repo.dart';
import '../theme/helper.dart';

class GameDetailsController extends GetxController {
  List offensive = [
    'Offensive DVOA',
    'Points Per Game',
    'Scoring Efficiency',
    'Redzone Efficiency',
    'Rushing Yards/game',
    'Passing Yards/game',
    'Rushing TDs/game',
    'Passing TDs/game',
    'TO/game',
    '3rd Down Efficiency',
    '4th Down Efficiency',
    'Field goal Percentage',
  ];
  List offensiveMLB = [
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
    'Rushing Yards Allowed/game',
    'Passing Yards Allowed/game',
    'Rushing TDs Allowed/game',
    'Passing TDs Allowed/game',
    'TO Generated/game',
    'Opponent 3rd Down Efficiency',
    'Opponent 4th Down Efficiency',
  ];

  List defensiveMLB = [
    'Wins',
    'Losses',
    'Earned Run Average (ERA)',
    'Shut Outs',
    'Save Percentage',
    'Quality Starts',
    'Runs Allowed',
    'Home runs Allowed',
    'Walks Allowed',
    'Strike Outs',
    'Walks & Hits Per Innings Pitched (WHIP)',
    'Opponents Batting Average',
    'Opponents Ground into Double Play',
    'Strike Out Per 9 innings Pitched',
    'Walks Per 9 Innings Pitched',
    'Strike out to walk ratio',
  ];

  List teamStatus = [
    'W/L record (last 5 games)',
    'Home/Away record',
    'Against the spread',
    'Point Differential',
  ];
  List teamStatusMLB = [
    'W/L Record (overall)',
    'W/L record (last 5 games)',
    'Home/Away record',
    'Against the spread',
    'Point Differential',
  ];

  RxBool isLoading = false.obs;
  List<InjuriesDataModel> _injuredAwayPlayerList = [];

  List<InjuriesDataModel> get injuredAwayPlayerList => _injuredAwayPlayerList;

  set injuredAwayPlayerList(List<InjuriesDataModel> value) {
    _injuredAwayPlayerList = value;
    update();
  }

  ///NFL INJURIES
  List<InjuriesDataModel> _injuredHomePlayerList = [];

  List<InjuriesDataModel> get injuredHomePlayerList => _injuredHomePlayerList;

  set injuredHomePlayerList(List<InjuriesDataModel> value) {
    _injuredHomePlayerList = value;
    update();
  }

  void nflInjuriesReportResponse(
      {String teamHomeName = '',
      String teamAwayName = '',
      String league = ''}) async {
    isLoading.value = true;
    injuredAwayPlayerList.clear();
    injuredHomePlayerList.clear();
    mlbInjuredAwayPlayerList.clear();
    mlbInjuredHomePlayerList.clear();
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameRepo().injuriesReport(league: league);
    try {
      if (result.status) {
        log('result.data---${result.data[0]}');
        List<InjuriesDataModel> response = (result.data as List)
            .map((i) => InjuriesDataModel.fromJson(i))
            .toList();
        if (response.isNotEmpty) {
          for (var element in response) {
            if (element.currentTeam.isNotEmpty) {
              if (element.currentTeam == teamAwayName) {
                injuredAwayPlayerList.add(element);
              }
              if (element.currentTeam == teamHomeName) {
                injuredHomePlayerList.add(element);
              }
            }
          }
        }
        isLoading.value = false;
      } else {
        isLoading.value = false;

        // showAppSnackBar('Resource not found', );
      }
    } catch (e) {
      isLoading.value = false;

      showAppSnackBar(
        errorText,
      );
    }

    update();
  }

  ///MLB INJURIES
  List<MLBInjuryReportModel> _mlbInjuredAwayPlayerList = [];

  List<MLBInjuryReportModel> get mlbInjuredAwayPlayerList =>
      _mlbInjuredAwayPlayerList;

  set mlbInjuredAwayPlayerList(List<MLBInjuryReportModel> value) {
    _mlbInjuredAwayPlayerList = value;
    update();
  }

  List<MLBInjuryReportModel> _mlbInjuredHomePlayerList = [];

  List<MLBInjuryReportModel> get mlbInjuredHomePlayerList =>
      _mlbInjuredHomePlayerList;

  set mlbInjuredHomePlayerList(List<MLBInjuryReportModel> value) {
    _mlbInjuredHomePlayerList = value;
    update();
  }

  void mlbInjuriesReportResponse(
      {String teamHomeName = '',
      String teamAwayName = '',
      String league = ''}) async {
    isLoading.value = true;
    injuredAwayPlayerList.clear();
    injuredHomePlayerList.clear();
    mlbInjuredAwayPlayerList.clear();
    mlbInjuredHomePlayerList.clear();
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameRepo().injuriesReport(league: league);
    try {
      if (result.status) {
        List<MLBInjuryReportModel> response = (result.data as List)
            .map((i) => MLBInjuryReportModel.fromJson(i))
            .toList();
        if (response.isNotEmpty) {
          for (var element in response) {
            if ((element.team ?? '').isNotEmpty) {
              if (element.team == teamAwayName) {
                mlbInjuredAwayPlayerList.add(element);
              }
              if (element.team == teamHomeName) {
                mlbInjuredHomePlayerList.add(element);
              }
            }
          }
        }
        isLoading.value = false;
      } else {
        isLoading.value = false;
        // showAppSnackBar('Resource not found', );
      }
    } catch (e) {
      isLoading.value = false;

      showAppSnackBar(
        errorText,
      );
    }

    update();
  }

  ///RUSHING RANKING

  String homeRushingOffenseTDs = '0';
  String homeRushingOffenseYards = '0';
  String awayRushingOffenseTDs = '0';
  String awayRushingOffenseYards = '0';
  String homeRushingDefenseTDs = '0';
  String homeRushingDefenseYards = '0';
  String awayRushingDefenseTDs = '0';
  String awayRushingDefenseYards = '0';
  String homePassingOffenseTDs = '0';
  String homePassingOffenseYards = '0';
  String awayPassingOffenseTDs = '0';
  String awayPassingOffenseYards = '0';
  String homePassingDefenseTDs = '0';
  String homePassingDefenseYards = '0';
  String awayPassingDefenseTDs = '0';
  String awayPassingDefenseYards = '0';
  String homeThirdDown = '0';
  String homeFourthDown = '0';
  String awayThirdDown = '0';
  String awayFourthDown = '0';
  String homeOpponentThirdDown = '0';
  String homeOpponentFourthDown = '0';
  String awayOpponentThirdDown = '0';
  String awayOpponentFourthDown = '0';
  String awayScore = '0';
  String homeScore = '0';
  String awayOpponentScore = '0';
  String homeOpponentScore = '0';
  // Map<BuffaloBills, dynamic> teamList = {};

  nflAnalysisStatResponse({
    String year = "",
    bool isLoad = false,
    String homeTeam = '',
    String awayTeam = '',
  }) async {
    isLoading.value = !isLoad ? false : true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameRepo().nflAnalysisStat(year);
    try {
      if (result.status) {
        List<NFLRankingModel> response = (result.data as List)
            .map((i) => NFLRankingModel.fromJson(i))
            .toList();
        // NFLStatModel res = NFLStatModel.fromJson(result.data);
        // teamList.addAll({
        //   (res.stats!.buffaloBills!): res.stats!.buffaloBills!.defensePerGame!
        // });
        // teamList.forEach((key, value) {
        //   if (key.toString() == homeTeam) {
        //     log('TEAMS----->>>${key.defensePerGame?.tm ?? ''}');
        //   }
        // });
        if (response.isNotEmpty) {
          for (var element in response) {
            if (element.team == homeTeam) {
              homePassingOffenseTDs =
                  ((element.passingTouchdowns ?? 0) / (element.games ?? 1))
                      .toStringAsFixed(2);
              homeRushingOffenseTDs =
                  ((element.rushingTouchdowns ?? 0) / (element.games ?? 1))
                      .toStringAsFixed(2);
              homeRushingOffenseYards =
                  element.rushingYardsPerAttempt.toString();
              homePassingOffenseYards =
                  element.passingYardsPerAttempt.toString();
              homePassingDefenseTDs =
                  ((element.opponentPassingTouchdowns ?? 0) /
                          (element.games ?? 1))
                      .toStringAsFixed(2);
              homeRushingDefenseTDs =
                  ((element.opponentRushingTouchdowns ?? 0) /
                          (element.games ?? 1))
                      .toStringAsFixed(2);
              homeRushingDefenseYards =
                  element.opponentRushingYardsPerAttempt.toString();
              homePassingDefenseYards =
                  element.opponentPassingYardsPerAttempt.toString();
              homeThirdDown = element.thirdDownPercentage.toString();
              homeFourthDown = element.fourthDownPercentage.toString();
              homeOpponentThirdDown =
                  element.opponentThirdDownPercentage.toString();
              homeOpponentFourthDown =
                  element.opponentFourthDownPercentage.toString();
              homeScore = element.score.toString();
              homeOpponentScore = element.opponentScore.toString();
            }
            if (element.team == awayTeam) {
              awayPassingOffenseTDs =
                  ((element.passingTouchdowns ?? 0) / (element.games ?? 1))
                      .toStringAsFixed(2);
              awayRushingOffenseTDs =
                  ((element.rushingTouchdowns ?? 0) / (element.games ?? 1))
                      .toStringAsFixed(2);
              awayRushingOffenseYards =
                  element.rushingYardsPerAttempt.toString();
              awayPassingOffenseYards =
                  element.passingYardsPerAttempt.toString();
              awayPassingDefenseTDs =
                  ((element.opponentPassingTouchdowns ?? 0) /
                          (element.games ?? 1))
                      .toStringAsFixed(2);
              awayRushingDefenseTDs =
                  ((element.opponentRushingTouchdowns ?? 0) /
                          (element.games ?? 1))
                      .toStringAsFixed(2);
              awayRushingDefenseYards =
                  element.opponentRushingYardsPerAttempt.toString();
              awayPassingDefenseYards =
                  element.opponentPassingYardsPerAttempt.toString();
              awayThirdDown = element.thirdDownPercentage.toString();
              awayFourthDown = element.fourthDownPercentage.toString();
              awayOpponentThirdDown =
                  element.opponentThirdDownPercentage.toString();
              awayOpponentFourthDown =
                  element.opponentFourthDownPercentage.toString();
              awayScore = element.score.toString();
              awayOpponentScore = element.opponentScore.toString();
            }
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

      showAppSnackBar(errorText);
    }
    update();
  }

  ///LAST YEAR GAME RECORDES

  String _lastHomeGameRecord = '0-0';

  String get lastHomeGameRecord => _lastHomeGameRecord;

  set lastHomeGameRecord(String value) {
    _lastHomeGameRecord = value;
    update();
  }

  String _lastAwayGameRecord = '0-0';

  String get lastAwayGameRecord => _lastAwayGameRecord;

  set lastAwayGameRecord(String value) {
    _lastAwayGameRecord = value;
    update();
  }

  nflLastRecordResponse({
    String year = "",
    bool isLoad = false,
    String homeTeam = '',
    String awayTeam = '',
  }) async {
    isLoading.value = !isLoad ? false : true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameRepo().nflLastGameRecord(year);
    try {
      if (result.status) {
        NFLWinLossesModel response = NFLWinLossesModel.fromJson(result.data);
        if ((response.eEmbedded?.teamWinStatsList ?? []).isNotEmpty) {
          response.eEmbedded?.teamWinStatsList?.forEach((element) {
            if (element.name?.split(' ').first == homeTeam.split(' ').first) {
              lastHomeGameRecord = '${element.wins}-${element.losses}';
            }
            if (element.name?.split(' ').first == awayTeam.split(' ').first) {
              lastAwayGameRecord = '${element.wins}-${element.losses}';
            }
          });
        } else {
          showAppSnackBar(
            'No data',
          );
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
