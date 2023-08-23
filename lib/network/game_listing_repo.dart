import 'package:hotlines/extras/extras.dart';
import '../model/response_item.dart';

class GameListingRepo {
  ///GAME LISTING
  Future<ResponseItem> gameListingRepo(
      {String date = '', String spotId = '', String key = ''}) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = "";

    Uri uri = Uri.parse(
        '${AppUrls.BASE_URL}en/us/sports/$spotId/$date/schedule.json?api_key=$key');

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
        '${AppUrls.MLB_BASE_URL}games/$gameId/boxscore.json?api_key=5hnm7xhtgc8q22q2x4w6urvb');

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
        '${AppUrls.MLB_BASE_URL}seasons/$seasons/REG/teams/$teamId/statistics.json?api_key=5hnm7xhtgc8q22q2x4w6urvb');

    result = await BaseApiHelper.getRequest(uri, {});
    status = result.status;
    data = result.data;
    message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  Future<ResponseItem> mlbHitterStatsRepo({String playerId = ''}) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = "";
    Uri uri = Uri.parse(
        '${AppUrls.MLB_BASE_URL}players/$playerId/profile.json?api_key=5hnm7xhtgc8q22q2x4w6urvb');

    result = await BaseApiHelper.getRequest(uri, {});
    status = result.status;
    data = result.data;
    message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  ///NFL STATICS
  Future<ResponseItem> nflStaticsRepo(
      {String teamId = '', String seasons = ''}) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = "";
    Uri uri = Uri.parse(
        '${AppUrls.NFL_BASE_URL}seasons/$seasons/REG/teams/$teamId/statistics.json?api_key=h4kantpwh2rhn783gdh6theg');

    result = await BaseApiHelper.getRequest(uri, {});
    status = result.status;
    data = result.data;
    message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  ///PLAYER PROPS API(HOTLINES)
  Future<ResponseItem> hotlinesDataRepo(
      {String sportId = '', String date = '', int start = 0}) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = "";
    Uri uri = Uri.parse(
        'https://api.sportradar.com/oddscomparison-player-props/production/v2/en/sports/$sportId/schedules/$date/players_props.json?api_key=u647s6e6thkuae4n63kkcvhz&start=$start&limit=5');

    result = await BaseApiHelper.getRequest(uri, {});
    status = result.status;
    data = result.data;
    message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  ///MLB INJURIES API
  Future<ResponseItem> mlbInjuriesRepo() async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = "";
    Uri uri = Uri.parse(
        '${AppUrls.MLB_BASE_URL}league/injuries.json?api_key=5hnm7xhtgc8q22q2x4w6urvb');

    result = await BaseApiHelper.getRequest(uri, {});
    status = result.status;
    data = result.data;
    message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  ///OTHER APIS
  Future<ResponseItem> gameListingsWithLogo(
      String year, String sportKey) async {
    ResponseItem result;
    var params = {"year": year};

    Uri parameter;
    Uri uri = Uri.parse(
        'https://sports-information.p.rapidapi.com/${sportKey == 'MLB' ? 'mlb' : sportKey == 'NCAA' ? 'cfb' : 'nfl'}/schedule?year=$year');
    parameter = uri.replace(queryParameters: params);

    result = await BaseApiHelper.getRequest(parameter, {
      'X-RapidAPI-Key': '08caae6c2bmsh572aebe4b01a829p14475ejsn8e6b0956f735',
      'X-RapidAPI-Host': 'sports-information.p.rapidapi.com'
    });
    return result;
  }
}
