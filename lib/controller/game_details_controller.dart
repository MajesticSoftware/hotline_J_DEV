import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotlines/model/injuries_data_model.dart';
import 'package:hotlines/model/mlb_injury_report_model.dart';
import 'package:hotlines/model/nfl_win_losses_record_model.dart';

import '../constant/app_strings.dart';
import '../model/nfl_passing_ranking_model.dart';
import '../model/nfl_rushing_ranking_model.dart';
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

  List teamStatus = [
    'W/L record (last 5 games)',
    'Home/Away record',
    'Division vs. Non-division record',
    'Head to head record (last 5 games)',
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

  void nflInjuriesReportResponse(BuildContext context,
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
        // ignore: use_build_context_synchronously
        // showAppSnackBar('Resource not found', context);
      }
    } catch (e) {
      isLoading.value = false;
      // ignore: use_build_context_synchronously
      showAppSnackBar(errorText, context);
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

  void mlbInjuriesReportResponse(BuildContext context,
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
        // ignore: use_build_context_synchronously
        // showAppSnackBar('Resource not found', context);
      }
    } catch (e) {
      isLoading.value = false;
      // ignore: use_build_context_synchronously
      showAppSnackBar(errorText, context);
    }

    update();
  }

  ///RUSHING RANKING
  String _homeRushingOffenseTDs = '0';

  String get homeRushingOffenseTDs => _homeRushingOffenseTDs;

  set homeRushingOffenseTDs(String value) {
    _homeRushingOffenseTDs = value;
    update();
  }

  String _homeRushingOffenseYards = '0';

  String get homeRushingOffenseYards => _homeRushingOffenseYards;

  set homeRushingOffenseYards(String value) {
    _homeRushingOffenseYards = value;
    update();
  }

  String _awayRushingOffenseTDs = '0';

  String get awayRushingOffenseTDs => _awayRushingOffenseTDs;

  set awayRushingOffenseTDs(String value) {
    _awayRushingOffenseTDs = value;
    update();
  }

  String _awayRushingOffenseYards = '0';

  String get awayRushingOffenseYards => _awayRushingOffenseYards;

  set awayRushingOffenseYards(String value) {
    _awayRushingOffenseYards = value;
    update();
  }

  Future nflRushingOffenseRankingResponse(
    BuildContext context, {
    String year = "",
    bool isLoad = false,
    String homeTeam = '',
    String awayTeam = '',
  }) async {
    isLoading.value = !isLoad ? false : true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameRepo().nflRushingRanking(year, isOffense: true);
    try {
      if (result.status) {
        NFLRushingStatModel response =
            NFLRushingStatModel.fromJson(result.data);

        if ((response.eEmbedded?.teamRushingStatsList ?? []).isNotEmpty) {
          response.eEmbedded?.teamRushingStatsList?.forEach((element) {
            if (element.name == homeTeam) {
              homeRushingOffenseTDs = element.touchdowns.toString();
              homeRushingOffenseYards = element.yards.toString();
            }
            if (element.name == awayTeam) {
              awayRushingOffenseTDs = element.touchdowns.toString();
              awayRushingOffenseYards = element.yards.toString();
            }
          });
        } else {
          // ignore: use_build_context_synchronously
          showAppSnackBar('No data', context);
        }
        isLoading.value = false;
      } else {
        isLoading.value = false;
        // ignore: use_build_context_synchronously
        showAppSnackBar(result.message, context);
      }
    } catch (e) {
      isLoading.value = false;
      // ignore: use_build_context_synchronously
      showAppSnackBar(errorText, context);
    }
    update();
  }

  String _homeRushingDefenseTDs = '0';

  String get homeRushingDefenseTDs => _homeRushingDefenseTDs;

  set homeRushingDefenseTDs(String value) {
    _homeRushingDefenseTDs = value;
    update();
  }

  String _homeRushingDefenseYards = '0';

  String get homeRushingDefenseYards => _homeRushingDefenseYards;

  set homeRushingDefenseYards(String value) {
    _homeRushingDefenseYards = value;
    update();
  }

  String _awayRushingDefenseTDs = '0';

  String get awayRushingDefenseTDs => _awayRushingDefenseTDs;

  set awayRushingDefenseTDs(String value) {
    _awayRushingDefenseTDs = value;
    update();
  }

  String _awayRushingDefenseYards = '0';

  String get awayRushingDefenseYards => _awayRushingDefenseYards;

  set awayRushingDefenseYards(String value) {
    _awayRushingDefenseYards = value;
    update();
  }

  Future nflRushingDefenseRankingResponse(
    BuildContext context, {
    String year = "",
    bool isLoad = false,
    String homeTeam = '',
    String awayTeam = '',
  }) async {
    isLoading.value = !isLoad ? false : true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameRepo().nflRushingRanking(year, isOffense: false);
    try {
      if (result.status) {
        NFLRushingStatModel response =
            NFLRushingStatModel.fromJson(result.data);
        if ((response.eEmbedded?.teamRushingStatsList ?? []).isNotEmpty) {
          response.eEmbedded?.teamRushingStatsList?.forEach((element) {
            if (element.name == homeTeam) {
              homeRushingDefenseTDs = element.touchdowns.toString();
              homeRushingDefenseYards = element.yards.toString();
            }
            if (element.name == awayTeam) {
              awayRushingDefenseTDs = element.touchdowns.toString();
              awayRushingDefenseYards = element.yards.toString();
            }
          });
        } else {
          // ignore: use_build_context_synchronously
          showAppSnackBar('No data', context);
        }
        isLoading.value = false;
      } else {
        isLoading.value = false;
        // ignore: use_build_context_synchronously
        showAppSnackBar(result.message, context);
      }
    } catch (e) {
      isLoading.value = false;
      // ignore: use_build_context_synchronously
      showAppSnackBar(errorText, context);
    }
    update();
  }

  ///PASSING RANKING

  String _homePassingOffenseTDs = '0';

  String get homePassingOffenseTDs => _homePassingOffenseTDs;

  set homePassingOffenseTDs(String value) {
    _homePassingOffenseTDs = value;
    update();
  }

  String _homePassingOffenseYards = '0';

  String get homePassingOffenseYards => _homePassingOffenseYards;

  set homePassingOffenseYards(String value) {
    _homePassingOffenseYards = value;
    update();
  }

  String _awayPassingOffenseTDs = '0';

  String get awayPassingOffenseTDs => _awayPassingOffenseTDs;

  set awayPassingOffenseTDs(String value) {
    _awayPassingOffenseTDs = value;
    update();
  }

  String _awayPassingOffenseYards = '0';

  String get awayPassingOffenseYards => _awayPassingOffenseYards;

  set awayPassingOffenseYards(String value) {
    _awayPassingOffenseYards = value;
    update();
  }

  Future nflPassingOffenseRankingResponse(
    BuildContext context, {
    String year = "",
    bool isLoad = false,
    String homeTeam = '',
    String awayTeam = '',
  }) async {
    isLoading.value = !isLoad ? false : true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameRepo().nflPassingRanking(year, isOffense: true);
    try {
      if (result.status) {
        NFLPassingStatModel response =
            NFLPassingStatModel.fromJson(result.data);

        if ((response.eEmbedded?.teamPassingStatsList ?? []).isNotEmpty) {
          response.eEmbedded?.teamPassingStatsList?.forEach((element) {
            if (element.name == homeTeam) {
              homePassingOffenseTDs = element.touchdowns.toString();
              homePassingOffenseYards = element.passYards.toString();
            }
            if (element.name == awayTeam) {
              awayPassingOffenseTDs = element.touchdowns.toString();
              awayPassingOffenseYards = element.passYards.toString();
            }
          });
        } else {
          // ignore: use_build_context_synchronously
          showAppSnackBar('No data', context);
        }
        isLoading.value = false;
      } else {
        isLoading.value = false;
        // ignore: use_build_context_synchronously
        showAppSnackBar(result.message, context);
      }
    } catch (e) {
      isLoading.value = false;
      // ignore: use_build_context_synchronously
      showAppSnackBar(errorText, context);
    }
    update();
  }

  String _homePassingDefenseTDs = '0';

  String get homePassingDefenseTDs => _homePassingDefenseTDs;

  set homePassingDefenseTDs(String value) {
    _homePassingDefenseTDs = value;
    update();
  }

  String _homePassingDefenseYards = '0';

  String get homePassingDefenseYards => _homePassingDefenseYards;

  set homePassingDefenseYards(String value) {
    _homePassingDefenseYards = value;
    update();
  }

  String _awayPassingDefenseTDs = '0';

  String get awayPassingDefenseTDs => _awayPassingDefenseTDs;

  set awayPassingDefenseTDs(String value) {
    _awayPassingDefenseTDs = value;
    update();
  }

  String _awayPassingDefenseYards = '0';

  String get awayPassingDefenseYards => _awayPassingDefenseYards;

  set awayPassingDefenseYards(String value) {
    _awayPassingDefenseYards = value;
    update();
  }

  Future nflPassingDefenseRankingResponse(
    BuildContext context, {
    String year = "",
    bool isLoad = false,
    String homeTeam = '',
    String awayTeam = '',
  }) async {
    isLoading.value = !isLoad ? false : true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameRepo().nflPassingRanking(year, isOffense: false);
    try {
      if (result.status) {
        NFLPassingStatModel response =
            NFLPassingStatModel.fromJson(result.data);
        if ((response.eEmbedded?.teamPassingStatsList ?? []).isNotEmpty) {
          response.eEmbedded?.teamPassingStatsList?.forEach((element) {
            if (element.name == homeTeam) {
              homePassingDefenseTDs = element.touchdowns.toString();
              homePassingDefenseYards = element.passYards.toString();
            }
            if (element.name == awayTeam) {
              awayPassingDefenseTDs = element.touchdowns.toString();
              awayPassingDefenseYards = element.passYards.toString();
            }
          });
        } else {
          // ignore: use_build_context_synchronously
          showAppSnackBar('No data', context);
        }
        isLoading.value = false;
      } else {
        isLoading.value = false;
        // ignore: use_build_context_synchronously
        showAppSnackBar(result.message, context);
      }
    } catch (e) {
      isLoading.value = false;
      // ignore: use_build_context_synchronously
      showAppSnackBar(errorText, context);
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

  nflLastRecordResponse(
    BuildContext context, {
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
          // ignore: use_build_context_synchronously
          showAppSnackBar('No data', context);
        }
        isLoading.value = false;
      } else {
        isLoading.value = false;
        // ignore: use_build_context_synchronously
        showAppSnackBar(result.message, context);
      }
    } catch (e) {
      isLoading.value = false;
      // ignore: use_build_context_synchronously
      showAppSnackBar(errorText, context);
    }
    update();
  }
}
