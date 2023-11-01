class AppUrls {
  // ignore: constant_identifier_names
  static const bool IS_LIVE = false;
  // ignore: constant_identifier_names
  static const String _DEV_BASE_URL = "http://134.209.79.197/hotlines/api/dev";
  // ignore: constant_identifier_names
  static const String _LIVE_BASE_URL =
      "http://134.209.79.197/hotlines/api/live";
  // ignore: constant_identifier_names
  static const String AUTH_BASE_URL =
      "${IS_LIVE ? _LIVE_BASE_URL : _DEV_BASE_URL}/Service.php?";

  // ignore: constant_identifier_names
  static const String BASE_URL =
      "https://api.sportradar.us/oddscomparison-usp1/";
  // ignore: constant_identifier_names
  static const String MLB_BASE_URL =
      "https://api.sportradar.com/mlb/production/v7/en/";
  // ignore: constant_identifier_names
  static const String NFL_BASE_URL =
      "https://api.sportradar.us/nfl/official/production/v7/en/";
  // ignore: constant_identifier_names
  static const String NCAA_BASE_URL =
      "https://api.sportradar.us/ncaafb/production/v7/en/";
  // ignore: constant_identifier_names
  static const String NCAA_APIKEY = "qucqbyh68myd733tsxtfnbau";
  // ignore: constant_identifier_names
  static const String NFL_APIKEY = "h4kantpwh2rhn783gdh6theg";
  // ignore: constant_identifier_names
  static const String MLB_APIKEY = "5hnm7xhtgc8q22q2x4w6urvb";
  // ignore: constant_identifier_names
  static const String NBA_APIKEY = "dwk38t4j9k57uwa8v2tkw673";
  static const String imageUrl =
      "http://134.209.79.197/hotlines/api/app_images/profile_images/";
}

class RequestParam {
  static const service = "Service"; // -> pass method name
// static const showError = "show_error"; // -> bool in String
}

class MethodNames {
  static const userRegistration = "userRegistration";
  static const checkSocialLogin = "checkSocialLogin";
  static const login = "userLogin";
  static const updateUserDetails = "updateUserDetails";
  static const changePassword = "changePassword";
  static const forgotPassword = "forgotPassword";
  static const logout = "logout";
  static const deleteAccount = "deleteAccount";
  static const changePasswordWithVerifyCode = "changePasswordWithVerifyCode";
}

class RequestHeaderKey {
  static const contentType = "Content-Type";
  static const userAgent = "User-Agent";
  static const appSecret = "App-Secret";
  static const appTrackVersion = "App-Track-Version";
  static const appDeviceType = "App-Device-Type";
  static const appStoreVersion = "App-Store-Version";
  static const appDeviceModel = "App-Device-Model";
  static const appOsVersion = "App-Os-Version";
  static const appStoreBuildNumber = "App-Store-Build-Number";
  static const authToken = "Auth-Token";
  static const accessControlAllowOrigin = "Access-Control-Allow-Origin";
}
