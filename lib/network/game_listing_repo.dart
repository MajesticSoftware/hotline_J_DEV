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

  Future<ResponseItem> gameListingRepoNCAAB(
      {String date = '', String spotId = '', String key = ''}) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = "";

    Uri uri = Uri.parse(
        '${AppUrls.NCAAB_BASE_URL}games/2024/02/03/schedule.json?api_key=${AppUrls.NCAAB_APIKEY}');

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
  
  ///MLB STANDINGS & RECORDS
  Future<ResponseItem> mlbStandingsRepo() async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = "";

    Uri uri = Uri.parse(
        '${AppUrls.MLB_BASE_URL}seasons/$currentYear/$SEASONS/standings.json?api_key=${AppUrls.MLB_APIKEY}');
    
    print('📊 MLB STANDINGS API URL: $uri');
    
    result = await BaseApiHelper.getRequest(uri, {});
    status = result.status;
    data = result.data;
    message = result.message;
    
    if (status) {
      print('✅ MLB STANDINGS API SUCCESS: Fetched team records');
    } else {
      print('❌ MLB STANDINGS API FAILED: $message');
    }

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

    // Validate API key exists and isn't empty
    // Try both possible key names from .env file
    String apiKey = dotenv.env['WEATHER_API'] ?? dotenv.env['WEATHER_APIKEY'] ?? "";
    if (apiKey.isEmpty || apiKey == "YOUR_WEATHER_API_KEY") {
      print('❌ WEATHER API ERROR: Valid API key is missing in .env file');
      return ResponseItem(
        status: false, 
        message: "API key is missing or invalid", 
        data: {"error": {"code": -1, "message": "API key not configured properly"}}
      );
    }

    // Log the API key (partially masked for security)
    String maskedKey = apiKey.length > 8 
        ? "${apiKey.substring(0, 4)}...${apiKey.substring(apiKey.length - 4)}" 
        : "key_too_short";
    
    print('🌦️ WEATHER API REQUEST: city=$city, key=$maskedKey');
    
    // Validate city parameter
    if (city.isEmpty) {
      print('❌ WEATHER API ERROR: City name is empty');
      return ResponseItem(
        status: false, 
        message: "Invalid city name", 
        data: {"error": {"code": -2, "message": "City name cannot be empty"}}
      );
    }
    
    try {
      // Encode city name properly for URL
      String encodedCity = Uri.encodeComponent(city);
      
      Uri parameter;
      Uri uri = Uri.parse(
          'https://api.weatherapi.com/v1/forecast.json?q=$encodedCity&days=1&key=$apiKey');
      parameter = uri.replace();
      
      print('🌦️ WEATHER API URL: ${parameter.toString()}');
      
      result = await BaseApiHelper.getRequest(parameter, {});
      
      print('🌦️ WEATHER API RESPONSE STATUS: ${result.status}, message: ${result.message}');
      
      // Check for API error codes specifically
      if (!result.status && result.data is Map) {
        var data = result.data as Map;
        if (data.containsKey('error')) {
          var error = data['error'];
          if (error is Map && error.containsKey('code')) {
            int errorCode = error['code'];
            String errorMsg = error['message'] ?? 'Unknown error';
            
            if (errorCode == 2008) {
              print('❌ WEATHER API ERROR: The API key has been disabled (code 2008)');
              print('⚠️ Please visit your WeatherAPI.com account to check the status of your API key');
              print('⚠️ You may need to verify your email, update billing information, or create a new key');
            } else {
              print('❌ WEATHER API ERROR: Code $errorCode - $errorMsg');
            }
          }
        }
      }
      
      return result;
    } catch (e) {
      print('❌ WEATHER API EXCEPTION: $e');
      return ResponseItem(
        status: false, 
        message: "Exception occurred: $e", 
        data: {"error": {"code": -3, "message": "Exception: $e"}}
      );
    }
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
