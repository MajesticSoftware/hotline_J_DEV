import '../extras/base_api_helper.dart';
import '../extras/request_constants.dart';
import '../model/response_item.dart';

class GameRepo {
  Future<ResponseItem> gameDetails(String sportKey) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = "";

    var params = {"league": sportKey};

    Uri uri = Uri.parse(AppUrls.BASE_URL + MethodNames.games);
    uri.replace(queryParameters: params);

    result = await BaseApiHelper.getRequest(uri, params);
    status = result.status;
    data = result.data;
    message = result.message;

    return ResponseItem(data: data, message: message, status: status);
  }
}
