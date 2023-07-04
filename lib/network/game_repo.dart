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

  Future<ResponseItem> injuriesReport() async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = "";

    Uri uri = Uri.parse(
        'https://api.sportsdata.io/v3/nfl/projections/json/InjuredPlayers?key=e4fa0e9f6e1d41d6862141c0959c8a65');
    result = await BaseApiHelper.getRequest(uri, {});
    status = result.status;
    data = result.data;
    message = result.message;

    return result;
  }
}
