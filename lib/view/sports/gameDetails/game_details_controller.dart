// ignore_for_file: unnecessary_string_interpolations, unused_local_variable

import 'dart:developer';
import 'dart:math' as math;

import 'package:get/get.dart';
import 'package:hotlines/model/game_listing.dart';
import 'package:hotlines/model/mlb_injuries_model.dart';
import 'package:hotlines/model/nfl_injury_model.dart';
import 'package:hotlines/utils/app_helper.dart';
import 'package:hotlines/utils/utils.dart';

import '../../../constant/constant.dart';
import '../../../extras/request_constants.dart';
import '../../../model/game_model.dart';
import '../../../model/hotlines_data_model.dart' as hotlines;
import '../../../model/mlb_statics_model.dart' as stat;
import '../../../model/nba_statics_model.dart';
import '../../../model/ncaab_standings_model.dart';
import '../../../model/nfl_profile_model.dart';
import '../../../model/nfl_roster_player_model.dart' as roster;
import '../../../model/nfl_statics_model.dart';
import '../../../model/nfl_team_record_model.dart';
import '../../../model/player_profile_model.dart';
import '../../../model/response_item.dart';
import '../../../model/team_record_model.dart';
import '../../../network/game_listing_repo.dart';
import '../../../theme/helper.dart';

class GameDetailsController extends GetxController {
  
  /// Safely parses a value and divides it by a divisor
  /// Returns 0 if the divisor is 0 or value is null/can't be parsed
  num safeParseAndDivide(dynamic value, int divisor) {
    if (divisor <= 0) return 0;
    try {
      if (value == null) return 0;
      num parsed = (value is num) ? value : num.parse(value.toString());
      return parsed / divisor;
    } catch (e) {
      print('⚠️ Error parsing value: $value - ${e.toString()}');
      return 0;
    }
  }
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

