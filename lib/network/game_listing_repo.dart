import 'package:hotlines/extras/extras.dart';

import '../extras/base_api_helper.dart';
import '../model/response_item.dart';

class GameListingRepo {
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

  Future<ResponseItem> boxScoreRepo({String gameId = ''}) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = "";

    Uri uri = Uri.parse(
        'https://api.sportradar.com/mlb/production/v7/en/games/$gameId/boxscore.json?api_key=5hnm7xhtgc8q22q2x4w6urvb');

    result = await BaseApiHelper.getRequest(uri, {});
    status = result.status;
    data = result.data;
    message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }
}
