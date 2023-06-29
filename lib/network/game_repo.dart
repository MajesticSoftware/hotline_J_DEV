import '../extras/base_api_helper.dart';
import '../extras/request_constants.dart';
import '../model/response_item.dart';

class GameRepo {
  Future<ResponseItem> gameDetails(String sportKey, String date) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = "";

    var params = {"league": sportKey, 'date': date};

    Uri parameter;
    Uri uri = Uri.parse(AppUrls.BASE_URL + MethodNames.games);
    parameter = uri.replace(queryParameters: params);

    result = await BaseApiHelper.getRequest(parameter, params);
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

    var params = {"q": cityName, "appid": "2e9714911e1deb0a2ee62104c0b5928b"};

    Uri uri = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?appid=2e9714911e1deb0a2ee62104c0b5928b&q=$cityName');

    result = await BaseApiHelper.getRequest(uri, params);
    status = result.status;
    data = result.data;
    message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }
}
