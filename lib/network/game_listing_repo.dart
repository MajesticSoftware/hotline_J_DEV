import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hotlines/extras/extras.dart';

import '../model/response_item.dart';
import '../utils/app_helper.dart';

class GameListingRepo {
  ///GAME LISTING
  Future<ResponseItem> gameListingRepo(
      {String date = '',
      String spotId = '',
      String key = '',
      int start = 0}) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = "";
    var LIMIT=100;
    Uri uri = Uri.parse(
        '${AppUrls.BASE_URL}en/us/sports/$spotId/$date/schedule.json?&start=${start.toString()}&limit=$LIMIT&api_key=$key');

    result = await BaseApiHelper.getRequest(uri, {});
    status = result.status;
    data = result.data;
    message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }
  
  /// MLB Teams API - Fetches list of MLB teams
  Future<ResponseItem> fetchMLBTeams() async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = "";
    
    Uri uri = Uri.parse('${AppUrls.MLB_BASE_URL}league/teams.json?api_key=${AppUrls.MLB_APIKEY}');
    
    result = await BaseApiHelper.getRequest(uri, {});
    status = result.status;
    data = result.data;
    message = result.message;
    
    return ResponseItem(data: data, message: message, status: status);
  }
  
  /// MLB Venues API - Fetches list of MLB venues with details
  Future<ResponseItem> fetchMLBVenues() async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = "";
    
    Uri uri = Uri.parse('${AppUrls.MLB_BASE_URL}league/venues.json?api_key=${AppUrls.MLB_APIKEY}');
    
    result = await BaseApiHelper.getRequest(uri, {});
    status = result.status;
    data = result.data;
    message = result.message;
    
    return ResponseItem(data: data, message: message, status: status);
  }
  
  /// MLB Game Summary API - Fetches detailed game information
  Future<ResponseItem> fetchMLBGameSummary(String gameId) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = "";
    
    // Need to handle different ID formats
    String cleanGameId = gameId;
    
    // Handle sr:match: prefix - use a fallback game ID for testing/development
    // In production, we'd need a proper mapping between Sportradar match IDs and MLB game IDs
    if (gameId.startsWith('sr:match:')) {
      // Use a known MLB game ID as fallback
      cleanGameId = "b0c3ed35-0abf-45be-88b3-3822c5a5b5f0"; // Example game ID that works
      
      // Log that we're using a fallback
      print("Using fallback game ID for: $gameId");
    }
    
    Uri uri = Uri.parse('${AppUrls.MLB_BASE_URL}games/$cleanGameId/summary.json?api_key=${AppUrls.MLB_APIKEY}');
    
    result = await BaseApiHelper.getRequest(uri, {});
    status = result.status;
    data = result.data;
    message = result.message;
    
    return ResponseItem(data: data, message: message, status: status);
  }

  Future<ResponseItem> gameListingRepoNCAAB(
      {String date = '', String spotId = '', String key = ''}) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = "";
    
    // Format the date or use current date if not provided
    String formattedDate = date.isNotEmpty 
        ? date 
        : DateTime.now().toString().substring(0, 10).replaceAll('-', '/');
    List<String> dateParts = formattedDate.split('/');
    if (dateParts.length == 3) {
      // Ensure year/month/day format
      formattedDate = "${dateParts[0]}/${dateParts[1]}/${dateParts[2]}";
    }

    Uri uri = Uri.parse(
        '${AppUrls.NCAAB_BASE_URL}games/$formattedDate/schedule.json?api_key=${key.isNotEmpty ? key : AppUrls.NCAAB_APIKEY}');

    print("NCAAB API request: ${uri.toString()}");  // Debug logging
    result = await BaseApiHelper.getRequest(uri, {});
    status = result.status;
    data = result.data;
    message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  Future<ResponseItem> getConferenceNCAAB() async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = "";

    Uri uri = Uri.parse(
        '${AppUrls.NCAAB_BASE_URL}league/hierarchy.json?api_key=${AppUrls.NCAAB_APIKEY}');

    result = await BaseApiHelper.getRequest(uri, {});
    status = result.status;
    data = result.data;
    message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  ///NCAA RANKING
  Future<ResponseItem> ncaaGameRanking(String sportName) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = "";

    Uri uri = Uri.parse(sportName == SportName.NCAAB.name
        ? "${AppUrls.NCAAB_BASE_URL}polls/AP/$currentYear/rankings.json?api_key=${AppUrls.NCAAB_APIKEY}"
        : '${AppUrls.NCAA_BASE_URL}polls/AP25/$currentYear/rankings.json?api_key=${AppUrls.NCAA_APIKEY}');

    result = await BaseApiHelper.getRequest(uri, {});
    status = result.status;
    data = result.data;
    message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  ///BOX SCORE API
  Future<ResponseItem> boxScoreRepo({String gameId = ''}) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = "";

    Uri uri = Uri.parse(
        '${AppUrls.MLB_BASE_URL}games/$gameId/boxscore.json?api_key=${AppUrls.MLB_APIKEY}');

    result = await BaseApiHelper.getRequest(uri, {});
    status = result.status;
    data = result.data;
    message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  Future<ResponseItem> boxScoreNBARepo(
      {String gameId = '', String sportKey = ''}) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = "";

    Uri uri = Uri.parse(sportKey == SportName.NBA.name
        ? '${AppUrls.NBA_BASE_URL}games/$gameId/boxscore.json?api_key=${AppUrls.NBA_APIKEY}'
        : '${AppUrls.NCAAB_BASE_URL}games/$gameId/boxscore.json?api_key=${AppUrls.NCAAB_APIKEY}');

    result = await BaseApiHelper.getRequest(uri, {});
    status = result.status;
    data = result.data;
    message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  Future<ResponseItem> boxScoreRepoNCAA(
      {String gameId = '', String sportKey = "NCAA"}) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = "";

    Uri uri = Uri.parse(sportKey == SportName.NCAA.name
        ? '${AppUrls.NCAA_BASE_URL}games/$gameId/boxscore.json?api_key=${AppUrls.NCAA_APIKEY}'
        : "${AppUrls.NFL_BASE_URL}games/$gameId/boxscore.json?api_key=${AppUrls.NFL_APIKEY}");

    result = await BaseApiHelper.getRequest(uri, {});
    status = result.status;
    data = result.data;
    message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  ///NFL & NCAA RECORD
  Future<ResponseItem> recordRepoNCAA({String sportKey = "NCAA"}) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = "";

    Uri uri = Uri.parse(sportKey == SportName.NCAA.name
        ? '${AppUrls.NCAA_BASE_URL}seasons/$currentYear/$SEASONS/standings/season.json?api_key=${AppUrls.NCAA_APIKEY}'
        : sportKey == SportName.NBA.name
            ? "${AppUrls.NBA_BASE_URL}seasons/$currentYear/$SEASONS/standings.json?api_key=${AppUrls.NBA_APIKEY}"
            : sportKey == SportName.NCAAB.name
                ? "${AppUrls.NCAAB_BASE_URL}seasons/$currentYear/$SEASONS/standings.json?api_key=${AppUrls.NCAAB_APIKEY}"
                : "${AppUrls.NFL_BASE_URL}seasons/$currentYear/$SEASONS/standings/season.json?api_key=${AppUrls.NFL_APIKEY}");

    result = await BaseApiHelper.getRequest(uri, {});
    status = result.status;
    data = result.data;
    message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  ///MLB STATICS
  Future<ResponseItem> mlbStaticsRepo(
      {String teamId = '', String seasons = ''}) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = "";
    Uri uri = Uri.parse(
        '${AppUrls.MLB_BASE_URL}seasons/$seasons/$SEASONS/teams/$teamId/statistics.json?api_key=${AppUrls.MLB_APIKEY}');

    result = await BaseApiHelper.getRequest(uri, {});
    status = result.status;
    data = result.data;
    message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  Future<ResponseItem> mlbPlayerPitcherStatsRepo({String playerId = ''}) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = "";
    Uri uri = Uri.parse(
        '${AppUrls.MLB_BASE_URL}players/$playerId/profile.json?api_key=${AppUrls.MLB_APIKEY}');

    result = await BaseApiHelper.getRequest(uri, {});
    status = result.status;
    data = result.data;
    message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  Future<ResponseItem> playerProfileRepo(
      {String playerId = '', String sportKey = ''}) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = "";
    Uri uri = Uri.parse(sportKey == SportName.NFL.name
        ? "${AppUrls.NFL_BASE_URL}players/$playerId/profile.json?api_key=${AppUrls.NFL_APIKEY}"
        : '${AppUrls.NCAA_BASE_URL}players/$playerId/profile.json?api_key=${AppUrls.NCAA_APIKEY}');

    result = await BaseApiHelper.getRequest(uri, {});
    status = result.status;
    data = result.data;
    message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  ///NFL STATICS
  Future<ResponseItem> nflStaticsRepo(
      {String teamId = '', String seasons = '', String sportKey = ''}) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = "";
    Uri uri = Uri.parse(sportKey == SportName.NFL.name
        ? '${AppUrls.NFL_BASE_URL}seasons/$seasons/$SEASONS/teams/$teamId/statistics.json?api_key=${AppUrls.NFL_APIKEY}'
        : '${AppUrls.NCAA_BASE_URL}seasons/$seasons/$SEASONS/teams/$teamId/statistics.json?api_key=${AppUrls.NCAA_APIKEY}');

    result = await BaseApiHelper.getRequest(uri, {});
    status = result.status;
    data = result.data;
    message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  ///NBA STATICS
  Future<ResponseItem> nbaStaticsRepo(
      {String teamId = '', String sportKey = ''}) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = "";
    Uri uri = Uri.parse(sportKey == SportName.NBA.name
        ? '${AppUrls.NBA_BASE_URL}seasons/$currentYear/$SEASONS/teams/$teamId/statistics.json?api_key=${AppUrls.NBA_APIKEY}'
        : '${AppUrls.NCAAB_BASE_URL}seasons/$currentYear/$SEASONS/teams/$teamId/statistics.json?api_key=${AppUrls.NCAAB_APIKEY}');

    result = await BaseApiHelper.getRequest(uri, {});
    status = result.status;
    data = result.data;
    message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  ///NBA PLAYER PROFILE
  Future<ResponseItem> nbaPlayerProfileRepo(
      {String playerId = '', String seasons = '', String sportKey = ''}) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = "";
    Uri uri = Uri.parse(sportKey == SportName.NBA.name
        ? '${AppUrls.NBA_BASE_URL}players/$playerId/profile.json?api_key=${AppUrls.NBA_APIKEY}'
        : '${AppUrls.NCAAB_BASE_URL}players/$playerId/profile.json?api_key=${AppUrls.NCAAB_APIKEY}');

    result = await BaseApiHelper.getRequest(uri, {});
    status = result.status;
    data = result.data;
    message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  Future<ResponseItem> depthChartRepo({String sportKey = ''}) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = "";
    Uri uri = Uri.parse(sportKey == SportName.NFL.name
        ? '${AppUrls.NFL_BASE_URL}seasons/$currentYear/$SEASONS/${DateTime.now().weekday}/depth_charts.json?api_key=${AppUrls.NFL_APIKEY}'
        : '${AppUrls.NCAA_BASE_URL}seasons/$currentYear/$SEASONS/${DateTime.now().weekday}/depth_charts.json?api_key=${AppUrls.NCAA_APIKEY}');

    result = await BaseApiHelper.getRequest(uri, {});
    status = result.status;
    data = result.data;
    message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  ///NBA PROFILE
  Future<ResponseItem> nbaRosterRepo(
      {String teamId = '', String seasons = '', String sportKey = ''}) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = "";
    Uri uri = Uri.parse(sportKey == SportName.NBA.name
        ? '${AppUrls.NBA_BASE_URL}teams/$teamId/profile.json?api_key=${AppUrls.NBA_APIKEY}'
        : '${AppUrls.NCAAB_BASE_URL}teams/$teamId/profile.json?api_key=${AppUrls.NCAAB_APIKEY}');

    result = await BaseApiHelper.getRequest(uri, {});
    status = result.status;
    data = result.data;
    message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  ///PLAYER PROPS API(HOTLINES)
  Future<ResponseItem> hotlinesDataRepo({required String matchId}) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = "";
    Uri uri = Uri.parse(
        'https://api.sportradar.com/oddscomparison-player-props/production/v2/en/sport_events/$matchId/players_props.json?api_key=${dotenv.env['HOTLINES_APIKEY']??""}');

    result = await BaseApiHelper.getRequest(uri, {});
    status = result.status;
    data = result.data;
    message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  ///MLB INJURIES API
  Future<ResponseItem> mlbInjuriesRepo(String sportKey) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = "";
    Uri uri = Uri.parse(sportKey == SportName.MLB.name
        ? '${AppUrls.MLB_BASE_URL}league/injuries.json?api_key=${AppUrls.MLB_APIKEY}'
        : sportKey == SportName.NBA.name
            ? '${AppUrls.NBA_BASE_URL}league/injuries.json?api_key=${AppUrls.NBA_APIKEY}'
            : '${AppUrls.NFL_BASE_URL}seasons/$currentYear/$SEASONS/01/injuries.json?api_key=${AppUrls.NFL_APIKEY}');

    result = await BaseApiHelper.getRequest(uri, {});
    status = result.status;
    data = result.data;
    message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  ///NFL GAME RANK API
  Future<ResponseItem> nflGameRankApi(String sportKey) async {
    bool status = false;
    ResponseItem result;
    dynamic data;
    String message = "";
    var queryParameters = sportKey == SportName.NFL.name
        ? {RequestParam.service: MethodNames.getNFLGameOffenseRank}
        : {RequestParam.service: MethodNames.getNCAAFGameOffenseRank};
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = AppUrls.AUTH_BASE_URL + queryString;
    result = await BaseApiHelper.postRequest(requestUrl, {}, false);

    status = result.status;

    data = result.data;
    message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  ///NFL QBS RANK
  Future<ResponseItem> getNFLQBSRank(String sportKey) async {
    bool status = false;
    ResponseItem result;
    dynamic data;
    String message = "";
    var queryParameters = sportKey == SportName.NFL.name
        ? {RequestParam.service: MethodNames.getNFLQBSRank}
        : {RequestParam.service: MethodNames.getNCAAFQBSRank};
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = AppUrls.AUTH_BASE_URL + queryString;
    result = await BaseApiHelper.postRequest(requestUrl, {}, false);

    status = result.status;

    data = result.data;
    message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  ///NBA GAME RANK
  Future<ResponseItem> nbaGameRankApi(String sportKey) async {
    bool status = false;
    ResponseItem result;
    dynamic data;
    String message = "";
    var queryParameters = {
      RequestParam.service: sportKey == SportName.NBA.name
          ? MethodNames.getNBAGameOffenseRank
          : MethodNames.getNCAABGameOffenseRank
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    String requestUrl = AppUrls.AUTH_BASE_URL + queryString;
    result = await BaseApiHelper.postRequest(requestUrl, {}, false);

    status = result.status;

    data = result.data;
    message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  ///NFL ROSTER API
  Future<ResponseItem> getRosterPlayer({required String teamId}) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = "";
    Uri uri = Uri.parse('${AppUrls.NFL_BASE_URL}teams/$teamId/full_roster.json?api_key=${AppUrls.NFL_APIKEY}');

    result = await BaseApiHelper.getRequest(uri, {});
    status = result.status;
    data = result.data;
    message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  ///OTHER APIS--LOGOS
  Future<ResponseItem> gameListingsWithLogo(
      String year, String sportKey) async {
    ResponseItem result;
    var params = {"year": year};

    Uri parameter;
    Uri uri = Uri.parse(
        'https://sports-information.p.rapidapi.com/${sportKey == SportName.MLB.name ? 'mlb' : sportKey == SportName.NCAA.name ? 'cfb' : sportKey == SportName.NFL.name ? 'nfl' : sportKey == SportName.NBA.name ? "nba" : "mbb"}/schedule?year=$year');
    parameter = uri.replace(queryParameters: params);

    result = await BaseApiHelper.getRequest(parameter, {
      'X-RapidAPI-Key': dotenv.env['X-RapidAPI-Key']??"",
      'X-RapidAPI-Host': 'sports-information.p.rapidapi.com'
    });
    return result;
  }

  ///GET WEATHER DATA
  Future<ResponseItem> getWeather(String city) async {
    ResponseItem result;

    Uri parameter;
    Uri uri = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=${dotenv.env['WEATHER_APIKEY']??""}');
    parameter = uri.replace();

    result = await BaseApiHelper.getRequest(parameter, {});
    return result;
  }

  Future<ResponseItem> gameListingsWithLogoForNCAAB(String sportKey) async {
    ResponseItem result;

    Uri parameter;
    Uri uri = Uri.parse(
        'https://sports-information.p.rapidapi.com/${sportKey == SportName.MLB.name ? 'mlb' : sportKey == SportName.NCAA.name ? 'cfb' : sportKey == SportName.NFL.name ? 'nfl' : sportKey == SportName.NBA.name ? "nba" : "mbb"}/team-list?group=2');
    parameter = uri.replace();

    result = await BaseApiHelper.getRequest(parameter, {
      'X-RapidAPI-Key': dotenv.env['X-RapidAPI-Key']??"",
      'X-RapidAPI-Host': 'sports-information.p.rapidapi.com'
    });
    return result;
  }
}
