import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hotlines/model/leauge_model.dart';
import 'package:hotlines/model/game_listing.dart' as game_listing;
import 'package:hotlines/model/mlb_box_score_model.dart' as mlb;
import 'package:hotlines/model/mlb_team_model.dart';
import 'package:hotlines/model/mlb_venue_model.dart';
import 'package:hotlines/model/mlb_game_summary_model.dart';
import 'package:hotlines/utils/animated_search.dart';
import 'package:hotlines/utils/app_helper.dart';
import 'package:intl/intl.dart';

import '../../../constant/constant.dart';
import '../../../constant/shred_preference.dart';
import '../../../extras/constants.dart';
import '../../../extras/request_constants.dart';
import '../../../model/forgot_pass_model.dart';
import '../../../model/game_listing.dart';
import '../../../model/nba_boxscore_model.dart';
import '../../../model/nba_rank_model.dart';
import '../../../model/ncaa_boxcore_model.dart' as ncaa;
import '../../../model/ncaab_conference_model.dart';
import '../../../model/nfl_qbs_rank_model.dart';
import '../../../model/nfl_rank_model.dart';
import '../../../model/ranking_model.dart';
import '../../../model/response_item.dart';
import '../../../model/team_logo_model.dart';
import '../../../model/user_model.dart';
import '../../../network/auth_repo.dart';
import '../../../network/game_listing_repo.dart';
import '../../../network/subscription_repo.dart';
import '../../../theme/helper.dart';
import '../../../utils/extension.dart';
import '../../auth/log_in_module/log_in_screen.dart';
import '../gameDetails/game_details_screen.dart';

class GameListingController extends GetxController {
  @override
  void dispose() {
    if (timer != null) {
      timer!.cancel();
      timer = null;
    }
    if (timerNCAA != null) {
      timerNCAA!.cancel();
      timerNCAA = null;
    }
    if (timerNFL != null) {
      timerNFL!.cancel();
      timerNFL = null;
    }
    log('GameListingController disposed');
    super.dispose();
  }

  @override
  void onClose() {
    if (timer != null) {
      timer!.cancel();
      timer = null;
    }
    if (timerNCAA != null) {
      timerNCAA!.cancel();
      timerNCAA = null;
    }
    if (timerNFL != null) {
      timerNFL!.cancel();
      timerNFL = null;
    }
    log('GameListingController closed');
    super.onClose();
  }

  String sportId = ncaabSportId;

  String _sportKey = SportName.NCAAB.name;

  String get sportKey => _sportKey;

  set sportKey(String value) {
    _sportKey = value;
    // If changing to MLB, update the sportId too
    if (value == SportName.MLB.name) {
      sportId = mlbSportId;
    }
    update();
  }

  String apiKey = dotenv.env['ODDS_COMPARISON_REGULAR_API'] ?? "";
  // Use current date for up-to-date games
  String date = DateFormat('yyyy-MM-dd').format(DateTime.now());

  List<String> _isSelected = [
    /*PreferenceManager.getFavoriteSport() ?? */
    SportName.NCAAB.name
  ];

  List<String> get isSelected => _isSelected;

  set isSelected(List<String> value) {
    _isSelected = value;
    update();
  }

  String _isSelectedGame = SportName.NCAAB.name;

  String get isSelectedGame => _isSelectedGame;

  set isSelectedGame(String value) {
    _isSelectedGame = value;
    update();
  }

  bool _isSearch = false;

  bool get isSearch => _isSearch;

  set isSearch(bool value) {
    _isSearch = value;
    update();
  }
  
  // Flag to track if this is the first load
  bool isFirstLoad = true;

  RxBool isLoading = false.obs;
  TextEditingController searchCon = TextEditingController();
  List<SportEvents> _nbaSportEventsList = [];

  List<SportEvents> get nbaSportEventsList => _nbaSportEventsList;

  set nbaSportEventsList(List<SportEvents> value) {
    _nbaSportEventsList = value;
    update();
  }

  List<SportEvents> _ncaabSportEventsList = [];

  List<SportEvents> get ncaabSportEventsList => _ncaabSportEventsList;

  set ncaabSportEventsList(List<SportEvents> value) {
    _ncaabSportEventsList = value;
    update();
  }

  List<SportEvents> _ncaaSportEventsList = [];

  List<SportEvents> get ncaaSportEventsList => _ncaaSportEventsList;

  set ncaaSportEventsList(List<SportEvents> value) {
    _ncaaSportEventsList = value;
    update();
  }

  List<SportEvents> _nflSportEventsList = [];

  List<SportEvents> get nflSportEventsList => _nflSportEventsList;

  set nflSportEventsList(List<SportEvents> value) {
    _nflSportEventsList = value.toSet().toList();
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
    _searchList = value.toSet().toList();
    update();
  }

  bool _isPagination = false;

  bool get isPagination => _isPagination;

  set isPagination(bool value) {
    _isPagination = value;
    update();
  }

  bool _isCallApi = false;

  bool get isCallApi => _isCallApi;

  set isCallApi(bool value) {
    _isCallApi = value;
    update();
  }

  List<SportEvents> _nflTodayEventsList = [];

  List<SportEvents> _mlbTodayEventsList = [];

  List<SportEvents> get mlbTodayEventsList => _mlbTodayEventsList;

  set mlbTodayEventsList(List<SportEvents> value) {
    _mlbTodayEventsList = value;
    update();
  }

  List<SportEvents> _nbaTomorrowEventsList = [];

  List<SportEvents> get nbaTomorrowEventsList => _nbaTomorrowEventsList;

  set nbaTomorrowEventsList(List<SportEvents> value) {
    _nbaTomorrowEventsList = value;
    update();
  }

  List<SportEvents> _ncaabTomorrowEventsList = [];

  List<SportEvents> get ncaabTomorrowEventsList => _ncaabTomorrowEventsList;

  set ncaabTomorrowEventsList(List<SportEvents> value) {
    _ncaabTomorrowEventsList = value;
    update();
  }

  List<SportEvents> _nflTomorrowEventsList = [];

  List<SportEvents> get nflTomorrowEventsList => _nflTomorrowEventsList;

  set nflTomorrowEventsList(List<SportEvents> value) {
    _nflTomorrowEventsList = value.toSet().toList();
    update();
  }

  List<SportEvents> _ncaaTodayEventsList = [];

  List<SportEvents> get ncaaTodayEventsList => _ncaaTodayEventsList;

  set ncaaTodayEventsList(List<SportEvents> value) {
    _ncaaTodayEventsList = value;
    update();
  }

  List<SportEvents> _ncaabTodayEventsList = [];

  List<SportEvents> get ncaabTodayEventsList => _ncaabTodayEventsList;

  set ncaabTodayEventsList(List<SportEvents> value) {
    _ncaabTodayEventsList = value;
    update();
  }

  List<SportEvents> _nbaTodayEventsList = [];

  List<SportEvents> get nbaTodayEventsList => _nbaTodayEventsList;

