import 'dart:developer';

import 'package:get/get.dart';
import 'package:hotlines/model/mlb_injuries_model.dart';

import '../../../constant/constant.dart';
import '../../../model/DET_KC_model.dart';
import '../../../model/game_listing.dart';
import '../../../model/hotlines_data_model.dart';
import '../../../model/mlb_statics_model.dart';
import '../../../model/response_item.dart';
import '../../../network/game_listing_repo.dart';
import '../../../theme/helper.dart';

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
    'Ground into Double Play',
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
  Statistics? mlbStaticsHomeList;
  Statistics? mlbStaticsAwayList;
  List<MLBStaticsDataModel> mlbStaticsData = [];
  Future mlbStaticsHomeTeamResponse(
      {String homeTeamId = '', bool isLoad = false}) async {
    isLoading.value = !isLoad ? false : true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo()
        .mlbStaticsRepo(teamId: homeTeamId, seasons: '2023');
    try {
      if (result.status) {
        MLBStaticsModel response = MLBStaticsModel.fromJson(result.data);
        if (response.statistics != null) {
          mlbStaticsHomeList = response.statistics;
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

  Future mlbStaticsAwayTeamResponse(
      {String awayTeamId = '', bool isLoad = false}) async {
    isLoading.value = !isLoad ? false : true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo()
        .mlbStaticsRepo(teamId: awayTeamId, seasons: '2023');
    try {
      if (result.status) {
        MLBStaticsModel response = MLBStaticsModel.fromJson(result.data);
        if (response.statistics != null) {
          mlbStaticsAwayList = response.statistics;
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
      log('ERORE1----$e');
      showAppSnackBar(
        errorText,
      );
    }
    update();
  }

  List<HotlinesModel> _hotlinesData = [];

  List<HotlinesModel> get hotlinesData => _hotlinesData;

  set hotlinesData(List<HotlinesModel> value) {
    _hotlinesData = value;
    update();
  }

  String hotlinesOdd = '';
  String hotlinesDecimal = '';
  String hotlinesDec = '';
  String hotlinesType = '';
  Future hotlinesDataResponse(
      {String awayTeamId = '',
      String sportId = '',
      String date = '',
      bool isLoad = false,
      String homeTeamId = ''}) async {
    isLoading.value = !isLoad ? false : true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result =
        await GameListingRepo().hotlinesDataRepo(sportId: sportId, date: date);
    try {
      hotlinesData.clear();
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
                        book.id == 'sr:book:18149') {
                      book.outcomes?.forEach((outcome) {
                        if (!int.parse(outcome.oddsAmerican ?? '').isNegative) {
                          hotlinesData.add(HotlinesModel(
                              teamName:
                                  '${playersProp.player?.name?.split(',').last ?? ''}, ${playersProp.player?.name?.split(',').first ?? ''} ${outcome.type.toString().capitalizeFirst} ${outcome.oddsDecimal} ${market.name?.split('(').first.toString().capitalize}',
                              value: '${outcome.oddsAmerican}'));
                          hotlinesData
                              .sort((a, b) => b.value.compareTo(a.value));
                        }
                      });
                    }
                  });
                });
              });
            }
          }
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
      log('ERORE>>>>>>>>----$e');
      showAppSnackBar(
        errorText,
      );
    }
    update();
  }

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
                  sportEvent?.awayTeamInjuredPlayer
                      .add('${player.firstName}(${player.status})');
                }
              });
            }
            if (team.id == homeTeamId) {
              team.players?.forEach((player) {
                if (player.status != 'A') {
                  sportEvent?.homeTeamInjuredPlayer
                      .add('${player.firstName}(${player.status})');
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
      log('ERORE1----$e');
      showAppSnackBar(
        errorText,
      );
    }
    update();
  }
}

class MLBStaticsDataModel {
  String awayValue;
  String homeValue;
  String staticsName;

  MLBStaticsDataModel(
      {required this.awayValue,
      required this.homeValue,
      required this.staticsName});
}
