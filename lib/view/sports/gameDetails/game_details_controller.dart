import 'dart:developer';

import 'package:get/get.dart';
import 'package:hotlines/model/mlb_injuries_model.dart';

import '../../../constant/constant.dart';
import '../../../model/DET_KC_model.dart';
import '../../../model/game_listing.dart';
import '../../../model/hotlines_data_model.dart';
import '../../../model/mlb_statics_model.dart' as stat;
import '../../../model/nfl_statics_model.dart';
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

  List pittchingMLB = [
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
              mlbHomePlayerBattingList.add(MLBStaticsDataModel(
                  hrsValue:
                      (player.statistics?.hitting?.overall?.onbase?.hr ?? "0")
                          .toString(),
                  avgValue: (player.statistics?.hitting?.overall?.avg ?? "0")
                      .toString(),
                  rbiValue: (player.statistics?.hitting?.overall?.rbi ?? "0")
                      .toString(),
                  playerName: (player.firstName ?? "")));
            }
            if (player.statistics?.pitching != null) {
              mlbHomePlayerPitchingList.add(MLBPitchingStaticsModel(
                playerName: (player.firstName ?? ""),
                wl: ('${player.statistics?.pitching?.overall?.games?.win}-${player.statistics?.pitching?.overall?.games?.loss}')
                    .toString(),
                era: (player.statistics?.pitching?.overall?.era ?? '0')
                    .toString(),
                whip: (player.statistics?.pitching?.overall?.whip ?? '0')
                    .toString(),
                ip: (player.statistics?.pitching?.overall?.ip1 ?? '0')
                    .toString(),
                h: (player.statistics?.pitching?.overall?.onbase?.h ?? '0')
                    .toString(),
                k: (player.statistics?.pitching?.overall?.k9 ?? '0').toString(),
                bb: (player.statistics?.pitching?.overall?.onbase?.bb ?? '0')
                    .toString(),
                hr: (player.statistics?.pitching?.overall?.onbase?.hr ?? '0')
                    .toString(),
              ));
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
            '${homeHitting?.slg ?? '0'}',
            '${homeHitting?.ops ?? '0'}',
            '${homeHitting?.outs?.gidp ?? '0'}',
            homeHitting?.abhr?.toStringAsFixed(2) ?? "0",
          ];
          mlbHomePitchingList = [
            '${homePitching?.games?.win ?? '0'}',
            '${homePitching?.games?.loss ?? '0'}',
            '${homePitching?.era ?? '0'}',
            '${homePitching?.games?.shutout ?? '0'}',
            '0',
            '${homePitching?.games?.qstart ?? '0'}',
            '0',
            '${homePitching?.onbase?.hr ?? '0'}',
            '${homePitching?.onbase?.bb ?? '0'}',
            '${homePitching?.outs?.ktotal ?? '0'}',
            '${homePitching?.whip ?? "0"}',
            '${homePitching?.oba ?? "0"}',
            '${homePitching?.outs?.gidp ?? "0"}',
            '0',
            '0',
            '0',
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

  Future mlbStaticsAwayTeamResponse(
      {String awayTeamId = '', bool isLoad = false}) async {
    isLoading.value = !isLoad ? false : true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo()
        .mlbStaticsRepo(teamId: awayTeamId, seasons: '2023');
    try {
      mlbAwayPlayerBattingList.clear();
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
          if (player.statistics?.pitching != null) {
            mlbAwayPlayerPitchingList.add(MLBPitchingStaticsModel(
              playerName: (player.firstName ?? ""),
              wl: ('${player.statistics?.pitching?.overall?.games?.win}-${player.statistics?.pitching?.overall?.games?.loss}')
                  .toString(),
              era:
                  (player.statistics?.pitching?.overall?.era ?? '0').toString(),
              whip: (player.statistics?.pitching?.overall?.whip ?? '0')
                  .toString(),
              ip: (player.statistics?.pitching?.overall?.ip1 ?? '0').toString(),
              h: (player.statistics?.pitching?.overall?.onbase?.h ?? '0')
                  .toString(),
              k: (player.statistics?.pitching?.overall?.k9 ?? '0').toString(),
              bb: (player.statistics?.pitching?.overall?.onbase?.bb ?? '0')
                  .toString(),
              hr: (player.statistics?.pitching?.overall?.onbase?.hr ?? '0')
                  .toString(),
            ));
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
          '${awayHitting?.slg ?? '0'}',
          '${awayHitting?.ops ?? '0'}',
          '${awayHitting?.outs?.gidp ?? '0'}',
          awayHitting?.abhr?.toStringAsFixed(2) ?? "0",
        ];
        mlbAwayPitchingList = [
          '${awayPitching?.games?.win ?? '0'}',
          '${awayPitching?.games?.loss ?? '0'}',
          '${awayPitching?.era ?? '0'}',
          '${awayPitching?.games?.shutout ?? '0'}',
          '0',
          '${awayPitching?.games?.qstart ?? '0'}',
          '0',
          '${awayPitching?.onbase?.hr ?? '0'}',
          '${awayPitching?.onbase?.bb ?? '0'}',
          '${awayPitching?.outs?.ktotal ?? '0'}',
          '${awayPitching?.whip ?? "0"}',
          '${awayPitching?.oba ?? "0"}',
          '${awayPitching?.outs?.gidp ?? "0"}',
          '0',
          '0',
          '0',
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
      log('ERORE STATIC ----$e');
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

  List<HotlinesModel> hotlinesNewData = [];
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
      int start = 0,
      bool isLoad = false,
      String homeTeamId = ''}) async {
    isLoading.value = !isLoad ? false : true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo()
        .hotlinesDataRepo(sportId: sportId, date: date, start: start);
    // try {
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
                      if (outcome.oddsAmerican != null) {
                        if (!int.parse(outcome.oddsAmerican ?? '').isNegative) {
                          if (!(hotlinesData.indexWhere((element) =>
                                  (element.tittle ==
                                      market.name
                                          ?.split('(')
                                          .first
                                          .toString()
                                          .capitalize)) >=
                              0)) {
                            if (!(hotlinesData.indexWhere((element) =>
                                    (element.playerName ==
                                        playersProp.player?.name
                                            ?.split(',')
                                            .last)) >=
                                0)) {
                              hotlinesData.add(HotlinesModel(
                                  teamName:
                                      '${playersProp.player?.name?.split(',').last ?? ''} ${playersProp.player?.name?.split(',').first ?? ''} ${outcome.type.toString().capitalizeFirst} ${outcome.total} ${market.name?.split('(').first.toString().capitalize}',
                                  tittle: market.name
                                          ?.split('(')
                                          .first
                                          .toString()
                                          .capitalize ??
                                      '',
                                  playerName: playersProp.player?.name
                                          ?.split(',')
                                          .last ??
                                      '',
                                  bookId: book.id ?? '',
                                  value: '${outcome.oddsAmerican}'));

                              hotlinesData
                                  .sort((a, b) => b.value.compareTo(a.value));
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
      }

      // isLoading.value = false;
    } else {
      isLoading.value = false;
      showAppSnackBar(
        result.message,
      );
    }
    // } catch (e) {
    //   isLoading.value = false;
    //   log('ERORE>>>>>>>>----$e');
    //   // showAppSnackBar(
    //   //   errorText,
    //   // );
    // }
    update();
    return hotlinesData;
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
        log('ERORE1---EWKFKQWLEHFIKEHQRFGIHRQFG ,KLERJGOERIJG');
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
