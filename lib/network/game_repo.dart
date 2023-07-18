import '../extras/base_api_helper.dart';
import '../extras/request_constants.dart';
import '../model/response_item.dart';

class GameRepo {
  Future<ResponseItem> gameListings(String sportKey, String date) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = "";

    var params = {"league": sportKey, 'date': date};

    Uri parameter;
    Uri uri = Uri.parse(AppUrls.BASE_URL + MethodNames.games);
    parameter = uri.replace(queryParameters: params);

    result = await BaseApiHelper.getRequest(parameter, {
      // 'X-RapidAPI-Key': '6dd1587895msh5f0c2263a5686aap120b34jsne9263cbd71ed',
      'X-RapidAPI-Key': '08caae6c2bmsh572aebe4b01a829p14475ejsn8e6b0956f735',
      'X-RapidAPI-Host': 'sportspage-feeds.p.rapidapi.com'
    });
    status = result.status;
    data = result.data;
    message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  Future<ResponseItem> weatherDetails(String cityName) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = "";

    Uri uri = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?appid=2e9714911e1deb0a2ee62104c0b5928b&q=$cityName');

    result = await BaseApiHelper.getRequest(uri, {});
    status = result.status;
    data = result.data;
    message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  Future<ResponseItem> injuriesReport({String league = ''}) async {
    ResponseItem result;
    String leagueText =
        league == 'NCAA' ? 'cfb' : league.toLowerCase().split('.').last;
    String key = leagueText == 'nfl'
        ? 'e4fa0e9f6e1d41d6862141c0959c8a65'
        : leagueText == 'mlb'
            ? 'f8fc1e2d640646079ee44e659989aa24'
            : '9129c2df275a49c59f59c4fba8d29a79';
    Uri uri = Uri.parse(
        "https://api.sportsdata.io/v3/$leagueText/projections/json/InjuredPlayers?key=$key");
    result = await BaseApiHelper.getRequest(uri, {});

    return result;
  }

  Future<ResponseItem> gameListingsWithLogo(
      String year, String sportKey) async {
    ResponseItem result;
    var params = {"year": year};

    Uri parameter;
    Uri uri = Uri.parse(
        '${AppUrls.BASE_URL}${sportKey == 'MLB' ? 'mlb' : sportKey == 'NCAA' ? 'cfb' : 'nfl'}/schedule?year=$year');
    parameter = uri.replace(queryParameters: params);

    result = await BaseApiHelper.getRequest(parameter, {
      'X-RapidAPI-Key': '08caae6c2bmsh572aebe4b01a829p14475ejsn8e6b0956f735',
      'X-RapidAPI-Host': 'sports-information.p.rapidapi.com'
    });
    return result;
  }

  Future<ResponseItem> nflRushingRanking(String year,
      {isOffense = true}) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = "";

    Uri uri = Uri.parse(
        'https://nfl-team-stats.p.rapidapi.com/v1/nfl-stats/teams/rushing-stats/${isOffense ? 'offense' : 'defense'}/$year');

    result = await BaseApiHelper.getRequest(uri, {
      'X-RapidAPI-Host': 'nfl-team-stats.p.rapidapi.com',
      'X-RapidAPI-Key': 'd95a925a59mshe22d68977f46b96p119cfajsn56b144b5a86f'
    });
    status = result.status;
    data = result.data;
    message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  Future<ResponseItem> nflPassingRanking(String year,
      {isOffense = true}) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = "";

    Uri uri = Uri.parse(
        'https://nfl-team-stats.p.rapidapi.com/v1/nfl-stats/teams/passing-stats/${isOffense ? 'offense' : 'defense'}/$year');

    result = await BaseApiHelper.getRequest(uri, {
      'X-RapidAPI-Host': 'nfl-team-stats.p.rapidapi.com',
      'X-RapidAPI-Key': 'd95a925a59mshe22d68977f46b96p119cfajsn56b144b5a86f'
    });
    status = result.status;
    data = result.data;
    message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  Future<ResponseItem> nflLastGameRecord(String year) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = "";

    Uri uri = Uri.parse(
        'https://nfl-team-stats.p.rapidapi.com/v1/nfl-stats/teams/win-stats/$year');

    result = await BaseApiHelper.getRequest(uri, {
      'X-RapidAPI-Host': 'nfl-team-stats.p.rapidapi.com',
      'X-RapidAPI-Key': 'd95a925a59mshe22d68977f46b96p119cfajsn56b144b5a86f'
    });
    status = result.status;
    data = result.data;
    message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }

  Future<ResponseItem> nflAnalysisStat(String year) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = "";

    Uri uri = Uri.parse(
        'https://api.sportsdata.io/v3/nfl/scores/json/TeamSeasonStats/$year?key=e4fa0e9f6e1d41d6862141c0959c8a65');

    result = await BaseApiHelper.getRequest(uri, {});
    status = result.status;
    data = result.data;
    message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }
}
