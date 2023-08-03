class AppUrls {
  /// Create request with query parameter
  // ignore: constant_identifier_names

  static const String BASE_URL =
      "https://api.sportradar.us/oddscomparison-ust1/";
  static const String MLB_BASE_URL =
      "https://api.sportradar.com/mlb/production/v7/en/";
}

class MethodNames {
  static const games = "games";
}

// ignore: constant_identifier_names
const int LIMIT = 50;

class RequestParam {
  static const service = "Service"; // -> pass method name
  // static const showError = "show_error"; // -> bool in String
}

class RequestHeaderKey {
  // static const contentType = "Content-Type";
  // static const userAgent = "User-Agent";
  // static const appSecret = "App-Secret";
  // static const appTrackVersion = "App-Track-Version";
  // static const appDeviceType = "App-Device-Type";
  // static const appStoreVersion = "App-Store-Version";
  // static const appDeviceModel = "App-Device-Model";
  // static const appOsVersion = "App-Os-Version";
  // static const appStoreBuildNumber = "App-Store-Build-Number";
  // static const authToken = "Auth-Token";
  // static const accessControlAllowOrigin = "Access-Control-Allow-Origin";
}