  List<String> statics = ['Pts/Gm', 'Rbs/Gm', 'Asst/Gm'];

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
    'Assists/Game',
    'Turnovers/Game',
    'Rebounds/Game',
    // 'Steals/Game',
    // 'Blocks/Game',
    // 'Total Turnovers/Game',
    // 'Fouls/Game',
    'FG made / att / %',
    '3P made / att / %',
    'FT made / att / %',
    // 'True Shooting',
    // 'Team PER Off',
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
    'Opponent Assists/Game',
    'Opponent Turnovers/Game',
    'Opponent Rebounds/Game',
    // 'Opponent Steals/Game',
    // 'Opponent Blocks/Game',
    // 'Opponent Total Turnovers/Game',
    // 'Opponent Fouls/Game',
    'Opponent FG made / att / %',
    'Opponent 3P made / att / %',
    'Opponent FT made / att / %',
    // 'Opponent True Shooting',
    // 'Team PER Def',
  ];
  List nbaMobileDefensive = [
    'Points Allowed/Game',
    'Opp Assists/Game',
    'Opp Turnovers/Game',
    'Opp Rebounds/Game',
    // 'Opp Steals/Game',
    // 'Opp Blocks/Game',
    // 'Opp Total Turnovers/Game',
    // 'Opp Fouls/Game',
    'Opp FG made / att / %',
    'Opp 3P made / att / %',
    'Opp FT made / att / %',
    // 'Opp True Shooting',
    // 'Team PER Def',
  ];
  // Keeping this for backward compatibility
  List pitchingMLB = [];
  
  // Old array values kept for reference
  /*
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
  */
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
  
  // New MLB stats arrays for offense/defense layout
  List mlbOffensive = [
    'Hits / Game',
    'Walks / Game',
    'HR / Game',
    'RBI / Game',
    'Runs / Game',
    'Batter Strike Out / Game',
    'Stolen Bases / Game',
    'Team Batting Average',
    'On Base Percentage', 
    'Slugging Percentage'
  ];
  
  List mlbDefensive = [
    'Hits Allowed / Game',
    'Walks Allowed / Game',
    'HR Allowed / Game',
    'RBI Allowed / Game',
    'Runs Allowed / Game',
    'Pitcher Strike Out / Game',
    'SB Allowed / Game',
    'Team Earned Run Average',
    'Opponent OBP',
    'Opponent SLG'
  ];
  
  // Store data for these stats
  List mlbHomeOffensiveList = [];
  List mlbAwayOffensiveList = [];
  List mlbHomeDefensiveList = [];
  List mlbAwayDefensiveList = [];
  bool showMLBHomeTeam = true; // Toggle between home and away team view
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
  List<HitterPlayerStatMainModel> _hitterAwayPlayerMainList = [];
  
  // Class variables for MLB statistics to fix scope issues
  stat.OverallHitting? homeHitting;
  stat.Overall? homePitching;
  stat.OverallHitting? awayHitting;
  stat.Overall? awayPitching;

  List<HitterPlayerStatMainModel> get hitterHomePlayerMainList =>
      _hitterHomePlayerMainList;

  set hitterHomePlayerMainList(List<HitterPlayerStatMainModel> value) {
    _hitterHomePlayerMainList = value;
    update();
  }
  
  List<HitterPlayerStatMainModel> get hitterAwayPlayerMainList =>
      _hitterAwayPlayerMainList;

  set hitterAwayPlayerMainList(List<HitterPlayerStatMainModel> value) {
    _hitterAwayPlayerMainList = value;
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
            if (player.type == SEASONS && player.year == DateTime.now().year) {
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
        e.toString(),
      );
    }
    update();
  }

  Future profileHomeTeamResponse(
      {required roster.Players players,
      String sportKey = '',
      bool isLoad = false,
      required SportEvents gameDetails}) async {
    isLoading.value = !isLoad ? false : true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo()
        .playerProfileRepo(playerId: players.id.toString(), sportKey: sportKey);
    try {
      if (result.status) {
        if (result.data != null) {
          NFLProfileModel response = NFLProfileModel.fromJson(result.data);
          final seasons = response.seasons;
          if (seasons != null) {
            for (var season in seasons) {
              if (season.type == SEASONS &&
                  season.year.toString() == currentYear) {
                players.receiving = season.teams?[0].statistics?.receiving;
                players.rushing = season.teams?[0].statistics?.rushing;
                players.gamesPlayed = season.teams?[0].statistics?.gamesPlayed;
                players.receiving?.gamesPlayed =
                    season.teams?[0].statistics?.gamesPlayed;
                players.rushing?.gamesPlayed =
                    season.teams?[0].statistics?.gamesPlayed;
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
      {required roster.Players players,
      String sportKey = '',
      bool isLoad = false,
      required SportEvents gameDetails}) async {
    isLoading.value = !isLoad ? false : true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo()
        .playerProfileRepo(playerId: players.id.toString(), sportKey: sportKey);
    try {
      if (result.status) {
        if (result.data != null) {
          NFLProfileModel response = NFLProfileModel.fromJson(result.data);
          final seasons = response.seasons;
          if (seasons != null) {
            for (var season in seasons) {
              if (season.type == SEASONS &&
                  season.year.toString() == currentYear) {
                players.receiving = season.teams?[0].statistics?.receiving;
                players.rushing = season.teams?[0].statistics?.rushing;
                players.gamesPlayed = season.teams?[0].statistics?.gamesPlayed;
                players.receiving?.gamesPlayed =
                    season.teams?[0].statistics?.gamesPlayed;
                players.rushing?.gamesPlayed =
                    season.teams?[0].statistics?.gamesPlayed;
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
          awayPlayerName =
              '${playerData.fullName.split(" ").first[0]}. ${playerData.fullName.split(" ").last}';

          for (var player in playerData.seasons) {
            if (player.type == '$SEASONS' &&
                player.year == DateTime.now().year) {
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
        e.toString(),
      );
    }
    update();
  }

  // Map to store MLB team records - will be populated by fetchMLBStandings
  Map<String, Map<String, dynamic>> mlbTeamRecords = {};
  
  // Fetch MLB standings data once and store in the map
  Future<void> fetchMLBStandings() async {
    // Skip if we already have the data
    if (mlbTeamRecords.isNotEmpty) {
      print('📊 MLB STANDINGS: Using cached standings data');
      return;
    }
    
    print('📊 MLB STANDINGS: Fetching standings data...');
    ResponseItem result = await GameListingRepo().mlbStandingsRepo();
    
    if (result.status) {
      try {
        // Parse the response and extract team records
        var standingsData = result.data;
        if (standingsData != null && standingsData['league'] != null) {
          var league = standingsData['league'];
          
          // The structure is different in API v8: league -> season -> leagues -> [league] -> divisions
          if (league['season'] != null && league['season']['leagues'] != null) {
            var leagues = league['season']['leagues'];
            
            // Process all leagues (AL and NL)
            for (var leagueItem in leagues) {
              if (leagueItem['divisions'] != null) {
                // Process all divisions
                for (var division in leagueItem['divisions']) {
                  if (division['teams'] != null) {
                    // Process all teams in this division
                    for (var team in division['teams']) {
                      String teamId = team['id'] ?? '';
                      if (teamId.isNotEmpty) {
                        mlbTeamRecords[teamId] = {
                          'win': team['win'] ?? 0,
                          'loss': team['loss'] ?? 0,
                          'name': team['name'] ?? '',
                          'market': team['market'] ?? '',
                          'abbr': team['abbr'] ?? ''
                        };
                        print('📊 MLB STANDINGS: Team ${team['abbr']} (${team['market']} ${team['name']}): W-${team['win']} L-${team['loss']}');
                      }
                    }
                  }
                }
              }
            }
            print('✅ MLB STANDINGS: Loaded ${mlbTeamRecords.length} team records');
          } else {
            print('⚠️ MLB STANDINGS: Could not find season/leagues data in the response');
          }
        } else {
          print('❌ MLB STANDINGS: Invalid response format');
        }
      } catch (e) {
        print('❌ MLB STANDINGS ERROR: $e');
      }
    } else {
      print('❌ MLB STANDINGS API FAILED: ${result.message}');
    }
  }

  ///MLB STATICS
  Future mlbStaticsHomeTeamResponse(
      {String homeTeamId = '',
      bool isLoad = false,
      required SportEvents gameDetails}) async {
    // isLoading.value = !isLoad ? false : true;
    
    // Fetch MLB standings first (will only fetch once)
    await fetchMLBStandings();
    
    // Update win/loss records from standings data
    if (mlbTeamRecords.containsKey(homeTeamId)) {
      gameDetails.homeWin = mlbTeamRecords[homeTeamId]!['win'].toString();
      gameDetails.homeLoss = mlbTeamRecords[homeTeamId]!['loss'].toString();
      print('📊 HOME TEAM RECORD UPDATED: W-${gameDetails.homeWin} L-${gameDetails.homeLoss}');
    }
    
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
          homeHitting = mlbStaticsHomeList?.hitting?.overall;
          homePitching = mlbStaticsHomeList?.pitching?.overall;
          // Calculate total games played for the home team
          int totalHomeWins = int.tryParse(gameDetails.homeWin) ?? 0;
          int totalHomeLosses = int.tryParse(gameDetails.homeLoss) ?? 0;
          int totalGame = totalHomeWins + totalHomeLosses;
          
          // Add debug print to check the values
          print('🏠 HOME TEAM STATS: Wins=${gameDetails.homeWin}, Losses=${gameDetails.homeLoss}, Total Games=$totalGame');
          
          // Special handling for Baltimore Orioles (BAL) or when totalGame is zero
          // The Orioles sometimes has missing win-loss data
          bool isOrioles = response.abbr == "BAL" || response.name == "Orioles";
          if (isOrioles) {
            print('🔍 DETECTING BALTIMORE ORIOLES TEAM - Using special handling');
          }
          
          // Ensure we never divide by zero and use a realistic game count
          if (totalGame <= 0 || isOrioles) {
            // If this is the Orioles or we get season totals but no game count,
            // estimate based on more reliable metrics
            int runsTotal = 0;
            int gamesPlayed = 0;
            
            try {
              // Try to get runs total first
              runsTotal = int.parse(homeHitting?.runs?.total.toString() ?? "0");
              print('📊 HOME TEAM: Parsed runs total: $runsTotal');
              
              // For Orioles specifically, check if games data is available
              if (isOrioles && homeHitting?.games?.play != null) {
                gamesPlayed = homeHitting!.games!.play!.toInt();
                print('🏟️ ORIOLES: Found games played in stats: $gamesPlayed');
                if (gamesPlayed > 0) {
                  totalGame = gamesPlayed;
                }
              }
            } catch (e) {
              print('❌ ERROR parsing home team data: $e');
            }
            
            // If we still don't have a valid game count, estimate based on runs
            if (totalGame <= 0) {
              if (runsTotal > 500) {
                // Full season's worth of data (or close to it)
                totalGame = 162;
                print('⚠️ Season stats detected for home team, using full season (162 games)');
              } else if (runsTotal > 300) {
                // Roughly mid-season
                totalGame = 81;
                print('⚠️ Mid-season stats detected for home team, using half season (81 games)');
              } else if (runsTotal > 0) {
                // Early season or partial data
                totalGame = math.max(runsTotal ~/ 4, 20); // Average ~4 runs per game, minimum 20 games
                print('⚠️ Partial season stats detected for home team, estimating ${totalGame} games');
              } else {
                // For Orioles with no meaningful data, use more reliable default
                totalGame = isOrioles ? 162 : 40; // Full season for Orioles, otherwise 40
                print('⚠️ No meaningful stats for home team, using default (${totalGame} games)');
              }
            }
          }
          
          // Force a reasonable game count based on typical season length
          // This is to prevent massively inflated per-game stats
          if (totalGame > 162) { // MLB teams play 162 games in a season
            print('⚠️ WARNING: Unrealistic game count $totalGame for home team, using 162 instead');
            totalGame = 162;
          }
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
                      runValue: safeParseAndDivide(
                          player.statistics?.hitting?.overall?.runs?.total,
                          totalGame).toStringAsFixed(1),
                      totalBase: 'Total Bases/Game',
                      totalBaseValue: safeParseAndDivide(
                          player.statistics?.hitting?.overall?.onbase?.tb,
                          totalGame).toStringAsFixed(1),
                      stolenBase: 'Stolen Bases/Game',
                      ab: '${player.statistics?.hitting?.overall?.ab ?? "0"}',
                      stolenBaseValue: safeParseAndDivide(
                          player.statistics?.hitting?.overall?.steal?.stolen,
                          totalGame).toStringAsFixed(1)),
                );
              }
            }
          }

          // Use the class-level helper method for calculations
          
          mlbHomeHittingList = [
            safeParseAndDivide(homeHitting?.runs?.total, totalGame).toStringAsFixed(1),
            safeParseAndDivide(homeHitting?.onbase?.h, totalGame).toStringAsFixed(1),
            safeParseAndDivide(homeHitting?.onbase?.hr, totalGame).toStringAsFixed(1),
            safeParseAndDivide(homeHitting?.rbi, totalGame).toStringAsFixed(1),
            safeParseAndDivide(homeHitting?.onbase?.bb, totalGame).toStringAsFixed(1),
            safeParseAndDivide(homeHitting?.outs?.ktotal, totalGame).toStringAsFixed(1),
            safeParseAndDivide(homeHitting?.steal?.stolen, totalGame).toStringAsFixed(1),
            homeHitting?.avg ?? "0",
            homeHitting?.slg != null ? '.${(homeHitting!.slg!).toString().split('.').last}' : "0",
            '${homeHitting?.ops ?? '0'}',
            safeParseAndDivide(homeHitting?.outs?.gidp, totalGame).toStringAsFixed(1),
            homeHitting?.abhr != null ? homeHitting!.abhr!.toStringAsFixed(1) : "0",
          ];
          // Safe pitching stats calculations 
          mlbHomePitchingList = [
            '${homePitching?.era ?? '0'}',
            '${homePitching?.games?.shutout ?? '0'}',
            homePitching?.games?.save != null && homePitching?.games?.svo != null && (homePitching?.games?.svo ?? 0) > 0 
                ? '.${((homePitching!.games!.save! / homePitching!.games!.svo!).toStringAsFixed(3).split('.').last)}'
                : '0',
            '${homePitching?.games?.blownSave ?? '0'}',
            '${homePitching?.games?.qstart ?? '0'}',
            safeParseAndDivide(homePitching?.runs?.total, totalGame).toStringAsFixed(1),
            safeParseAndDivide(homePitching?.onbase?.hr, totalGame).toStringAsFixed(1),
            safeParseAndDivide(homePitching?.onbase?.bb, totalGame).toStringAsFixed(1),
            safeParseAndDivide(homePitching?.outs?.ktotal, totalGame).toStringAsFixed(1),
            '${homePitching?.whip ?? "0"}',
            homePitching?.oba != null ? '.${(homePitching!.oba!).toString().split('.').last}' : '0',
            safeParseAndDivide(homePitching?.outs?.gidp, totalGame).toStringAsFixed(1),
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
    
    // Get total games played from wins and losses
    int totalHomeWins = int.tryParse(gameDetails.homeWin) ?? 0;
    int totalHomeLosses = int.tryParse(gameDetails.homeLoss) ?? 0;
    int totalGame = totalHomeWins + totalHomeLosses;
    
    // Handle edge cases: Baltimore Orioles and zero games
    if (totalGame == 0) {
      totalGame = 1; // Prevent division by zero
    }
    // Cap at maximum season games
    if (totalGame > 162) {
      totalGame = 162;
    }
    
    // Log raw values from API before calculating
    print('📊 HOME TEAM RAW VALUES:');
    print('- Games from API (games.play): ${homeHitting?.games?.play}');
    print('- Games from wins/losses: $totalGame (Wins: ${gameDetails.homeWin}, Losses: ${gameDetails.homeLoss})');
    print('- Total hits: ${homeHitting?.onbase?.h}');
    print('- Total runs: ${homeHitting?.runs?.total}');
    print('- Team abbreviation: ${result.status ? stat.MLBStaticsModel.fromJson(result.data).abbr : "Unknown"}');
    
    // Get the actual number of games played from the API response if available
    int gamesPlayed = homeHitting?.games?.play?.toInt() ?? totalGame;
    
    // Make sure we have a valid number of games to avoid division by zero
    if (gamesPlayed <= 0) {
      gamesPlayed = totalGame > 0 ? totalGame : 1;
    }
    
    // Log the final games played count used for calculations
    print('📊 HOME TEAM: Using games played count: $gamesPlayed for per-game calculations');
    
    // Calculate actual per-game stats without any scaling
    mlbHomeOffensiveList = [
      (homeHitting?.onbase?.h != null ? (homeHitting!.onbase!.h! / gamesPlayed).toStringAsFixed(1) : "0.0"),       // Hits / Game
      (homeHitting?.onbase?.bb != null ? (homeHitting!.onbase!.bb! / gamesPlayed).toStringAsFixed(1) : "0.0"),      // Walks / Game
      (homeHitting?.onbase?.hr != null ? (homeHitting!.onbase!.hr! / gamesPlayed).toStringAsFixed(1) : "0.0"),      // HR / Game
      (homeHitting?.rbi != null ? (homeHitting!.rbi! / gamesPlayed).toStringAsFixed(1) : "0.0"),                    // RBI / Game
      (homeHitting?.runs?.total != null ? (homeHitting!.runs!.total! / gamesPlayed).toStringAsFixed(1) : "0.0"),    // Runs / Game
      (homeHitting?.outs?.ktotal != null ? (homeHitting!.outs!.ktotal! / gamesPlayed).toStringAsFixed(1) : "0.0"),  // Strikeouts / Game
      (homeHitting?.steal?.stolen != null ? (homeHitting!.steal!.stolen! / gamesPlayed).toStringAsFixed(1) : "0.0"), // Stolen Bases / Game
      homeHitting?.avg ?? "0",                                                                                       // Team Batting Average
      homeHitting?.obp != null ? homeHitting!.obp!.toString() : "0",                                                 // On Base Percentage
      homeHitting?.slg != null ? homeHitting!.slg!.toString() : "0"                                                  // Slugging Percentage
    ];
    
    mlbHomeDefensiveList = [
      (homePitching?.onbase?.h != null ? (homePitching!.onbase!.h! / gamesPlayed).toStringAsFixed(1) : "0.0"),       // Hits Allowed / Game
      (homePitching?.onbase?.bb != null ? (homePitching!.onbase!.bb! / gamesPlayed).toStringAsFixed(1) : "0.0"),      // Walks Allowed / Game
      (homePitching?.onbase?.hr != null ? (homePitching!.onbase!.hr! / gamesPlayed).toStringAsFixed(1) : "0.0"),      // HR Allowed / Game
      (homePitching?.runs?.total != null ? (homePitching!.runs!.total! / gamesPlayed).toStringAsFixed(1) : "0.0"),    // RBI Allowed / Game
      (homePitching?.runs?.earned != null ? (homePitching!.runs!.earned! / gamesPlayed).toStringAsFixed(1) : "0.0"),  // Runs Allowed / Game
      (homePitching?.outs?.ktotal != null ? (homePitching!.outs!.ktotal! / gamesPlayed).toStringAsFixed(1) : "0.0"),  // Pitcher Strike Out / Game
      (homePitching?.steal?.stolen != null ? (homePitching!.steal!.stolen! / gamesPlayed).toStringAsFixed(1) : "0.0"), // SB Allowed / Game
      homePitching?.era != null ? homePitching!.era!.toString() : "0",                                                // Team Earned Run Average
      homePitching?.obp != null ? homePitching!.obp!.toString() : "0",                                                // Opponent OBP 
      homePitching?.slg != null ? homePitching!.slg!.toString() : "0"                                                 // Opponent SLG
    ];
    
    update();
  }

  // Getter and setter already defined at the class level

  Future mlbStaticsAwayTeamResponse(
      {String awayTeamId = '',
      bool isLoad = false,
      required SportEvents gameDetails}) async {
    // isLoading.value = !isLoad ? false : true;
    
    // Fetch MLB standings first (will only fetch once)
    await fetchMLBStandings();
    
    // Update win/loss records from standings data
    if (mlbTeamRecords.containsKey(awayTeamId)) {
      gameDetails.awayWin = mlbTeamRecords[awayTeamId]!['win'].toString();
      gameDetails.awayLoss = mlbTeamRecords[awayTeamId]!['loss'].toString();
      print('📊 AWAY TEAM RECORD UPDATED: W-${gameDetails.awayWin} L-${gameDetails.awayLoss}');
    }
    
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
        // Calculate total games played for the away team
        int totalAwayWins = int.tryParse(gameDetails.awayWin) ?? 0;
        int totalAwayLosses = int.tryParse(gameDetails.awayLoss) ?? 0;
        int totalGame = totalAwayWins + totalAwayLosses;
        
        // Add debug print to check the values
        print('🏃 AWAY TEAM STATS: Wins=${gameDetails.awayWin}, Losses=${gameDetails.awayLoss}, Total Games=$totalGame');
        
        // Special handling for Baltimore Orioles (BAL) or when totalGame is zero
        // The Orioles sometimes has missing win-loss data
        bool isOrioles = response.abbr == "BAL" || response.name == "Orioles";
        if (isOrioles) {
          print('🔍 DETECTING BALTIMORE ORIOLES TEAM (AWAY) - Using special handling');
        }
        
        // Ensure we never divide by zero and use a realistic game count
        if (totalGame <= 0 || isOrioles) {
          // If this is the Orioles or we get season totals but no game count,
          // estimate based on more reliable metrics
          int runsTotal = 0;
          int gamesPlayed = 0;
          
          try {
            // Try to get runs total first
            runsTotal = int.parse(awayHitting?.runs?.total.toString() ?? "0");
            print('📊 AWAY TEAM: Parsed runs total: $runsTotal');
            
            // For Orioles specifically, check if games data is available
            if (isOrioles && awayHitting?.games?.play != null) {
              gamesPlayed = awayHitting!.games!.play!.toInt();
              print('🏟️ ORIOLES (AWAY): Found games played in stats: $gamesPlayed');
              if (gamesPlayed > 0) {
                totalGame = gamesPlayed;
              }
            }
          } catch (e) {
            print('❌ ERROR parsing away team data: $e');
          }
          
          // If we still don't have a valid game count, estimate based on runs
          if (totalGame <= 0) {
            if (runsTotal > 500) {
              // Full season's worth of data (or close to it)
              totalGame = 162;
              print('⚠️ Season stats detected for away team, using full season (162 games)');
            } else if (runsTotal > 300) {
              // Roughly mid-season
              totalGame = 81;
              print('⚠️ Mid-season stats detected for away team, using half season (81 games)');
            } else if (runsTotal > 0) {
              // Early season or partial data
              totalGame = math.max(runsTotal ~/ 4, 20); // Average ~4 runs per game, minimum 20 games
              print('⚠️ Partial season stats detected for away team, estimating ${totalGame} games');
            } else {
              // For Orioles with no meaningful data, use more reliable default
              totalGame = isOrioles ? 162 : 40; // Full season for Orioles, otherwise 40
              print('⚠️ No meaningful stats for away team, using default (${totalGame} games)');
            }
          }
        }
        
        awayHitting = mlbStaticsAwayList?.hitting?.overall;
        awayPitching = mlbStaticsAwayList?.pitching?.overall;
        
        // Force a reasonable game count based on typical season length
        // This is to prevent massively inflated per-game stats
        if (totalGame > 162) { // MLB teams play 162 games in a season
          print('⚠️ WARNING: Unrealistic game count $totalGame for away team, using 162 instead');
          totalGame = 162;
        }
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
                    runValue: safeParseAndDivide(
                        player.statistics?.hitting?.overall?.runs?.total,
                        totalGame).toStringAsFixed(1),
                    totalBase: 'Total Bases/Game',
                    totalBaseValue: safeParseAndDivide(
                        player.statistics?.hitting?.overall?.onbase?.tb,
                        totalGame).toStringAsFixed(1),
                    stolenBase: 'Stolen Bases/Game',
                    ab: '${player.statistics?.hitting?.overall?.ab ?? "0"}',
                    stolenBaseValue: safeParseAndDivide(
                        player.statistics?.hitting?.overall?.steal?.stolen,
                        totalGame).toStringAsFixed(1)),
              );
            }
          }
        }

        // Use the class-level helper method for calculations
        
        mlbAwayHittingList = [
          safeParseAndDivide(awayHitting?.runs?.total, totalGame).toStringAsFixed(1),
          safeParseAndDivide(awayHitting?.onbase?.h, totalGame).toStringAsFixed(1),
          safeParseAndDivide(awayHitting?.onbase?.hr, totalGame).toStringAsFixed(1),
          safeParseAndDivide(awayHitting?.rbi, totalGame).toStringAsFixed(1),
          safeParseAndDivide(awayHitting?.onbase?.bb, totalGame).toStringAsFixed(1),
          safeParseAndDivide(awayHitting?.outs?.ktotal, totalGame).toStringAsFixed(1),
          safeParseAndDivide(awayHitting?.steal?.stolen, totalGame).toStringAsFixed(1),
          awayHitting?.avg ?? "0",
          awayHitting?.slg != null ? '.${(awayHitting!.slg!).toString().split('.').last}' : "0",
          '${awayHitting?.ops ?? '0'}',
          safeParseAndDivide(awayHitting?.outs?.gidp, totalGame).toStringAsFixed(1),
          awayHitting?.abhr != null ? awayHitting!.abhr!.toStringAsFixed(1) : "0",
        ];
        // Safe pitching stats calculations for away team
        mlbAwayPitchingList = [
          '${awayPitching?.era ?? '0'}',
          '${awayPitching?.games?.shutout ?? '0'}',
          awayPitching?.games?.save != null && awayPitching?.games?.svo != null && (awayPitching?.games?.svo ?? 0) > 0 
              ? '.${((awayPitching!.games!.save! / awayPitching!.games!.svo!).toStringAsFixed(3).split('.').last)}'
              : '0',
          '${awayPitching?.games?.blownSave ?? '0'}',
          '${awayPitching?.games?.qstart ?? '0'}',
          safeParseAndDivide(awayPitching?.runs?.total, totalGame).toStringAsFixed(1),
          safeParseAndDivide(awayPitching?.onbase?.hr, totalGame).toStringAsFixed(1),
          safeParseAndDivide(awayPitching?.onbase?.bb, totalGame).toStringAsFixed(1),
          safeParseAndDivide(awayPitching?.outs?.ktotal, totalGame).toStringAsFixed(1),
          '${awayPitching?.whip ?? "0"}',
          awayPitching?.oba != null ? '.${(awayPitching!.oba!).toString().split('.').last}' : '0',
          safeParseAndDivide(awayPitching?.outs?.gidp, totalGame).toStringAsFixed(1),
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
        e.toString(),
      );
    }
    
    // Get total games played from wins and losses
    int totalAwayWins = int.tryParse(gameDetails.awayWin) ?? 0;
    int totalAwayLosses = int.tryParse(gameDetails.awayLoss) ?? 0;
    int totalGame = totalAwayWins + totalAwayLosses;
    
    // Handle edge cases: Baltimore Orioles and zero games
    if (totalGame == 0) {
      totalGame = 1; // Prevent division by zero
    }
    // Cap at maximum season games
    if (totalGame > 162) {
      totalGame = 162;
    }
    
    // Log raw values from API before calculating
    print('📊 AWAY TEAM RAW VALUES:');
    print('- Games from API (games.play): ${awayHitting?.games?.play}');
    print('- Games from wins/losses: $totalGame (Wins: ${gameDetails.awayWin}, Losses: ${gameDetails.awayLoss})');
    print('- Total hits: ${awayHitting?.onbase?.h}');
    print('- Total runs: ${awayHitting?.runs?.total}');
    print('- Team abbreviation: ${result.status ? stat.MLBStaticsModel.fromJson(result.data).abbr : "Unknown"}');
    
    // Get the actual number of games played from the API response if available
    int gamesPlayed = awayHitting?.games?.play?.toInt() ?? totalGame;
    
    // Make sure we have a valid number of games to avoid division by zero
    if (gamesPlayed <= 0) {
      gamesPlayed = totalGame > 0 ? totalGame : 1;
    }
    
    // Log the final games played count used for calculations
    print('📊 AWAY TEAM: Using games played count: $gamesPlayed for per-game calculations');
    
    // Calculate actual per-game stats without any scaling
    mlbAwayOffensiveList = [
      (awayHitting?.onbase?.h != null ? (awayHitting!.onbase!.h! / gamesPlayed).toStringAsFixed(1) : "0.0"),       // Hits / Game
      (awayHitting?.onbase?.bb != null ? (awayHitting!.onbase!.bb! / gamesPlayed).toStringAsFixed(1) : "0.0"),      // Walks / Game
      (awayHitting?.onbase?.hr != null ? (awayHitting!.onbase!.hr! / gamesPlayed).toStringAsFixed(1) : "0.0"),      // HR / Game
      (awayHitting?.rbi != null ? (awayHitting!.rbi! / gamesPlayed).toStringAsFixed(1) : "0.0"),                    // RBI / Game
      (awayHitting?.runs?.total != null ? (awayHitting!.runs!.total! / gamesPlayed).toStringAsFixed(1) : "0.0"),    // Runs / Game
      (awayHitting?.outs?.ktotal != null ? (awayHitting!.outs!.ktotal! / gamesPlayed).toStringAsFixed(1) : "0.0"),  // Strikeouts / Game
      (awayHitting?.steal?.stolen != null ? (awayHitting!.steal!.stolen! / gamesPlayed).toStringAsFixed(1) : "0.0"), // Stolen Bases / Game
      awayHitting?.avg ?? "0",                                                                                       // Team Batting Average
      awayHitting?.obp != null ? awayHitting!.obp!.toString() : "0",                                                 // On Base Percentage
      awayHitting?.slg != null ? awayHitting!.slg!.toString() : "0"                                                  // Slugging Percentage
    ];
    
    mlbAwayDefensiveList = [
      (awayPitching?.onbase?.h != null ? (awayPitching!.onbase!.h! / gamesPlayed).toStringAsFixed(1) : "0.0"),       // Hits Allowed / Game
      (awayPitching?.onbase?.bb != null ? (awayPitching!.onbase!.bb! / gamesPlayed).toStringAsFixed(1) : "0.0"),      // Walks Allowed / Game
      (awayPitching?.onbase?.hr != null ? (awayPitching!.onbase!.hr! / gamesPlayed).toStringAsFixed(1) : "0.0"),      // HR Allowed / Game
      (awayPitching?.runs?.total != null ? (awayPitching!.runs!.total! / gamesPlayed).toStringAsFixed(1) : "0.0"),    // RBI Allowed / Game
      (awayPitching?.runs?.earned != null ? (awayPitching!.runs!.earned! / gamesPlayed).toStringAsFixed(1) : "0.0"),  // Runs Allowed / Game
      (awayPitching?.outs?.ktotal != null ? (awayPitching!.outs!.ktotal! / gamesPlayed).toStringAsFixed(1) : "0.0"),  // Pitcher Strike Out / Game
      (awayPitching?.steal?.stolen != null ? (awayPitching!.steal!.stolen! / gamesPlayed).toStringAsFixed(1) : "0.0"), // SB Allowed / Game
      awayPitching?.era != null ? awayPitching!.era!.toString() : "0",                                                // Team Earned Run Average
      awayPitching?.obp != null ? awayPitching!.obp!.toString() : "0",                                                // Opponent OBP 
      awayPitching?.slg != null ? awayPitching!.slg!.toString() : "0"                                                 // Opponent SLG
    ];
    
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
              /* gameDetails.homeDefense = [
                ((int.parse(defenciveData?.passing?.yards.toString() ?? "0") /
                        totalGame)
                    .toStringAsFixed(1)),
                ((int.parse(defenciveData?.passing?.touchdowns.toString() ??
                            "0") /
                        totalGame)
                    .toStringAsFixed(1)),
                ((int.parse(defenciveData?.rushing?.yards.toString() ?? "0") /
                        totalGame)
                    .toStringAsFixed(1)),
                ((int.parse(defenciveData?.rushing?.touchdowns.toString() ??
                            "0") /
                        totalGame)
                    .toStringAsFixed(1)),
                (int.parse(defenciveData?.defense?.interceptions.toString() ??
                            "0") /
                        totalGame)
                    .toStringAsFixed(1),
              ];*/
              gameDetails.homeRunningBackPlayer.clear();
              gameDetails.homeReceiversPlayer.clear();
              if (response.players != null) {
                response.players?.forEach((player) {
                  if (player.position == 'RB') {
                    gameDetails.homeRunningBackPlayer.add(player);
                    // runningBacksHomeList.add(RunningBacks(carries: carries, yard: yard, avgCarry: avgCarry, tds: tds, longestRun: longestRun, fumbles: fumbles))
                  }
                  if (player.position == 'WR' || player.position == 'TE') {
                    gameDetails.homeReceiversPlayer.add(player);
                  }
                  /* if (sportKey == SportName.NCAA.name) {
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
                              .toStringAsFixed(1)),
                          ((int.parse(player.rushing?.yards.toString() ?? "0") /
                              totalPlay)
                              .toStringAsFixed(1)),
                          ((int.parse(player.rushing?.touchdowns.toString() ??
                              "0") /
                              totalPlay)
                              .toStringAsFixed(1)),
                          ((int.parse(player.passing?.interceptions
                              .toString() ??
                              "0") /
                              totalPlay)
                              .toStringAsFixed(1)),

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
        e.toString(),
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
              /* gameDetails.awayDefense = [
                ((int.parse(defenciveData?.passing?.yards.toString() ?? "0") /
                        totalGame)
                    .toStringAsFixed(1)),
                ((int.parse(defenciveData?.passing?.touchdowns.toString() ??
                            "0") /
                        totalGame)
                    .toStringAsFixed(1)),
                ((int.parse(defenciveData?.rushing?.yards.toString() ?? "0") /
                        totalGame)
                    .toStringAsFixed(1)),
                ((int.parse(defenciveData?.rushing?.touchdowns.toString() ??
                            "0") /
                        totalGame)
                    .toStringAsFixed(1)),
                ((int.parse(defenciveData?.defense?.interceptions.toString() ??
                            "0") /
                        totalGame)
                    .toStringAsFixed(1)),
                // (offenciveData?.defense?.interceptions ?? "0").toString(),
              ];*/
              gameDetails.awayReceiversPlayer.clear();
              gameDetails.awayRunningBackPlayer.clear();
              if (response.players != null) {
                response.players?.forEach((player) {
                  if (player.position == 'RB') {
                    gameDetails.awayRunningBackPlayer.add(player);
                  }
                  if (player.position == 'WR' || player.position == 'TE') {
                    gameDetails.awayReceiversPlayer.add(player);
                  }
                  /* if (sportKey == SportName.NCAA.name) {
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
                              .toStringAsFixed(1)),
                          ((int.parse(player.rushing?.yards.toString() ?? "0") /
                              totalPlay)
                              .toStringAsFixed(1)),
                          ((int.parse(player.rushing?.touchdowns.toString() ??
                              "0") /
                              totalPlay)
                              .toStringAsFixed(1)),
                          ((int.parse(player.passing?.interceptions
                              .toString() ??
                              "0") /
                              totalPlay)
                              .toStringAsFixed(1)),

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
        e.toString(),
      );
    }
    update();
  }

  Future getRosterAwayPlayer(
      {String awayTeamId = '',
      required SportEvents gameDetails,
      bool isLoad = false,
      String sportKey = ''}) async {
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo().getRosterPlayer(teamId: awayTeamId);
    try {
      if (result.status) {
        if (result.data != null) {
          roster.NFLRosterPlayerModel response =
              roster.NFLRosterPlayerModel.fromJson(result.data);
          gameDetails.nflAwayReceiversPlayer.clear();
          gameDetails.nflAwayRunningBackPlayer.clear();
          if (response.players != null) {
            for (int i = 0; i < (response.players!.length); i++) {
              if (response.players?[i].position == 'RB') {
                gameDetails.nflAwayRunningBackPlayer.add(response.players![i]);
                profileAwayTeamResponse(
                    gameDetails: gameDetails,
                    players: response.players![i],
                    sportKey: sportKey);
              }
              if ((response.players?[i].position == 'WR' ||
                  response.players?[i].position == 'TE')) {
                gameDetails.nflAwayReceiversPlayer.add(response.players![i]);
                profileAwayTeamResponse(
                    gameDetails: gameDetails,
                    players: response.players![i],
                    sportKey: sportKey);
              }
            }
          } else {
            // isLoading.value = false;
          }
        } else {
          // isLoading.value = false;
        }
      }
    } catch (e) {
      // isLoading.value = false;
      log('ERROR NFL AWAY FULL ROSTER-----$e');
      showAppSnackBar(
        e.toString(),
      );
    }
    update();
  }

  Future getRosterHomePlayer(
      {String homeTeamId = '',
      required SportEvents gameDetails,
      bool isLoad = false,
      String sportKey = ''}) async {
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo().getRosterPlayer(teamId: homeTeamId);
    try {
      if (result.status) {
        if (result.data != null) {
          roster.NFLRosterPlayerModel response =
              roster.NFLRosterPlayerModel.fromJson(result.data);
          gameDetails.nflHomeReceiversPlayer.clear();
          gameDetails.nflHomeRunningBackPlayer.clear();
          if (response.players != null) {
            for (int i = 0; i < (response.players!.length); i++) {
              if (response.players?[i].position == 'RB') {
                gameDetails.nflHomeRunningBackPlayer.add(response.players![i]);

                profileHomeTeamResponse(
                    gameDetails: gameDetails,
                    players: response.players![i],
                    sportKey: sportKey);
              }
              if ((response.players?[i].position == 'WR' ||
                  response.players?[i].position == 'TE')) {
                gameDetails.nflHomeReceiversPlayer.add(response.players![i]);

                profileHomeTeamResponse(
                    gameDetails: gameDetails,
                    players: response.players![i],
                    sportKey: sportKey);
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
      log('ERROR NFL HOME FULL ROSTER------$e');
      showAppSnackBar(
        e.toString(),
      );
    }
    update();
  }

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
        if (key == SportName.NFL.name || key == SportName.NBA.name) {
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
        } else if (key == SportName.NCAA.name) {
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
        } else if (key == SportName.NCAAB.name) {
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
        isLoading.value = false;
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
    // Ensure this list is mutable
    gameDetails.awayRushingPlayer = [];
    gameDetails.startingAwayFiveList = [];
    isLoading.value = !isLoad ? false : true;

    ResponseItem result =
    ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo().nbaStaticsRepo(sportKey: key, teamId: awayId);

    try {
      if (result.status) {
        NBAStaticsModel response = NBAStaticsModel.fromJson(result.data);
        if (response.players != null) {
          // Assign a mutable list to awayRushingPlayer
          gameDetails.awayRushingPlayer = List.from(response.players!);

          // Sorting players for awayRushingPlayer based on points
          gameDetails.awayRushingPlayer.sort((a, b) =>
              (b.average?.points ?? 0).compareTo(a.average?.points ?? 0));

          // Finding the top two players based on minutes
          var topPlayers = response.players!
              .where((element) => element.position == 'G')
              .toList()
            ..sort((a, b) =>
                (b.average?.minutes ?? 0).compareTo(a.average?.minutes ?? 0));

          // Assign the first position as pgPlayer and second position as sgPlayer
          if (topPlayers.isNotEmpty) {
            gameDetails.pgDataAway = topPlayers[0];
            gameDetails.startingAwayFiveList = List.from(gameDetails.startingAwayFiveList)
              ..add(topPlayers[0]); // First position
          }
          if (topPlayers.length > 1) {
            gameDetails.sgDataAway = topPlayers[1];
            gameDetails.startingAwayFiveList = List.from(gameDetails.startingAwayFiveList)
              ..add(topPlayers[1]); // Second position
          }

          // Finding the top 3 players based on minutes for the 'F' position
          var topFPlayers = response.players!
              .where((element) => element.position == 'F')
              .toList()
            ..sort((a, b) =>
                (b.average?.minutes ?? 0).compareTo(a.average?.minutes ?? 0));

          // Assign the top 3 players to respective positions if available
          if (topFPlayers.isNotEmpty) {
            gameDetails.sfDataAway = topFPlayers[0];
            gameDetails.startingAwayFiveList = List.from(gameDetails.startingAwayFiveList)
              ..add(topFPlayers[0]); // First position (most minutes)
          }
          if (topFPlayers.length > 1) {
            gameDetails.pfDataAway = topFPlayers[1];
            gameDetails.startingAwayFiveList = List.from(gameDetails.startingAwayFiveList)
              ..add(topFPlayers[1]); // Second position
          }
          var topCPlayers = response.players!
              .where((element) => element.position == 'C')
              .toList()
            ..sort((a, b) =>
                (b.average?.minutes ?? 0).compareTo(a.average?.minutes ?? 0));
          if (topCPlayers.isNotEmpty) {
            gameDetails.cDataAway = topCPlayers[0];
            gameDetails.startingAwayFiveList = List.from(gameDetails.startingAwayFiveList)
              ..add(topCPlayers[0]); // Third position
          }else{
            if (topFPlayers.length > 2) {
              gameDetails.cDataAway = topFPlayers[2];
              gameDetails.startingAwayFiveList = List.from(gameDetails.startingAwayFiveList)
                ..add(topFPlayers[2]); // Second position
            }
          }
        }
        update();
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      log('ERROR RECORD NFL && NCAA--------$e');
    }

    update();
  }




  Future staticsHomeNBA({
    String homeId = '',
    bool isLoad = false,
    required SportEvents gameDetails,
    String sportKey = '',
  }) async {
    gameDetails.homeRushingPlayer = [];
    gameDetails.startingHomeFiveList = [];// Ensure this list is mutable
    isLoading.value = !isLoad ? false : true;

    ResponseItem result =
    ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo()
        .nbaStaticsRepo(sportKey: sportKey, teamId: homeId);

    try {
      if (result.status) {
        NBAStaticsModel response = NBAStaticsModel.fromJson(result.data);
        if (response.players != null) {
          // Assign a mutable list to homeRushingPlayer
          gameDetails.homeRushingPlayer = List.from(response.players!);

          // Sorting players for homeRushingPlayer based on points
          gameDetails.homeRushingPlayer.sort((a, b) =>
              (b.average?.points ?? 0).compareTo(a.average?.points ?? 0));

          // Finding the top two players based on minutes
          var topPlayers = response.players!
              .where((element) => element.position == 'G')
              .toList()
            ..sort((a, b) =>
                (b.average?.minutes ?? 0).compareTo(a.average?.minutes ?? 0));

          // Assign the first position as pgPlayer and second position as sgPlayer
          if (topPlayers.isNotEmpty) {
            gameDetails.pgDataHome = topPlayers[0];
            gameDetails.startingHomeFiveList = List.from(gameDetails.startingHomeFiveList)
              ..add(topPlayers[0]); // First position
          }
          if (topPlayers.length > 1) {
            gameDetails.sgDataHome = topPlayers[1];
            gameDetails.startingHomeFiveList = List.from(gameDetails.startingHomeFiveList)
              ..add(topPlayers[1]); // Second position
          }

          // Finding the top 3 players based on minutes for the 'F' position
          var topFPlayers = response.players!
              .where((element) => element.position == 'F')
              .toList()
            ..sort((a, b) =>
                (b.average?.minutes ?? 0).compareTo(a.average?.minutes ?? 0));

          // Assign the top 3 players to respective positions if available
          if (topFPlayers.isNotEmpty) {
            gameDetails.sfDataHome = topFPlayers[0];
            gameDetails.startingHomeFiveList = List.from(gameDetails.startingHomeFiveList)
              ..add(topFPlayers[0]); // First position (most minutes)
          }
          if (topFPlayers.length > 1) {
            gameDetails.pfDataHome = topFPlayers[1];
            gameDetails.startingHomeFiveList = List.from(gameDetails.startingHomeFiveList)
              ..add(topFPlayers[1]); // Second position
          }

          var topCPlayers = response.players!
              .where((element) => element.position == 'C')
              .toList()
            ..sort((a, b) =>
                (b.average?.minutes ?? 0).compareTo(a.average?.minutes ?? 0));
          if (topCPlayers.isNotEmpty) {
            gameDetails.cDataHome = topCPlayers[0];
            gameDetails.startingHomeFiveList = List.from(gameDetails.startingHomeFiveList)
              ..add(topCPlayers[0]); // Third position
          }else{
            if (topFPlayers.length > 2) {
              gameDetails.cDataHome = topFPlayers[2];
              gameDetails.startingHomeFiveList = List.from(gameDetails.startingHomeFiveList)
                ..add(topFPlayers[2]); // Second position
            }
          }
        }
      } else {
        isLoading.value = false;
      }
      update();
    } catch (e) {
      isLoading.value = false;
      log('ERROR RECORD NFL && NCAA--------$e');
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
        if (sportKey == SportName.NFL.name) {
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
                    if (sportKey == SportName.NBA.name) {
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
                    if (sportKey == SportName.NBA.name) {
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
        e.toString(),
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

    if (sportKey == SportName.MLB.name) {
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
          sportKey: SportName.MLB.name,
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
      // await hotlinesDataResponse(
      //     awayTeamId: awayTeam?.id ?? "",
      //     sportId: sportId,
      //     gameDetails: gameDetails,
      //     matchId: gameDetails.id ?? "",
      //     isLoad: isLoad,
      //     homeTeamId: homeTeam?.id ?? "");
    }
    if (sportKey == SportName.NFL.name) {
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
      getRosterAwayPlayer(
          awayTeamId: awayTeam?.abbreviation == 'LV'
              ? '7d4fcc64-9cb5-4d1b-8e75-8a906d1e1576'
              : replaceId(awayTeam?.uuids ?? ''),
          gameDetails: gameDetails,
          isLoad: isLoad,
          sportKey: sportKey);
      getRosterHomePlayer(
          homeTeamId: homeTeam?.abbreviation == 'LV'
              ? '7d4fcc64-9cb5-4d1b-8e75-8a906d1e1576'
              : replaceId(homeTeam?.uuids ?? ''),
          gameDetails: gameDetails,
          isLoad: isLoad,
          sportKey: sportKey);
      nflStaticsHomeTeamResponse(
          isLoad: false,
          gameDetails: gameDetails,
          sportKey: sportKey,
          homeTeamId: homeTeam?.abbreviation == 'LV'
              ? '7d4fcc64-9cb5-4d1b-8e75-8a906d1e1576'
              : replaceId(homeTeam?.uuids ?? ''));
      mlbInjuriesResponse(
          isLoad: false,
          sportKey: SportName.NFL.name,
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
    if (sportKey == SportName.NCAA.name) {
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
      // hotlinesDataResponse(
      //     awayTeamId: awayTeam?.id ?? "",
      //     sportId: sportId,
      //     gameDetails: gameDetails,
      //     matchId: gameDetails.id ?? "",
      //     isLoad: isLoad,
      //     homeTeamId: homeTeam?.id ?? "");
    }
    if (sportKey == SportName.NBA.name || sportKey == SportName.NCAAB.name) {
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
      if (sportKey == SportName.NBA.name) {
        mlbInjuriesResponse(
            isLoad: false,
            sportKey: SportName.NBA.name,
            sportEvent: gameDetails,
            awayTeamId: replaceId(awayTeam?.uuids ?? ''),
            homeTeamId: replaceId(homeTeam?.uuids ?? ''));
      }
      // hotlinesDataResponse(
      //     awayTeamId: awayTeam?.id ?? "",
      //     sportId: sportId,
      //     gameDetails: gameDetails,
      //     matchId: gameDetails.id ?? "",
      //     isLoad: isLoad,
      //     homeTeamId: homeTeam?.id ?? "");
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

  ///HOTLINES DATA
// List<HotlinesModel> _hotlinesFData = [];
//
// List<HotlinesModel> get hotlinesFData => _hotlinesFData;
//
// set hotlinesFData(List<HotlinesModel> value) {
//   _hotlinesFData = value;
//   update();
// }
}

class StartingQBModel {
  String playerId;
  String playerName;
  String teamId;

  StartingQBModel(
      {required this.playerId, required this.playerName, required this.teamId});
}