  set nbaTodayEventsList(List<SportEvents> value) {
    _nbaTodayEventsList = value;
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
  Future<List<SportEvents>> fetchListingData({String sportId = '',
    String date = "",
    String sportKey = "",
    int start = 0,
    bool isLoad = false,
    String key = ''}) async {
    ResponseItem result =
    ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo()
        .gameListingRepo(key: key, date: date, spotId: sportId, start: start);
    try {
      if (result.status) {
        GameListingDataModel response =
        GameListingDataModel.fromJson(result.data);
        final sportEvents = response.sportEvents;
        return sportEvents?.toSet().toList() ?? [];
      }
      isLoading.value = false;
      if (result.message == 'Error in response: No internet connection') {
        showAppSnackBar(
          result.message,
        );
      }
    } catch (e) {
      log('ERROR__------$e');
      showAppSnackBar(e.toString());
    }
    return [];
  }

  Future<void> getResponse(bool isLoad, String sportKey) async {
    date = DateFormat('yyyy-MM-dd')
        .format(DateTime.now() /*.subtract(const Duration(days: 2))*/);
    if (sportKey == SportName.MLB.name) {
      return await getGameListingForMLBRes(isLoad,
          apiKey: apiKey,
          sportKey: SportName.MLB.name,
          date: date,
          sportId: sportId);
    } else if (sportKey == SportName.NFL.name) {
      return await getGameListingForNFLGame(isLoad,
          apiKey: apiKey,
          sportKey: SportName.NFL.name,
          date: date,
          sportId: sportId);
    } else if (sportKey == SportName.NCAA.name) {
      return getGameListingForNCAAGame(isLoad,
          apiKey: apiKey, sportKey: sportKey, date: date, sportId: sportId);
    } else if (sportKey == SportName.NBA.name) {
      return getGameListingForNBARes(isLoad,
          apiKey: apiKey, sportKey: sportKey, date: date, sportId: sportId);
    } else if (sportKey == SportName.NCAAB.name) {
      return getGameListingForNCAABRes(isLoad,
          apiKey: apiKey, sportKey: sportKey, date: date, sportId: sportId);
    }
  }

  Future<void> getRefreshResponse(bool isLoad, String sportKey) async {
    if (sportKey == SportName.MLB.name) {
      return await mlbGameRefreshCall(isLoad,
          apiKey: apiKey,
          sportKey: SportName.MLB.name,
          date: date,
          sportId: sportId);
    } else if (sportKey == SportName.NFL.name) {
      return await nflGameRefreshCall(isLoad,
          apiKey: apiKey,
          sportKey: SportName.NFL.name,
          date: date,
          sportId: sportId);
    } else if (sportKey == SportName.NCAA.name) {
      return ncaaGameRefreshCall(isLoad,
          apiKey: apiKey, sportKey: sportKey, date: date, sportId: sportId);
    } else if (sportKey == SportName.NBA.name) {
      return nbaGameRefreshCall(isLoad,
          apiKey: apiKey, sportKey: sportKey, date: date, sportId: sportId);
    } else if (sportKey == SportName.NCAAB.name) {
      return ncaabGameRefreshCall(isLoad,
          apiKey: apiKey, sportKey: sportKey, date: date, sportId: sportId);
    }
  }

  searchData(String text, String sportKey, List<SportEvents> gameList) {
    searchList = [];
    searchList.clear();
    if (text.isNotEmpty) {
      for (var element in gameList) {
        if (((mobileView.size.shortestSide < 600
            ? element.homeTeamAbb
            : element.homeTeam)
            .toString()
            .toLowerCase()
            .contains(text.trim().toString().toLowerCase())) ||
            ((mobileView.size.shortestSide < 600
                ? element.awayTeamAbb
                : element.awayTeam)
                .toString()
                .toLowerCase()
                .contains(text.trim().toString().toLowerCase()))) {
          if (searchList.length > 3) {
            searchList.clear();
          }
          searchList.add(element);
        }
      }
    }
    update();
  }

  accountLogOut() {
    bool isDark = PreferenceManager.getIsDarkMode() ?? false;
    Get.changeThemeMode((PreferenceManager.getIsDarkMode() ?? false)
        ? ThemeMode.dark
        : ThemeMode.light);
    if (PreferenceManager.getLoginType() == 'google') {
      signOut();
    }
    Get.offAll(LogInScreen());
    PreferenceManager.clearData();
    PreferenceManager.setIsLogin(false);
    PreferenceManager.setIsOpenDialog(false);
    PreferenceManager.setIsDarkMod(isDark);
    PreferenceManager.setIsFirstLoaded(true);
    showAppSnackBar('Successfully logged out.', status: true);
  }

  favoriteGameCall() {
    sportId = ncaabSportId;
    sportKey = SportName.NCAAB.name;
    isSelected.add(SportName.NCAAB.name);
    isSelectedGame = SportName.NCAAB.name;
    Future.delayed(
      Duration.zero,
          () async {
        isPagination = true;
        isLoading.value = true;
        // Choose optimized method based on sport
        if (isSelectedGame == SportName.NCAAB.name) {
          await loadNCAABDataOptimized();
        } else if (isSelectedGame == SportName.MLB.name) {
          await loadMLBDataOptimized();
        }
      },
    );
  }
  
  /// Optimized method for loading NCAAB data
  Future<void> loadNCAABDataOptimized() async {
    try {
      // Cancel existing timer to prevent multiple refresh cycles
      if (timer != null) {
        timer!.cancel();
        timer = null;
      }
      
      // Show loading state
      isLoading.value = true;
      
      // Clear existing data before loading
      ncaabTodayEventsList = [];
      ncaabTomorrowEventsList = [];
      ncaabSportEventsList = [];
      
      // Load today's games first (most important data)
      final todayDate = DateFormat('yyyy/MM/dd').format(DateTime.now());
      log("Loading NCAAB games for date: $todayDate", name: "NCAAB");
      
      final ResponseItem result = await GameListingRepo().gameListingRepoNCAAB(
        date: todayDate,
        key: AppUrls.NCAAB_APIKEY
      );
      
      if (!result.status) {
        throw Exception(result.message);
      }
      
      // Parse the data
      if (result.data != null) {
        // Create a GameListingDataModel to parse the response
        final gameModel = GameListingDataModel.fromJson(result.data);
        
        if (gameModel.sportEvents != null && gameModel.sportEvents!.isNotEmpty) {
          // Process today's games
          for (var game in gameModel.sportEvents!) {
            final gameDate = DateTime.parse(game.scheduled ?? "").toLocal();
            final today = DateTime.now().toLocal();
            
            // Add to today's list if it's today's game
            if (gameDate.day == today.day && 
                gameDate.month == today.month && 
                gameDate.year == today.year) {
              ncaabTodayEventsList.add(game);
            } 
            // Add to tomorrow's list if it's tomorrow's game
            else if (gameDate.day == today.add(const Duration(days: 1)).day && 
                     gameDate.month == today.add(const Duration(days: 1)).month && 
                     gameDate.year == today.add(const Duration(days: 1)).year) {
              ncaabTomorrowEventsList.add(game);
            }
            
            // Add to the full list
            ncaabSportEventsList.add(game);
          }
        }
      }
      
      // Get all teams/players set up properly
      getAllEventList(SportName.NCAAB.name, true);
      
      // CRITICAL: Load conference data and assign to teams BEFORE ending the loading state
      await getConferenceNCAAB(false);
      
      // Load team logos in parallel
      gameListingsWithLogoResponseNCAAB(currentYear, SportName.NCAAB.name, isLoad: true);
      
      // Load rankings data - only do this after we have the game data
      if (ncaabSportEventsList.isNotEmpty) {
        // Remove await since ncaaGameRanking doesn't return a Future<void>
        ncaaGameRanking(
          sportName: SportName.NCAAB.name,
          isLoad: true,
          sportList: ncaabSportEventsList,
        );
      }
      
      // NOW update UI after conference data is loaded
      update();
      
      // Only turn off loading when conference data is fully processed
      isLoading.value = false;
      
      // Load box scores for today's games only
      if (ncaabTodayEventsList.isNotEmpty) {
        List<Future> boxScoreFutures = [];
        
        for (int i = 0; i < ncaabTodayEventsList.length; i++) {
          if (ncaabTodayEventsList[i].uuids != null) {
            boxScoreFutures.add(
              boxScoreNBAResponse(
                sportKey: SportName.NCAAB.name,
                homeTeamId: replaceId(ncaabTodayEventsList[i].competitors[0].uuids ?? '') ?? "",
                awayTeamId: replaceId(ncaabTodayEventsList[i].competitors[1].uuids ?? '') ?? "",
                gameId: replaceId(ncaabTodayEventsList[i].uuids ?? ''),
                index: i
              )
            );
          }
        }
        
        // Run box score requests in parallel (if possible)
        if (boxScoreFutures.isNotEmpty) {
          await Future.wait(boxScoreFutures);
        }
      }
      
      // Update after loading box scores
      update();
      isPagination = false;
      
      // Set up refresh timer for live games
      _setupOptimizedRefreshTimer();
      
      log("NCAAB data loaded successfully: ${ncaabSportEventsList.length} games", name: "NCAAB");
      
    } catch (e) {
      // Handle errors gracefully
      log("Error loading NCAAB data: $e", name: "NCAAB Error");
      isLoading.value = false;
      isPagination = false;
      showAppSnackBar("Error loading NCAAB data. Pull down to refresh.");
    }
  }
  
  /// Optimized method for loading MLB data from Sportradar API
  Future<void> loadMLBDataOptimized() async {
    try {
      // Cancel existing timer to prevent multiple refresh cycles
      if (timer != null) {
        timer!.cancel();
        timer = null;
      }
      
      // Show loading state
      isLoading.value = true;
      
      // Clear existing data before loading
      mlbTodayEventsList = [];
      mlbTomorrowEventsList = [];
      mlbSportEventsList = [];
      
      // Load today's games first (most important data)
      final todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
      log("Loading MLB games for date: $todayDate", name: "MLB");
      
      // Fetch MLB teams data first (only once)
      log("Fetching MLB team data...", name: "MLB");
      Map<String, MLBTeam> teamsMap = {};
      
      try {
        final teamsResult = await GameListingRepo().fetchMLBTeams();
        
        if (teamsResult.status && teamsResult.data != null) {
          final teamsResponse = MLBTeamsResponse.fromJson(teamsResult.data);
          if (teamsResponse.teams != null) {
            // Create a map of team id -> team data for quick lookup
            for (var team in teamsResponse.teams!) {
              teamsMap[team.id ?? ""] = team;
            }
            log("Loaded ${teamsMap.length} MLB teams", name: "MLB");
          }
        }
      } catch (e) {
        log("ERROR FETCHING MLB TEAMS: $e", name: "MLB");
        // Continue with empty teams map
      }
      
      // Fetch MLB venues data (only once)
      log("Fetching MLB venue data...", name: "MLB");
      Map<String, MLBVenue> venuesMap = {};
      
      try {
        final venuesResult = await GameListingRepo().fetchMLBVenues();
        
        if (venuesResult.status && venuesResult.data != null) {
          final venuesResponse = MLBVenuesResponse.fromJson(venuesResult.data);
          if (venuesResponse.venues != null) {
            // Create a map of venue id -> venue data for quick lookup
            for (var venue in venuesResponse.venues!) {
              venuesMap[venue.id ?? ""] = venue;
            }
            log("Loaded ${venuesMap.length} MLB venues", name: "MLB");
          }
        }
      } catch (e) {
        log("ERROR FETCHING MLB VENUES: $e", name: "MLB");
        // Continue with empty venues map
      }
      
      // MLB data uses the game listing API endpoint
      final ResponseItem result = await GameListingRepo().gameListingRepo(
        date: todayDate,
        spotId: mlbSportId,
        key: AppUrls.MLB_APIKEY
      );
      
      if (!result.status) {
        throw Exception(result.message);
      }
      
      // Parse the data
      if (result.data != null) {
        // Create a GameListingDataModel to parse the response
        final gameModel = GameListingDataModel.fromJson(result.data);
        
        if (gameModel.sportEvents != null && gameModel.sportEvents!.isNotEmpty) {
          // Process games and enhance with Sportradar API data
          final today = DateTime.now().toLocal();
          List<Future> gameSummaryFutures = [];
          
          for (var game in gameModel.sportEvents!) {
            final gameDate = DateTime.parse(game.scheduled ?? "").toLocal();
            
            // Add to today's list if it's today's game
            if (gameDate.day == today.day && 
                gameDate.month == today.month && 
                gameDate.year == today.year) {
              mlbTodayEventsList.add(game);
              
              // Enhance today's games with team and venue data
              if (game.uuids != null) {
                String gameId = replaceId(game.uuids ?? "") ?? "";
                if (gameId.isNotEmpty) {
                  // Add to list of futures to execute in parallel
                  gameSummaryFutures.add(_enhanceGameWithSportradarData(
                    game, 
                    gameId, 
                    teamsMap, 
                    venuesMap
                  ));
                }
              }
            } 
            // Add to tomorrow's list if it's tomorrow's game
            else if (gameDate.day == today.add(const Duration(days: 1)).day && 
                     gameDate.month == today.add(const Duration(days: 1)).month && 
                     gameDate.year == today.add(const Duration(days: 1)).year) {
              mlbTomorrowEventsList.add(game);
            }
            
            // Add to the full list
            mlbSportEventsList.add(game);
          }
          
          // Wait for all game summary futures to complete
          if (gameSummaryFutures.isNotEmpty) {
            try {
              await Future.wait(gameSummaryFutures);
              log("Sportradar data loaded successfully", name: "MLB");
            } catch (e) {
              // Continue even if some futures fail
              log("Error in game summary futures: $e", name: "MLB");
            }
          }
        }
      }
      
      // Get all teams/players set up properly
      getAllEventList(SportName.MLB.name, true);
      
      // Load MLB-specific data (commenting out until mlbInjuriesRepo is implemented)
      // TODO: Implement MLB injuries repo method
      // await mlbInjuriesRepo(false);
      
      // Load team logos in parallel
      gameListingsWithLogoResponse(currentYear, SportName.MLB.name, isLoad: true);
      
      // Load box scores for today's games only
      if (mlbTodayEventsList.isNotEmpty) {
        List<Future> boxScoreFutures = [];
        
        for (int i = 0; i < mlbTodayEventsList.length; i++) {
          if (mlbTodayEventsList[i].uuids != null) {
            boxScoreFutures.add(
              boxScoreResponse(
                homeTeamId: replaceId(mlbTodayEventsList[i].competitors[0].uuids ?? '') ?? "",
                awayTeamId: replaceId(mlbTodayEventsList[i].competitors[1].uuids ?? '') ?? "",
                gameId: replaceId(mlbTodayEventsList[i].uuids ?? ''),
                index: i
              )
            );
          }
        }
        
        // Run box score requests in parallel (if possible)
        if (boxScoreFutures.isNotEmpty) {
          await Future.wait(boxScoreFutures);
        }
      }
      
      // Ensure all games have team logos (final fallback)
      _ensureAllTeamsHaveLogos();
      
      // Setup refresh timer for live games
      _setupMLBRefreshTimer();
      
      // Update UI
      update();
      isLoading.value = false;
      isPagination = false;
      
      log("MLB data loaded successfully: ${mlbSportEventsList.length} games", name: "MLB");
      
    } catch (e) {
      log("MLB data loading error: $e", name: "MLB");
      isLoading.value = false;
      isPagination = false;
      showAppSnackBar("Failed to load MLB data: ${e.toString()}");
    }
  }
  
  /// Helper method to enhance a game with Sportradar API data
  Future<void> _enhanceGameWithSportradarData(
    SportEvents game, 
    String gameId, 
    Map<String, MLBTeam> teamsMap, 
    Map<String, MLBVenue> venuesMap
  ) async {
    try {
      // Check if this is a demo/test game ID
      if (gameId.isEmpty || gameId.startsWith("mlb-demo-")) {
        log("Using fallback game ID instead of: $gameId", name: "MLB");
        // Use a real MLB game ID - 2022 World Series Game 1 as fallback
        gameId = "b0c3ed35-0abf-45be-88b3-3822c5a5b5f0";
      }
      
      log("Game ID found: $gameId", name: "MLB");
      log("Attempting to fetch MLB game summary with ID: $gameId", name: "MLB");
      
      try {
        // Fetch detailed game summary data from Sportradar API
        final gameResult = await GameListingRepo().fetchMLBGameSummary(gameId);
        
        if (!gameResult.status) {
          log("Error fetching MLB game summary: ${gameResult.message}", name: "MLB");
          log("API Response: ${gameResult.data}", name: "MLB");
          return; // Skip this game and continue with others
        }
        
        if (gameResult.data == null) {
          log("No data returned for MLB game summary with ID: $gameId", name: "MLB");
          return; // Skip this game and continue with others
        }
        
        // Process the game data
        if (gameResult.status && gameResult.data != null) {
        try {
          final gameSummary = MLBGameSummaryResponse.fromJson(gameResult.data);
          
          if (gameSummary.game != null) {
          // Update team names with their proper names from the API
          if (gameSummary.game!.homeTeam != null) {
            String teamId = gameSummary.game!.homeTeam!.id ?? "";
            
            // Combine market and name for full team name (e.g., "Toronto Blue Jays")
            String fullName = "${gameSummary.game!.homeTeam!.market ?? ""} ${gameSummary.game!.homeTeam!.name ?? ""}".trim();
            game.homeTeam = fullName;
            
            // Use abbreviation from the Sportradar API
            game.homeTeamAbb = gameSummary.game!.homeTeam!.abbr ?? game.homeTeamAbb;
            
            // Update win/loss record if available
            if (gameSummary.game!.homeTeam!.win != null && gameSummary.game!.homeTeam!.loss != null) {
              game.homeTeamRecord = "${gameSummary.game!.homeTeam!.win}-${gameSummary.game!.homeTeam!.loss}";
            }
            
            // Look up team in our teams map to get additional data
            if (teamsMap.containsKey(teamId)) {
              // Get the team ID from the response
              String teamLogoId = gameSummary.game!.homeTeam!.id ?? "";
              if (teamLogoId.isNotEmpty) {
                // Extract the ID number without prefixes
                String idNumber = "";
                if (teamLogoId.contains(":")) {
                  idNumber = teamLogoId.split(":").last;
                } else {
                  idNumber = teamLogoId;
                }
                
                // Map to MLB team code
                String teamCode = _mapSportRadarIdToTeamCode(idNumber);
                // Use the official MLB static image URL  
                String officialLogoUrl = "https://www.mlbstatic.com/team-logos/team-cap-on-dark/$teamCode.svg";
                game.homeTeamLogo = officialLogoUrl;
                log("Set home team logo with official MLB URL: $officialLogoUrl", name: "MLB Logo");
              } else {
                // Fallback to ESPN logo URL format if team ID is missing
                String teamAbbr = gameSummary.game!.homeTeam!.abbr?.toUpperCase() ?? "";
                if (teamAbbr.isNotEmpty) {
                  // Clean up the abbreviation - remove any spaces and ensure lowercase
                  String cleanAbbr = teamAbbr.replaceAll(" ", "").toLowerCase();
                  String espnLogoUrl = "https://a.espncdn.com/i/teamlogos/mlb/500/$cleanAbbr.png";
                  game.homeTeamLogo = espnLogoUrl;
                  log("Set home team logo from ESPN fallback: $espnLogoUrl", name: "MLB Logo");
                }
              }
            }
          }
          
          if (gameSummary.game!.awayTeam != null) {
            String teamId = gameSummary.game!.awayTeam!.id ?? "";
            
            // Combine market and name for full team name
            String fullName = "${gameSummary.game!.awayTeam!.market ?? ""} ${gameSummary.game!.awayTeam!.name ?? ""}".trim();
            game.awayTeam = fullName;
            
            // Use abbreviation from the Sportradar API
            game.awayTeamAbb = gameSummary.game!.awayTeam!.abbr ?? game.awayTeamAbb;
            
            // Update win/loss record if available
            if (gameSummary.game!.awayTeam!.win != null && gameSummary.game!.awayTeam!.loss != null) {
              game.awayTeamRecord = "${gameSummary.game!.awayTeam!.win}-${gameSummary.game!.awayTeam!.loss}";
            }
            
            // Look up team in our teams map to get additional data
            if (teamsMap.containsKey(teamId)) {
              // Get the team ID from the response
              String teamLogoId = gameSummary.game!.awayTeam!.id ?? "";
              if (teamLogoId.isNotEmpty) {
                // Extract the ID number without prefixes
                String idNumber = "";
                if (teamLogoId.contains(":")) {
                  idNumber = teamLogoId.split(":").last;
                } else {
                  idNumber = teamLogoId;
                }
                
                // Map to MLB team code
                String teamCode = _mapSportRadarIdToTeamCode(idNumber);
                // Use the official MLB static image URL
                String officialLogoUrl = "https://www.mlbstatic.com/team-logos/team-cap-on-dark/$teamCode.svg";
                game.awayTeamLogo = officialLogoUrl;
                log("Set away team logo with official MLB URL: $officialLogoUrl", name: "MLB Logo");
              } else {
                // Fallback to ESPN logo URL format if team ID is missing
                String teamAbbr = gameSummary.game!.awayTeam!.abbr?.toUpperCase() ?? "";
                if (teamAbbr.isNotEmpty) {
                  // Clean up the abbreviation - remove any spaces and ensure lowercase
                  String cleanAbbr = teamAbbr.replaceAll(" ", "").toLowerCase();
                  String espnLogoUrl = "https://a.espncdn.com/i/teamlogos/mlb/500/$cleanAbbr.png";
                  game.awayTeamLogo = espnLogoUrl;
                  log("Set away team logo from ESPN fallback: $espnLogoUrl", name: "MLB Logo");
                }
              }
            }
          }
          
          // Update venue information
          if (gameSummary.game!.venue != null) {
            String venueId = gameSummary.game!.venue!.id ?? "";
            
            // Update venue information
            game.venue = game_listing.Venue(
              name: gameSummary.game!.venue!.name,
              cityName: gameSummary.game!.venue!.city,
              countryName: gameSummary.game!.venue!.state, // Use countryName for state
            );
            
            // If we have detailed venue info from the venues API, use that
            if (venuesMap.containsKey(venueId)) {
              MLBVenue venue = venuesMap[venueId]!;
              
              // If the venue has location data, use it to fetch weather
              if (venue.location != null && 
                  venue.location!.lat != null && 
                  venue.location!.lng != null) {
                
                // Fetch weather data using venue coordinates
                try {
                  double lat = venue.location!.lat!;
                  double lng = venue.location!.lng!;
                  
                  // Ensure lat and lng are actually doubles
                  if (lat is! double) {
                    lat = double.tryParse(lat.toString()) ?? 0.0;
                  }
                  if (lng is! double) {
                    lng = double.tryParse(lng.toString()) ?? 0.0;
                  }
                  
                  // Only fetch weather if we have valid coordinates
                  if (lat != 0.0 && lng != 0.0) {
                    await _updateGameWithWeatherData(game, lat, lng);
                  }
                } catch (e) {
                  log("Error processing venue coordinates: $e", name: "MLB");
                }
              }
            }
          }
          
          // Update game status and timing information
          if (gameSummary.game!.status != null) {
            // Update game status if needed
            if (gameSummary.game!.status == "inprogress" || gameSummary.game!.status == "live") {
              game.status = GameStatus.inprogress.name;
            } else if (gameSummary.game!.status == "closed" || gameSummary.game!.status == "complete") {
              game.status = GameStatus.closed.name;
            } else if (gameSummary.game!.status == "scheduled") {
              game.status = GameStatus.upcoming.name;
            }
          }
        }
        } catch (e) {
          log("Error parsing game summary data: $e", name: "MLB");
        }
      }
      } catch (e) {
        log("ERROR FETCHING MLB GAME SUMMARY: $e", name: "MLB");
      }
    } catch (e) {
      log("Error enhancing game with Sportradar data: $e", name: "MLB");
      // Don't throw, just log the error - we'll still have the basic game data
    }
  }
  
  /// Helper method to update a game with weather data
  Future<void> _updateGameWithWeatherData(
    SportEvents game,
    double lat,
    double lng
  ) async {
    try {
      // Format coordinates with 4 decimal places
      String latStr = lat.toStringAsFixed(4);
      String lngStr = lng.toStringAsFixed(4);
      
      // Call weather API using coordinates
      log("Fetching weather for coordinates: $latStr,$lngStr", name: "MLB Weather");
      final ResponseItem result = await GameListingRepo().getWeather("$latStr,$lngStr");
      
      if (result.status && result.data != null) {
        final weather = result.data;
        
        // Extract temperature (convert from Kelvin to Fahrenheit)
        if (weather['main'] != null && weather['main']['temp'] != null) {
          double kelvin = weather['main']['temp'].toDouble();
          // Store as Kelvin in the model
          game.temp = kelvin;
        }
        
        // Extract weather condition code
        if (weather['weather'] != null && weather['weather'].isNotEmpty) {
          int code = weather['weather'][0]['id'];
          game.weather = code;
        }
      }
    } catch (e) {
      log("Error fetching weather data: $e", name: "MLB");
      // Don't throw, just log the error - weather is optional
    }
  }
  
  void _setupMLBRefreshTimer() {
    // Cancel any existing timer first to prevent multiple timers
    if (timer != null) {
      timer!.cancel();
      timer = null;
    }
    
    // Only set up refresh timer for today's games that are in progress
    if (mlbTodayEventsList.isNotEmpty) {
      // Check if any game is live/in progress
      bool hasLiveGames = mlbTodayEventsList.any(
        (game) => game.status == GameStatus.live.name || 
                 game.status == GameStatus.inprogress.name
      );
      
      // Only refresh if there are live games
      if (hasLiveGames) {
        log("Setting up timer for live MLB games refresh", name: "MLB");
        timer = Timer.periodic(const Duration(seconds: 60), (t) {
          log("Timer triggered: refreshing live MLB games", name: "MLB");
          _refreshLiveMLBGames();
        });
      }
    }
  }
  
  /// Helper method to ensure all MLB teams have logo URLs
  void _ensureAllTeamsHaveLogos() {
    log("Ensuring all MLB teams have logos", name: "MLB Logo");
    
    // Mapping of team IDs to official MLB static URLs
    Map<String, String> mlbTeamIdMap = {
      '575': 'https://www.mlbstatic.com/team-logos/team-cap-on-dark/575.svg', // Diamondbacks (ARI)
      '144': 'https://www.mlbstatic.com/team-logos/team-cap-on-dark/144.svg', // Braves (ATL)
      '110': 'https://www.mlbstatic.com/team-logos/team-cap-on-dark/110.svg', // Orioles (BAL)
      '111': 'https://www.mlbstatic.com/team-logos/team-cap-on-dark/111.svg', // Red Sox (BOS)
      '112': 'https://www.mlbstatic.com/team-logos/team-cap-on-dark/112.svg', // Cubs (CHC)
      '113': 'https://www.mlbstatic.com/team-logos/team-cap-on-dark/113.svg', // Reds (CIN)
      '114': 'https://www.mlbstatic.com/team-logos/team-cap-on-dark/114.svg', // Guardians (CLE)
      '115': 'https://www.mlbstatic.com/team-logos/team-cap-on-dark/115.svg', // Rockies (COL)
      '116': 'https://www.mlbstatic.com/team-logos/team-cap-on-dark/116.svg', // Tigers (DET)
      '117': 'https://www.mlbstatic.com/team-logos/team-cap-on-dark/117.svg', // Astros (HOU)
      '118': 'https://www.mlbstatic.com/team-logos/team-cap-on-dark/118.svg', // Royals (KC)
      '119': 'https://www.mlbstatic.com/team-logos/team-cap-on-dark/119.svg', // Angels (LAA)
      '158': 'https://www.mlbstatic.com/team-logos/team-cap-on-dark/158.svg', // Brewers (MIL)
      '142': 'https://www.mlbstatic.com/team-logos/team-cap-on-dark/142.svg', // Twins (MIN)
      '121': 'https://www.mlbstatic.com/team-logos/team-cap-on-dark/121.svg', // Mets (NYM)
      '147': 'https://www.mlbstatic.com/team-logos/team-cap-on-dark/147.svg', // Yankees (NYY)
      '133': 'https://www.mlbstatic.com/team-logos/team-cap-on-dark/133.svg', // Athletics (OAK)
      '143': 'https://www.mlbstatic.com/team-logos/team-cap-on-dark/143.svg', // Phillies (PHI)
      '134': 'https://www.mlbstatic.com/team-logos/team-cap-on-dark/134.svg', // Pirates (PIT)
      '135': 'https://www.mlbstatic.com/team-logos/team-cap-on-dark/135.svg', // Padres (SD)
      '137': 'https://www.mlbstatic.com/team-logos/team-cap-on-dark/137.svg', // Giants (SF)
      '136': 'https://www.mlbstatic.com/team-logos/team-cap-on-dark/136.svg', // Mariners (SEA)
      '138': 'https://www.mlbstatic.com/team-logos/team-cap-on-dark/138.svg', // Cardinals (STL)
      '139': 'https://www.mlbstatic.com/team-logos/team-cap-on-dark/139.svg', // Rays (TB)
      '140': 'https://www.mlbstatic.com/team-logos/team-cap-on-dark/140.svg', // Rangers (TEX)
      '141': 'https://www.mlbstatic.com/team-logos/team-cap-on-dark/141.svg', // Blue Jays (TOR)
      '120': 'https://www.mlbstatic.com/team-logos/team-cap-on-dark/120.svg', // Nationals (WSH)
      '146': 'https://www.mlbstatic.com/team-logos/team-cap-on-dark/146.svg', // Marlins (MIA)
      '145': 'https://www.mlbstatic.com/team-logos/team-cap-on-dark/145.svg', // White Sox (CHW)
      '108': 'https://www.mlbstatic.com/team-logos/team-cap-on-dark/108.svg', // Dodgers (LAD)
    };
    
    // Fallback mapping of team abbreviations to ESPN logos (as backup)
    Map<String, String> mlbTeamAbbrevMap = {
      'ari': 'https://a.espncdn.com/i/teamlogos/mlb/500/ari.png', // Diamondbacks
      'atl': 'https://a.espncdn.com/i/teamlogos/mlb/500/atl.png', // Braves
      'bal': 'https://a.espncdn.com/i/teamlogos/mlb/500/bal.png', // Orioles
      'bos': 'https://a.espncdn.com/i/teamlogos/mlb/500/bos.png', // Red Sox
      'chc': 'https://a.espncdn.com/i/teamlogos/mlb/500/chc.png', // Cubs
      'cin': 'https://a.espncdn.com/i/teamlogos/mlb/500/cin.png', // Reds
      'cle': 'https://a.espncdn.com/i/teamlogos/mlb/500/cle.png', // Guardians
      'col': 'https://a.espncdn.com/i/teamlogos/mlb/500/col.png', // Rockies
      'det': 'https://a.espncdn.com/i/teamlogos/mlb/500/det.png', // Tigers
      'hou': 'https://a.espncdn.com/i/teamlogos/mlb/500/hou.png', // Astros
      'kc':  'https://a.espncdn.com/i/teamlogos/mlb/500/kc.png',  // Royals
      'laa': 'https://a.espncdn.com/i/teamlogos/mlb/500/laa.png', // Angels
      'mil': 'https://a.espncdn.com/i/teamlogos/mlb/500/mil.png', // Brewers
      'min': 'https://a.espncdn.com/i/teamlogos/mlb/500/min.png', // Twins
      'nym': 'https://a.espncdn.com/i/teamlogos/mlb/500/nym.png', // Mets
      'nyy': 'https://a.espncdn.com/i/teamlogos/mlb/500/nyy.png', // Yankees
      'oak': 'https://a.espncdn.com/i/teamlogos/mlb/500/oak.png', // Athletics
      'phi': 'https://a.espncdn.com/i/teamlogos/mlb/500/phi.png', // Phillies
      'pit': 'https://a.espncdn.com/i/teamlogos/mlb/500/pit.png', // Pirates
      'sd':  'https://a.espncdn.com/i/teamlogos/mlb/500/sd.png',  // Padres
      'sf':  'https://a.espncdn.com/i/teamlogos/mlb/500/sf.png',  // Giants
      'sea': 'https://a.espncdn.com/i/teamlogos/mlb/500/sea.png', // Mariners
      'stl': 'https://a.espncdn.com/i/teamlogos/mlb/500/stl.png', // Cardinals
      'tb':  'https://a.espncdn.com/i/teamlogos/mlb/500/tb.png',  // Rays
      'tex': 'https://a.espncdn.com/i/teamlogos/mlb/500/tex.png', // Rangers
      'tor': 'https://a.espncdn.com/i/teamlogos/mlb/500/tor.png', // Blue Jays
      'wsh': 'https://a.espncdn.com/i/teamlogos/mlb/500/wsh.png', // Nationals
      'mia': 'https://a.espncdn.com/i/teamlogos/mlb/500/mia.png', // Marlins
      'chw': 'https://a.espncdn.com/i/teamlogos/mlb/500/chw.png', // White Sox
      'lad': 'https://a.espncdn.com/i/teamlogos/mlb/500/lad.png', // Dodgers
    };
    
    // Process all games in the list
    for (var game in mlbSportEventsList) {
      // Check and set home team logo
      if (game.homeGameLogo == null || game.homeGameLogo!.isEmpty) {
        // Try to get team abbreviation from various sources
        String homeTeamAbbr = "";
        
        // Try from competitors list
        for (var competitor in game.competitors) {
          if (competitor.qualifier == "home" && competitor.abbreviation != null) {
            homeTeamAbbr = competitor.abbreviation!;
            break;
          }
        }
        
        // If still empty, try from the team abbreviation property
        if (homeTeamAbbr.isEmpty && game.homeTeamAbb.isNotEmpty) {
          homeTeamAbbr = game.homeTeamAbb;
        }
        
        // If we have an abbreviation, set the logo URL
        if (homeTeamAbbr.isNotEmpty) {
          // Ensure it's normalized (no spaces, lowercase)
          homeTeamAbbr = homeTeamAbbr.trim().toLowerCase();
          
          // Try to get team ID from competitors
          String teamId = "";
          for (var competitor in game.competitors) {
            if (competitor.qualifier == "home" && competitor.id != null) {
              teamId = competitor.id!;
              break;
            }
          }
          
          // First try the official MLB static image (by ID)
          if (teamId.isNotEmpty) {
            // Extract the ID number without prefixes
            String idNumber = "";
            if (teamId.contains(":")) {
              idNumber = teamId.split(":").last;
            } else {
              idNumber = teamId;
            }
            
            // Map to MLB team code 
            String teamCode = _mapSportRadarIdToTeamCode(idNumber);
            String officialLogoUrl = "https://www.mlbstatic.com/team-logos/team-cap-on-dark/$teamCode.svg";
            game.homeTeamLogo = officialLogoUrl;
            log("Fallback: Set home logo by ID for ${game.homeTeam}: $officialLogoUrl", name: "MLB Logo");
          }
          // Then try our ID mapping
          else if (teamId.isNotEmpty && mlbTeamIdMap.containsKey(teamId)) {
            game.homeTeamLogo = mlbTeamIdMap[teamId];
            log("Fallback: Set home logo from ID map for ${game.homeTeam}: ${mlbTeamIdMap[teamId]}", name: "MLB Logo");
          }
          // Then try our abbreviation mapping
          else if (mlbTeamAbbrevMap.containsKey(homeTeamAbbr)) {
            game.homeTeamLogo = mlbTeamAbbrevMap[homeTeamAbbr];
            log("Fallback: Set home logo from abbrev map for ${game.homeTeam}: ${mlbTeamAbbrevMap[homeTeamAbbr]}", name: "MLB Logo");
          } 
          // Default to ESPN URL pattern
          else {
            String espnLogoUrl = "https://a.espncdn.com/i/teamlogos/mlb/500/$homeTeamAbbr.png";
            game.homeTeamLogo = espnLogoUrl;
            log("Fallback: Set home logo by pattern for ${game.homeTeam}: $espnLogoUrl", name: "MLB Logo");
          }
        } else {
          // Last resort - use a generic baseball logo
          game.homeTeamLogo = "https://a.espncdn.com/i/teamlogos/leagues/500/mlb.png";
          log("Using generic MLB logo for home team ${game.homeTeam}", name: "MLB Logo");
        }
      }
      
      // Check and set away team logo
      if (game.awayGameLogo == null || game.awayGameLogo!.isEmpty) {
        // Try to get team abbreviation from various sources
        String awayTeamAbbr = "";
        
        // Try from competitors list
        for (var competitor in game.competitors) {
          if (competitor.qualifier == "away" && competitor.abbreviation != null) {
            awayTeamAbbr = competitor.abbreviation!;
            break;
          }
        }
        
        // If still empty, try from the team abbreviation property
        if (awayTeamAbbr.isEmpty && game.awayTeamAbb.isNotEmpty) {
          awayTeamAbbr = game.awayTeamAbb;
        }
        
        // If we have an abbreviation, set the logo URL
        if (awayTeamAbbr.isNotEmpty) {
          // Ensure it's normalized (no spaces, lowercase)
          awayTeamAbbr = awayTeamAbbr.trim().toLowerCase();
          
          // Try to get team ID from competitors
          String teamId = "";
          for (var competitor in game.competitors) {
            if (competitor.qualifier == "away" && competitor.id != null) {
              teamId = competitor.id!;
              break;
            }
          }
          
          // First try the official MLB static image (by ID)
          if (teamId.isNotEmpty) {
            // Extract the ID number without prefixes
            String idNumber = "";
            if (teamId.contains(":")) {
              idNumber = teamId.split(":").last;
            } else {
              idNumber = teamId;
            }
            
            // Map to MLB team code 
            String teamCode = _mapSportRadarIdToTeamCode(idNumber);
            String officialLogoUrl = "https://www.mlbstatic.com/team-logos/team-cap-on-dark/$teamCode.svg";
            game.awayTeamLogo = officialLogoUrl;
            log("Fallback: Set away logo by ID for ${game.awayTeam}: $officialLogoUrl", name: "MLB Logo");
          }
          // Then try our ID mapping
          else if (teamId.isNotEmpty && mlbTeamIdMap.containsKey(teamId)) {
            game.awayTeamLogo = mlbTeamIdMap[teamId];
            log("Fallback: Set away logo from ID map for ${game.awayTeam}: ${mlbTeamIdMap[teamId]}", name: "MLB Logo");
          }
          // Then try our abbreviation mapping
          else if (mlbTeamAbbrevMap.containsKey(awayTeamAbbr)) {
            game.awayTeamLogo = mlbTeamAbbrevMap[awayTeamAbbr];
            log("Fallback: Set away logo from abbrev map for ${game.awayTeam}: ${mlbTeamAbbrevMap[awayTeamAbbr]}", name: "MLB Logo");
          } 
          // Default to ESPN URL pattern
          else {
            String espnLogoUrl = "https://a.espncdn.com/i/teamlogos/mlb/500/$awayTeamAbbr.png";
            game.awayTeamLogo = espnLogoUrl;
            log("Fallback: Set away logo by pattern for ${game.awayTeam}: $espnLogoUrl", name: "MLB Logo");
          }
        } else {
          // Last resort - use a generic baseball logo
          game.awayTeamLogo = "https://a.espncdn.com/i/teamlogos/leagues/500/mlb.png";
          log("Using generic MLB logo for away team ${game.awayTeam}", name: "MLB Logo");
        }
      }
    }
  }
  
  /// Maps Sportradar team IDs to MLB team codes used in the MLB static site
  String _mapSportRadarIdToTeamCode(String sportRadarId) {
    // Mapping between Sportradar IDs and MLB team codes
    Map<String, String> teamCodeMap = {
      // American League East
      "67112": "nyy", // Yankees
      "67108": "bos", // Red Sox
      "67106": "tor", // Blue Jays
      "67110": "tb",  // Rays
      "67109": "bal", // Orioles
      
      // American League Central
      "67113": "cle", // Cleveland
      "67117": "min", // Twins
      "67114": "kc",  // Royals
      "67122": "chw", // White Sox
      "67111": "det", // Tigers
      
      // American League West
      "67116": "hou", // Astros
      "67119": "tex", // Rangers
      "67120": "sea", // Mariners
      "67121": "laa", // Angels
      "67118": "oak", // Athletics
      
      // National League East
      "67129": "atl", // Braves
      "67124": "phi", // Phillies
      "67123": "nym", // Mets
      "67125": "was", // Nationals
      "67130": "mia", // Marlins
      
      // National League Central
      "67127": "stl", // Cardinals
      "67128": "mil", // Brewers
      "67133": "chc", // Cubs
      "67131": "cin", // Reds
      "67126": "pit", // Pirates
      
      // National League West
      "67132": "lad", // Dodgers
      "67134": "sd",  // Padres
      "67135": "sf",  // Giants
      "67136": "ari", // Diamondbacks
      "67137": "col", // Rockies
    };
    
    // Return the MLB team code if we have a mapping, otherwise use the ID as is
    return teamCodeMap[sportRadarId] ?? sportRadarId;
  }
  
  void _refreshLiveMLBGames() async {
    try {
      // Get fresh data for live games
      for (var game in mlbTodayEventsList) {
        if (game.status == GameStatus.live.name || 
            game.status == GameStatus.inprogress.name) {
          // Refresh box score data for this game
          if (game.id != null && game.uuids != null) {
            await boxScoreResponse(
              gameId: replaceId(game.uuids ?? ""),
              homeTeamId: replaceId(game.competitors[0].uuids ?? ''),
              awayTeamId: replaceId(game.competitors[1].uuids ?? ''),
              index: mlbSportEventsList.indexWhere((element) => element.id == game.id)
            );
          }
        }
      }
      
      // Ensure all refreshed games have logos
      _ensureAllTeamsHaveLogos();
      
      // Update the UI with fresh data
      update();
    } catch (e) {
      log("Error refreshing MLB games: $e", name: "MLB");
    }
  }

  /// NCAAB refresh timer setup
  void _setupOptimizedRefreshTimer() {
    // Cancel any existing timer first to prevent multiple timers
    if (timer != null) {
      timer!.cancel();
      timer = null;
    }
    
    // Only set up refresh timer for today's games that are in progress
    if (ncaabTodayEventsList.isNotEmpty) {
      // Check if any game is live/in progress
      bool hasLiveGames = ncaabTodayEventsList.any(
        (game) => game.status == GameStatus.live.name || 
                 game.status == GameStatus.inprogress.name || 
                 game.status == GameStatus.halftime.name
      );
      
      // Only refresh if there are live games
      if (hasLiveGames) {
        log("Setting up timer for live NCAAB games refresh", name: "NCAAB");
        // Use a longer refresh interval (120 seconds) to reduce API load
        timer = Timer.periodic(const Duration(seconds: 120), (t) {
          log("Timer triggered: refreshing live NCAAB games", name: "NCAAB");
          _refreshLiveNCAABGames();
        });
      } else {
        log("No live NCAAB games found, not setting up timer", name: "NCAAB");
      }
    }
  }
  
  void _refreshLiveNCAABGames() async {
    try {
      // Only fetch data for live games to reduce API calls
      for (final game in ncaabTodayEventsList.where((game) => 
          game.status == GameStatus.live.name || 
          game.status == GameStatus.inprogress.name || 
          game.status == GameStatus.halftime.name)) {
            
        if (game.uuids != null) {
          // Only fetch box score for live games
          await boxScoreNBAResponse(
            sportKey: SportName.NCAAB.name,
            homeTeamId: replaceId(game.competitors[0].uuids ?? '') ?? "",
            awayTeamId: replaceId(game.competitors[1].uuids ?? '') ?? "",
            gameId: replaceId(game.uuids ?? ''),
            index: ncaabSportEventsList.indexWhere((e) => e.id == game.id)
          );
        }
      }
      
      update();
    } catch (e) {
      log("Error refreshing NCAAB live games: $e");
      // Don't show error to user during background refresh
    }
  }

  tabClick(BuildContext context, int index) {
    searchCon.clear();
    searchList.clear();
    
    // Ensure index is valid
    if (index < 0 || index >= sportsLeagueList.length) {
      log("Invalid index: $index. Using default (0)");
      index = 0; // Default to first sport (NCAAB)
    }
    
    isSelectedGame = sportsLeagueList[index].gameName;
    date = sportsLeagueList[index].date;
    sportKey = sportsLeagueList[index].key;
    apiKey = sportsLeagueList[index].apiKey;
    sportId = sportsLeagueList[index].sportId;
    
    log("Selected sport: ${sportsLeagueList[index].gameName} with key ${sportsLeagueList[index].key}");
    
    if (isSelected.contains(sportsLeagueList[index].gameName)) {
      // Sport already loaded, just update UI
      update();
    } else {
      isSelected.add(sportsLeagueList[index].gameName);
      Future.delayed(const Duration(seconds: 0), () async {
        isLoading.value = true;
        isPagination = true;
        
        // Use optimized method for NCAAB
        if (sportsLeagueList[index].key == SportName.NCAAB.name) {
          await loadNCAABDataOptimized();
        } 
        // Special handling for MLB
        else if (sportsLeagueList[index].key == SportName.MLB.name) {
          log("Loading MLB data with Sportradar API integration...");
          await loadMLBDataOptimized();
        }
        else {
          await getResponse(true, sportsLeagueList[index].key);
        }
      });
    }
    update();
  }

  gameOnClick(BuildContext context, SportEvents gameDetails) {
    toggle = 0;
    FocusScope.of(context).unfocus();
    searchCon.clear();
    if ((PreferenceManager.getIsOpenDialog() == null) &&
        ((PreferenceManager.getSubscriptionActive() ?? "1") == "0")) {
      PreferenceManager.setIsOpenDialog(true);
    } else {
      PreferenceManager.setIsOpenDialog(false);
    }
    Get.to(SportDetailsScreen(
      gameDetails: gameDetails,
      sportKey: sportKey,
      sportId: sportId,
      date: date,
    ));
    update();
  }

  Future<void> getSubscriptionStatus() async {
    // isLoading.value = true;
    ResponseItem result = Platform.isIOS
        ? await SubscriptionRepo.getReceiptStatus()
        : await SubscriptionRepo.getGoogleCloudStatus();
    try {
      if (result.status) {
        if (result.data != null) {
          UserData subscriptionModel = UserData.fromJson(result.data);
          PreferenceManager().saveSubscription(subscriptionModel);
          update();
        }
      } else {
        // showAppSnackBar(result.message);
      }
    } catch (e) {
      showAppSnackBar(e.toString());
      debugPrint(e.toString());
    }
    // isLoading.value = false;
    update();
  }

  searchGameOnClick(BuildContext context, SportEvents gameDetails) {
    toggle = 0;
    FocusScope.of(context).unfocus();
    if ((PreferenceManager.getIsOpenDialog() == null) &&
        ((PreferenceManager.getSubscriptionActive() ?? "1") == "0")) {
      PreferenceManager.setIsOpenDialog(true);
    } else {
      PreferenceManager.setIsOpenDialog(false);
    }
    Get.to(SportDetailsScreen(
      gameDetails: gameDetails,
      sportKey: sportKey,
      sportId: sportId,
      date: date,
    ));
    searchCon.clear();
    searchCon.text = '';
    update();
  }

  static Future<bool> signOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      await googleSignIn.signOut();
      return true;
    } catch (e) {
      showAppSnackBar('logOutErrorMsg'.tr);
    }
    return false;
  }

  void logOut(BuildContext context) async {
    isLoading.value = true;
    ResponseItem result =
    ResponseItem(data: null, message: errorText.tr, status: false);
    result = await UserStartupRepo().logOutApp();
    try {
      if (result.status) {
        log('RESPONSE--${result.status}');
        ForgotPasswordResModel response =
        ForgotPasswordResModel.fromJson(result.toJson());
        bool isDark = PreferenceManager.getIsDarkMode() ?? false;
        Get.changeThemeMode((PreferenceManager.getIsDarkMode() ?? false)
            ? ThemeMode.dark
            : ThemeMode.light);
        if (PreferenceManager.getLoginType() == 'google') {
          await signOut();
        }
        Get.offAll(LogInScreen());
        PreferenceManager.clearData();
        PreferenceManager.setIsLogin(false);
        PreferenceManager.setIsDarkMod(isDark);
        PreferenceManager.setIsFirstLoaded(true);
        showAppSnackBar(response.msg, status: true);
        isLoading.value = false;
      } else {
        isLoading.value = false;
        showAppSnackBar(result.message);
      }
    } catch (e) {
      isLoading.value = false;
      showAppSnackBar(e.toString());
    }
    update();
  }

  void deleteAc(BuildContext context) async {
    isLoading.value = true;
    ResponseItem result =
    ResponseItem(data: null, message: errorText.tr, status: false);
    result = await UserStartupRepo().deleteAc();
    try {
      if (result.status) {
        log('RESPONSE--${result.status}');
        ForgotPasswordResModel response =
        ForgotPasswordResModel.fromJson(result.toJson());
        bool isDark = PreferenceManager.getIsDarkMode() ?? false;
        Get.changeThemeMode((PreferenceManager.getIsDarkMode() ?? false)
            ? ThemeMode.dark
            : ThemeMode.light);
        if (PreferenceManager.getLoginType() == 'google') {
          signOut();
        }
        Get.offAll(LogInScreen());
        PreferenceManager.clearData();
        PreferenceManager.setIsLogin(false);
        PreferenceManager.setIsDarkMod(isDark);
        showAppSnackBar(response.msg, status: true);
        isLoading.value = false;
      } else {
        isLoading.value = false;
        showAppSnackBar(result.message);
      }
    } catch (e) {
      isLoading.value = false;
      showAppSnackBar(e.toString());
    }
    update();
  }

  void launchEmailSubmission() async {
    final Uri params = Uri(
        scheme: 'mailto',
        path: 'casey@hotlinesmd.com',
        queryParameters: {'subject': '', 'body': ''});
    String url = params.toString();
    launchInBrowser(Uri.parse(url));
  }

  gameListingTodayApiRes({String sportId = '',
    String date = "",
    String sportKey = "",
    int start = 0,
    bool isLoad = false,
    String key = ''}) async {
    isLoading.value = isLoad;
    int pageIndex = 0;
    for (int i = 0; i <= pageIndex; i++) {
      await fetchListingData(
          start: i * 100,
          key: key,
          date: date,
          isLoad: isLoad,
          sportKey: sportKey,
          sportId: sportId)
          .then((value) {
        if (value.isNotEmpty) {
          if (value.length >= 95) {
            pageIndex++;
          }
          final sportEvents = value;
          for (var event in sportEvents) {
            DateTime time = (DateTime.parse(event.scheduled ?? ''));
            var difference =
            (time.toUtc().difference((DateTime.now().toUtc())));
              if ((mlbGameSeasonId.contains(event.season?.id.toString())) &&
                sportKey == SportName.MLB.name &&
                (difference.inHours >= (-6)) &&
                (event.status != GameStatus.closed.name)) {
              if (mlbTodayEventsList.contains(event)) {} else {
                mlbTodayEventsList.add(event);
              }
            } else if (event.season?.id == 'sr:season:115087' &&
                sportKey ==
                    SportName.NFL.name &&
                (difference.inHours >= (-6))
                &&
                (event.status != GameStatus.closed.name)
            ) {
              if (nflTodayEventsList
                  .indexWhere((element) => element.id == event.id) !=
                  -1) {} else {
                nflTodayEventsList.add(event);
              }
            } else if ((event.season?.id == 'sr:season:101983' ||
                event.season?.id == "sr:season:101811") &&
                sportKey == SportName.NCAA.name &&
                (difference.inHours >= (-6)) &&
                (event.status != GameStatus.closed.name)) {
              if (ncaaTodayEventsList
                  .indexWhere((element) => element.id == event.id) !=
                  -1) {} else {
                ncaaTodayEventsList.add(event);
              }
            } else if (((ncaabGameSeasonId.contains(event.season?.id.toString())) &&
                sportKey == SportName.NCAAB.name &&
                (difference.inHours >= (-6)) &&
                (event.status != GameStatus.closed.name))) {
              if (ncaabTodayEventsList
                  .indexWhere((element) => element.id == event.id) !=
                  -1) {} else {
                ncaabTodayEventsList.add(event);
              }
            } else if (event.season?.id == 'sr:season:106289' &&
                sportKey == SportName.NBA.name &&
                (difference.inHours >= (-6)) &&
                (event.status != GameStatus.closed.name)) {
              if (nbaTodayEventsList.contains(event)) {} else {
                nbaTodayEventsList.add(event);
              }
            }
          }
          (getTodayList(sportKey)).sort((a, b) =>
              DateTime.parse(a.scheduled ?? "")
                  .compareTo(DateTime.parse(b.scheduled ?? "")));
        }
      });
    }
    update();
    return getTodayList(sportKey);
  }

  gameListingTomorrowApiRes({String sportId = '',
    String date = "",
    String sportKey = "",
    int start = 0,
    bool isLoad = false,
    String key = ''}) async {
    isPagination = isLoad;
    isLoading.value = false;
    int pageIndex = 0;
    for (int i = 0; i <= pageIndex; i++) {
      await fetchListingData(
          start: i * 100,
          key: key,
          date: date,
          isLoad: isLoad,
          sportKey: sportKey,
          sportId: sportId)
          .then((List<SportEvents> value) {
        if (value.isNotEmpty) {
          if (value.length >= 95) {
            pageIndex++;
          }
          List<SportEvents> sportEvents = value.toSet().toList();
          for (var event in sportEvents.toSet()) {
            DateTime time = (DateTime.parse(event.scheduled ?? ''));
            var difference =
            (time.toUtc().difference((DateTime.now().toUtc())));
            if ((mlbGameSeasonId.contains(event.season?.id.toString())) &&
                sportKey == SportName.MLB.name &&
                DateTime
                    .parse(event.scheduled ?? '')
                    .toLocal()
                    .day !=
                    DateTime
                        .now()
                        .add(const Duration(days: 1))
                        .toLocal()
                        .day) {
              if (mlbTomorrowEventsList.contains(event)) {} else {
                mlbTomorrowEventsList.add(event);
              }
            } else if (event.season?.id == 'sr:season:115087' &&
                sportKey == SportName.NFL.name) {
              if (nflSportEventsList
                  .indexWhere((element) => element.id == event.id) !=
                  -1) {} else {
                if (nflTomorrowEventsList.contains(event)) {} else {
                  nflTomorrowEventsList.add(event);
                }
              }
            } else if ((event.season?.id == 'sr:season:101983' ||
                (event.season?.id == 'sr:season:101811')) &&
                sportKey == SportName.NCAA.name) {
              if (ncaaTomorrowEventsList.contains(event)) {} else {
                ncaaTomorrowEventsList.add(event);
              }
            } else if (ncaabGameSeasonId.contains(event.season?.id.toString()) &&
                sportKey == SportName.NCAAB.name) {
              if (ncaabSportEventsList
                  .indexWhere((element) => element.id == event.id) !=
                  -1) {} else {
                if (ncaabTomorrowEventsList.contains(event)) {} else {
                  ncaabTomorrowEventsList.add(event);
                }
              }
            } else if (event.season?.id == 'sr:season:106289' &&
                sportKey == SportName.NBA.name &&
                (difference.inHours <= (16)
                )) {
              if (nbaTomorrowEventsList.contains(event)) {} else {
                nbaTomorrowEventsList.add(event);
              }
            }
          }
          getTomorrowList(sportKey).sort((a, b) =>
              DateTime.parse(a.scheduled ?? "")
                  .compareTo(DateTime.parse(b.scheduled ?? "")));
        }
      });
      update();
    }
  }

  List<SportEvents> getTodayList(sportKey) {
    return (sportKey == SportName.NFL.name
        ? nflTodayEventsList.toSet()
        : sportKey == SportName.MLB.name
        ? mlbTodayEventsList.toSet()
        : sportKey == SportName.NBA.name
        ? nbaTodayEventsList.toSet()
        : sportKey == SportName.NCAAB.name
        ? ncaabTodayEventsList.toSet()
        : ncaaTodayEventsList.toSet())
        .toSet()
        .toList();
  }

  List<SportEvents> getTomorrowList(sportKey) {
    return (sportKey == SportName.NFL.name
        ? nflTomorrowEventsList.toSet()
        : sportKey == SportName.MLB.name
        ? mlbTomorrowEventsList.toSet()
        : sportKey == SportName.NBA.name
        ? nbaTomorrowEventsList.toSet()
        : sportKey == SportName.NCAAB.name
        ? ncaabTomorrowEventsList.toSet()
        : ncaaTomorrowEventsList.toSet())
        .toSet()
        .toList();
  }

  List<SportEvents> getSportEventList(sportKey) {
    // List<SportEvents> newNcaabSportEventsList = ncaabSportEventsList
    //     .where((element) => conferenceIdList.contains(element.awayConferenceId)||conferenceIdList.contains(element.awayConferenceId))
    //     .toList();

    return sportKey == SportName.NFL.name
        ? nflSportEventsList
        : sportKey == SportName.MLB.name
        ? mlbSportEventsList
        : sportKey == SportName.NCAAB.name
        ? ncaabSportEventsList
        : sportKey == SportName.NBA.name
        ? nbaSportEventsList
        : ncaaSportEventsList;
  }

  ///GET ALL EVENT BY HOME AWAY FILTER
  getAllEventList(String sportKey, bool isLoad) {
    getSportEventList(sportKey).clear();
    getSportEventList(sportKey).addAll(getTodayList(sportKey).toSet());
    getSportEventList(sportKey).addAll(getTomorrowList(sportKey).toSet());
    update();
    getSportEventList(sportKey).sort((a, b) =>
        DateTime.parse(a.scheduled ?? "")
            .compareTo(DateTime.parse(b.scheduled ?? "")));
    for (var event in getSportEventList(sportKey)) {
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

      ///MONEY LINES

      if (event.consensus != null) {
        if (event.consensus?.lines != null) {
          event.consensus?.lines?.forEach((consensus) {
            if (consensus.name == 'moneyline_live') {
              consensus.outcomes?.forEach((lines) {
                if (lines.type == 'home') {
                  event.homeMoneyLine = lines.odds.toString();
                  log('HOME MONEY ---${event.homeMoneyLine}');
                }
                if (lines.type == 'away') {
                  event.awayMoneyLine = lines.odds.toString();
                  log('AWAY MONEY ---${event.awayMoneyLine}');
                }
              });
            } else {
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
            }
            if (consensus.name == 'total_live') {
              event.homeOU = consensus.total.toString();
              event.awayOU = consensus.total.toString();
            } else {
              if (consensus.name == 'total_current') {
                event.homeOU = consensus.total.toString();
                event.awayOU = consensus.total.toString();
              }
            }

            // if (consensus.name == 'run_line_current' ||
            //     consensus.name == 'spread_current') {
            //   event.homeSpread = '${consensus.spread}'.toString();
            //   event.awaySpread = '${consensus.spread}'.toString();
            // }
          });
        }
      }
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
    }
    update();
  }

  ///BOX SCORE API
  Future boxScoreResponse({String gameId = '',
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
        mlb.MLBBoxScoreModel response = mlb.MLBBoxScoreModel.fromJson(result.data);
        final game = response.game;
        if (game != null) {
          if (game.id == gameId) {
            mlbSportEventsList[index].inning =
                game.outcome?.currentInning.toString() ?? '0';
            mlbSportEventsList[index].inningHalf =
                game.outcome?.currentInningHalf.toString() ?? '';
            mlbSportEventsList[index].outs =
            "${(game.outcome?.count?.outs ?? "0").toString()} Outs";
            if (game.home?.id == homeTeamId) {
              mlbSportEventsList[index].homeScore =
                  (game.home?.runs).toString();
              mlbSportEventsList[index].homeWin = (game.home?.win).toString();
              mlbSportEventsList[index].homeLoss = (game.home?.loss).toString();
              mlbSportEventsList[index].homePlayerId =
                  (game.home?.probablePitcher?.id ?? "").toString();
              mlbSportEventsList[index].wlHome =
                  ('${game.home?.probablePitcher?.win ?? '0'}-${game.home
                      ?.probablePitcher?.loss ?? '0'}')
                      .toString();
              mlbSportEventsList[index].eraHome =
                  (game.home?.probablePitcher?.era ?? '0').toString();
              if (game.home?.probablePitcher != null) {
                mlbSportEventsList[index].homePlayerName =
                    ('${game.home?.probablePitcher?.preferredName?[0]}. ${game
                        .home?.probablePitcher?.lastName}')
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
                  ('${game.away?.probablePitcher?.win ?? '0'}-${game.away
                      ?.probablePitcher?.loss ?? "0"}')
                      .toString();
              mlbSportEventsList[index].eraAway =
                  (game.away?.probablePitcher?.era ?? '0').toString();
              if (game.away?.probablePitcher != null) {
                mlbSportEventsList[index].awayPlayerName =
                    ('${game.away?.probablePitcher?.preferredName?[0] ??
                        ""}. ${game.away?.probablePitcher?.lastName ?? ""}')
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

  Future boxScoreResponseNCAA({String gameId = '',
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
        ncaa.NCAABoxScoreModel response = ncaa.NCAABoxScoreModel.fromJson(result.data);
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
          if (key == SportName.NFL.name) {
            nflSportEventsList[index].inning = (game.quarter ?? "0").toString();
            nflSportEventsList[index].inningHalf = "Q";
            nflSportEventsList[index].clock = (game.clock ?? "00:00");
            if (game.situation != null) {
              nflSportEventsList[index].currentTime =
              'Q${(game.quarter ?? "0")} ${game.situation?.clock ??
                  ""}, $down & ${game.situation?.yfd ?? ""}';
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
            ncaaSportEventsList[index].clock = (game.clock ?? "00:00");
            if (game.situation != null) {
              ncaaSportEventsList[index].currentTime =
              'Q${(game.quarter ?? "0")} ${game.situation?.clock ??
                  ""}, $down & ${game.situation?.yfd ?? ""}';
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
      // isLoading.value = false;
      log('ERROR BOX SCORE NFL && NCAA--------$e');
      // showAppSnackBar(
      //   errorText,
      // );
    }

    update();
  }

  Future boxScoreNBAResponse({String gameId = '',
    String sportKey = '',
    String homeTeamId = '',
    String awayTeamId = '',
    bool isLoad = false,
    String key = '',
    required int index}) async {
    // isLoading.value = !isLoad ? false : true;
    ResponseItem result =
    ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo()
        .boxScoreNBARepo(gameId: gameId, sportKey: sportKey);
    try {
      if (result.status) {
        NBABoxScoreModel response = NBABoxScoreModel.fromJson(result.data);
        final game = response;

        if (game.id == gameId) {
          if (homeTeamId == game.home?.id) {
            if (sportKey == SportName.NBA.name) {
              nbaSportEventsList[index].homeScore =
                  (game.home?.points ?? "0").toString();
              nbaSportEventsList[index].homeRank =
                  (game.home?.rank ?? 0).toString();
            } else {
              ncaabSportEventsList[index].homeScore =
                  (game.home?.points ?? "0").toString();
              // ncaabSportEventsList[index].homeRank =
              //     (game.home?.rank ?? 0).toString();
            }
          }
          if (awayTeamId == game.away?.id) {
            if (sportKey == SportName.NBA.name) {
              nbaSportEventsList[index].awayScore =
                  (game.away?.points ?? "0").toString();
              nbaSportEventsList[index].awayRank =
                  (game.away?.rank ?? 0).toString();
            } else {
              ncaabSportEventsList[index].awayScore =
                  (game.away?.points ?? "0").toString();
              // ncaabSportEventsList[index].awayRank =
              //     (game.away?.rank ?? 0).toString();
            }
          }
          if (sportKey == SportName.NBA.name) {
            nbaSportEventsList[index].inning = (game.quarter ?? "0").toString();
            nbaSportEventsList[index].inningHalf = 'Q';
            nbaSportEventsList[index].status = game.status.toString();
            nbaSportEventsList[index].clock = (game.clock ?? "00:00");
          } else {
            ncaabSportEventsList[index].inning = (game.half ?? "0").toString();
            ncaabSportEventsList[index].inningHalf = 'H';
            ncaabSportEventsList[index].status = game.status.toString();
            ncaabSportEventsList[index].clock = (game.clock ?? "00:00");
            ncaabSportEventsList[index].clock = (game.clock ?? "00:00");
          }
        }
        update();
      } else {
        // showAppSnackBar(
        //   result.message,
        // );
      }
    } catch (e) {
      log('ERROR BOX SCORE NBA----$e');
      // showAppSnackBar(
      //   errorText,
      // );
    }
    update();
  }

  List<String> conferenceIdList = [
    "9ed9d01e-977c-4ba7-ac7d-64035039461c",
    "a30fe8ff-82d2-4521-bc8d-e08e6a9dbb52",
    "2853cf4d-6d62-4ec6-8e2c-d69f7a01a557",
    "88368ebb-01fb-44d5-a6c6-3e7d46bb3ab7",
    "d07bc93e-c84c-44a9-a99d-c213bd0014d6",
    "3b6a48d8-1f9c-484f-8ed0-ef0a540a0efe",
    "db136c00-f45b-4af6-bc7d-ffff216f2e5d",
    "6902bb03-02f7-4da4-8261-de5fd2cbd011",
    "93a776e4-d390-48e1-95bb-74945457366a",
    "c664ceee-1dc0-4743-a6d8-11fbdfb87f61",
  ];

  ///NCAA RANKING
  Future ncaaGameRanking({
    bool isLoad = false,
    required String sportName,
    required List<SportEvents> sportList,
  }) async {
    // isLoading.value = isLoad;
    ResponseItem result =
    ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo().ncaaGameRanking(sportName);
    try {
      if (result.status) {
        RankingModel response = RankingModel.fromJson(result.data);
        if (response.rankings != null) {
          for (int i = 0; i < sportList.length; i++) {
            if (sportList[i].uuids != null) {
              response.rankings?.forEach((team) {
                if (team.id.toString() ==
                    (replaceId(sportList[i].competitors[0].uuids ?? '') ??
                        "")) {
                  sportList[i].homeRank =
                  team.prevRank != null ? team.prevRank.toString() : '0';
                }
                if (team.id.toString() ==
                    (replaceId(sportList[i].competitors[1].uuids ?? '') ??
                        "")) {
                  sportList[i].awayRank =
                  team.prevRank != null ? team.prevRank.toString() : '0';
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
      // isLoading.value = false;
      log('ERROR NCAA RANKING-------$e');
      // showAppSnackBar(
      //   errorText,
      // );
    }
    update();
  }

  ///getConferenceNCAAB
  Future getConferenceNCAAB(bool isLoad) async {
    isLoading.value = isLoad;
    ResponseItem result =
    ResponseItem(data: null, message: errorText.tr, status: false);
    
    log("Getting NCAAB conference data...", name: "NCAAB");
    result = await GameListingRepo().getConferenceNCAAB();
    
    try {
      if (result.status) {
        log("Conference API call successful!", name: "NCAAB");
        ConferencesModelNCAAB response =
        ConferencesModelNCAAB.fromJson(result.data);
        
        if (response.divisions != null) {
          int conferenceMatchCount = 0;
          
          for (int i = 0; i < ncaabSportEventsList.length; i++) {
            if (ncaabSportEventsList[i].uuids != null) {
              response.divisions?.forEach((division) {
                division.conferences?.forEach(
                      (conference) {
                    conference.teams?.forEach(
                          (team) {
                        // Check if team ID matches home team
                        String homeTeamId = replaceId(ncaabSportEventsList[i]
                                .competitors[0]
                                .uuids ?? '') ?? "";
                                
                        String awayTeamId = replaceId(ncaabSportEventsList[i]
                                .competitors[1]
                                .uuids ?? '') ?? "";
                                
                        if (team.id.toString() == homeTeamId) {
                          ncaabSportEventsList[i].homeConferenceName = conference.name;
                          ncaabSportEventsList[i].homeConferenceId = conference.id;
                          conferenceMatchCount++;
                          log("Home Team Match: ${ncaabSportEventsList[i].homeTeam} -> Conference: ${conference.name}", name: "NCAAB");
                        }
                        
                        if (team.id.toString() == awayTeamId) {
                          ncaabSportEventsList[i].awayConferenceName = conference.name;
                          ncaabSportEventsList[i].awayConferenceId = conference.id;
                          conferenceMatchCount++;
                          log("Away Team Match: ${ncaabSportEventsList[i].awayTeam} -> Conference: ${conference.name}", name: "NCAAB");
                        }
                      },
                    );
                  },
                );
              });
            }
          }
          
          // Log summary of conference matching
          log("Conference matching complete: $conferenceMatchCount matches for ${ncaabSportEventsList.length} games", name: "NCAAB");
          
          // Verify if any games would be filtered out
          int filteredCount = ncaabSportEventsList
              .where((element) =>
                  conferenceIdList.contains(element.homeConferenceId) ||
                  conferenceIdList.contains(element.awayConferenceId))
              .length;
          
          log("Filtered games count: $filteredCount out of ${ncaabSportEventsList.length}", name: "NCAAB");
          
          if (filteredCount == 0) {
            log("WARNING: All games would be filtered out! Check conference IDs.", name: "NCAAB");
          }
        }
      } else {
        log("Conference API call failed: ${result.message}", name: "NCAAB");
        isLoading.value = false;
      }
    } catch (e) {
      log('ERROR NCAA CONFERENCE-------$e');
    }
    update();
  }

  setOdds(SportEvents event) {
    if (event.consensus != null) {
      if (event.consensus?.lines != null) {
        event.consensus?.lines?.forEach((consensus) {
          if (consensus.name == 'moneyline_live') {
            consensus.outcomes?.forEach((lines) {
              if (lines.type == 'home') {
                event.homeMoneyLine = lines.odds.toString();
                log('HOME MONEY ---${event.homeMoneyLine}');
              }
              if (lines.type == 'away') {
                event.awayMoneyLine = lines.odds.toString();
                log('AWAY MONEY ---${event.awayMoneyLine}');
              }
            });
          } else {
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
          }
          if (consensus.name == 'total_live') {
            event.homeOU = consensus.total.toString();
            event.awayOU = consensus.total.toString();
          } else {
            if (consensus.name == 'total_current') {
              event.homeOU = consensus.total.toString();
              event.awayOU = consensus.total.toString();
            }
          }

          // if (consensus.name == 'run_line_current' ||
          //     consensus.name == 'spread_current') {
          //   event.homeSpread = '${consensus.spread}'.toString();
          //   event.awaySpread = '${consensus.spread}'.toString();
          // }
        });
      }
    }
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
        String sportId = ''}) async {
    ncaaTodayEventsList = [];
    gameListingTodayApiRes(
        key: apiKey,
        isLoad: isLoad,
        sportKey: sportKey,
        date: date,
        sportId: sportId)
        .then((value) {
      gameListingTodayApiRes(
          key: apiKey,
          isLoad: isLoad,
          sportKey: sportKey,
          date: DateFormat('yyyy-MM-dd')
              .format(DateTime.parse(date).add(const Duration(days: 1))),
          sportId: sportId)
          .then((value) {
        isLoading.value = false;
        isPagination = isLoad;
        ncaaTomorrowEventsList.clear();
        for (int i = 2; i <= 12; i++) {
          gameListingTomorrowApiRes(
              key: apiKey,
              isLoad: isLoad,
              sportKey: sportKey,
              date: DateFormat('yyyy-MM-dd')
                  .format(DateTime.parse(date).add(Duration(days: i))),
              sportId: sportId)
              .then((value) {
            getAllEventList(sportKey, isLoad);
            nflGameRankApi(isLoad: isLoad, sportKey: sportKey);
            getNFLQBSRank(isLoad: isLoad, sportKey: sportKey);
            gameListingsWithLogoResponse(currentYear, sportKey, isLoad: isLoad);
            if (i == 12) {
              isPagination = false;
            }
          }).then((value) {
            if (ncaaSportEventsList.isNotEmpty) {
              ncaaGameRanking(
                  sportName: sportKey,
                  isLoad: false,
                  sportList: ncaaSportEventsList);
              for (int i = 0; i < ncaaSportEventsList.length; i++) {
                if (ncaaSportEventsList[i].uuids != null) {
                  getWeather(ncaaSportEventsList[i].venue?.cityName ?? "",
                      index: i, sportKey: sportKey);
                  boxScoreResponseNCAA(
                      key: sportKey,
                      gameId: replaceId(ncaaSportEventsList[i].uuids ?? ''),
                      index: i);
                }
              }
            }
          });
        }
        if (ncaaTodayEventsList.isNotEmpty) {
          timerNCAA = Timer.periodic(const Duration(seconds: 45), (t) async {
            ncaaTodayEventsList.clear();
            await gameListingTodayApiRes(
                key: apiKey,
                isLoad: false,
                sportKey: sportKey,
                date: date,
                sportId: sportId)
                .then((value) {
              gameListingTodayApiRes(
                  key: apiKey,
                  isLoad: false,
                  sportKey: sportKey,
                  date: DateFormat('yyyy-MM-dd').format(
                      DateTime.parse(date).add(const Duration(days: 1))),
                  sportId: sportId)
                  .then((value) {
                for (int i = 0; i < ncaaTodayEventsList.length; i++) {
                  int liveIndex = ncaaSportEventsList.indexWhere(
                          (element) => element.id == ncaaTodayEventsList[i].id);
                  if (liveIndex >= 0) {
                    setOdds(ncaaSportEventsList[liveIndex]);
                  }
                  if (((DateTime.parse(ncaaTodayEventsList[i].scheduled ?? "")
                      .toLocal())
                      .day ==
                      DateTime
                          .now()
                          .toLocal()
                          .day) &&
                      ncaaTodayEventsList[i].status != GameStatus.closed.name) {
                    if (ncaaTodayEventsList[i].uuids != null) {
                      boxScoreResponseNCAA(
                          key: sportKey,
                          gameId: replaceId(ncaaTodayEventsList[i].uuids ?? ''),
                          index: i);
                    }
                  }
                }
              });
            });
            update();
          });
        }
      });
    });
  }

  ncaaGameRefreshCall(bool isLoad,
      {String apiKey = '',
        String sportKey = '',
        String date = '',
        String sportId = ''}) async {
    ncaaTodayEventsList = [];
    gameListingTodayApiRes(
        key: apiKey,
        isLoad: isLoad,
        sportKey: sportKey,
        date: date,
        sportId: sportId)
        .then((value) {
      gameListingTodayApiRes(
          key: apiKey,
          isLoad: isLoad,
          sportKey: sportKey,
          date: DateFormat('yyyy-MM-dd')
              .format(DateTime.parse(date).add(const Duration(days: 1))),
          sportId: sportId)
          .then((value) {
        isLoading.value = false;
        isPagination = isLoad;
        ncaaTomorrowEventsList.clear();
        for (int i = 2; i <= 12; i++) {
          gameListingTomorrowApiRes(
              key: apiKey,
              isLoad: isLoad,
              sportKey: sportKey,
              date: DateFormat('yyyy-MM-dd')
                  .format(DateTime.parse(date).add(Duration(days: i))),
              sportId: sportId)
              .then((value) {
            getAllEventList(sportKey, isLoad);
            nflGameRankApi(isLoad: isLoad, sportKey: sportKey);
            getNFLQBSRank(isLoad: isLoad, sportKey: sportKey);
            gameListingsWithLogoResponse(currentYear, sportKey, isLoad: isLoad);
            if (i == 12) {
              isPagination = false;
            }
          }).then((value) {
            if (ncaaSportEventsList.isNotEmpty) {
              ncaaGameRanking(
                  sportName: sportKey,
                  isLoad: false,
                  sportList: ncaaSportEventsList);
              for (int i = 0; i < ncaaSportEventsList.length; i++) {
                if (ncaaSportEventsList[i].uuids != null) {
                  getWeather(ncaaSportEventsList[i].venue?.cityName ?? "",
                      index: i, sportKey: sportKey);
                  boxScoreResponseNCAA(
                      key: sportKey,
                      gameId: replaceId(ncaaSportEventsList[i].uuids ?? ''),
                      index: i);
                }
              }
            }
          });
        }
      });
    });
  }

  Future<void> getGameListingForNFLGame(bool isLoad,
      {String apiKey = '',
        String sportKey = '',
        String date = '',
        String sportId = ''}) async {
    nflTodayEventsList = [];
    update();
    gameListingTodayApiRes(
        key: apiKey,
        isLoad: isLoad,
        sportKey: sportKey,
        date: date,
        sportId: sportId)
        .then((value) {
      gameListingTodayApiRes(
          key: apiKey,
          isLoad: isLoad,
          sportKey: sportKey,
          date: DateFormat('yyyy-MM-dd')
              .format(DateTime.parse(date).add(const Duration(days: 1))),
          sportId: sportId)
          .then((value) {
        isLoading.value = false;
        isPagination = isLoad;
        nflTomorrowEventsList = [];
        for (int i = 2; i <= 6; i++) {
          gameListingTomorrowApiRes(
              key: apiKey,
              isLoad: isLoad,
              sportKey: sportKey,
              date: DateFormat('yyyy-MM-dd')
                  .format(DateTime.parse(date).add(Duration(days: i))),
              sportId: sportId)
              .then((value) async {
            getAllEventList(sportKey, isLoad);
            nflGameRankApi(isLoad: isLoad, sportKey: sportKey);
            getNFLQBSRank(isLoad: isLoad, sportKey: sportKey);
            if (i == 6) {
              isPagination = false;
            }
            gameListingsWithLogoResponseNCAAB(currentYear, sportKey,
                isLoad: isLoad);
            if (nflSportEventsList.isNotEmpty) {
              for (int i = 0; i < nflSportEventsList.length; i++) {
                if (nflSportEventsList[i].uuids != null) {
                  getWeather(nflSportEventsList[i].venue?.cityName ?? "",
                      index: i, sportKey: sportKey);
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
          timerNFL = Timer.periodic(const Duration(seconds: 45), (t) {
            nflTodayEventsList.clear();
            gameListingTodayApiRes(
                key: apiKey,
                isLoad: false,
                sportKey: sportKey,
                date: date,
                sportId: sportId)
                .then((value) {
              gameListingTodayApiRes(
                  key: apiKey,
                  isLoad: false,
                  sportKey: sportKey,
                  date: DateFormat('yyyy-MM-dd').format(
                      DateTime.parse(date).add(const Duration(days: 1))),
                  sportId: sportId)
                  .then((value) {
                for (int i = 0; i < nflTodayEventsList.length; i++) {
                  int liveIndex = nflSportEventsList.indexWhere(
                          (element) => element.id == nflTodayEventsList[i].id);
                  if (liveIndex >= 0) {
                    setOdds(nflSportEventsList[liveIndex]);
                  }
                  if (((DateTime.parse(nflTodayEventsList[i].scheduled ?? "")
                      .toLocal())
                      .day ==
                      DateTime
                          .now()
                          .toLocal()
                          .day) &&
                      nflTodayEventsList[i].status != GameStatus.closed.name) {
                    if (nflTodayEventsList[i].uuids != null) {
                      boxScoreResponseNCAA(
                          key: sportKey,
                          gameId: replaceId(nflTodayEventsList[i].uuids ?? ''),
                          index: i);
                    }
                  }
                }
              });
            });
            update();
          });
        }
      });
    });
    update();
  }

  Future<void> nflGameRefreshCall(bool isLoad,
      {String apiKey = '',
        String sportKey = '',
        String date = '',
        String sportId = ''}) async {
    nflTodayEventsList = [];
    gameListingTodayApiRes(
        key: apiKey,
        isLoad: isLoad,
        sportKey: sportKey,
        date: date,
        sportId: sportId)
        .then((value) {
      gameListingTodayApiRes(
          key: apiKey,
          isLoad: isLoad,
          sportKey: sportKey,
          date: DateFormat('yyyy-MM-dd')
              .format(DateTime.parse(date).add(const Duration(days: 1))),
          sportId: sportId)
          .then((value) {
        isLoading.value = false;
        isPagination = isLoad;
        nflTomorrowEventsList = [];
        for (int i = 2; i <= 6; i++) {
          gameListingTomorrowApiRes(
              key: apiKey,
              isLoad: isLoad,
              sportKey: sportKey,
              date: DateFormat('yyyy-MM-dd')
                  .format(DateTime.parse(date).add(Duration(days: i))),
              sportId: sportId)
              .then((value) async {
            getAllEventList(sportKey, isLoad);
            nflGameRankApi(isLoad: isLoad, sportKey: sportKey);
            getNFLQBSRank(isLoad: isLoad, sportKey: sportKey);
            if (i == 6) {
              isPagination = false;
            }
            gameListingsWithLogoResponseNCAAB(currentYear, sportKey,
                isLoad: isLoad);
            if (nflSportEventsList.isNotEmpty) {
              for (int i = 0; i < nflSportEventsList.length; i++) {
                if (nflSportEventsList[i].uuids != null) {
                  getWeather(nflSportEventsList[i].venue?.cityName ?? "",
                      index: i, sportKey: sportKey);
                  boxScoreResponseNCAA(
                      key: sportKey,
                      gameId: replaceId(nflSportEventsList[i].uuids ?? ''),
                      index: i);
                }
              }
            }
          });
        }
      });
    });
  }

  ///NFL GAME RANK API
  Future nflGameRankApi({bool isLoad = false, String sportKey = ''}) async {
    ResponseItem result =
    ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo().nflGameRankApi(sportKey);
    try {
      if (result.status) {
        NFLGameRankModel response = NFLGameRankModel.fromJson(result.toJson());
        if (response.data != null) {
          for (var element in (getSportEventList(sportKey))) {
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
            response.data?.forEach((team) {
              if ((awayTeam?.abbreviation == 'LV'
                  ? '7d4fcc64-9cb5-4d1b-8e75-8a906d1e1576'
                  : replaceId(awayTeam?.uuids ?? '')) ==
                  replaceId(team.teamId ?? "")) {
                element.nflAwayOffensiveRank = [
                  (team.pointOffenceRank ?? 0).toString(),
                  (team.rushingOffenseRank ?? 0).toString(),
                  (team.passingYardOffenseRank ?? 0).toString(),
                  (team.rushingTDSOffenseRank ?? 0).toString(),
                  (team.passingTDSOffenseRank ?? 0).toString(),
                  (team.redzonEfficiencyOffenceRank ?? 0).toString(),
                  (team.thirdDownOffenceRank ?? 0).toString(),
                  (team.fourthDownOffenseRank ?? 0).toString(),
                  (team.fieldGoalOffenseRank ?? 0).toString(),
                  (team.ternoverOffenseRank ?? 0).toString(),
                ];
                element.nflAwayOffensiveList = [
                  (team.pointsOffense ?? 0).toString(),
                  (team.rushingOffense ?? 0).toString(),
                  (team.passingYardOffense ?? 0).toString(),
                  (team.rushingTDSOffense ?? 0).toString(),
                  (team.passingTDSOffense ?? 0).toString(),
                  ('${team.redzonEfficiencyOffence ?? 0}%').toString(),
                  ('${team.thirdDownOffence ?? 0}%').toString(),
                  ('${team.fourthDownOffense ?? 0}%').toString(),
                  (team.fieldGoalOffense ?? 0).toString(),
                  (team.ternoverOffense ?? 0).toString(),
                ];
                element.nflAwayDefensiveRank = [
                  (team.pointsDefenseRank ?? 0).toString(),
                  (team.rushingDefenseRank ?? 0).toString(),
                  (team.passingYardDefenseRank ?? 0).toString(),
                  (team.rushingTDSDefenceRank ?? 0).toString(),
                  (team.passingTDSDefenceRank ?? 0).toString(),
                  (team.opponentRedzonEfficiencyRank ?? 0).toString(),
                  (team.opponentThirdDownRank ?? 0).toString(),
                  (team.opponentFourtDownRank ?? 0).toString(),
                  (team.fieldGoalDefenseRank ?? 0).toString(),
                  (team.ternoverDefenseRank ?? 0).toString(),
                ];
                element.nflAwayDefensiveList = [
                  (team.pointsDefense ?? 0).toString(),
                  (team.rushingDefense ?? 0).toString(),
                  (team.passingYardDefense ?? 0).toString(),
                  (team.rushingTDSDefence ?? 0).toString(),
                  (team.passingTDSDefence ?? 0).toString(),
                  ('${team.opponentRedzonEfficiency ?? 0}%').toString(),
                  ('${team.opponentThirdDown ?? 0}%').toString(),
                  ('${team.opponentFourtDown ?? 0}%').toString(),
                  (team.fieldGoalDefense ?? 0).toString(),
                  (team.ternoverDefense ?? 0).toString(),
                ];
                element.awayDefense = [
                  (team.passingYardDefense ?? 0).toString(),
                  (team.passingTDSDefence ?? 0).toString(),
                  (team.rushingDefense ?? 0).toString(),
                  (team.rushingTDSDefence ?? 0).toString(),
                  (team.interceptionDefense ?? 0).toString(),
                  // (offenciveData?.defense?.interceptions ?? "0").toString(),
                ];
                element.awayQbDefenseRank = [
                  (team.passingYardDefenseRank ?? 0).toString(),
                  (team.passingTDSDefenceRank ?? 0).toString(),
                  (team.rushingDefenseRank ?? 0).toString(),
                  (team.rushingTDSDefenceRank ?? 0).toString(),
                  (team.interceptionDefenseRank ?? 0).toString(),
                ];
              }
              if ((homeTeam?.abbreviation == 'LV'
                  ? '7d4fcc64-9cb5-4d1b-8e75-8a906d1e1576'
                  : replaceId(homeTeam?.uuids ?? '')) ==
                  replaceId(team.teamId ?? "")) {
                element.nflHomeOffensiveRank = [
                  (team.pointOffenceRank ?? 0).toString(),
                  (team.rushingOffenseRank ?? 0).toString(),
                  (team.passingYardOffenseRank ?? 0).toString(),
                  (team.rushingTDSOffenseRank ?? 0).toString(),
                  (team.passingTDSOffenseRank ?? 0).toString(),
                  (team.redzonEfficiencyOffenceRank ?? 0).toString(),
                  (team.thirdDownOffenceRank ?? 0).toString(),
                  (team.fourthDownOffenseRank ?? 0).toString(),
                  (team.fieldGoalOffenseRank ?? 0).toString(),
                  (team.ternoverOffenseRank ?? 0).toString(),
                ];
                element.nflHomeOffensiveList = [
                  (team.pointsOffense ?? 0).toString(),
                  (team.rushingOffense ?? 0).toString(),
                  (team.passingYardOffense ?? 0).toString(),
                  (team.rushingTDSOffense ?? 0).toString(),
                  (team.passingTDSOffense ?? 0).toString(),
                  ('${team.redzonEfficiencyOffence ?? 0}%').toString(),
                  ('${team.thirdDownOffence ?? 0}%').toString(),
                  ('${team.fourthDownOffense ?? 0}%').toString(),
                  (team.fieldGoalOffense ?? 0).toString(),
                  (team.ternoverOffense ?? 0).toString(),
                ];
                element.nflHomeDefensiveRank = [
                  (team.pointsDefenseRank ?? 0).toString(),
                  (team.rushingDefenseRank ?? 0).toString(),
                  (team.passingYardDefenseRank ?? 0).toString(),
                  (team.rushingTDSDefenceRank ?? 0).toString(),
                  (team.passingTDSDefenceRank ?? 0).toString(),
                  (team.opponentRedzonEfficiencyRank ?? 0).toString(),
                  (team.opponentThirdDownRank ?? 0).toString(),
                  (team.opponentFourtDownRank ?? 0).toString(),
                  (team.fieldGoalDefenseRank ?? 0).toString(),
                  (team.ternoverDefenseRank ?? 0).toString(),
                ];
                element.nflHomeDefensiveList = [
                  (team.pointsDefense ?? 0).toString(),
                  (team.rushingDefense ?? 0).toString(),
                  (team.passingYardDefense ?? 0).toString(),
                  (team.rushingTDSDefence ?? 0).toString(),
                  (team.passingTDSDefence ?? 0).toString(),
                  ('${team.opponentRedzonEfficiency ?? 0}%').toString(),
                  ('${team.opponentThirdDown ?? 0}%').toString(),
                  ('${team.opponentFourtDown ?? 0}%').toString(),
                  (team.fieldGoalDefense ?? 0).toString(),
                  (team.ternoverDefense ?? 0).toString(),
                ];
                element.homeDefense = [
                  (team.passingYardDefense ?? 0).toString(),
                  (team.passingTDSDefence ?? 0).toString(),
                  (team.rushingDefense ?? 0).toString(),
                  (team.rushingTDSDefence ?? 0).toString(),
                  (team.interceptionDefense ?? 0).toString(),
                  // (offenciveData?.defense?.interceptions ?? "0").toString(),
                ];
                element.homeQbDefenseRank = [
                  (team.passingYardDefenseRank ?? 0).toString(),
                  (team.passingTDSDefenceRank ?? 0).toString(),
                  (team.rushingDefenseRank ?? 0).toString(),
                  (team.rushingTDSDefenceRank ?? 0).toString(),
                  (team.interceptionDefenseRank ?? 0).toString(),
                ];
              }
            });
          }
        }
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      log('ERROR NFL GAME RANK-----$e');
      showAppSnackBar(e.toString());
    }
    update();
  }

  Future getNFLQBSRank({bool isLoad = false, String sportKey = ''}) async {
    ResponseItem result =
    ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo().getNFLQBSRank(sportKey);
    try {
      if (result.status) {
        NFLQBsRankModel response = NFLQBsRankModel.fromJson(result.toJson());
        if (response.data != null) {
          for (var sportData in (getSportEventList(sportKey))) {
            Competitors? homeTeam;
            Competitors? awayTeam;
            if (sportData.competitors[0].qualifier == 'home') {
              homeTeam = sportData.competitors[0];
            } else {
              awayTeam = sportData.competitors[0];
            }
            if (sportData.competitors[1].qualifier == 'away') {
              awayTeam = sportData.competitors[1];
            } else {
              homeTeam = sportData.competitors[1];
            }
            response.data?.forEach((element) {
              if ((homeTeam?.abbreviation == 'LV'
                  ? '7d4fcc64-9cb5-4d1b-8e75-8a906d1e1576'
                  : replaceId(homeTeam?.uuids ?? '')) ==
                  element.teamId) {
                sportData.homePlayerName = element.playerName ?? "";
                sportData.homePlayerId = element.playerId ?? "";
                sportData.homeQbRank = [
                  (element.passingYardOffenseRank ?? 0).toString(),
                  (element.passingTDSOffenseRank ?? 0).toString(),
                  (element.rushingYardOffenseRank ?? 0).toString(),
                  (element.rushingTDsOffenseRank ?? 0).toString(),
                  (element.interceptionOffenseRank ?? 0).toString(),
                ];
                sportData.homeQb = [
                  (element.passingYardOffense ?? 0).toStringAsFixed(1),
                  (element.passingTDSOffense ?? 0).toStringAsFixed(1),
                  (element.rushingYardOffense ?? 0).toStringAsFixed(1),
                  (element.rushingTDsOffense ?? 0).toStringAsFixed(1),
                  (element.interceptionOffense ?? 0).toStringAsFixed(1),
                ];
              }
              if ((awayTeam?.abbreviation == 'LV'
                  ? '7d4fcc64-9cb5-4d1b-8e75-8a906d1e1576'
                  : replaceId(awayTeam?.uuids ?? '')) ==
                  element.teamId) {
                sportData.awayPlayerName = element.playerName ?? "";
                sportData.awayPlayerId = element.playerId ?? "";
                sportData.awayQbRank = [
                  (element.passingYardOffenseRank ?? 0).toString(),
                  (element.passingTDSOffenseRank ?? 0).toString(),
                  (element.rushingYardOffenseRank ?? 0).toString(),
                  (element.rushingTDsOffenseRank ?? 0).toString(),
                  (element.interceptionOffenseRank ?? 0).toString(),
                ];
                sportData.awayQb = [
                  (element.passingYardOffense ?? 0).toStringAsFixed(1),
                  (element.passingTDSOffense ?? 0).toStringAsFixed(1),
                  (element.rushingYardOffense ?? 0).toStringAsFixed(1),
                  (element.rushingTDsOffense ?? 0).toStringAsFixed(1),
                  (element.interceptionOffense ?? 0).toStringAsFixed(1),
                ];
              }
            });
          }
        }
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      log('ERROR NFL GAME RANK-----$e');
      showAppSnackBar(e.toString());
    }
    update();
  }

  ///NBA GAME RANK API
  Future nbaGameRankApi({bool isLoad = false, String sportKey = ''}) async {
    ResponseItem result =
    ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo().nbaGameRankApi(sportKey);
    try {
      if (result.status) {
        NBAGameRankModel response = NBAGameRankModel.fromJson(result.toJson());
        if (response.data != null) {
          for (var element in (getSportEventList(sportKey))) {
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
            response.data?.forEach((team) {
              if ((replaceId(awayTeam?.uuids ?? '')) ==
                  replaceId(team.teamId ?? "")) {
                element.nbaAwayOffensiveList = [
                  team.pointOffense.toString(),
                  team.assistOffense.toString(),
                  team.turnOverOffense.toString(),
                  team.reboundesOffense.toString(),
                  // team.stealsOffense.toString(),
                  // team.blocksOffense.toString(),
                  // team.turnOverOffense.toString(),
                  // team.foulsOffense.toString(),
                  '${team.fgMadeOffense} / ${team.fgAttOffense} / ${team
                      .fgOffense}%',
                  '${team.threePMadeOffense} / ${team.threePAttOffense} / ${team
                      .threePOffense}%',
                  '${team.ftMadeOffense} / ${team.ftAttOffense} / ${team
                      .ftOffense}%',
                  // '${((team.trueShootingOffense ?? 0) * 100).toStringAsFixed(1)}%'
                  //     .toString(),
                  // team.teamPerOffense.toString(),
                ];

                element.nbaAwayOffensiveRank = [
                  (team.pointOffenseRank ?? 0).toString(),
                  (team.assistOffenseRank ?? 0).toString(),
                  team.turnOverOffenseRank.toString(),
                  (team.reboundesOffenseRank ?? 0).toString(),
                  // (team.stealsOffenseRank ?? 0).toString(),
                  // (team.blocksOffenseRank ?? 0).toString(),
                  // (team.turnOverOffenseRank ?? 0).toString(),
                  // (team.foulsOffenseRank ?? 0).toString(),
                  '${team.fgOffenseRank ?? 0}',
                  '${team.threePOffenseRank ?? 0}',
                  '${team.ftOffenseRank ?? 0}',
                  // (team.trueShootingOffenseRank ?? 0).toString(),
                  // (team.teamPerOffenseRank ?? 0).toString(),
                ];
                element.nbaAwayDefensiveList = [
                  team.pointDefense.toString(),
                  team.assistDefense.toString(),
                  team.turnOverDefense.toString(),
                  team.reboundesDefense.toString(),
                  // team.stealsDefense.toString(),
                  // team.blocksDefense.toString(),
                  // team.turnOverDefense.toString(),
                  // team.foulsDefense.toString(),
                  '${team.fgMadeDefense} / ${team.fgAttDefense} / ${team
                      .fgDefense}%',
                  '${team.threePMadeDefense} / ${team.threePAttDefense} / ${team
                      .threePDefense}%',
                  '${team.ftMadeDefense} / ${team.ftAttDefense} / ${team
                      .ftDefense}%',
                  // '${((team.trueShootingDefense ?? 0) * 100).toStringAsFixed(1)}%'
                  //     .toString(),
                  // team.teamPerDefense.toString(),
                ];
                element.nbaAwayDefensiveRank = [
                  (team.pointDefenseRank ?? 0).toString(),
                  (team.assistDefenseRank ?? 0).toString(),
                  team.turnOverDefenseRank.toString(),
                  (team.reboundesDefenseRank ?? 0).toString(),
                  // (team.stealsDefenseRank ?? 0).toString(),
                  // (team.blocksDefenseRank ?? 0).toString(),
                  // (team.turnOverDefenseRank ?? 0).toString(),
                  // (team.foulsDefenseRank ?? 0).toString(),
                  '${team.fgDefenseRank ?? 0}',
                  '${team.threePDefenseRank ?? 0}',
                  '${team.ftDefenseRank ?? 0}',
                  // (team.trueShootingDefenseRank ?? 0).toString(),
                  // (team.teamPerDefenseRank ?? 0).toString(),
                ];
              }
              if ((replaceId(homeTeam?.uuids ?? '')) ==
                  replaceId(team.teamId ?? "")) {
                element.nbaHomeOffensiveList = [
                  team.pointOffense.toString(),
                  team.assistOffense.toString(),
                  team.turnOverOffense.toString(),
                  team.reboundesOffense.toString(),
                  // team.stealsOffense.toString(),
                  // team.blocksOffense.toString(),
                  // team.turnOverOffense.toString(),
                  // team.foulsOffense.toString(),
                  '${team.fgMadeOffense} / ${team.fgAttOffense} / ${team
                      .fgOffense}%',
                  '${team.threePMadeOffense} / ${team.threePAttOffense} / ${team
                      .threePOffense}%',
                  '${team.ftMadeOffense} / ${team.ftAttOffense} / ${team
                      .ftOffense}%',
                  // '${((team.trueShootingOffense ?? 0) * 100).toStringAsFixed(1)}%'
                  //     .toString(),
                  // team.teamPerOffense.toString(),
                ];
                element.nbaHomeOffensiveRank = [
                  (team.pointOffenseRank ?? 0).toString(),
                  (team.assistOffenseRank ?? 0).toString(),
                  team.turnOverOffenseRank.toString(),
                  (team.reboundesOffenseRank ?? 0).toString(),
                  // (team.stealsOffenseRank ?? 0).toString(),
                  // (team.blocksOffenseRank ?? 0).toString(),
                  // (team.turnOverOffenseRank ?? 0).toString(),
                  // (team.foulsOffenseRank ?? 0).toString(),
                  '${team.fgOffenseRank ?? 0}',
                  '${team.threePOffenseRank ?? 0}',
                  '${team.ftOffenseRank ?? 0}',
                  // (team.trueShootingOffenseRank ?? 0).toString(),
                  // (team.teamPerOffenseRank ?? 0).toString(),
                ];
                element.nbaHomeDefensiveList = [
                  team.pointDefense.toString(),
                  team.assistDefense.toString(),
                  team.turnOverDefense.toString(),
                  team.reboundesDefense.toString(),
                  // team.stealsDefense.toString(),
                  // team.blocksDefense.toString(),
                  // team.turnOverDefense.toString(),
                  // team.foulsDefense.toString(),
                  '${team.fgMadeDefense} / ${team.fgAttDefense} / ${team
                      .fgDefense}%',
                  '${team.threePMadeDefense} / ${team.threePAttDefense} / ${team
                      .threePDefense}%',
                  '${team.ftMadeDefense} / ${team.ftAttDefense} / ${team
                      .ftDefense}%',
                  // '${((team.trueShootingDefense ?? 0) * 100).toStringAsFixed(1)}%'
                  //     .toString(),
                  // team.teamPerDefense.toString(),
                ];
                element.nbaHomeDefensiveRank = [
                  (team.pointDefenseRank ?? 0).toString(),
                  (team.assistDefenseRank ?? 0).toString(),
                  team.turnOverDefenseRank.toString(),
                  (team.reboundesDefenseRank ?? 0).toString(),
                  // (team.stealsDefenseRank ?? 0).toString(),
                  // (team.blocksDefenseRank ?? 0).toString(),
                  // (team.turnOverDefenseRank ?? 0).toString(),
                  // (team.foulsDefenseRank ?? 0).toString(),
                  '${team.fgDefenseRank ?? 0}',
                  '${team.threePDefenseRank ?? 0}',
                  '${team.ftDefenseRank ?? 0}',
                  // (team.trueShootingDefenseRank ?? 0).toString(),
                  // (team.teamPerDefenseRank ?? 0).toString(),
                ];
              }
            });
          }
        }
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      log('ERROR NFL GAME RANK-----$e');
      showAppSnackBar(e.toString());
    }
    update();
  }

  Future<void> getGameListingForMLBRes(bool isLoad,
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
      gameListingTodayApiRes(
          key: apiKey,
          isLoad: isLoad,
          sportKey: sportKey,
          date: DateFormat('yyyy-MM-dd')
              .format(DateTime.parse(date).add(const Duration(days: 1))),
          sportId: sportId)
          .then((value) {
        isLoading.value = false;
        isPagination = isLoad;
        mlbTomorrowEventsList.clear();
        for (int j = 2; j <= 4; j++) {
          gameListingTomorrowApiRes(
              key: apiKey,
              isLoad: isLoad,
              sportKey: sportKey,
              date: DateFormat('yyyy-MM-dd')
                  .format(DateTime.parse(date).add(Duration(days: j))),
              sportId: sportId)
              .then((value) {
            getAllEventList(sportKey, isLoad);
            gameListingsWithLogoResponse(currentYear, sportKey, isLoad: isLoad);
            if (j == 4) {
              isPagination = false;
            }
            if (mlbSportEventsList.isNotEmpty) {
              for (int i = 0; i < mlbSportEventsList.length; i++) {
                getWeather(mlbSportEventsList[i].venue?.cityName ?? "",
                    index: i, sportKey: sportKey);
                if (mlbSportEventsList[i].uuids != null) {
                  if (DateTime
                      .parse(mlbSportEventsList[i].scheduled ?? "")
                      .toLocal()
                      .day ==
                      DateTime
                          .now()
                          .day) {
                    boxScoreResponse(
                        homeTeamId: replaceId(
                            mlbSportEventsList[i].competitors[0].uuids ??
                                '') ??
                            "",
                        awayTeamId: replaceId(
                            mlbSportEventsList[i].competitors[1].uuids ??
                                '') ??
                            "",
                        gameId: replaceId(mlbSportEventsList[i].uuids ?? ''),
                        index: i);
                  }
                }
              }
            }
          });
        }
        if (mlbTodayEventsList.isNotEmpty) {
          timer = Timer.periodic(const Duration(seconds: 45), (t) {
            mlbTodayEventsList.clear();
            gameListingTodayApiRes(
                key: apiKey,
                isLoad: false,
                sportKey: sportKey,
                date: date,
                sportId: sportId)
                .then((value) {
              gameListingTodayApiRes(
                  key: apiKey,
                  isLoad: false,
                  sportKey: sportKey,
                  date: DateFormat('yyyy-MM-dd').format(
                      DateTime.parse(date).add(const Duration(days: 1))),
                  sportId: sportId)
                  .then((value) {
                for (int i = 0; i < mlbTodayEventsList.length; i++) {
                  int liveIndex = mlbSportEventsList.indexWhere(
                          (element) => element.id == mlbTodayEventsList[i].id);
                  if (liveIndex >= 0) {
                    setOdds(mlbSportEventsList[liveIndex]);
                  }
                  if (((DateTime.parse(mlbTodayEventsList[i].scheduled ?? "")
                      .toLocal())
                      .day ==
                      DateTime
                          .now()
                          .toLocal()
                          .day) &&
                      mlbTodayEventsList[i].status != GameStatus.closed.name) {
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
            });
            update();
          });
        }
      });
    });
  }

  Future<void> mlbGameRefreshCall(bool isLoad,
      {String apiKey = '',
        String sportKey = '',
        String date = '',
        String sportId = ''}) async {
    mlbTodayEventsList = [];
    gameListingTodayApiRes(
        key: apiKey,
        isLoad: isLoad,
        sportKey: sportKey,
        date: date,
        sportId: sportId)
        .then((value) {
      gameListingTodayApiRes(
          key: apiKey,
          isLoad: isLoad,
          sportKey: sportKey,
          date: DateFormat('yyyy-MM-dd')
              .format(DateTime.parse(date).add(const Duration(days: 1))),
          sportId: sportId)
          .then((value) {
        isLoading.value = false;
        isPagination = isLoad;
        mlbTomorrowEventsList.clear();
        for (int i = 2; i <= 4; i++) {
          gameListingTomorrowApiRes(
              key: apiKey,
              isLoad: isLoad,
              sportKey: sportKey,
              date: DateFormat('yyyy-MM-dd')
                  .format(DateTime.parse(date).add(Duration(days: i))),
              sportId: sportId)
              .then((value) {
            getAllEventList(sportKey, isLoad);
            if (mlbSportEventsList.isNotEmpty) {
              for (int i = 0; i < mlbSportEventsList.length; i++) {
                getWeather(mlbSportEventsList[i].venue?.cityName ?? "",
                    index: i, sportKey: sportKey);
                if (mlbSportEventsList[i].uuids != null) {
                  boxScoreResponse(
                      homeTeamId: replaceId(
                          mlbSportEventsList[i].competitors[0].uuids ??
                              '') ??
                          "",
                      awayTeamId: replaceId(
                          mlbSportEventsList[i].competitors[1].uuids ??
                              '') ??
                          "",
                      gameId: replaceId(mlbSportEventsList[i].uuids ?? ''),
                      index: i);
                }
              }
            }
            gameListingsWithLogoResponse(currentYear, sportKey, isLoad: isLoad);
          });
          if (i == 4) {
            isPagination = false;
          }
        }
      });
    });
  }

  Future<void> getGameListingForNBARes(bool isLoad,
      {String apiKey = '',
        String sportKey = '',
        String date = '',
        String sportId = ''}) async {
    nbaTodayEventsList.clear();
    gameListingTodayApiRes(
        key: apiKey,
        isLoad: isLoad,
        sportKey: sportKey,
        date: date,
        sportId: sportId)
        .then((value) {
      gameListingTodayApiRes(
          key: apiKey,
          isLoad: isLoad,
          sportKey: sportKey,
          date: DateFormat('yyyy-MM-dd')
              .format(DateTime.parse(date).add(const Duration(days: 1))),
          sportId: sportId)
          .then((value) {
        isLoading.value = false;
        isPagination = isLoad;
        nbaTomorrowEventsList.clear();
        gameListingTomorrowApiRes(
            key: apiKey,
            isLoad: isLoad,
            sportKey: sportKey,
            date: DateFormat('yyyy-MM-dd')
                .format(DateTime.parse(date).add(const Duration(days: 2))),
            sportId: sportId)
            .then((value) async {
          getAllEventList(sportKey, isLoad);
          isPagination = false;
          gameListingsWithLogoResponseNCAAB(currentYear, sportKey,
              isLoad: isLoad);
          nbaGameRankApi(isLoad: isLoad, sportKey: sportKey);

          if (nbaSportEventsList.isNotEmpty) {
            for (int i = 0; i < nbaSportEventsList.length; i++) {
              if (nbaSportEventsList[i].uuids != null) {
                boxScoreNBAResponse(
                    sportKey: sportKey,
                    homeTeamId: replaceId(
                        nbaSportEventsList[i].competitors[0].uuids ?? '') ??
                        "",
                    awayTeamId: replaceId(
                        nbaSportEventsList[i].competitors[1].uuids ?? '') ??
                        "",
                    gameId: replaceId(nbaSportEventsList[i].uuids ?? ''),
                    index: i);
              }
            }
          }
        });
        if (nbaTodayEventsList.isNotEmpty) {
          timer = Timer.periodic(const Duration(seconds: 45), (t) {
            nbaTodayEventsList.clear();
            gameListingTodayApiRes(
                key: apiKey,
                isLoad: false,
                sportKey: sportKey,
                date: date,
                sportId: sportId)
                .then((value) async {
              gameListingTodayApiRes(
                  key: apiKey,
                  isLoad: false,
                  sportKey: sportKey,
                  date: DateFormat('yyyy-MM-dd').format(
                      DateTime.parse(date).add(const Duration(days: 1))),
                  sportId: sportId)
                  .then((value) async {
                for (int i = 0; i < nbaTodayEventsList.length; i++) {
                  int liveIndex = nbaSportEventsList.indexWhere(
                          (element) => element.id == nbaTodayEventsList[i].id);
                  if (liveIndex >= 0) {
                    setOdds(nbaSportEventsList[liveIndex]);
                  }
                  if (((DateTime.parse(nbaTodayEventsList[i].scheduled ?? "")
                      .toLocal())
                      .day ==
                      DateTime
                          .now()
                          .toLocal()
                          .day) &&
                      nbaTodayEventsList[i].status != GameStatus.closed.name) {
                    if (nbaTodayEventsList[i].uuids != null) {
                      boxScoreNBAResponse(
                          sportKey: sportKey,
                          homeTeamId: replaceId(
                              nbaTodayEventsList[i].competitors[0].uuids ??
                                  '') ??
                              "",
                          awayTeamId: replaceId(
                              nbaTodayEventsList[i].competitors[1].uuids ??
                                  '') ??
                              "",
                          gameId: replaceId(nbaTodayEventsList[i].uuids ?? ''),
                          index: i);
                    }
                  }
                }
              });
            });
            update();
          });
        }
      });
    });
  }

  Future<void> nbaGameRefreshCall(bool isLoad,
      {String apiKey = '',
        String sportKey = '',
        String date = '',
        String sportId = ''}) async {
    nbaTodayEventsList.clear();
    gameListingTodayApiRes(
        key: apiKey,
        isLoad: isLoad,
        sportKey: sportKey,
        date: date,
        sportId: sportId)
        .then((value) {
      gameListingTodayApiRes(
          key: apiKey,
          isLoad: isLoad,
          sportKey: sportKey,
          date: DateFormat('yyyy-MM-dd')
              .format(DateTime.parse(date).add(const Duration(days: 1))),
          sportId: sportId)
          .then((value) {
        isLoading.value = false;
        isPagination = isLoad;
        nbaTomorrowEventsList.clear();
        gameListingTomorrowApiRes(
            key: apiKey,
            isLoad: isLoad,
            sportKey: sportKey,
            date: DateFormat('yyyy-MM-dd')
                .format(DateTime.parse(date).add(const Duration(days: 2))),
            sportId: sportId)
            .then((value) async {
          getAllEventList(sportKey, isLoad);
          isPagination = false;
          gameListingsWithLogoResponseNCAAB(currentYear, sportKey,
              isLoad: isLoad);
          nbaGameRankApi(isLoad: isLoad, sportKey: sportKey);

          if (nbaSportEventsList.isNotEmpty) {
            for (int i = 0; i < nbaSportEventsList.length; i++) {
              if (nbaSportEventsList[i].uuids != null) {
                boxScoreNBAResponse(
                    sportKey: sportKey,
                    homeTeamId: replaceId(
                        nbaSportEventsList[i].competitors[0].uuids ?? '') ??
                        "",
                    awayTeamId: replaceId(
                        nbaSportEventsList[i].competitors[1].uuids ?? '') ??
                        "",
                    gameId: replaceId(nbaSportEventsList[i].uuids ?? ''),
                    index: i);
              }
            }
          }
        });
      });
    });
  }

  Future<void> getGameListingForNCAABRes(bool isLoad, {
    String apiKey = '',
    String sportKey = '',
    String date = '',
    String sportId = '',
  }) async {
    // Clear any existing timers first
    if (timer != null) {
      timer!.cancel();
      timer = null;
    }
    
    // Reset data and show loading state
    log("Starting NCAAB data load...", name: "NCAAB");
    ncaabTodayEventsList = [];
    ncaabTomorrowEventsList = [];
    ncaabSportEventsList = [];
    isLoading.value = true;
    update();
    
    try {
      // Load NCAAB data directly rather than through gameListingTodayApiRes
      // This ensures we're using the specialized NCAAB API endpoint
      log("Fetching NCAAB games data...", name: "NCAAB");
      
      // Format date correctly for API
      String formattedDate = date.isNotEmpty 
          ? date 
          : DateTime.now().toString().substring(0, 10).replaceAll('-', '/');
      
      log("Using date: $formattedDate for NCAAB API call", name: "NCAAB");
      
      // Make three API calls - yesterday, today, and tomorrow
      // This ensures we have games that may have started yesterday but are still ongoing,
      // today's games, and upcoming games for tomorrow
      List<SportEvents> allGames = [];
      
      // Yesterday's games (for ongoing games)
      DateTime yesterday = DateTime.now().subtract(const Duration(days: 1));
      String yesterdayDate = "${yesterday.year}/${yesterday.month.toString().padLeft(2, '0')}/${yesterday.day.toString().padLeft(2, '0')}";
      
      // Today's games
      DateTime today = DateTime.now();
      String todayDate = "${today.year}/${today.month.toString().padLeft(2, '0')}/${today.day.toString().padLeft(2, '0')}";
      
      // Tomorrow's games
      DateTime tomorrow = DateTime.now().add(const Duration(days: 1));
      String tomorrowDate = "${tomorrow.year}/${tomorrow.month.toString().padLeft(2, '0')}/${tomorrow.day.toString().padLeft(2, '0')}";
      
      log("Fetching NCAAB games for dates: $yesterdayDate, $todayDate, $tomorrowDate", name: "NCAAB");
      
      // Make API calls for all three dates to ensure full coverage of games
      try {
        // Yesterday (primarily for in-progress games)
        ResponseItem resultYesterday = await GameListingRepo().gameListingRepoNCAAB(
          date: yesterdayDate,
          key: AppUrls.NCAAB_APIKEY
        );
        
        if (resultYesterday.status && resultYesterday.data != null) {
          final gameModel = GameListingDataModel.fromJson(resultYesterday.data);
          if (gameModel.sportEvents != null && gameModel.sportEvents!.isNotEmpty) {
            // Only add games that are in progress or starting really late
            for (var game in gameModel.sportEvents!) {
              if (game.status == GameStatus.live.name || 
                  game.status == GameStatus.inprogress.name || 
                  game.status == GameStatus.halftime.name) {
                allGames.add(game);
              }
            }
          }
        }
        
        // Today
        ResponseItem resultToday = await GameListingRepo().gameListingRepoNCAAB(
          date: todayDate,
          key: AppUrls.NCAAB_APIKEY
        );
        
        // Tomorrow
        ResponseItem resultTomorrow = await GameListingRepo().gameListingRepoNCAAB(
          date: tomorrowDate,
          key: AppUrls.NCAAB_APIKEY
        );
        
        // Process today's games
        if (resultToday.status && resultToday.data != null) {
          final gameModel = GameListingDataModel.fromJson(resultToday.data);
          if (gameModel.sportEvents != null && gameModel.sportEvents!.isNotEmpty) {
            allGames.addAll(gameModel.sportEvents!);
          }
        }
        
        // Process tomorrow's games
        if (resultTomorrow.status && resultTomorrow.data != null) {
          final gameModel = GameListingDataModel.fromJson(resultTomorrow.data);
          if (gameModel.sportEvents != null && gameModel.sportEvents!.isNotEmpty) {
            allGames.addAll(gameModel.sportEvents!);
          }
        }
        
        log("Total NCAAB games found across all dates: ${allGames.length}", name: "NCAAB");
      } catch (e) {
        log("Error fetching NCAAB games for multiple dates: $e", name: "NCAAB");
      }
      
      // Process the combined results
      if (allGames.isNotEmpty) {
        log("Processing ${allGames.length} NCAAB games", name: "NCAAB");
        
        // Add all games to the main list
        ncaabSportEventsList.addAll(allGames);
        
        // Categorize games by date
        final today = DateTime.now().toLocal();
        final tomorrow = today.add(const Duration(days: 1));
        
        for (var game in allGames) {
          if (game.scheduled != null) {
            final gameDate = DateTime.parse(game.scheduled!).toLocal();
            
            // Today's games
            if (gameDate.year == today.year && 
                gameDate.month == today.month && 
                gameDate.day == today.day) {
              ncaabTodayEventsList.add(game);
            }
            // Tomorrow's games
            else if (gameDate.year == tomorrow.year && 
                     gameDate.month == tomorrow.month && 
                     gameDate.day == tomorrow.day) {
              ncaabTomorrowEventsList.add(game);
            }
          }
        }
        
        log("Today's games: ${ncaabTodayEventsList.length}", name: "NCAAB");
        log("Tomorrow's games: ${ncaabTomorrowEventsList.length}", name: "NCAAB");
      } else {
        log("No NCAAB games found across all dates", name: "NCAAB");
      }
      
      // Set up team and player info
      getAllEventList(sportKey, isLoad);
      
      // Load conference data (important for possible future filtering)
      await getConferenceNCAAB(false);
      
      // Get logos and other metadata
      gameListingsWithLogoResponseNCAAB(currentYear, sportKey, isLoad: false);
      
      // Check if we have data
      if (ncaabSportEventsList.isEmpty) {
        log("WARNING: No NCAAB games were loaded", name: "NCAAB");
      }
      
      // Turn off loading state and first load flag
      isLoading.value = false;
      isFirstLoad = false;
      update();
    } catch (e) {
      log("Error loading NCAAB data: $e", name: "NCAAB");
      isLoading.value = false;
      isFirstLoad = false;
      update();
    }
  }

  Future<void> ncaabGameRefreshCall(bool isLoad, {
    String apiKey = '',
    String sportKey = '',
    String date = '',
    String sportId = '',
  }) async {
    // Use the same simplified approach as getGameListingForNCAABRes
    return await getGameListingForNCAABRes(
      isLoad,
      apiKey: apiKey,
      sportKey: sportKey,
      date: date,
      sportId: sportId
    );
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
                      for (var element in (getSportEventList(sportKey))) {
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
      // isLoading.value = false;
      // showAppSnackBar(
      //   errorText,
      // );
    }
    update();
  }

  void gameListingsWithLogoResponseNCAAB(String year, String sportKey,
      {bool isLoad = false}) async {
    ResponseItem result =
    ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo().gameListingsWithLogoForNCAAB(sportKey);
    try {
      isLoading.value=isLoad;
      if (result.status) {
        TeamLogoModel response = TeamLogoModel.fromJson(result.data);
        try {
          if (response.sports != null) {
            for (var element in (getSportEventList(sportKey))) {
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
              response.sports?.forEach((sport) {
                sport.leagues?.forEach((league) {
                  league.teams?.forEach((team) {
                    if (team.team?.abbreviation == awayTeam?.abbreviation ||
                        team.team?.displayName == awayTeam?.name) {
                      if (team.team?.logos != null) {
                        element.awayGameLogo = team.team?.logos?[0].href;
                      }
                    }
                    if (team.team?.abbreviation == homeTeam?.abbreviation ||
                        team.team?.displayName == homeTeam?.name) {
                      if (team.team?.logos != null) {
                        element.homeGameLogo = team.team?.logos?[0].href;
                      }
                    }
                  });
                });
              });
            }
          }
        } catch (e) {
          log('error--$e');
        }
        isLoading.value = false;
      } else {}
    } catch (e) {
      isLoading.value = false;
    }
    update();
  }

  Future getWeather(String cityName,
      {bool isLoad = false, int index = 0, required String sportKey}) async {
    ResponseItem result =
    ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo().getWeather(cityName
        .split(',')
        .first);
    try {
      if (result.status) {
        if (result.data != null) {
          (sportKey == SportName.MLB.name
              ? mlbSportEventsList
              : sportKey == SportName.NFL.name
              ? nflSportEventsList
              : ncaaSportEventsList)[index]
              .weather = result.data['weather'][0]['id'];
          (sportKey == SportName.MLB.name
              ? mlbSportEventsList
              : sportKey == SportName.NFL.name
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
      // isLoading.value = false;
      log('ERROR WEATHER----$e');
      // showAppSnackBar(e.toString());
    }
    update();
  }
}
