import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hotlines/extras/extras.dart';

import '../model/response_item.dart';

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

    Uri uri = Uri.parse(
        '${AppUrls.BASE_URL}en/us/sports/$spotId/$date/schedule.json?api_key=$key&start=${start.toString()}');

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

  ///NCAA RANKING
  Future<ResponseItem> ncaaGameRanking(String sportName) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = "";

    Uri uri = Uri.parse(sportName == "NCAAB"
        ? "${AppUrls.NCAAB_BASE_URL}polls/us/$currentYear/rankings.json?api_key=${AppUrls.NCAAB_APIKEY}"
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

    Uri uri = Uri.parse(sportKey == "NBA"
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

    Uri uri = Uri.parse(sportKey == "NCAA"
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

    Uri uri = Uri.parse(sportKey == "NCAA"
        ? '${AppUrls.NCAA_BASE_URL}seasons/$currentYear/REG/standings/season.json?api_key=${AppUrls.NCAA_APIKEY}'
        : sportKey == "NBA"
            ? "${AppUrls.NBA_BASE_URL}seasons/$currentYear/REG/standings.json?api_key=${AppUrls.NBA_APIKEY}"
            : sportKey == "NCAAB"
                ? "${AppUrls.NCAAB_BASE_URL}seasons/$currentYear/REG/standings.json?api_key=${AppUrls.NCAAB_APIKEY}"
                : "${AppUrls.NFL_BASE_URL}seasons/$currentYear/REG/standings/season.json?api_key=${AppUrls.NFL_APIKEY}");

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
        '${AppUrls.MLB_BASE_URL}seasons/$seasons/REG/teams/$teamId/statistics.json?api_key=${AppUrls.MLB_APIKEY}');

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
    Uri uri = Uri.parse(sportKey == "NFL"
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
    Uri uri = Uri.parse(sportKey == "NFL"
        ? '${AppUrls.NFL_BASE_URL}seasons/$seasons/REG/teams/$teamId/statistics.json?api_key=${AppUrls.NFL_APIKEY}'
        : '${AppUrls.NCAA_BASE_URL}seasons/$seasons/REG/teams/$teamId/statistics.json?api_key=${AppUrls.NCAA_APIKEY}');

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
    Uri uri = Uri.parse(sportKey == "NBA"
        ? '${AppUrls.NBA_BASE_URL}seasons/$currentYear/REG/teams/$teamId/statistics.json?api_key=${AppUrls.NBA_APIKEY}'
        : '${AppUrls.NCAAB_BASE_URL}seasons/$currentYear/REG/teams/$teamId/statistics.json?api_key=${AppUrls.NCAAB_APIKEY}');

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
    Uri uri = Uri.parse(sportKey == "NBA"
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
    Uri uri = Uri.parse(sportKey == "NFL"
        ? '${AppUrls.NFL_BASE_URL}seasons/$currentYear/REG/${DateTime.now().weekday}/depth_charts.json?api_key=${AppUrls.NFL_APIKEY}'
        : '${AppUrls.NCAA_BASE_URL}seasons/$currentYear/REG/${DateTime.now().weekday}/depth_charts.json?api_key=${AppUrls.NCAA_APIKEY}');

    result = await BaseApiHelper.getRequest(uri, {});
    status = result.status;
    data = result.data;
    message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  ///NBA RUSHING ROSTER
  Future<ResponseItem> nbaRosterRepo(
      {String teamId = '', String seasons = '', String sportKey = ''}) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = "";
    Uri uri = Uri.parse(sportKey == "NBA"
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
    Uri uri = Uri.parse(sportKey == "MLB"
        ? '${AppUrls.MLB_BASE_URL}league/injuries.json?api_key=${AppUrls.MLB_APIKEY}'
        : sportKey == "NBA"
            ? '${AppUrls.NBA_BASE_URL}league/injuries.json?api_key=${AppUrls.NBA_APIKEY}'
            : '${AppUrls.NFL_BASE_URL}seasons/$currentYear/REG/01/injuries.json?api_key=${AppUrls.NFL_APIKEY}');

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
    var queryParameters = sportKey == "NFL"
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
    var queryParameters = sportKey == "NFL"
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
      RequestParam.service: sportKey == "NBA"
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
        'https://sports-information.p.rapidapi.com/${sportKey == 'MLB' ? 'mlb' : sportKey == 'NCAA' ? 'cfb' : sportKey == 'NFL' ? 'nfl' : sportKey == 'NBA' ? "nba" : "mbb"}/schedule?year=$year');
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
        'https://sports-information.p.rapidapi.com/${sportKey == 'MLB' ? 'mlb' : sportKey == 'NCAA' ? 'cfb' : sportKey == 'NFL' ? 'nfl' : sportKey == 'NBA' ? "nba" : "mbb"}/team-list?group=2');
    parameter = uri.replace();

    result = await BaseApiHelper.getRequest(parameter, {
      'X-RapidAPI-Key': dotenv.env['X-RapidAPI-Key']??"",
      'X-RapidAPI-Host': 'sports-information.p.rapidapi.com'
    });
    return result;
  }
}
