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
  static const String NBA_BASE_URL =
      "https://api.sportradar.com/nba/production/v8/en/";

  // ignore: constant_identifier_names
  static const String NCAAB_BASE_URL =
      "https://api.sportradar.us/ncaamb/production/v8/en/";

  // ignore: constant_identifier_names
  static const String NFL_BASE_URL =
      "https://api.sportradar.us/nfl/official/production/v7/en/";

  // ignore: constant_identifier_names
  static const String NCAA_BASE_URL =
      "https://api.sportradar.us/ncaafb/production/v7/en/";

  // ignore: constant_identifier_names
  static const String NCAA_APIKEY = "qucqbyh68myd733tsxtfnbau";

  // ignore: constant_identifier_names
  // static const String NFL_APIKEY = "h4kantpwh2rhn783gdh6theg";
  static const String NFL_APIKEY = "Iz3Lagp15R2l9IjmmUtez12WtUCJES3V7cLVm9Ka";
  // static const String NFL_APIKEY = "GXce1iTx4O6rlLkrY8iFG70fmvd4V4vL7SZuVcPQ";

  // ignore: constant_identifier_names
  static const String MLB_APIKEY = "5hnm7xhtgc8q22q2x4w6urvb";

  // ignore: constant_identifier_names
  static const String NBA_APIKEY = "pddyppr3qun2b2zbskn8fymc";

  // ignore: constant_identifier_names
  static const String NCAAB_APIKEY = "tfkmznsbvq8h7evtx9yc2xkh";
  static const String imageUrl =
      "http://134.209.79.197/hotlines/api/app_images/profile_images/";
}

class RequestParam {
  static const service = "Service"; // -> pass method name
// static const showError = "show_error"; // -> bool in String
}

String currentYear = (DateTime.now().year-1).toString();

class MethodNames {
  static const userRegistration = "userRegistration";
  static const checkSocialLogin = "checkSocialLogin";
  static const login = "userLogin";
  static const getNBAGameOffenseRank = "getNBAGameOffenseRank";
  static const getNCAABGameOffenseRank = "getNCAABGameOffenseRank";
  static const getNFLGameOffenseRank = "getNFLGameOffenseRank";
  static const getNCAAFGameOffenseRank = "getNCAAFGameOffenseRank";
  static const getNFLQBSRank = "getNFLQBSRank";
  static const getNCAAFQBSRank = "getNCAAFQBSRank";
  static const updateUserDetails = "updateUserDetails";
  static const changePassword = "changePassword";
  static const forgotPassword = "forgotPassword";
  static const logout = "logout";
  static const deleteAccount = "deleteAccount";
  static const changePasswordWithVerifyCode = "changePasswordWithVerifyCode";
  static const verifyReceipt = "verifyReceipt";
  static const getReceiptStatus = "getReceiptStatus";
  static const getReleaseVersion = "getReleaseVersion";
  static const googleCloudGetStatus = "googleCloudGetStatus";
  static const manageGooglePurchase = "manageGooglePurchase";
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
