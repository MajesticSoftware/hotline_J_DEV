import 'dart:async';
import 'dart:developer' as dev;
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hotlines/model/leauge_model.dart';
import 'package:hotlines/model/mlb_box_score_model.dart';
import 'package:hotlines/utils/animated_search.dart';
import 'package:hotlines/utils/app_helper.dart';
import 'package:intl/intl.dart';

import '../../../constant/constant.dart';
import '../../../constant/shred_preference.dart';
import '../../../extras/constants.dart';
import '../../../extras/request_constants.dart';
import '../../../model/forgot_pass_model.dart';
import '../../../model/game_listing.dart';
import '../../../model/nba_boxscore_model.dart';
import '../../../model/nba_rank_model.dart';
import '../../../model/ncaa_boxcore_model.dart';
import '../../../model/ncaab_conference_model.dart';
import '../../../model/nfl_qbs_rank_model.dart';
import '../../../model/nfl_rank_model.dart';
import '../../../model/ranking_model.dart';
import '../../../model/response_item.dart';
import '../../../model/team_logo_model.dart';
import '../../../model/user_model.dart';
import '../../../network/auth_repo.dart';
import '../../../network/game_listing_repo.dart';
import '../../../network/subscription_repo.dart';
import '../../../theme/helper.dart';
import '../../../utils/extension.dart';
import '../../auth/log_in_module/log_in_screen.dart';
import '../gameDetails/game_details_screen.dart';

class GameListingController extends GetxController {
  @override
  void dispose() {
    timer = null;
    timerNCAA = null;
    super.dispose();
  }

  @override
  void onClose() {
    timer = null;
    timerNCAA = null;
    super.onClose();
    dev.log('I am closed');
  }

  String sportId = ncaabSportId;

  String _sportKey = SportName.NCAAB.name;

  String get sportKey => _sportKey;

  set sportKey(String value) {
    _sportKey = value;
    update();
  }

  String apiKey = dotenv.env['ODDS_COMPARISON_REGULAR_API'] ?? "";
  String date = DateFormat('yyyy-MM-dd').format(DateTime.now());

  List<String> _isSelected = [
    /*PreferenceManager.getFavoriteSport() ?? */
    SportName.NCAAB.name
  ];

  List<String> get isSelected => _isSelected;

  set isSelected(List<String> value) {
    _isSelected = value;
    update();
  }

  String _isSelectedGame = SportName.NCAAB.name;

  String get isSelectedGame => _isSelectedGame;

  set isSelectedGame(String value) {
    _isSelectedGame = value;
    update();
  }

  bool _isSearch = false;

  bool get isSearch => _isSearch;

  set isSearch(bool value) {
    _isSearch = value;
    update();
  }

  RxBool isLoading = false.obs;
  TextEditingController searchCon = TextEditingController();
  List<SportEvents> _nbaSportEventsList = [];

  List<SportEvents> get nbaSportEventsList => _nbaSportEventsList;

  set nbaSportEventsList(List<SportEvents> value) {
    _nbaSportEventsList = value;
    update();
  }

  List<SportEvents> _ncaabSportEventsList = [];

  List<SportEvents> get ncaabSportEventsList => _ncaabSportEventsList;

  set ncaabSportEventsList(List<SportEvents> value) {
    _ncaabSportEventsList = value;
    update();
  }

  List<SportEvents> _ncaaSportEventsList = [];

  List<SportEvents> get ncaaSportEventsList => _ncaaSportEventsList;

  set ncaaSportEventsList(List<SportEvents> value) {
    _ncaaSportEventsList = value;
    update();
  }

  List<SportEvents> _nflSportEventsList = [];

  List<SportEvents> get nflSportEventsList => _nflSportEventsList;

  set nflSportEventsList(List<SportEvents> value) {
    _nflSportEventsList = value.toSet().toList();
    update();
  }

  List<SportEvents> _mlbSportEventsList = [];

  List<SportEvents> get mlbSportEventsList => _mlbSportEventsList;

  set mlbSportEventsList(List<SportEvents> value) {
    _mlbSportEventsList = value;
    update();
  }

  List<SportEvents> _searchList = [];

  List<SportEvents> get searchList => _searchList;

  set searchList(List<SportEvents> value) {
    _searchList = value.toSet().toList();
    update();
  }

  bool _isPagination = false;

  bool get isPagination => _isPagination;

  set isPagination(bool value) {
    _isPagination = value;
    update();
  }

  bool _isCallApi = false;

  bool get isCallApi => _isCallApi;

  set isCallApi(bool value) {
    _isCallApi = value;
    update();
  }

  List<SportEvents> _nflTodayEventsList = [];

  List<SportEvents> _mlbTodayEventsList = [];

  List<SportEvents> get mlbTodayEventsList => _mlbTodayEventsList;

  set mlbTodayEventsList(List<SportEvents> value) {
    _mlbTodayEventsList = value;
    update();
  }

  List<SportEvents> _nbaTomorrowEventsList = [];

  List<SportEvents> get nbaTomorrowEventsList => _nbaTomorrowEventsList;

  set nbaTomorrowEventsList(List<SportEvents> value) {
    _nbaTomorrowEventsList = value;
    update();
  }

  List<SportEvents> _ncaabTomorrowEventsList = [];

  List<SportEvents> get ncaabTomorrowEventsList => _ncaabTomorrowEventsList;

  set ncaabTomorrowEventsList(List<SportEvents> value) {
    _ncaabTomorrowEventsList = value;
    update();
  }

  List<SportEvents> _nflTomorrowEventsList = [];

  List<SportEvents> get nflTomorrowEventsList => _nflTomorrowEventsList;

  set nflTomorrowEventsList(List<SportEvents> value) {
    _nflTomorrowEventsList = value.toSet().toList();
    update();
  }

  List<SportEvents> _ncaaTodayEventsList = [];

  List<SportEvents> get ncaaTodayEventsList => _ncaaTodayEventsList;

  set ncaaTodayEventsList(List<SportEvents> value) {
    _ncaaTodayEventsList = value;
    update();
  }

  List<SportEvents> _ncaabTodayEventsList = [];

  List<SportEvents> get ncaabTodayEventsList => _ncaabTodayEventsList;

  set ncaabTodayEventsList(List<SportEvents> value) {
    _ncaabTodayEventsList = value;
    update();
  }

  List<SportEvents> _nbaTodayEventsList = [];

  List<SportEvents> get nbaTodayEventsList => _nbaTodayEventsList;

  set nbaTodayEventsList(List<SportEvents> value) {
    _nbaTodayEventsList = value;
    update();
  }

  List<SportEvents> get ncaaTomorrowEventsList => _ncaaTomorrowEventsList;

  set ncaaTomorrowEventsList(List<SportEvents> value) {
    _ncaaTomorrowEventsList = value;
    update();
  }

  List<SportEvents> get nflTodayEventsList => _nflTodayEventsList;

  set nflTodayEventsList(List<SportEvents> value) {
    _nflTodayEventsList = value;
    update();
  }

  List<SportEvents> _mlbTomorrowEventsList = [];

  List<SportEvents> get mlbTomorrowEventsList => _mlbTomorrowEventsList;

  set mlbTomorrowEventsList(List<SportEvents> value) {
    _mlbTomorrowEventsList = value;
    update();
  }

  List<SportEvents> _ncaaTomorrowEventsList = [];

  ///GAME LISTING API
  Future<List<SportEvents>> fetchListingData(
      {String sportId = '',
      String date = "",
      String sportKey = "",
      int start = 0,
      bool isLoad = false,
      String key = ''}) async {
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo()
        .gameListingRepo(key: key, date: date, spotId: sportId, start: start);
    try {
      if (result.status) {
        GameListingDataModel response =
            GameListingDataModel.fromJson(result.data);
        final sportEvents = response.sportEvents;
        return sportEvents?.toSet().toList() ?? [];
      }
      isLoading.value = false;
      if (result.message == 'Error in response: No internet connection') {
        showAppSnackBar(
          result.message,
        );
      }
    } catch (e) {
      dev.log('ERROR__------$e');
      showAppSnackBar(e.toString());
    }
    return [];
  }

  Future<void> getResponse(bool isLoad, String sportKey) async {
    date = DateFormat('yyyy-MM-dd')
        .format(DateTime.now() /*.subtract(const Duration(days: 2))*/);
    if (sportKey == SportName.MLB.name) {
      return await getGameListingForMLB(isLoad,
          apiKey: apiKey,
          sportKey: SportName.MLB.name,
          date: date,
          sportId: mlbSportId);
    } else if (sportKey == SportName.NFL.name) {
      return await getGameListingForNFLGame(isLoad,
          apiKey: apiKey,
          sportKey: SportName.NFL.name,
          date: date,
          sportId: sportId);
    } else if (sportKey == SportName.NCAA.name) {
      return getGameListingForNCAAGame(isLoad,
          apiKey: apiKey, sportKey: sportKey, date: date, sportId: sportId);
    } else if (sportKey == SportName.NBA.name) {
      return getGameListingForNBARes(isLoad,
          apiKey: apiKey, sportKey: sportKey, date: date, sportId: sportId);
    } else if (sportKey == SportName.NCAAB.name) {
      return getGameListingForNCAABRes(isLoad,
          apiKey: apiKey, sportKey: sportKey, date: date, sportId: sportId);
    }
  }

  Future<void> getRefreshResponse(bool isLoad, String sportKey) async {
    if (sportKey == SportName.MLB.name) {
      return await mlbGameRefreshCall(isLoad,
          apiKey: apiKey,
          sportKey: SportName.MLB.name,
          date: date,
          sportId: "sr:sport:3");
    } else if (sportKey == SportName.NFL.name) {
      return await nflGameRefreshCall(isLoad,
          apiKey: apiKey,
          sportKey: SportName.NFL.name,
          date: date,
          sportId: sportId);
    } else if (sportKey == SportName.NCAA.name) {
      return ncaaGameRefreshCall(isLoad,
          apiKey: apiKey, sportKey: sportKey, date: date, sportId: sportId);
    } else if (sportKey == SportName.NBA.name) {
      return nbaGameRefreshCall(isLoad,
          apiKey: apiKey, sportKey: sportKey, date: date, sportId: sportId);
    } else if (sportKey == SportName.NCAAB.name) {
      return ncaabGameRefreshCall(isLoad,
          apiKey: apiKey, sportKey: sportKey, date: date, sportId: sportId);
    }
  }

  searchData(String text, String sportKey, List<SportEvents> gameList) {
    searchList = [];
    searchList.clear();
    if (text.isNotEmpty) {
      for (var element in gameList) {
        if (((mobileView.size.shortestSide < 600
                    ? element.homeTeamAbb
                    : element.homeTeam)
                .toString()
                .toLowerCase()
                .contains(text.trim().toString().toLowerCase())) ||
            ((mobileView.size.shortestSide < 600
                    ? element.awayTeamAbb
                    : element.awayTeam)
                .toString()
                .toLowerCase()
                .contains(text.trim().toString().toLowerCase()))) {
          if (searchList.length > 3) {
            searchList.clear();
          }
          searchList.add(element);
        }
      }
    }
    update();
  }

  accountLogOut() {
    bool isDark = PreferenceManager.getIsDarkMode() ?? false;
    Get.changeThemeMode((PreferenceManager.getIsDarkMode() ?? false)
        ? ThemeMode.dark
        : ThemeMode.light);
    if (PreferenceManager.getLoginType() == 'google') {
      signOut();
    }
    Get.offAll(LogInScreen());
    PreferenceManager.clearData();
    PreferenceManager.setIsLogin(false);
    PreferenceManager.setIsOpenDialog(false);
    PreferenceManager.setIsDarkMod(isDark);
    PreferenceManager.setIsFirstLoaded(true);
    showAppSnackBar('Successfully logged out.', status: true);
  }

  favoriteGameCall() {
    sportId = ncaabSportId;
    sportKey = SportName.NCAAB.name;
    isSelected.add(SportName.NCAAB.name);
    isSelectedGame = SportName.NCAAB.name;
    Future.delayed(
      Duration.zero,
      () async {
        isPagination = true;
        isLoading.value = true;
        await getResponse(true, SportName.NCAAB.name);
      },
    );
  }

  tabClick(BuildContext context, int index) {
    searchCon.clear();
    searchList.clear();
    isSelectedGame = sportsLeagueList[index].gameName;
    date = sportsLeagueList[index].date;
    sportKey = sportsLeagueList[index].key;
    apiKey = sportsLeagueList[index].apiKey;
    sportId = sportsLeagueList[index].sportId;
    if (isSelected.contains(sportsLeagueList[index].gameName)) {
    } else {
      isSelected.add(sportsLeagueList[index].gameName);
      Future.delayed(const Duration(seconds: 0), () {
        isLoading.value = true;
        isPagination = true;
        getResponse(true, sportsLeagueList[index].key);
      });
    }
    update();
  }

  gameOnClick(BuildContext context, SportEvents gameDetails) {
    toggle = 0;
    FocusScope.of(context).unfocus();
    searchCon.clear();
    if ((PreferenceManager.getIsOpenDialog() == null) &&
        ((PreferenceManager.getSubscriptionActive() ?? "1") == "0")) {
      PreferenceManager.setIsOpenDialog(true);
    } else {
      PreferenceManager.setIsOpenDialog(false);
    }
    Get.to(SportDetailsScreen(
      gameDetails: gameDetails,
      sportKey: sportKey,
      sportId: sportId,
      date: date,
    ));
    update();
  }

  Future<void> getSubscriptionStatus() async {
    // isLoading.value = true;
    ResponseItem result = Platform.isIOS
        ? await SubscriptionRepo.getReceiptStatus()
        : await SubscriptionRepo.getGoogleCloudStatus();
    try {
      if (result.status) {
        if (result.data != null) {
          UserData subscriptionModel = UserData.fromJson(result.data);
          PreferenceManager().saveSubscription(subscriptionModel);
          update();
        }
      } else {
        // showAppSnackBar(result.message);
      }
    } catch (e) {
      showAppSnackBar(e.toString());
      debugPrint(e.toString());
    }
    // isLoading.value = false;
    update();
  }

  searchGameOnClick(BuildContext context, SportEvents gameDetails) {
    toggle = 0;
    FocusScope.of(context).unfocus();
    if ((PreferenceManager.getIsOpenDialog() == null) &&
        ((PreferenceManager.getSubscriptionActive() ?? "1") == "0")) {
      PreferenceManager.setIsOpenDialog(true);
    } else {
      PreferenceManager.setIsOpenDialog(false);
    }
    Get.to(SportDetailsScreen(
      gameDetails: gameDetails,
      sportKey: sportKey,
      sportId: sportId,
      date: date,
    ));
    searchCon.clear();
    searchCon.text = '';
    update();
  }

  static Future<bool> signOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      await googleSignIn.signOut();
      return true;
    } catch (e) {
      showAppSnackBar('logOutErrorMsg'.tr);
    }
    return false;
  }

  void logOut(BuildContext context) async {
    isLoading.value = true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await UserStartupRepo().logOutApp();
    try {
      if (result.status) {
        dev.log('RESPONSE--${result.status}');
        ForgotPasswordResModel response =
            ForgotPasswordResModel.fromJson(result.toJson());
        bool isDark = PreferenceManager.getIsDarkMode() ?? false;
        Get.changeThemeMode((PreferenceManager.getIsDarkMode() ?? false)
            ? ThemeMode.dark
            : ThemeMode.light);
        if (PreferenceManager.getLoginType() == 'google') {
          await signOut();
        }
        Get.offAll(LogInScreen());
        PreferenceManager.clearData();
        PreferenceManager.setIsLogin(false);
        PreferenceManager.setIsDarkMod(isDark);
        PreferenceManager.setIsFirstLoaded(true);
        showAppSnackBar(response.msg, status: true);
        isLoading.value = false;
      } else {
        isLoading.value = false;
        showAppSnackBar(result.message);
      }
    } catch (e) {
      isLoading.value = false;
      showAppSnackBar(e.toString());
    }
    update();
  }

  void deleteAc(BuildContext context) async {
    isLoading.value = true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await UserStartupRepo().deleteAc();
    try {
      if (result.status) {
        dev.log('RESPONSE--${result.status}');
        ForgotPasswordResModel response =
            ForgotPasswordResModel.fromJson(result.toJson());
        bool isDark = PreferenceManager.getIsDarkMode() ?? false;
        Get.changeThemeMode((PreferenceManager.getIsDarkMode() ?? false)
            ? ThemeMode.dark
            : ThemeMode.light);
        if (PreferenceManager.getLoginType() == 'google') {
          signOut();
        }
        Get.offAll(LogInScreen());
        PreferenceManager.clearData();
        PreferenceManager.setIsLogin(false);
        PreferenceManager.setIsDarkMod(isDark);
        showAppSnackBar(response.msg, status: true);
        isLoading.value = false;
      } else {
        isLoading.value = false;
        showAppSnackBar(result.message);
      }
    } catch (e) {
      isLoading.value = false;
      showAppSnackBar(e.toString());
    }
    update();
  }

  void launchEmailSubmission() async {
    final Uri params = Uri(
        scheme: 'mailto',
        path: 'casey@hotlinesmd.com',
        queryParameters: {'subject': '', 'body': ''});
    String url = params.toString();
    launchInBrowser(Uri.parse(url));
  }

  gameListingTodayApiRes(
      {String sportId = '',
      String date = "",
      String sportKey = "",
      int start = 0,
      bool isLoad = false,
      String key = ''}) async {
    isLoading.value = isLoad;
    int pageIndex = 0;
    List<SportEvents> resultEvents = [];
    
    try {
      for (int i = 0; i <= pageIndex; i++) {
        List<SportEvents> value = await fetchListingData(
          start: i * 100,
          key: key,
          date: date,
          isLoad: isLoad,
          sportKey: sportKey,
          sportId: sportId
        );
        
        if (value.isNotEmpty) {
          if (value.length >= 85) {
            pageIndex++;
          }
          
          if (sportKey == SportName.MLB.name) {
            dev.log("MLB API CALL - Processing ${value.length} events from sportId: $sportId");
          }
          
          for (var event in value) {
            try {
              DateTime time = (DateTime.parse(event.scheduled ?? ''));
              var difference = (time.toUtc().difference((DateTime.now().toUtc())));
              
              // Special handling for MLB - only get official MLB games (not minor leagues or international)
              if (sportKey == SportName.MLB.name) {
                // Debug info about each MLB game with eye-catching emoji
                print("🔍🔍🔍 MLB GAME DEBUG INFO 🔍🔍🔍");
                print("🆔 ID: ${event.id}");
                print("📊 Status: ${event.status}");
                print("🏆 Season ID: ${event.season?.id}");
                print("🏆 Season Name: ${event.season?.name}");
                print("🏟️ Tournament ID: ${event.tournament?.id}");
                print("🏟️ Tournament Name: ${event.tournament?.name}");
                print("🌍 Category Name: ${event.tournament?.category?.name}");
                print("🌍 Category Country: ${event.tournament?.category?.countryCode}");
                print("⚾ Teams: ${event.awayTeam} vs ${event.homeTeam}");
                print("🌡️ Weather: ${event.weather}, IconURL: ${event.weatherIconUrl?.isNotEmpty}");
                
                // Only add official MLB games (filter out minor leagues and international games)
                bool isOfficialMLB = 
                    event.tournament?.id == "sr:tournament:109" && 
                    event.season?.name?.contains("MLB 2025") == true;
                
                print("✅ Is Official MLB: $isOfficialMLB");
                print("📍📍📍 END MLB GAME INFO 📍📍📍");
                
                if (!mlbTodayEventsList.contains(event) && 
                    (difference.inHours >= (-6)) &&
                    (event.status != GameStatus.closed.name) &&
                    isOfficialMLB) {
                  mlbTodayEventsList.add(event);
                }
              } 
              // NFL events
              else if (sportKey == SportName.NFL.name && 
                      event.season?.id == 'sr:season:115087' &&
                      (difference.inHours >= (-6)) &&
                      (event.status != GameStatus.closed.name)) {
                if (!nflTodayEventsList.contains(event)) {
                  nflTodayEventsList.add(event);
                }
              } 
              // NCAA events
              else if (sportKey == SportName.NCAA.name && 
                      (event.season?.id == 'sr:season:101983' || event.season?.id == "sr:season:101811") &&
                      (difference.inHours >= (-6)) &&
                      (event.status != GameStatus.closed.name)) {
                if (!ncaaTodayEventsList.contains(event)) {
                  ncaaTodayEventsList.add(event);
                }
              } 
              // NCAAB events
              else if (sportKey == SportName.NCAAB.name && 
                      ((ncaabGameSeasonUid.contains(replaceId((event.season?.uuids).toString()))) ||
                      ncaabGameSeasonId.contains(event.season?.id)) &&
                      ((ncaabGameTournamentId.contains(replaceId((event.tournament?.id).toString()))) ||
                      (ncaabGameTournamentId.contains(replaceId((event.season?.tournamentId).toString())))) &&
                      (difference.inHours >= (-6)) &&
                      (event.status != GameStatus.closed.name)) {
                if (!ncaabTodayEventsList.contains(event)) {
                  ncaabTodayEventsList.add(event);
                }
              } 
              // NBA events
              else if (sportKey == SportName.NBA.name && 
                      event.season?.id == 'sr:season:106289' &&
                      (difference.inHours >= (-6)) &&
                      (event.status != GameStatus.closed.name)) {
                if (!nbaTodayEventsList.contains(event)) {
                  nbaTodayEventsList.add(event);
                }
              }
            } catch (e) {
              dev.log("Error processing event in gameListingTodayApiRes: $e");
            }
          }
          
          // Sort the list by scheduled time
          (getTodayList(sportKey)).sort((a, b) =>
              DateTime.parse(a.scheduled ?? "")
                  .compareTo(DateTime.parse(b.scheduled ?? "")));
        }
      }
    } catch (e) {
      dev.log("Error in gameListingTodayApiRes: $e");
    }
    
    update();
    return getTodayList(sportKey);
  }

  gameListingTomorrowApiRes(
      {String sportId = '',
      String date = "",
      String sportKey = "",
      int start = 0,
      bool isLoad = false,
      String key = ''}) async {
    isPagination = isLoad;
    isLoading.value = false;
    int pageIndex = 0;
    
    try {
      for (int i = 0; i <= pageIndex; i++) {
        List<SportEvents> value = await fetchListingData(
          start: i * 100,
          key: key,
          date: date,
          isLoad: isLoad,
          sportKey: sportKey,
          sportId: sportId
        );
        
        if (value.isNotEmpty) {
          if (value.length >= 85) {
            pageIndex++;
          }
          
          if (sportKey == SportName.MLB.name) {
            dev.log("MLB API CALL - Tomorrow - Processing ${value.length} events from sportId: $sportId}");
          }
          
          List<SportEvents> sportEvents = value.toSet().toList();
          for (var event in sportEvents.toSet()) {
            try {
              DateTime time = DateTime.parse(event.scheduled ?? '');
              var difference = time.toUtc().difference(DateTime.now().toUtc());
              
              // Special handling for MLB games - only include official MLB games
              if (sportKey == SportName.MLB.name) {
                // Only add official MLB games
                bool isOfficialMLB = 
                    event.tournament?.id == "sr:tournament:109" && 
                    event.season?.name?.contains("MLB 2025") == true;
                
                if (!mlbTomorrowEventsList.contains(event) && isOfficialMLB) {
                  dev.log("MLB API CALL - Adding future event: ${event.id} - ${event.status} - Season: ${event.season?.id}");
                  mlbTomorrowEventsList.add(event);
                }
              } 
              // NFL events
              else if (sportKey == SportName.NFL.name && 
                       event.season?.id == 'sr:season:115087') {
                if (!nflTomorrowEventsList.contains(event) &&
                    nflSportEventsList.indexWhere((element) => element.id == event.id) == -1) {
                  nflTomorrowEventsList.add(event);
                }
              } 
              // NCAA events
              else if (sportKey == SportName.NCAA.name && 
                      (event.season?.id == 'sr:season:101983' || event.season?.id == 'sr:season:101811')) {
                if (!ncaaTomorrowEventsList.contains(event)) {
                  ncaaTomorrowEventsList.add(event);
                }
              } 
              // NCAAB events
              else if (sportKey == SportName.NCAAB.name && 
                      ((ncaabGameSeasonUid.contains(replaceId((event.season?.uuids).toString()))) ||
                       ncaabGameSeasonId.contains(event.season?.id)) &&
                      ((ncaabGameTournamentId.contains(replaceId((event.tournament?.id).toString()))) ||
                       (ncaabGameTournamentId.contains(replaceId((event.season?.tournamentId).toString()))))) {
                if (!ncaabTomorrowEventsList.contains(event) &&
                    ncaabSportEventsList.indexWhere((element) => element.id == event.id) == -1) {
                  ncaabTomorrowEventsList.add(event);
                }
              } 
              // NBA events
              else if (sportKey == SportName.NBA.name && 
                       event.season?.id == 'sr:season:106289' &&
                       (difference.inHours <= (16))) {
                if (!nbaTomorrowEventsList.contains(event)) {
                  nbaTomorrowEventsList.add(event);
                }
              }
            } catch (e) {
              dev.log("Error processing event in gameListingTomorrowApiRes: $e for event ID: ${event.id}");
            }
          }
          
          // Sort the list by scheduled time
          getTomorrowList(sportKey).sort((a, b) =>
              DateTime.parse(a.scheduled ?? "").compareTo(DateTime.parse(b.scheduled ?? "")));
        }
      }
    } catch (e) {
      dev.log("Error in gameListingTomorrowApiRes: $e");
    }
    
    update();
  }

  List<SportEvents> getTodayList(sportKey) {
    // Get the appropriate list based on sport key
    List<SportEvents> eventsList = sportKey == SportName.NFL.name
        ? nflTodayEventsList
        : sportKey == SportName.MLB.name
            ? mlbTodayEventsList
            : sportKey == SportName.NBA.name
                ? nbaTodayEventsList
                : sportKey == SportName.NCAAB.name
                    ? ncaabTodayEventsList
                    : ncaaTodayEventsList;
    
    // Deduplicate based on event ID
    Map<String, SportEvents> uniqueEvents = {};
    for (var event in eventsList) {
      if (event.id != null && event.id!.isNotEmpty) {
        uniqueEvents[event.id!] = event;
      }
    }
    
    return uniqueEvents.values.toList();
  }

  List<SportEvents> getTomorrowList(sportKey) {
    // Get the appropriate list based on sport key
    List<SportEvents> eventsList = sportKey == SportName.NFL.name
        ? nflTomorrowEventsList
        : sportKey == SportName.MLB.name
            ? mlbTomorrowEventsList
            : sportKey == SportName.NBA.name
                ? nbaTomorrowEventsList
                : sportKey == SportName.NCAAB.name
                    ? ncaabTomorrowEventsList
                    : ncaaTomorrowEventsList;
    
    // Deduplicate based on event ID
    Map<String, SportEvents> uniqueEvents = {};
    for (var event in eventsList) {
      if (event.id != null && event.id!.isNotEmpty) {
        uniqueEvents[event.id!] = event;
      }
    }
    
    return uniqueEvents.values.toList();
  }

  List<SportEvents> getSportEventList(sportKey) {
    // List<SportEvents> newNcaabSportEventsList = ncaabSportEventsList
    //     .where((element) => conferenceIdList.contains(element.awayConferenceId)||conferenceIdList.contains(element.awayConferenceId))
    //     .toList();

    return sportKey == SportName.NFL.name
        ? nflSportEventsList
        : sportKey == SportName.MLB.name
            ? mlbSportEventsList
            : sportKey == SportName.NCAAB.name
                ? ncaabSportEventsList
                : sportKey == SportName.NBA.name
                    ? nbaSportEventsList
                    : ncaaSportEventsList;
  }

  ///GET ALL EVENT BY HOME AWAY FILTER
  getAllEventList(String sportKey, bool isLoad) {
    // Debug log for duplicate checking
    if (sportKey == SportName.MLB.name) {
      dev.log("MLB API CALL - Before deduplication: Today list: ${getTodayList(sportKey).length}, Tomorrow list: ${getTomorrowList(sportKey).length}");
    } else if (sportKey == SportName.NCAAB.name) {
      dev.log("NCAAB API CALL - Before deduplication: Today list: ${getTodayList(sportKey).length}, Tomorrow list: ${getTomorrowList(sportKey).length}");
    }
    
    // Clear current list
    getSportEventList(sportKey).clear();
    
    // Create sets to deduplicate events by ID
    Set<String> addedEventIds = {};
    List<SportEvents> dedupedEvents = [];
    
    // Process today events
    for (var event in getTodayList(sportKey)) {
      if (!addedEventIds.contains(event.id)) {
        addedEventIds.add(event.id ?? "");
        dedupedEvents.add(event);
      }
    }
    
    // Process tomorrow events
    for (var event in getTomorrowList(sportKey)) {
      if (!addedEventIds.contains(event.id)) {
        addedEventIds.add(event.id ?? "");
        dedupedEvents.add(event);
      }
    }
    
    // Add the deduplicated list
    getSportEventList(sportKey).addAll(dedupedEvents);
    
    // Debug log after deduplication
    if (sportKey == SportName.MLB.name) {
      dev.log("MLB API CALL - After deduplication: ${getSportEventList(sportKey).length} events");
    } else if (sportKey == SportName.NCAAB.name) {
      dev.log("NCAAB API CALL - After deduplication: ${getSportEventList(sportKey).length} events");
    }
    
    // Sort by scheduled time
    getSportEventList(sportKey).sort((a, b) => 
        DateTime.parse(a.scheduled ?? "").compareTo(DateTime.parse(b.scheduled ?? "")));
    
    // Process each event to set home/away teams
    for (var event in getSportEventList(sportKey)) {
      if (event.competitors.isNotEmpty) {
        if (event.competitors[0].qualifier == 'home') {
          event.homeTeam = event.competitors[0].name ?? '';
          event.homeTeamAbb = event.competitors[0].abbreviation ?? '';
        } else {
          event.awayTeam = event.competitors[0].name ?? '';
          event.awayTeamAbb = event.competitors[0].abbreviation ?? '';
        }
        if (event.competitors[1].qualifier == 'away') {
          event.awayTeam = event.competitors[1].name ?? '';
          event.awayTeamAbb = event.competitors[1].abbreviation ?? '';
        } else {
          event.homeTeam = event.competitors[1].name ?? '';
          event.homeTeamAbb = event.competitors[1].abbreviation ?? '';
        }
      }

      ///MONEY LINES

      if (event.consensus != null) {
        if (event.consensus?.lines != null) {
          event.consensus?.lines?.forEach((consensus) {
            if (consensus.name == 'moneyline_live') {
              consensus.outcomes?.forEach((lines) {
                if (lines.type == 'home') {
                  event.homeMoneyLine = lines.odds.toString();
                  dev.log('HOME MONEY ---${event.homeMoneyLine}');
                }
                if (lines.type == 'away') {
                  event.awayMoneyLine = lines.odds.toString();
                  dev.log('AWAY MONEY ---${event.awayMoneyLine}');
                }
              });
            } else {
              if (consensus.name == 'moneyline_current') {
                consensus.outcomes?.forEach((lines) {
                  if (lines.type == 'home') {
                    event.homeMoneyLine = lines.odds.toString();
                  }
                  if (lines.type == 'away') {
                    event.awayMoneyLine = lines.odds.toString();
                  }
                });
              }
            }
            if (consensus.name == 'total_live') {
              event.homeOU = consensus.total.toString();
              event.awayOU = consensus.total.toString();
            } else {
              if (consensus.name == 'total_current') {
                event.homeOU = consensus.total.toString();
                event.awayOU = consensus.total.toString();
              }
            }

            // if (consensus.name == 'run_line_current' ||
            //     consensus.name == 'spread_current') {
            //   event.homeSpread = '${consensus.spread}'.toString();
            //   event.awaySpread = '${consensus.spread}'.toString();
            // }
          });
        }
      }
      if (event.markets.isNotEmpty) {
        for (var marketData in event.markets) {
          if (marketData.oddsTypeId == 4) {
            int fanDuelIndex = marketData.books
                .indexWhere((element) => element.id == 'sr:book:18186');
            for (var bookData in marketData.books) {
              if (fanDuelIndex >= 0) {
                if (bookData.id == 'sr:book:18186') {
                  if (bookData.outcomes?[0].type == 'home') {
                    event.homeSpread =
                        bookData.outcomes?[0].spread.toString() ?? '00';
                  }
                  if (bookData.outcomes?[1].type == 'away') {
                    event.awaySpread =
                        bookData.outcomes?[1].spread.toString() ?? '00';
                  }
                }
              } else if (bookData.id == 'sr:book:28901') {
                if (bookData.outcomes?[0].type == 'home') {
                  event.homeSpread =
                      bookData.outcomes?[0].spread.toString() ?? '';
                }
                if (bookData.outcomes?[1].type == 'away') {
                  event.awaySpread =
                      bookData.outcomes?[1].spread.toString() ?? '';
                }
              } else if (bookData.id == 'sr:book:17324') {
                if (bookData.outcomes?[0].type == 'home') {
                  event.homeSpread =
                      bookData.outcomes?[0].spread.toString() ?? '';
                }
                if (bookData.outcomes?[1].type == 'away') {
                  event.awaySpread =
                      bookData.outcomes?[1].spread.toString() ?? '';
                }
              }
            }
          }
        }
      }
    }
    update();
  }

  ///BOX SCORE API
  Future boxScoreResponse(
      {String gameId = '',
      String homeTeamId = '',
      String awayTeamId = '',
      bool isLoad = false,
      String key = '',
      required int index}) async {
    // isLoading.value = !isLoad ? false : true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo().boxScoreRepo(gameId: gameId);
    try {
      if (result.status) {
        MLBBoxScoreModel response = MLBBoxScoreModel.fromJson(result.data);
        final game = response.game;
        if (game != null) {
          if (game.id == gameId) {
            mlbSportEventsList[index].inning =
                game.outcome?.currentInning.toString() ?? '0';
            mlbSportEventsList[index].inningHalf =
                game.outcome?.currentInningHalf.toString() ?? '';
            mlbSportEventsList[index].outs =
                "${(game.outcome?.count?.outs ?? "0").toString()} Outs";
            if (game.home?.id == homeTeamId) {
              mlbSportEventsList[index].homeScore =
                  (game.home?.runs).toString();
              mlbSportEventsList[index].homeWin = (game.home?.win).toString();
              mlbSportEventsList[index].homeLoss = (game.home?.loss).toString();
              mlbSportEventsList[index].homePlayerId =
                  (game.home?.probablePitcher?.id ?? "").toString();
              mlbSportEventsList[index].wlHome =
                  ('${game.home?.probablePitcher?.win ?? '0'}-${game.home?.probablePitcher?.loss ?? '0'}')
                      .toString();
              mlbSportEventsList[index].eraHome =
                  (game.home?.probablePitcher?.era ?? '0').toString();
              if (game.home?.probablePitcher != null) {
                mlbSportEventsList[index].homePlayerName =
                    ('${game.home?.probablePitcher?.preferredName?[0]}. ${game.home?.probablePitcher?.lastName}')
                        .toString();
              }
            }
            if (game.away?.id == awayTeamId) {
              mlbSportEventsList[index].awayScore =
                  (game.away?.runs).toString();
              mlbSportEventsList[index].awayWin = (game.away?.win).toString();
              mlbSportEventsList[index].awayLoss = (game.away?.loss).toString();
              mlbSportEventsList[index].awayPlayerId =
                  (game.away?.probablePitcher?.id ?? "").toString();
              mlbSportEventsList[index].wlAway =
                  ('${game.away?.probablePitcher?.win ?? '0'}-${game.away?.probablePitcher?.loss ?? "0"}')
                      .toString();
              mlbSportEventsList[index].eraAway =
                  (game.away?.probablePitcher?.era ?? '0').toString();
              if (game.away?.probablePitcher != null) {
                mlbSportEventsList[index].awayPlayerName =
                    ('${game.away?.probablePitcher?.preferredName?[0] ?? ""}. ${game.away?.probablePitcher?.lastName ?? ""}')
                        .toString();
              }
            }
          }
        }
      } else {
        // showAppSnackBar(
        //   result.message,
        // );
      }
    } catch (e) {
      dev.log('ERROR BOX SCORE MLB----$e');
      // showAppSnackBar(
      //   errorText,
      // );
    }

    update();
  }

  Future boxScoreResponseNCAA(
      {String gameId = '',
      bool isLoad = false,
      String key = '',
      int index = 0}) async {
    // isLoading.value = !isLoad ? false : true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result =
        await GameListingRepo().boxScoreRepoNCAA(gameId: gameId, sportKey: key);
    try {
      if (result.status) {
        NCAABoxScoreModel response = NCAABoxScoreModel.fromJson(result.data);
        final game = response;
        if (game.id == gameId) {
          String down = (game.situation?.down ?? "").toString();
          if ((down) == '1') {
            down = '${down}st';
          } else if ((down).toString().endsWith('1') &&
              !(down).toString().startsWith('1')) {
            down = '${down}st';
          } else if ((down).toString().endsWith('2') &&
              !(down).toString().startsWith('1')) {
            down = '${down}nd';
          } else if ((down).toString().endsWith('3') &&
              !(down).toString().startsWith('1')) {
            down = '${down}rd';
          } else {
            down = down;
          }
          if (key == SportName.NFL.name) {
            nflSportEventsList[index].inning = (game.quarter ?? "0").toString();
            nflSportEventsList[index].inningHalf = "Q";
            nflSportEventsList[index].clock = (game.clock ?? "00:00");
            if (game.situation != null) {
              nflSportEventsList[index].currentTime =
                  'Q${(game.quarter ?? "0")} ${game.situation?.clock ?? ""}, $down & ${game.situation?.yfd ?? ""}';
            } else {
              nflSportEventsList[index].currentTime = '';
            }
            nflSportEventsList[index].homeScore =
                (game.summary?.home?.points ?? "0").toString();
            nflSportEventsList[index].awayScore =
                (game.summary?.away?.points ?? "0").toString();
          } else {
            ncaaSportEventsList[index].inning =
                (game.quarter ?? "0").toString();
            ncaaSportEventsList[index].inningHalf = "Q";
            ncaaSportEventsList[index].clock = (game.clock ?? "00:00");
            if (game.situation != null) {
              ncaaSportEventsList[index].currentTime =
                  'Q${(game.quarter ?? "0")} ${game.situation?.clock ?? ""}, $down & ${game.situation?.yfd ?? ""}';
            } else {
              ncaaSportEventsList[index].currentTime = '';
            }
            ncaaSportEventsList[index].homeScore =
                (game.summary?.home?.points ?? "0").toString();
            ncaaSportEventsList[index].awayScore =
                (game.summary?.away?.points ?? "0").toString();
          }
        }
      } else {
        isLoading.value = false;
        // showAppSnackBar(
        //   result.message,
        // );
      }
    } catch (e) {
      // isLoading.value = false;
      dev.log('ERROR BOX SCORE NFL && NCAA--------$e');
      // showAppSnackBar(
      //   errorText,
      // );
    }

    update();
  }

  Future boxScoreNBAResponse(
      {String gameId = '',
      String sportKey = '',
      String homeTeamId = '',
      String awayTeamId = '',
      bool isLoad = false,
      String key = '',
      required int index}) async {
    // isLoading.value = !isLoad ? false : true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo()
        .boxScoreNBARepo(gameId: gameId, sportKey: sportKey);
    try {
      if (result.status) {
        NBABoxScoreModel response = NBABoxScoreModel.fromJson(result.data);
        final game = response;

        if (game.id == gameId) {
          if (homeTeamId == game.home?.id) {
            if (sportKey == SportName.NBA.name) {
              nbaSportEventsList[index].homeScore =
                  (game.home?.points ?? "0").toString();
              nbaSportEventsList[index].homeRank =
                  (game.home?.rank ?? 0).toString();
            } else {
              ncaabSportEventsList[index].homeScore =
                  (game.home?.points ?? "0").toString();
              // ncaabSportEventsList[index].homeRank =
              //     (game.home?.rank ?? 0).toString();
            }
          }
          if (awayTeamId == game.away?.id) {
            if (sportKey == SportName.NBA.name) {
              nbaSportEventsList[index].awayScore =
                  (game.away?.points ?? "0").toString();
              nbaSportEventsList[index].awayRank =
                  (game.away?.rank ?? 0).toString();
            } else {
              ncaabSportEventsList[index].awayScore =
                  (game.away?.points ?? "0").toString();
              // ncaabSportEventsList[index].awayRank =
              //     (game.away?.rank ?? 0).toString();
            }
          }
          if (sportKey == SportName.NBA.name) {
            nbaSportEventsList[index].inning = (game.quarter ?? "0").toString();
            nbaSportEventsList[index].inningHalf = 'Q';
            nbaSportEventsList[index].status = game.status.toString();
            nbaSportEventsList[index].clock = (game.clock ?? "00:00");
          } else {
            ncaabSportEventsList[index].inning = (game.half ?? "0").toString();
            ncaabSportEventsList[index].inningHalf = 'H';
            ncaabSportEventsList[index].status = game.status.toString();
            ncaabSportEventsList[index].clock = (game.clock ?? "00:00");
            ncaabSportEventsList[index].clock = (game.clock ?? "00:00");
          }
        }
        update();
      } else {
        // showAppSnackBar(
        //   result.message,
        // );
      }
    } catch (e) {
      dev.log('ERROR BOX SCORE NBA----$e');
      // showAppSnackBar(
      //   errorText,
      // );
    }
    update();
  }

  List<String> conferenceIdList = [
    "9ed9d01e-977c-4ba7-ac7d-64035039461c",
    "a30fe8ff-82d2-4521-bc8d-e08e6a9dbb52",
    "2853cf4d-6d62-4ec6-8e2c-d69f7a01a557",
    "88368ebb-01fb-44d5-a6c6-3e7d46bb3ab7",
    "d07bc93e-c84c-44a9-a99d-c213bd0014d6",
    "3b6a48d8-1f9c-484f-8ed0-ef0a540a0efe",
    "db136c00-f45b-4af6-bc7d-ffff216f2e5d",
    "6902bb03-02f7-4da4-8261-de5fd2cbd011",
    "93a776e4-d390-48e1-95bb-74945457366a",
    "c664ceee-1dc0-4743-a6d8-11fbdfb87f61",
  ];

  ///NCAA RANKING
  Future ncaaGameRanking({
    bool isLoad = false,
    required String sportName,
    required List<SportEvents> sportList,
  }) async {
    // isLoading.value = isLoad;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo().ncaaGameRanking(sportName);
    try {
      if (result.status) {
        RankingModel response = RankingModel.fromJson(result.data);
        if (response.rankings != null) {
          for (int i = 0; i < sportList.length; i++) {
            if (sportList[i].uuids != null) {
              response.rankings?.forEach((team) {
                if (team.id.toString() ==
                    (replaceId(sportList[i].competitors[0].uuids ?? '') ??
                        "")) {
                  sportList[i].homeRank =
                      team.rank != null ? team.rank.toString() : '0';
                }
                if (team.id.toString() ==
                    (replaceId(sportList[i].competitors[1].uuids ?? '') ??
                        "")) {
                  sportList[i].awayRank =
                      team.rank != null ? team.rank.toString() : '0';
                }
              });
            }
          }
        }
      } else {
        isLoading.value = false;
        // showAppSnackBar(
        //   result.message,
        // );
      }
    } catch (e) {
      // isLoading.value = false;
      dev.log('ERROR NCAA RANKING-------$e');
      // showAppSnackBar(
      //   errorText,
      // );
    }
    update();
  }

  ///getConferenceNCAAB
  Future getConferenceNCAAB(bool isLoad) async {
    isLoading.value = isLoad;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo().getConferenceNCAAB();
    try {
      if (result.status) {
        ConferencesModelNCAAB response =
            ConferencesModelNCAAB.fromJson(result.data);
        if (response.divisions != null) {
          for (int i = 0; i < ncaabSportEventsList.length; i++) {
            if (ncaabSportEventsList[i].uuids != null) {
              response.divisions?.forEach((division) {
                division.conferences?.forEach(
                  (conference) {
                    conference.teams?.forEach(
                      (team) {
                        if (team.id.toString() ==
                            (replaceId(ncaabSportEventsList[i]
                                        .competitors[0]
                                        .uuids ??
                                    '') ??
                                "")) {
                          ncaabSportEventsList[i].homeConferenceName =
                              conference.name;
                          ncaabSportEventsList[i].homeConferenceId =
                              conference.id;
                        }
                        if (team.id.toString() ==
                            (replaceId(ncaabSportEventsList[i]
                                        .competitors[1]
                                        .uuids ??
                                    '') ??
                                "")) {
                          ncaabSportEventsList[i].awayConferenceName =
                              conference.name;
                          ncaabSportEventsList[i].awayConferenceId =
                              conference.id;
                        }
                      },
                    );
                  },
                );
              });
            }
          }
        }
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      dev.log('ERROR NCAA CONFERENCE-------$e');
    }
    update();
  }

  setOdds(SportEvents event) {
    if (event.consensus != null) {
      if (event.consensus?.lines != null) {
        event.consensus?.lines?.forEach((consensus) {
          if (consensus.name == 'moneyline_live') {
            consensus.outcomes?.forEach((lines) {
              if (lines.type == 'home') {
                event.homeMoneyLine = lines.odds.toString();
                dev.log('HOME MONEY ---${event.homeMoneyLine}');
              }
              if (lines.type == 'away') {
                event.awayMoneyLine = lines.odds.toString();
                dev.log('AWAY MONEY ---${event.awayMoneyLine}');
              }
            });
          } else {
            if (consensus.name == 'moneyline_current') {
              consensus.outcomes?.forEach((lines) {
                if (lines.type == 'home') {
                  event.homeMoneyLine = lines.odds.toString();
                }
                if (lines.type == 'away') {
                  event.awayMoneyLine = lines.odds.toString();
                }
              });
            }
          }
          if (consensus.name == 'total_live') {
            event.homeOU = consensus.total.toString();
            event.awayOU = consensus.total.toString();
          } else {
            if (consensus.name == 'total_current') {
              event.homeOU = consensus.total.toString();
              event.awayOU = consensus.total.toString();
            }
          }

          // if (consensus.name == 'run_line_current' ||
          //     consensus.name == 'spread_current') {
          //   event.homeSpread = '${consensus.spread}'.toString();
          //   event.awaySpread = '${consensus.spread}'.toString();
          // }
        });
      }
    }
    if (event.markets.isNotEmpty) {
      for (var marketData in event.markets) {
        if (marketData.oddsTypeId == 4) {
          int fanDuelIndex = marketData.books
              .indexWhere((element) => element.id == 'sr:book:18186');
          for (var bookData in marketData.books) {
            if (fanDuelIndex >= 0) {
              if (bookData.id == 'sr:book:18186') {
                if (bookData.outcomes?[0].type == 'home') {
                  event.homeSpread =
                      bookData.outcomes?[0].spread.toString() ?? '00';
                }
                if (bookData.outcomes?[1].type == 'away') {
                  event.awaySpread =
                      bookData.outcomes?[1].spread.toString() ?? '00';
                }
              }
            } else if (bookData.id == 'sr:book:28901') {
              if (bookData.outcomes?[0].type == 'home') {
                event.homeSpread =
                    bookData.outcomes?[0].spread.toString() ?? '';
              }
              if (bookData.outcomes?[1].type == 'away') {
                event.awaySpread =
                    bookData.outcomes?[1].spread.toString() ?? '';
              }
            } else if (bookData.id == 'sr:book:17324') {
              if (bookData.outcomes?[0].type == 'home') {
                event.homeSpread =
                    bookData.outcomes?[0].spread.toString() ?? '';
              }
              if (bookData.outcomes?[1].type == 'away') {
                event.awaySpread =
                    bookData.outcomes?[1].spread.toString() ?? '';
              }
            }
          }
        }
      }
    }
    update();
  }

  ///GAME LISTING FOR ALL GAME
  Timer? timer;
  Timer? timerNCAA;
  Timer? timerNFL;

  getGameListingForNCAAGame(bool isLoad,
      {String apiKey = '',
      String sportKey = '',
      String date = '',
      String sportId = ''}) async {
    ncaaTodayEventsList = [];
    gameListingTodayApiRes(
            key: apiKey,
            isLoad: isLoad,
            sportKey: sportKey,
            date: date,
            sportId: sportId)
        .then((value) {
      gameListingTodayApiRes(
              key: apiKey,
              isLoad: isLoad,
              sportKey: sportKey,
              date: DateFormat('yyyy-MM-dd')
                  .format(DateTime.parse(date).add(const Duration(days: 1))),
              sportId: sportId)
          .then((value) {
        isLoading.value = false;
        isPagination = isLoad;
        ncaaTomorrowEventsList.clear();
        for (int i = 2; i <= 12; i++) {
          gameListingTomorrowApiRes(
                  key: apiKey,
                  isLoad: isLoad,
                  sportKey: sportKey,
                  date: DateFormat('yyyy-MM-dd')
                      .format(DateTime.parse(date).add(Duration(days: i))),
                  sportId: sportId)
              .then((value) {
            getAllEventList(sportKey, isLoad);
            nflGameRankApi(isLoad: isLoad, sportKey: sportKey);
            getNFLQBSRank(isLoad: isLoad, sportKey: sportKey);
            gameListingsWithLogoResponse(currentYear, sportKey, isLoad: isLoad);
            if (i == 12) {
              isPagination = false;
            }
          }).then((value) {
            if (ncaaSportEventsList.isNotEmpty) {
              ncaaGameRanking(
                  sportName: sportKey,
                  isLoad: false,
                  sportList: ncaaSportEventsList);
              for (int i = 0; i < ncaaSportEventsList.length; i++) {
                if (ncaaSportEventsList[i].uuids != null) {
                  getWeather(ncaaSportEventsList[i].venue?.cityName ?? "",
                      index: i, sportKey: sportKey);
                  boxScoreResponseNCAA(
                      key: sportKey,
                      gameId: replaceId(ncaaSportEventsList[i].uuids ?? ''),
                      index: i);
                }
              }
            }
          });
        }
        if (ncaaTodayEventsList.isNotEmpty) {
          timerNCAA = Timer.periodic(const Duration(seconds: 45), (t) async {
            ncaaTodayEventsList.clear();
            await gameListingTodayApiRes(
                    key: apiKey,
                    isLoad: false,
                    sportKey: sportKey,
                    date: date,
                    sportId: sportId)
                .then((value) {
              gameListingTodayApiRes(
                      key: apiKey,
                      isLoad: false,
                      sportKey: sportKey,
                      date: DateFormat('yyyy-MM-dd').format(
                          DateTime.parse(date).add(const Duration(days: 1))),
                      sportId: sportId)
                  .then((value) {
                for (int i = 0; i < ncaaTodayEventsList.length; i++) {
                  int liveIndex = ncaaSportEventsList.indexWhere(
                      (element) => element.id == ncaaTodayEventsList[i].id);
                  if (liveIndex >= 0) {
                    setOdds(ncaaSportEventsList[liveIndex]);
                  }
                  if (((DateTime.parse(ncaaTodayEventsList[i].scheduled ?? "")
                                  .toLocal())
                              .day ==
                          DateTime.now().toLocal().day) &&
                      ncaaTodayEventsList[i].status != GameStatus.closed.name) {
                    if (ncaaTodayEventsList[i].uuids != null) {
                      boxScoreResponseNCAA(
                          key: sportKey,
                          gameId: replaceId(ncaaTodayEventsList[i].uuids ?? ''),
                          index: i);
                    }
                  }
                }
              });
            });
            update();
          });
        }
      });
    });
  }

  ncaaGameRefreshCall(bool isLoad,
      {String apiKey = '',
      String sportKey = '',
      String date = '',
      String sportId = ''}) async {
    ncaaTodayEventsList = [];
    gameListingTodayApiRes(
            key: apiKey,
            isLoad: isLoad,
            sportKey: sportKey,
            date: date,
            sportId: sportId)
        .then((value) {
      gameListingTodayApiRes(
              key: apiKey,
              isLoad: isLoad,
              sportKey: sportKey,
              date: DateFormat('yyyy-MM-dd')
                  .format(DateTime.parse(date).add(const Duration(days: 1))),
              sportId: sportId)
          .then((value) {
        isLoading.value = false;
        isPagination = isLoad;
        ncaaTomorrowEventsList.clear();
        for (int i = 2; i <= 12; i++) {
          gameListingTomorrowApiRes(
                  key: apiKey,
                  isLoad: isLoad,
                  sportKey: sportKey,
                  date: DateFormat('yyyy-MM-dd')
                      .format(DateTime.parse(date).add(Duration(days: i))),
                  sportId: sportId)
              .then((value) {
            getAllEventList(sportKey, isLoad);
            nflGameRankApi(isLoad: isLoad, sportKey: sportKey);
            getNFLQBSRank(isLoad: isLoad, sportKey: sportKey);
            gameListingsWithLogoResponse(currentYear, sportKey, isLoad: isLoad);
            if (i == 12) {
              isPagination = false;
            }
          }).then((value) {
            if (ncaaSportEventsList.isNotEmpty) {
              ncaaGameRanking(
                  sportName: sportKey,
                  isLoad: false,
                  sportList: ncaaSportEventsList);
              for (int i = 0; i < ncaaSportEventsList.length; i++) {
                if (ncaaSportEventsList[i].uuids != null) {
                  getWeather(ncaaSportEventsList[i].venue?.cityName ?? "",
                      index: i, sportKey: sportKey);
                  boxScoreResponseNCAA(
                      key: sportKey,
                      gameId: replaceId(ncaaSportEventsList[i].uuids ?? ''),
                      index: i);
                }
              }
            }
          });
        }
      });
    });
  }

  Future<void> getGameListingForNFLGame(bool isLoad,
      {String apiKey = '',
      String sportKey = '',
      String date = '',
      String sportId = ''}) async {
    nflTodayEventsList = [];
    update();
    gameListingTodayApiRes(
            key: apiKey,
            isLoad: isLoad,
            sportKey: sportKey,
            date: date,
            sportId: sportId)
        .then((value) {
      gameListingTodayApiRes(
              key: apiKey,
              isLoad: isLoad,
              sportKey: sportKey,
              date: DateFormat('yyyy-MM-dd')
                  .format(DateTime.parse(date).add(const Duration(days: 1))),
              sportId: sportId)
          .then((value) {
        isLoading.value = false;
        isPagination = isLoad;
        nflTomorrowEventsList = [];
        for (int i = 2; i <= 6; i++) {
          gameListingTomorrowApiRes(
                  key: apiKey,
                  isLoad: isLoad,
                  sportKey: sportKey,
                  date: DateFormat('yyyy-MM-dd')
                      .format(DateTime.parse(date).add(Duration(days: i))),
                  sportId: sportId)
              .then((value) async {
            getAllEventList(sportKey, isLoad);
            nflGameRankApi(isLoad: isLoad, sportKey: sportKey);
            getNFLQBSRank(isLoad: isLoad, sportKey: sportKey);
            if (i == 6) {
              isPagination = false;
            }
            gameListingsWithLogoResponseNCAAB(currentYear, sportKey,
                isLoad: isLoad);
            if (nflSportEventsList.isNotEmpty) {
              for (int i = 0; i < nflSportEventsList.length; i++) {
                if (nflSportEventsList[i].uuids != null) {
                  getWeather(nflSportEventsList[i].venue?.cityName ?? "",
                      index: i, sportKey: sportKey);
                  boxScoreResponseNCAA(
                      key: sportKey,
                      gameId: replaceId(nflSportEventsList[i].uuids ?? ''),
                      index: i);
                }
              }
            }
          });
        }

        if (nflTodayEventsList.isNotEmpty) {
          timerNFL = Timer.periodic(const Duration(seconds: 45), (t) {
            nflTodayEventsList.clear();
            gameListingTodayApiRes(
                    key: apiKey,
                    isLoad: false,
                    sportKey: sportKey,
                    date: date,
                    sportId: sportId)
                .then((value) {
              gameListingTodayApiRes(
                      key: apiKey,
                      isLoad: false,
                      sportKey: sportKey,
                      date: DateFormat('yyyy-MM-dd').format(
                          DateTime.parse(date).add(const Duration(days: 1))),
                      sportId: sportId)
                  .then((value) {
                for (int i = 0; i < nflTodayEventsList.length; i++) {
                  int liveIndex = nflSportEventsList.indexWhere(
                      (element) => element.id == nflTodayEventsList[i].id);
                  if (liveIndex >= 0) {
                    setOdds(nflSportEventsList[liveIndex]);
                  }
                  if (((DateTime.parse(nflTodayEventsList[i].scheduled ?? "")
                                  .toLocal())
                              .day ==
                          DateTime.now().toLocal().day) &&
                      nflTodayEventsList[i].status != GameStatus.closed.name) {
                    if (nflTodayEventsList[i].uuids != null) {
                      boxScoreResponseNCAA(
                          key: sportKey,
                          gameId: replaceId(nflTodayEventsList[i].uuids ?? ''),
                          index: i);
                    }
                  }
                }
              });
            });
            update();
          });
        }
      });
    });
    update();
  }

  Future<void> nflGameRefreshCall(bool isLoad,
      {String apiKey = '',
      String sportKey = '',
      String date = '',
      String sportId = ''}) async {
    nflTodayEventsList = [];
    gameListingTodayApiRes(
            key: apiKey,
            isLoad: isLoad,
            sportKey: sportKey,
            date: date,
            sportId: sportId)
        .then((value) {
      gameListingTodayApiRes(
              key: apiKey,
              isLoad: isLoad,
              sportKey: sportKey,
              date: DateFormat('yyyy-MM-dd')
                  .format(DateTime.parse(date).add(const Duration(days: 1))),
              sportId: sportId)
          .then((value) {
        isLoading.value = false;
        isPagination = isLoad;
        nflTomorrowEventsList = [];
        for (int i = 2; i <= 6; i++) {
          gameListingTomorrowApiRes(
                  key: apiKey,
                  isLoad: isLoad,
                  sportKey: sportKey,
                  date: DateFormat('yyyy-MM-dd')
                      .format(DateTime.parse(date).add(Duration(days: i))),
                  sportId: sportId)
              .then((value) async {
            getAllEventList(sportKey, isLoad);
            nflGameRankApi(isLoad: isLoad, sportKey: sportKey);
            getNFLQBSRank(isLoad: isLoad, sportKey: sportKey);
            if (i == 6) {
              isPagination = false;
            }
            gameListingsWithLogoResponseNCAAB(currentYear, sportKey,
                isLoad: isLoad);
            if (nflSportEventsList.isNotEmpty) {
              for (int i = 0; i < nflSportEventsList.length; i++) {
                if (nflSportEventsList[i].uuids != null) {
                  getWeather(nflSportEventsList[i].venue?.cityName ?? "",
                      index: i, sportKey: sportKey);
                  boxScoreResponseNCAA(
                      key: sportKey,
                      gameId: replaceId(nflSportEventsList[i].uuids ?? ''),
                      index: i);
                }
              }
            }
          });
        }
      });
    });
  }

  ///NFL GAME RANK API
  Future nflGameRankApi({bool isLoad = false, String sportKey = ''}) async {
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo().nflGameRankApi(sportKey);
    try {
      if (result.status) {
        NFLGameRankModel response = NFLGameRankModel.fromJson(result.toJson());
        if (response.data != null) {
          for (var element in (getSportEventList(sportKey))) {
            Competitors? homeTeam;
            Competitors? awayTeam;
            if (element.competitors[0].qualifier == 'home') {
              homeTeam = element.competitors[0];
            } else {
              awayTeam = element.competitors[0];
            }
            if (element.competitors[1].qualifier == 'away') {
              awayTeam = element.competitors[1];
            } else {
              homeTeam = element.competitors[1];
            }
            response.data?.forEach((team) {
              if ((awayTeam?.abbreviation == 'LV'
                      ? '7d4fcc64-9cb5-4d1b-8e75-8a906d1e1576'
                      : replaceId(awayTeam?.uuids ?? '')) ==
                  replaceId(team.teamId ?? "")) {
                element.nflAwayOffensiveRank = [
                  (team.pointOffenceRank ?? 0).toString(),
                  (team.rushingOffenseRank ?? 0).toString(),
                  (team.passingYardOffenseRank ?? 0).toString(),
                  (team.rushingTDSOffenseRank ?? 0).toString(),
                  (team.passingTDSOffenseRank ?? 0).toString(),
                  (team.redzonEfficiencyOffenceRank ?? 0).toString(),
                  (team.thirdDownOffenceRank ?? 0).toString(),
                  (team.fourthDownOffenseRank ?? 0).toString(),
                  (team.fieldGoalOffenseRank ?? 0).toString(),
                  (team.ternoverOffenseRank ?? 0).toString(),
                ];
                element.nflAwayOffensiveList = [
                  (team.pointsOffense ?? 0).toString(),
                  (team.rushingOffense ?? 0).toString(),
                  (team.passingYardOffense ?? 0).toString(),
                  (team.rushingTDSOffense ?? 0).toString(),
                  (team.passingTDSOffense ?? 0).toString(),
                  ('${team.redzonEfficiencyOffence ?? 0}%').toString(),
                  ('${team.thirdDownOffence ?? 0}%').toString(),
                  ('${team.fourthDownOffense ?? 0}%').toString(),
                  (team.fieldGoalOffense ?? 0).toString(),
                  (team.ternoverOffense ?? 0).toString(),
                ];
                element.nflAwayDefensiveRank = [
                  (team.pointsDefenseRank ?? 0).toString(),
                  (team.rushingDefenseRank ?? 0).toString(),
                  (team.passingYardDefenseRank ?? 0).toString(),
                  (team.rushingTDSDefenceRank ?? 0).toString(),
                  (team.passingTDSDefenceRank ?? 0).toString(),
                  (team.opponentRedzonEfficiencyRank ?? 0).toString(),
                  (team.opponentThirdDownRank ?? 0).toString(),
                  (team.opponentFourtDownRank ?? 0).toString(),
                  (team.fieldGoalDefenseRank ?? 0).toString(),
                  (team.ternoverDefenseRank ?? 0).toString(),
                ];
                element.nflAwayDefensiveList = [
                  (team.pointsDefense ?? 0).toString(),
                  (team.rushingDefense ?? 0).toString(),
                  (team.passingYardDefense ?? 0).toString(),
                  (team.rushingTDSDefence ?? 0).toString(),
                  (team.passingTDSDefence ?? 0).toString(),
                  ('${team.opponentRedzonEfficiency ?? 0}%').toString(),
                  ('${team.opponentThirdDown ?? 0}%').toString(),
                  ('${team.opponentFourtDown ?? 0}%').toString(),
                  (team.fieldGoalDefense ?? 0).toString(),
                  (team.ternoverDefense ?? 0).toString(),
                ];
                element.awayDefense = [
                  (team.passingYardDefense ?? 0).toString(),
                  (team.passingTDSDefence ?? 0).toString(),
                  (team.rushingDefense ?? 0).toString(),
                  (team.rushingTDSDefence ?? 0).toString(),
                  (team.interceptionDefense ?? 0).toString(),
                  // (offenciveData?.defense?.interceptions ?? "0").toString(),
                ];
                element.awayQbDefenseRank = [
                  (team.passingYardDefenseRank ?? 0).toString(),
                  (team.passingTDSDefenceRank ?? 0).toString(),
                  (team.rushingDefenseRank ?? 0).toString(),
                  (team.rushingTDSDefenceRank ?? 0).toString(),
                  (team.interceptionDefenseRank ?? 0).toString(),
                ];
              }
              if ((homeTeam?.abbreviation == 'LV'
                      ? '7d4fcc64-9cb5-4d1b-8e75-8a906d1e1576'
                      : replaceId(homeTeam?.uuids ?? '')) ==
                  replaceId(team.teamId ?? "")) {
                element.nflHomeOffensiveRank = [
                  (team.pointOffenceRank ?? 0).toString(),
                  (team.rushingOffenseRank ?? 0).toString(),
                  (team.passingYardOffenseRank ?? 0).toString(),
                  (team.rushingTDSOffenseRank ?? 0).toString(),
                  (team.passingTDSOffenseRank ?? 0).toString(),
                  (team.redzonEfficiencyOffenceRank ?? 0).toString(),
                  (team.thirdDownOffenceRank ?? 0).toString(),
                  (team.fourthDownOffenseRank ?? 0).toString(),
                  (team.fieldGoalOffenseRank ?? 0).toString(),
                  (team.ternoverOffenseRank ?? 0).toString(),
                ];
                element.nflHomeOffensiveList = [
                  (team.pointsOffense ?? 0).toString(),
                  (team.rushingOffense ?? 0).toString(),
                  (team.passingYardOffense ?? 0).toString(),
                  (team.rushingTDSOffense ?? 0).toString(),
                  (team.passingTDSOffense ?? 0).toString(),
                  ('${team.redzonEfficiencyOffence ?? 0}%').toString(),
                  ('${team.thirdDownOffence ?? 0}%').toString(),
                  ('${team.fourthDownOffense ?? 0}%').toString(),
                  (team.fieldGoalOffense ?? 0).toString(),
                  (team.ternoverOffense ?? 0).toString(),
                ];
                element.nflHomeDefensiveRank = [
                  (team.pointsDefenseRank ?? 0).toString(),
                  (team.rushingDefenseRank ?? 0).toString(),
                  (team.passingYardDefenseRank ?? 0).toString(),
                  (team.rushingTDSDefenceRank ?? 0).toString(),
                  (team.passingTDSDefenceRank ?? 0).toString(),
                  (team.opponentRedzonEfficiencyRank ?? 0).toString(),
                  (team.opponentThirdDownRank ?? 0).toString(),
                  (team.opponentFourtDownRank ?? 0).toString(),
                  (team.fieldGoalDefenseRank ?? 0).toString(),
                  (team.ternoverDefenseRank ?? 0).toString(),
                ];
                element.nflHomeDefensiveList = [
                  (team.pointsDefense ?? 0).toString(),
                  (team.rushingDefense ?? 0).toString(),
                  (team.passingYardDefense ?? 0).toString(),
                  (team.rushingTDSDefence ?? 0).toString(),
                  (team.passingTDSDefence ?? 0).toString(),
                  ('${team.opponentRedzonEfficiency ?? 0}%').toString(),
                  ('${team.opponentThirdDown ?? 0}%').toString(),
                  ('${team.opponentFourtDown ?? 0}%').toString(),
                  (team.fieldGoalDefense ?? 0).toString(),
                  (team.ternoverDefense ?? 0).toString(),
                ];
                element.homeDefense = [
                  (team.passingYardDefense ?? 0).toString(),
                  (team.passingTDSDefence ?? 0).toString(),
                  (team.rushingDefense ?? 0).toString(),
                  (team.rushingTDSDefence ?? 0).toString(),
                  (team.interceptionDefense ?? 0).toString(),
                  // (offenciveData?.defense?.interceptions ?? "0").toString(),
                ];
                element.homeQbDefenseRank = [
                  (team.passingYardDefenseRank ?? 0).toString(),
                  (team.passingTDSDefenceRank ?? 0).toString(),
                  (team.rushingDefenseRank ?? 0).toString(),
                  (team.rushingTDSDefenceRank ?? 0).toString(),
                  (team.interceptionDefenseRank ?? 0).toString(),
                ];
              }
            });
          }
        }
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      dev.log('ERROR NFL GAME RANK-----$e');
      showAppSnackBar(e.toString());
    }
    update();
  }

  Future getNFLQBSRank({bool isLoad = false, String sportKey = ''}) async {
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo().getNFLQBSRank(sportKey);
    try {
      if (result.status) {
        NFLQBsRankModel response = NFLQBsRankModel.fromJson(result.toJson());
        if (response.data != null) {
          for (var sportData in (getSportEventList(sportKey))) {
            Competitors? homeTeam;
            Competitors? awayTeam;
            if (sportData.competitors[0].qualifier == 'home') {
              homeTeam = sportData.competitors[0];
            } else {
              awayTeam = sportData.competitors[0];
            }
            if (sportData.competitors[1].qualifier == 'away') {
              awayTeam = sportData.competitors[1];
            } else {
              homeTeam = sportData.competitors[1];
            }
            response.data?.forEach((element) {
              if ((homeTeam?.abbreviation == 'LV'
                      ? '7d4fcc64-9cb5-4d1b-8e75-8a906d1e1576'
                      : replaceId(homeTeam?.uuids ?? '')) ==
                  element.teamId) {
                sportData.homePlayerName = element.playerName ?? "";
                sportData.homePlayerId = element.playerId ?? "";
                sportData.homeQbRank = [
                  (element.passingYardOffenseRank ?? 0).toString(),
                  (element.passingTDSOffenseRank ?? 0).toString(),
                  (element.rushingYardOffenseRank ?? 0).toString(),
                  (element.rushingTDsOffenseRank ?? 0).toString(),
                  (element.interceptionOffenseRank ?? 0).toString(),
                ];
                sportData.homeQb = [
                  (element.passingYardOffense ?? 0).toStringAsFixed(1),
                  (element.passingTDSOffense ?? 0).toStringAsFixed(1),
                  (element.rushingYardOffense ?? 0).toStringAsFixed(1),
                  (element.rushingTDsOffense ?? 0).toStringAsFixed(1),
                  (element.interceptionOffense ?? 0).toStringAsFixed(1),
                ];
              }
              if ((awayTeam?.abbreviation == 'LV'
                      ? '7d4fcc64-9cb5-4d1b-8e75-8a906d1e1576'
                      : replaceId(awayTeam?.uuids ?? '')) ==
                  element.teamId) {
                sportData.awayPlayerName = element.playerName ?? "";
                sportData.awayPlayerId = element.playerId ?? "";
                sportData.awayQbRank = [
                  (element.passingYardOffenseRank ?? 0).toString(),
                  (element.passingTDSOffenseRank ?? 0).toString(),
                  (element.rushingYardOffenseRank ?? 0).toString(),
                  (element.rushingTDsOffenseRank ?? 0).toString(),
                  (element.interceptionOffenseRank ?? 0).toString(),
                ];
                sportData.awayQb = [
                  (element.passingYardOffense ?? 0).toStringAsFixed(1),
                  (element.passingTDSOffense ?? 0).toStringAsFixed(1),
                  (element.rushingYardOffense ?? 0).toStringAsFixed(1),
                  (element.rushingTDsOffense ?? 0).toStringAsFixed(1),
                  (element.interceptionOffense ?? 0).toStringAsFixed(1),
                ];
              }
            });
          }
        }
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      dev.log('ERROR NFL GAME RANK-----$e');
      showAppSnackBar(e.toString());
    }
    update();
  }

  ///NBA GAME RANK API
  Future nbaGameRankApi({bool isLoad = false, String sportKey = ''}) async {
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo().nbaGameRankApi(sportKey);
    try {
      if (result.status) {
        NBAGameRankModel response = NBAGameRankModel.fromJson(result.toJson());
        if (response.data != null) {
          for (var element in (getSportEventList(sportKey))) {
            Competitors? homeTeam;
            Competitors? awayTeam;

            if (element.competitors[0].qualifier == 'home') {
              homeTeam = element.competitors[0];
            } else {
              awayTeam = element.competitors[0];
            }
            if (element.competitors[1].qualifier == 'away') {
              awayTeam = element.competitors[1];
            } else {
              homeTeam = element.competitors[1];
            }
            response.data?.forEach((team) {
              if ((replaceId(awayTeam?.uuids ?? '')) ==
                  replaceId(team.teamId ?? "")) {
                element.nbaAwayOffensiveList = [
                  team.pointOffense.toString(),
                  team.assistOffense.toString(),
                  team.turnOverOffense.toString(),
                  team.reboundesOffense.toString(),
                  // team.stealsOffense.toString(),
                  // team.blocksOffense.toString(),
                  // team.turnOverOffense.toString(),
                  // team.foulsOffense.toString(),
                  '${team.fgMadeOffense} / ${team.fgAttOffense} / ${team.fgOffense}%',
                  '${team.threePMadeOffense} / ${team.threePAttOffense} / ${team.threePOffense}%',
                  '${team.ftMadeOffense} / ${team.ftAttOffense} / ${team.ftOffense}%',
                  // '${((team.trueShootingOffense ?? 0) * 100).toStringAsFixed(1)}%'
                  //     .toString(),
                  // team.teamPerOffense.toString(),
                ];

                element.nbaAwayOffensiveRank = [
                  (team.pointOffenseRank ?? 0).toString(),
                  (team.assistOffenseRank ?? 0).toString(),
                  team.turnOverOffenseRank.toString(),
                  (team.reboundesOffenseRank ?? 0).toString(),
                  // (team.stealsOffenseRank ?? 0).toString(),
                  // (team.blocksOffenseRank ?? 0).toString(),
                  // (team.turnOverOffenseRank ?? 0).toString(),
                  // (team.foulsOffenseRank ?? 0).toString(),
                  '${team.fgOffenseRank ?? 0}',
                  '${team.threePOffenseRank ?? 0}',
                  '${team.ftOffenseRank ?? 0}',
                  // (team.trueShootingOffenseRank ?? 0).toString(),
                  // (team.teamPerOffenseRank ?? 0).toString(),
                ];
                element.nbaAwayDefensiveList = [
                  team.pointDefense.toString(),
                  team.assistDefense.toString(),
                  team.turnOverDefense.toString(),
                  team.reboundesDefense.toString(),
                  // team.stealsDefense.toString(),
                  // team.blocksDefense.toString(),
                  // team.turnOverDefense.toString(),
                  // team.foulsDefense.toString(),
                  '${team.fgMadeDefense} / ${team.fgAttDefense} / ${team.fgDefense}%',
                  '${team.threePMadeDefense} / ${team.threePAttDefense} / ${team.threePDefense}%',
                  '${team.ftMadeDefense} / ${team.ftAttDefense} / ${team.ftDefense}%',
                  // '${((team.trueShootingDefense ?? 0) * 100).toStringAsFixed(1)}%'
                  //     .toString(),
                  // team.teamPerDefense.toString(),
                ];
                element.nbaAwayDefensiveRank = [
                  (team.pointDefenseRank ?? 0).toString(),
                  (team.assistDefenseRank ?? 0).toString(),
                  team.turnOverDefenseRank.toString(),
                  (team.reboundesDefenseRank ?? 0).toString(),
                  // (team.stealsDefenseRank ?? 0).toString(),
                  // (team.blocksDefenseRank ?? 0).toString(),
                  // (team.turnOverDefenseRank ?? 0).toString(),
                  // (team.foulsDefenseRank ?? 0).toString(),
                  '${team.fgDefenseRank ?? 0}',
                  '${team.threePDefenseRank ?? 0}',
                  '${team.ftDefenseRank ?? 0}',
                  // (team.trueShootingDefenseRank ?? 0).toString(),
                  // (team.teamPerDefenseRank ?? 0).toString(),
                ];
              }
              if ((replaceId(homeTeam?.uuids ?? '')) ==
                  replaceId(team.teamId ?? "")) {
                element.nbaHomeOffensiveList = [
                  team.pointOffense.toString(),
                  team.assistOffense.toString(),
                  team.turnOverOffense.toString(),
                  team.reboundesOffense.toString(),
                  // team.stealsOffense.toString(),
                  // team.blocksOffense.toString(),
                  // team.turnOverOffense.toString(),
                  // team.foulsOffense.toString(),
                  '${team.fgMadeOffense} / ${team.fgAttOffense} / ${team.fgOffense}%',
                  '${team.threePMadeOffense} / ${team.threePAttOffense} / ${team.threePOffense}%',
                  '${team.ftMadeOffense} / ${team.ftAttOffense} / ${team.ftOffense}%',
                  // '${((team.trueShootingOffense ?? 0) * 100).toStringAsFixed(1)}%'
                  //     .toString(),
                  // team.teamPerOffense.toString(),
                ];
                element.nbaHomeOffensiveRank = [
                  (team.pointOffenseRank ?? 0).toString(),
                  (team.assistOffenseRank ?? 0).toString(),
                  team.turnOverOffenseRank.toString(),
                  (team.reboundesOffenseRank ?? 0).toString(),
                  // (team.stealsOffenseRank ?? 0).toString(),
                  // (team.blocksOffenseRank ?? 0).toString(),
                  // (team.turnOverOffenseRank ?? 0).toString(),
                  // (team.foulsOffenseRank ?? 0).toString(),
                  '${team.fgOffenseRank ?? 0}',
                  '${team.threePOffenseRank ?? 0}',
                  '${team.ftOffenseRank ?? 0}',
                  // (team.trueShootingOffenseRank ?? 0).toString(),
                  // (team.teamPerOffenseRank ?? 0).toString(),
                ];
                element.nbaHomeDefensiveList = [
                  team.pointDefense.toString(),
                  team.assistDefense.toString(),
                  team.turnOverDefense.toString(),
                  team.reboundesDefense.toString(),
                  // team.stealsDefense.toString(),
                  // team.blocksDefense.toString(),
                  // team.turnOverDefense.toString(),
                  // team.foulsDefense.toString(),
                  '${team.fgMadeDefense} / ${team.fgAttDefense} / ${team.fgDefense}%',
                  '${team.threePMadeDefense} / ${team.threePAttDefense} / ${team.threePDefense}%',
                  '${team.ftMadeDefense} / ${team.ftAttDefense} / ${team.ftDefense}%',
                  // '${((team.trueShootingDefense ?? 0) * 100).toStringAsFixed(1)}%'
                  //     .toString(),
                  // team.teamPerDefense.toString(),
                ];
                element.nbaHomeDefensiveRank = [
                  (team.pointDefenseRank ?? 0).toString(),
                  (team.assistDefenseRank ?? 0).toString(),
                  team.turnOverDefenseRank.toString(),
                  (team.reboundesDefenseRank ?? 0).toString(),
                  // (team.stealsDefenseRank ?? 0).toString(),
                  // (team.blocksDefenseRank ?? 0).toString(),
                  // (team.turnOverDefenseRank ?? 0).toString(),
                  // (team.foulsDefenseRank ?? 0).toString(),
                  '${team.fgDefenseRank ?? 0}',
                  '${team.threePDefenseRank ?? 0}',
                  '${team.ftDefenseRank ?? 0}',
                  // (team.trueShootingDefenseRank ?? 0).toString(),
                  // (team.teamPerDefenseRank ?? 0).toString(),
                ];
              }
            });
          }
        }
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      dev.log('ERROR NFL GAME RANK-----$e');
      showAppSnackBar(e.toString());
    }
    update();
  }

  Future<void> getGameListingForMLBRes(bool isLoad,
      {String apiKey = '',
      String sportKey = '',
      String date = '',
      String sportId = ''}) async {
    gameListingTodayApiRes(
            key: apiKey,
            isLoad: isLoad,
            sportKey: sportKey,
            date: date,
            sportId: sportId)
        .then((value) {
      gameListingTodayApiRes(
              key: apiKey,
              isLoad: isLoad,
              sportKey: sportKey,
              date: DateFormat('yyyy-MM-dd')
                  .format(DateTime.parse(date).add(const Duration(days: 1))),
              sportId: sportId)
          .then((value) {
        isLoading.value = false;
        isPagination = isLoad;
        mlbTomorrowEventsList.clear();
        for (int j = 2; j <= 4; j++) {
          gameListingTomorrowApiRes(
                  key: apiKey,
                  isLoad: isLoad,
                  sportKey: sportKey,
                  date: DateFormat('yyyy-MM-dd')
                      .format(DateTime.parse(date).add(Duration(days: j))),
                  sportId: sportId)
              .then((value) {
            getAllEventList(sportKey, isLoad);
            gameListingsWithLogoResponse(currentYear, sportKey, isLoad: isLoad);
            if (j == 4) {
              isPagination = false;
            }
            if (mlbSportEventsList.isNotEmpty) {
              for (int i = 0; i < mlbSportEventsList.length; i++) {
                getWeather(mlbSportEventsList[i].venue?.cityName ?? "",
                    index: i, sportKey: sportKey);
                if (mlbSportEventsList[i].uuids != null) {
                  if (DateTime.parse(mlbSportEventsList[i].scheduled ?? "")
                          .toLocal()
                          .day ==
                      DateTime.now().day) {
                    boxScoreResponse(
                        homeTeamId: replaceId(
                                mlbSportEventsList[i].competitors[0].uuids ??
                                    '') ??
                            "",
                        awayTeamId: replaceId(
                                mlbSportEventsList[i].competitors[1].uuids ??
                                    '') ??
                            "",
                        gameId: replaceId(mlbSportEventsList[i].uuids ?? ''),
                        index: i);
                  }
                }
              }
            }
          });
        }
        if (mlbTodayEventsList.isNotEmpty) {
          timer = Timer.periodic(const Duration(seconds: 45), (t) {
            mlbTodayEventsList.clear();
            gameListingTodayApiRes(
                    key: apiKey,
                    isLoad: false,
                    sportKey: sportKey,
                    date: date,
                    sportId: sportId)
                .then((value) {
              gameListingTodayApiRes(
                      key: apiKey,
                      isLoad: false,
                      sportKey: sportKey,
                      date: DateFormat('yyyy-MM-dd').format(
                          DateTime.parse(date).add(const Duration(days: 1))),
                      sportId: sportId)
                  .then((value) {
                for (int i = 0; i < mlbTodayEventsList.length; i++) {
                  int liveIndex = mlbSportEventsList.indexWhere(
                      (element) => element.id == mlbTodayEventsList[i].id);
                  if (liveIndex >= 0) {
                    setOdds(mlbSportEventsList[liveIndex]);
                  }
                  if (((DateTime.parse(mlbTodayEventsList[i].scheduled ?? "")
                                  .toLocal())
                              .day ==
                          DateTime.now().toLocal().day) &&
                      mlbTodayEventsList[i].status != GameStatus.closed.name) {
                    if (mlbTodayEventsList[i].uuids != null) {
                      boxScoreResponse(
                          homeTeamId: replaceId(
                                  mlbTodayEventsList[i].competitors[0].uuids ??
                                      '') ??
                              "",
                          awayTeamId: replaceId(
                                  mlbTodayEventsList[i].competitors[1].uuids ??
                                      '') ??
                              "",
                          gameId: replaceId(mlbTodayEventsList[i].uuids ?? ''),
                          index: i);
                    }
                  }
                }
              });
            });
            update();
          });
        }
      });
    });
  }

  Future<void> getGameListingForMLB(bool isLoad,
      {String apiKey = '',
      String sportKey = '',
      String date = '',
      String sportId = ''}) async {
    dev.log("MLB API Call - Starting with sportId: $mlbSportId and date: $date");
    mlbTodayEventsList = [];
    mlbSportEventsList = [];
    
    try {
      List<SportEvents> todayEvents = await gameListingTodayApiRes(
          key: apiKey,
          isLoad: isLoad,
          sportKey: sportKey,
          date: date,
          sportId: mlbSportId);
          
      dev.log("MLB API Call - Today events count: ${todayEvents.length}");
      
      List<SportEvents> tomorrowEvents = await gameListingTodayApiRes(
          key: apiKey,
          isLoad: isLoad,
          sportKey: sportKey,
          date: DateFormat('yyyy-MM-dd')
              .format(DateTime.parse(date).add(const Duration(days: 1))),
          sportId: mlbSportId);
          
      dev.log("MLB API Call - Tomorrow events count: ${tomorrowEvents.length}");
      
      isLoading.value = false;
      isPagination = isLoad;
      mlbTomorrowEventsList.clear();
      
      // Load future games
      for (int i = 2; i <= 6; i++) {
        gameListingTomorrowApiRes(
            key: apiKey,
            isLoad: isLoad,
            sportKey: sportKey,
            date: DateFormat('yyyy-MM-dd')
                .format(DateTime.parse(date).add(Duration(days: i))),
            sportId: mlbSportId)
            .then((value) {
          getAllEventList(sportKey, isLoad);
          gameListingsWithLogoResponse(currentYear, sportKey, isLoad: isLoad);
          
          dev.log("MLB API Call - After getAllEventList: ${mlbSportEventsList.length} events");
          
          if (i == 6) {
            isPagination = false;
          }
        }).then((value) {
          if (mlbSportEventsList.isNotEmpty) {
            for (int i = 0; i < mlbSportEventsList.length; i++) {
              if (mlbSportEventsList[i].uuids != null) {
                getWeather(mlbSportEventsList[i].venue?.cityName ?? "",
                    index: i, sportKey: sportKey);
                if (mlbSportEventsList[i].competitors.isNotEmpty) {
                  boxScoreResponse(
                      gameId: replaceId(mlbSportEventsList[i].uuids ?? ''),
                      index: i,
                      homeTeamId: mlbSportEventsList[i].competitors[0].id ?? "",
                      awayTeamId: mlbSportEventsList[i].competitors[1].id ?? "");
                }
              }
            }
          } else {
            dev.log("MLB API Call - No MLB events found");
          }
        });
      }
      
      // Handle live updates
      if (mlbTodayEventsList.isNotEmpty) {
        dev.log("MLB API Call - Setting up timer for ${mlbTodayEventsList.length} events");
        timer = Timer.periodic(const Duration(seconds: 45), (t) async {
          mlbTodayEventsList.clear();
          await gameListingTodayApiRes(
              key: apiKey,
              isLoad: false,
              sportKey: sportKey,
              date: date,
              sportId: mlbSportId)
              .then((value) {
            gameListingTodayApiRes(
                key: apiKey,
                isLoad: false,
                sportKey: sportKey,
                date: DateFormat('yyyy-MM-dd').format(
                    DateTime.parse(date).add(const Duration(days: 1))),
                sportId: mlbSportId)
                .then((value) {
              for (int i = 0; i < mlbTodayEventsList.length; i++) {
                int liveIndex = mlbSportEventsList.indexWhere(
                    (element) => element.id == mlbTodayEventsList[i].id);
                if (liveIndex >= 0) {
                  setOdds(mlbSportEventsList[liveIndex]);
                }
                if (((DateTime.parse(mlbTodayEventsList[i].scheduled ?? "")
                            .toLocal())
                        .day ==
                    DateTime.now().toLocal().day) &&
                    mlbTodayEventsList[i].status != GameStatus.closed.name) {
                  if (mlbTodayEventsList[i].competitors.isNotEmpty) {
                    boxScoreResponse(
                        gameId: replaceId(mlbTodayEventsList[i].uuids ?? ''),
                        index: i,
                        homeTeamId: mlbTodayEventsList[i].competitors[0].id ?? "",
                        awayTeamId: mlbTodayEventsList[i].competitors[1].id ?? "");
                  }
                }
              }
            });
          });
          update();
        });
      } else {
        dev.log("MLB API Call - No today events for timer");
      }
    } catch (e) {
      dev.log("MLB API Call - Error: $e");
      isLoading.value = false;
    }
    
    update();
  }

  Future<void> mlbGameRefreshCall(bool isLoad,
      {String apiKey = '',
      String sportKey = '',
      String date = '',
      String sportId = ''}) async {
    mlbTodayEventsList = [];
    gameListingTodayApiRes(
            key: apiKey,
            isLoad: isLoad,
            sportKey: sportKey,
            date: date,
            sportId: sportId)
        .then((value) {
      gameListingTodayApiRes(
              key: apiKey,
              isLoad: isLoad,
              sportKey: sportKey,
              date: DateFormat('yyyy-MM-dd')
                  .format(DateTime.parse(date).add(const Duration(days: 1))),
              sportId: sportId)
          .then((value) {
        isLoading.value = false;
        isPagination = isLoad;
        mlbTomorrowEventsList.clear();
        for (int i = 2; i <= 6; i++) {
          gameListingTomorrowApiRes(
                  key: apiKey,
                  isLoad: isLoad,
                  sportKey: sportKey,
                  date: DateFormat('yyyy-MM-dd')
                      .format(DateTime.parse(date).add(Duration(days: i))),
                  sportId: sportId)
              .then((value) {
            getAllEventList(sportKey, isLoad);
            if (mlbSportEventsList.isNotEmpty) {
              for (int i = 0; i < mlbSportEventsList.length; i++) {
                getWeather(mlbSportEventsList[i].venue?.cityName ?? "",
                    index: i, sportKey: sportKey);
                if (mlbSportEventsList[i].uuids != null) {
                  boxScoreResponse(
                      gameId: replaceId(mlbSportEventsList[i].uuids ?? ''),
                      index: i,
                      homeTeamId: mlbSportEventsList[i].competitors[0].id ?? "",
                      awayTeamId: mlbSportEventsList[i].competitors[1].id ?? "");
                }
              }
            }
            gameListingsWithLogoResponse(currentYear, sportKey, isLoad: isLoad);
            if (i == 6) {
              isPagination = false;
            }
          });
        }
      });
    });
  }

  Future<void> getGameListingForNBARes(bool isLoad,
      {String apiKey = '',
      String sportKey = '',
      String date = '',
      String sportId = ''}) async {
    nbaTodayEventsList.clear();
    gameListingTodayApiRes(
            key: apiKey,
            isLoad: isLoad,
            sportKey: sportKey,
            date: date,
            sportId: sportId)
        .then((value) {
      gameListingTodayApiRes(
              key: apiKey,
              isLoad: isLoad,
              sportKey: sportKey,
              date: DateFormat('yyyy-MM-dd')
                  .format(DateTime.parse(date).add(const Duration(days: 1))),
              sportId: sportId)
          .then((value) {
        isLoading.value = false;
        isPagination = isLoad;
        nbaTomorrowEventsList.clear();
        gameListingTomorrowApiRes(
                key: apiKey,
                isLoad: isLoad,
                sportKey: sportKey,
                date: DateFormat('yyyy-MM-dd')
                    .format(DateTime.parse(date).add(const Duration(days: 2))),
                sportId: sportId)
            .then((value) async {
          getAllEventList(sportKey, isLoad);
          isPagination = false;
          gameListingsWithLogoResponseNCAAB(currentYear, sportKey,
              isLoad: isLoad);
          nbaGameRankApi(isLoad: isLoad, sportKey: sportKey);

          if (nbaSportEventsList.isNotEmpty) {
            for (int i = 0; i < nbaSportEventsList.length; i++) {
              if (nbaSportEventsList[i].uuids != null) {
                boxScoreNBAResponse(
                    sportKey: sportKey,
                    homeTeamId: replaceId(
                            nbaSportEventsList[i].competitors[0].uuids ?? '') ??
                        "",
                    awayTeamId: replaceId(
                            nbaSportEventsList[i].competitors[1].uuids ?? '') ??
                        "",
                    gameId: replaceId(nbaSportEventsList[i].uuids ?? ''),
                    index: i);
              }
            }
          }
        });
        if (nbaTodayEventsList.isNotEmpty) {
          timer = Timer.periodic(const Duration(seconds: 45), (t) {
            nbaTodayEventsList.clear();
            gameListingTodayApiRes(
                    key: apiKey,
                    isLoad: false,
                    sportKey: sportKey,
                    date: date,
                    sportId: sportId)
                .then((value) async {
              gameListingTodayApiRes(
                      key: apiKey,
                      isLoad: false,
                      sportKey: sportKey,
                      date: DateFormat('yyyy-MM-dd').format(
                          DateTime.parse(date).add(const Duration(days: 1))),
                      sportId: sportId)
                  .then((value) async {
                for (int i = 0; i < nbaTodayEventsList.length; i++) {
                  int liveIndex = nbaSportEventsList.indexWhere(
                      (element) => element.id == nbaTodayEventsList[i].id);
                  if (liveIndex >= 0) {
                    setOdds(nbaSportEventsList[liveIndex]);
                  }
                  if (((DateTime.parse(nbaTodayEventsList[i].scheduled ?? "")
                                  .toLocal())
                              .day ==
                          DateTime.now().toLocal().day) &&
                      nbaTodayEventsList[i].status != GameStatus.closed.name) {
                    if (nbaTodayEventsList[i].uuids != null) {
                      boxScoreNBAResponse(
                          sportKey: sportKey,
                          homeTeamId: replaceId(
                                  nbaTodayEventsList[i].competitors[0].uuids ??
                                      '') ??
                              "",
                          awayTeamId: replaceId(
                                  nbaTodayEventsList[i].competitors[1].uuids ??
                                      '') ??
                              "",
                          gameId: replaceId(nbaTodayEventsList[i].uuids ?? ''),
                          index: i);
                    }
                  }
                }
              });
            });
            update();
          });
        }
      });
    });
  }

  Future<void> nbaGameRefreshCall(bool isLoad,
      {String apiKey = '',
      String sportKey = '',
      String date = '',
      String sportId = ''}) async {
    nbaTodayEventsList.clear();
    gameListingTodayApiRes(
            key: apiKey,
            isLoad: isLoad,
            sportKey: sportKey,
            date: date,
            sportId: sportId)
        .then((value) {
      gameListingTodayApiRes(
              key: apiKey,
              isLoad: isLoad,
              sportKey: sportKey,
              date: DateFormat('yyyy-MM-dd')
                  .format(DateTime.parse(date).add(const Duration(days: 1))),
              sportId: sportId)
          .then((value) {
        isLoading.value = false;
        isPagination = isLoad;
        nbaTomorrowEventsList.clear();
        gameListingTomorrowApiRes(
                key: apiKey,
                isLoad: isLoad,
                sportKey: sportKey,
                date: DateFormat('yyyy-MM-dd')
                    .format(DateTime.parse(date).add(const Duration(days: 2))),
                sportId: sportId)
            .then((value) async {
          getAllEventList(sportKey, isLoad);
          isPagination = false;
          gameListingsWithLogoResponseNCAAB(currentYear, sportKey,
              isLoad: isLoad);
          nbaGameRankApi(isLoad: isLoad, sportKey: sportKey);

          if (nbaSportEventsList.isNotEmpty) {
            for (int i = 0; i < nbaSportEventsList.length; i++) {
              if (nbaSportEventsList[i].uuids != null) {
                boxScoreNBAResponse(
                    sportKey: sportKey,
                    homeTeamId: replaceId(
                            nbaSportEventsList[i].competitors[0].uuids ?? '') ??
                        "",
                    awayTeamId: replaceId(
                            nbaSportEventsList[i].competitors[1].uuids ?? '') ??
                        "",
                    gameId: replaceId(nbaSportEventsList[i].uuids ?? ''),
                    index: i);
              }
            }
          }
        });
      });
    });
  }

  Future<void> getGameListingForNCAABRes(
    bool isLoad, {
    String apiKey = '',
    String sportKey = '',
    String date = '',
    String sportId = '',
  }) async {
    ncaabTodayEventsList = [];
    gameListingTodayApiRes(
            key: apiKey,
            isLoad: isLoad,
            sportKey: sportKey,
            date: date,
            sportId: sportId)
        .then((value) {
      gameListingTodayApiRes(
              key: apiKey,
              isLoad: isLoad,
              sportKey: sportKey,
              date: DateFormat('yyyy-MM-dd')
                  .format(DateTime.parse(date).add(const Duration(days: 1))),
              sportId: sportId)
          .then((value) {
        isLoading.value = false;
        ncaabTomorrowEventsList.clear();
        for (int j = 2; j <= 6; j++) {
          isPagination = isLoad;
          gameListingTomorrowApiRes(
                  key: apiKey,
                  isLoad: isLoad,
                  sportKey: sportKey,
                  date: DateFormat('yyyy-MM-dd')
                      .format(DateTime.parse(date).add(Duration(days: j))),
                  sportId: sportId)
              .then((value) async {
            getAllEventList(sportKey, isLoad);
            nbaGameRankApi(isLoad: isLoad, sportKey: sportKey).then((v) {
              if (j == 6) {
                isPagination = false;
              }
            });
            gameListingsWithLogoResponseNCAAB(currentYear, sportKey,
                isLoad: isLoad);
            if (ncaabSportEventsList.isNotEmpty) {
              getConferenceNCAAB(false);
              ncaaGameRanking(
                sportName: sportKey,
                isLoad: isLoad,
                sportList: ncaabSportEventsList,
              );
              for (int i = 0; i < ncaabSportEventsList.length; i++) {
                if (ncaabSportEventsList[i].uuids != null) {
                  if (DateTime.parse(ncaabSportEventsList[i].scheduled ?? "")
                          .toLocal()
                          .day ==
                      DateTime.now().day) {
                    boxScoreNBAResponse(
                        sportKey: sportKey,
                        homeTeamId: replaceId(
                                ncaabSportEventsList[i].competitors[0].uuids ??
                                    '') ??
                            "",
                        awayTeamId: replaceId(
                                ncaabSportEventsList[i].competitors[1].uuids ??
                                    '') ??
                            "",
                        gameId: replaceId(ncaabSportEventsList[i].uuids ?? ''),
                        index: i);
                  }
                }
              }
            }
          });
        }
        if (ncaabTodayEventsList.isNotEmpty) {
          timer = Timer.periodic(const Duration(seconds: 45), (t) {
            ncaabTodayEventsList.clear();
            gameListingTodayApiRes(
                    key: apiKey,
                    isLoad: false,
                    sportKey: sportKey,
                    date: date,
                    sportId: sportId)
                .then((value) async {
              gameListingTodayApiRes(
                      key: apiKey,
                      isLoad: false,
                      sportKey: sportKey,
                      date: DateFormat('yyyy-MM-dd').format(
                          DateTime.parse(date).add(const Duration(days: 1))),
                      sportId: sportId)
                  .then((value) async {
                for (int i = 0; i < ncaabTodayEventsList.length; i++) {
                  int liveIndex = ncaabSportEventsList.indexWhere(
                      (element) => element.id == ncaabTodayEventsList[i].id);
                  if (liveIndex >= 0) {
                    setOdds(ncaabSportEventsList[liveIndex]);
                  }
                  if (((DateTime.parse(ncaabTodayEventsList[i].scheduled ?? "")
                                  .toLocal())
                              .day ==
                          DateTime.now().toLocal().day) &&
                      (ncaabTodayEventsList[i].status !=
                              GameStatus.closed.name ||
                          ncaabTodayEventsList[i].status != "complete")) {
                    if (ncaabTodayEventsList[i].uuids != null) {
                      boxScoreNBAResponse(
                          sportKey: sportKey,
                          homeTeamId: replaceId(ncaabTodayEventsList[i]
                                      .competitors[0]
                                      .uuids ??
                                  '') ??
                              "",
                          awayTeamId: replaceId(ncaabTodayEventsList[i]
                                      .competitors[1]
                                      .uuids ??
                                  '') ??
                              "",
                          gameId:
                              replaceId(ncaabTodayEventsList[i].uuids ?? ''),
                          index: i);
                    }
                  }
                }
              });
            });
            update();
          });
        }
      });
    });
  }

  ncaabGameRefreshCall(
    bool isLoad, {
    String apiKey = '',
    String sportKey = '',
    String date = '',
    String sportId = '',
  }) {
    ncaabTodayEventsList = [];
    gameListingTodayApiRes(
            key: apiKey,
            start: 0,
            isLoad: isLoad,
            sportKey: sportKey,
            date: date,
            sportId: sportId)
        .then((value) {
      gameListingTodayApiRes(
              key: apiKey,
              isLoad: isLoad,
              sportKey: sportKey,
              date: DateFormat('yyyy-MM-dd')
                  .format(DateTime.parse(date).add(const Duration(days: 1))),
              sportId: sportId)
          .then((value) {
        isLoading.value = false;
        isPagination = isLoad;
        ncaabTomorrowEventsList = [];
        for (int j = 2; j <= 6; j++) {
          gameListingTomorrowApiRes(
                  key: apiKey,
                  isLoad: isLoad,
                  sportKey: sportKey,
                  date: DateFormat('yyyy-MM-dd')
                      .format(DateTime.parse(date).add(Duration(days: j))),
                  sportId: sportId)
              .then((value) async {
            getAllEventList(sportKey, isLoad);
            gameListingsWithLogoResponseNCAAB(currentYear, sportKey,
                isLoad: isLoad);
            nbaGameRankApi(isLoad: isLoad, sportKey: sportKey);
            if (ncaabSportEventsList.isNotEmpty) {
              ncaaGameRanking(
                  sportName: sportKey,
                  isLoad: false,
                  sportList: ncaabSportEventsList);
              getConferenceNCAAB(false);
              for (int i = 0; i < ncaabSportEventsList.length; i++) {
                if (ncaabSportEventsList[i].uuids != null) {
                  if (DateTime.parse(ncaabSportEventsList[i].scheduled ?? "")
                          .toLocal()
                          .day ==
                      DateTime.now().day) {
                    boxScoreNBAResponse(
                        sportKey: sportKey,
                        homeTeamId: replaceId(
                                ncaabSportEventsList[i].competitors[0].uuids ??
                                    '') ??
                            "",
                        awayTeamId: replaceId(
                                ncaabSportEventsList[i].competitors[1].uuids ??
                                    '') ??
                            "",
                        gameId: replaceId(ncaabSportEventsList[i].uuids ?? ''),
                        index: i);
                  }
                }
              }
            }
          });
        }
      });
    });
  }

  ///other apis
  void gameListingsWithLogoResponse(String year, String sportKey,
      {bool isLoad = false}) async {
    // isLoading.value = !isLoad ? false : true;

    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo().gameListingsWithLogo(year, sportKey);
    // result = await BaseApiHelper.jasonRequestNew(sportKey);
    try {
      Map<String, dynamic> data = result.data;
      if (result.status) {
        try {
          data.forEach((key, value) {
            if (result.data[key] != null) {
              if (result.data[key]['games'] != null) {
                (result.data[key]['games']).forEach((games) {
                  games['competitions'].forEach((teams) {
                    teams['competitors'].forEach((details) {
                      for (var element in (getSportEventList(sportKey))) {
                        Competitors? homeTeam;
                        Competitors? awayTeam;
                        if (element.competitors[0].qualifier == 'home') {
                          homeTeam = element.competitors[0];
                        } else {
                          awayTeam = element.competitors[0];
                        }
                        if (element.competitors[1].qualifier == 'away') {
                          awayTeam = element.competitors[1];
                        } else {
                          homeTeam = element.competitors[1];
                        }
                        if ((homeTeam?.abbreviation ?? '') ==
                                details['team']['abbreviation'] ||
                            (homeTeam?.name ?? "") ==
                                details['team']['displayName']) {
                          element.homeGameLogo = details['team']['logo'];
                        }
                        if ((awayTeam?.abbreviation ?? "") ==
                                details['team']['abbreviation'] ||
                            (awayTeam?.name ?? "") ==
                                details['team']['displayName']) {
                          element.awayGameLogo = details['team']['logo'];
                        }
                      }
                    });
                  });
                });
              }
            }
          });
        } catch (e) {
          dev.log('error--$e');
        }
        isLoading.value = false;
      } else {
        isLoading.value = false;
        // showAppSnackBar(
        //   errorText,
        // );
      }
    } catch (e) {
      // isLoading.value = false;
      // showAppSnackBar(
      //   errorText,
      // );
    }
    update();
  }

  void gameListingsWithLogoResponseNCAAB(String year, String sportKey,
      {bool isLoad = false}) async {
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo().gameListingsWithLogoForNCAAB(sportKey);
    try {
      isLoading.value = isLoad;
      if (result.status) {
        TeamLogoModel response = TeamLogoModel.fromJson(result.data);
        try {
          if (response.sports != null) {
            for (var element in (getSportEventList(sportKey))) {
              Competitors? homeTeam;
              Competitors? awayTeam;
              if (element.competitors[0].qualifier == 'home') {
                homeTeam = element.competitors[0];
              } else {
                awayTeam = element.competitors[0];
              }
              if (element.competitors[1].qualifier == 'away') {
                awayTeam = element.competitors[1];
              } else {
                homeTeam = element.competitors[1];
              }
              response.sports?.forEach((sport) {
                sport.leagues?.forEach((league) {
                  league.teams?.forEach((team) {
                    if (team.team?.abbreviation == awayTeam?.abbreviation ||
                        team.team?.displayName == awayTeam?.name) {
                      if (team.team?.logos != null) {
                        element.awayGameLogo = team.team?.logos?[0].href;
                      }
                    }
                    if (team.team?.abbreviation == homeTeam?.abbreviation ||
                        team.team?.displayName == homeTeam?.name) {
                      if (team.team?.logos != null) {
                        element.homeGameLogo = team.team?.logos?[0].href;
                      }
                    }
                  });
                });
              });
            }
          }
        } catch (e) {
          dev.log('error--$e');
        }
        isLoading.value = false;
      } else {}
    } catch (e) {
      isLoading.value = false;
    }
    update();
  }

  Future getWeather(String cityName,
      {bool isLoad = false, int index = 0, required String sportKey}) async {
    // Get the current game's scheduled time
    SportEvents gameEvent = (sportKey == SportName.MLB.name
        ? mlbSportEventsList
        : sportKey == SportName.NFL.name
            ? nflSportEventsList
            : ncaaSportEventsList)[index];
    
    String gameScheduledTime = gameEvent.scheduled ?? "";
    
    // Log start of weather fetch with detailed parameters
    print('🌡️ WEATHER API CALL START: city=${cityName.split(',').first}, sportKey=$sportKey, index=$index, gameTime=$gameScheduledTime');
    
    // Skip if city name is empty
    if (cityName.isEmpty) {
      print('⚠️ WEATHER API ERROR: Empty city name for game');
      return;
    }
    
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo().getWeather(cityName.split(',').first);
    
    try {
      if (result.status) {
        if (result.data != null) {
          // Check if 'forecast' exists in response
          if (result.data['forecast'] == null || result.data['forecast']['forecastday'] == null) {
            print('⚠️ WEATHER API ERROR: Missing forecast data in response');
            
            // Fall back to current weather if no forecast
            if (result.data['current'] != null) {
              print('🌡️ WEATHER API: Falling back to current weather data');
              processCurrentWeather(result.data['current'], sportKey, index);
            }
            return;
          }
          
          // Process the game's scheduled time to determine which forecast hour to use
          DateTime gameDateTime;
          try {
            gameDateTime = DateTime.parse(gameScheduledTime).toLocal();
            print('🕒 Game time (local): ${gameDateTime.toString()}');
          } catch (e) {
            print('⚠️ Failed to parse game time: $e');
            // Fall back to current weather if we can't parse game time
            if (result.data['current'] != null) {
              processCurrentWeather(result.data['current'], sportKey, index);
            }
            return;
          }
          
          // Get the forecast day for the game date
          var forecastDay = result.data['forecast']['forecastday'][0];
          if (forecastDay == null || forecastDay['hour'] == null) {
            print('⚠️ Missing hourly forecast data');
            // Fall back to current weather
            if (result.data['current'] != null) {
              processCurrentWeather(result.data['current'], sportKey, index);
            }
            return;
          }
          
          // Find the forecast hour closest to the game time
          var hourlyForecasts = forecastDay['hour'];
          var gameHour = gameDateTime.hour;
          
          // Default to noon if we can't find a good match
          var closestHourForecast = hourlyForecasts[12]; 
          var smallestDiff = 24;
          
          for (var hourForecast in hourlyForecasts) {
            try {
              // Parse the time from the forecast
              var forecastTime = DateTime.parse(hourForecast['time']).hour;
              var diff = (forecastTime - gameHour).abs();
              
              // Find closest hour to game time
              if (diff < smallestDiff) {
                smallestDiff = diff;
                closestHourForecast = hourForecast;
              }
            } catch (e) {
              print('⚠️ Error parsing hour forecast: $e');
              continue;
            }
          }
          
          print('🌡️ Using forecast for hour closest to game time (${gameHour}:00)');
          
          // Process the forecast for the specific game hour
          if (closestHourForecast != null && closestHourForecast['condition'] != null) {
            var conditionData = closestHourForecast['condition'];
            
            // Check if it's day or night for the selected hour
            bool isDay = closestHourForecast['is_day'] == 1;
            print('🌞🌙 Is daytime at game hour: $isDay');
            
            // Map the WeatherAPI condition code to our internal weather condition code
            int weatherCode = conditionData['code'] ?? 805;
            
            // Convert the API condition code to match our internal weather display system
            int mappedCode = 805; // Default value
            if (weatherCode == 1000) {
              // Sunny/Clear
              mappedCode = 800;
            } else if (weatherCode >= 1001 && weatherCode <= 1003) {
              // Partly cloudy
              mappedCode = 801;
            } else if (weatherCode >= 1004 && weatherCode <= 1009) {
              // Cloudy/Overcast
              mappedCode = 804;
            } else if (weatherCode >= 1030 && weatherCode <= 1149) {
              // Mist/Fog/Drizzle
              mappedCode = 310;
            } else if (weatherCode >= 1150 && weatherCode <= 1201) {
              // Rain
              mappedCode = 500;
            } else if (weatherCode >= 1202 && weatherCode <= 1237) {
              // Snow/Sleet
              mappedCode = 600;
            } else if (weatherCode >= 1238 && weatherCode <= 1282) {
              // Thunder
              mappedCode = 200;
            }
            
            // Store the mapped weather code
            gameEvent.weather = mappedCode;
              
            // Store the temperature (already in F)
            num tempF = closestHourForecast['temp_f'] ?? 0;
            gameEvent.temp = tempF;
              
            // Store the weather icon URL directly from the API - this will now correctly show day/night
            String iconUrl = "https:${conditionData['icon'] ?? ''}";
            print('🌡️ WEATHER ICON URL (game time specific): $iconUrl');
            
            gameEvent.weatherIconUrl = iconUrl;
          } else {
            // Fall back to current weather if hour forecast is missing
            print('⚠️ Missing condition data in hour forecast, falling back to current');
            if (result.data['current'] != null) {
              processCurrentWeather(result.data['current'], sportKey, index);
            }
          }
        }
      } else {
        isLoading.value = false;
        print('❌ WEATHER API ERROR: Request failed with message: ${result.message}');
      }
    } catch (e) {
      print('❌ WEATHER API ERROR EXCEPTION: $e');
    }
    update();
  }
  
  // Helper method to process current weather data (for fallback)
  void processCurrentWeather(Map<String, dynamic> currentData, String sportKey, int index) {
    if (currentData == null || currentData['condition'] == null) {
      print('⚠️ Invalid current weather data');
      return;
    }
    
    var conditionData = currentData['condition'];
    
    // Map the WeatherAPI condition code to our internal weather condition code
    int weatherCode = conditionData['code'] ?? 805;
    
    // Convert the API condition code to match our internal weather display system
    int mappedCode = 805; // Default value
    if (weatherCode == 1000) {
      // Sunny/Clear
      mappedCode = 800;
    } else if (weatherCode >= 1001 && weatherCode <= 1003) {
      // Partly cloudy
      mappedCode = 801;
    } else if (weatherCode >= 1004 && weatherCode <= 1009) {
      // Cloudy/Overcast
      mappedCode = 804;
    } else if (weatherCode >= 1030 && weatherCode <= 1149) {
      // Mist/Fog/Drizzle
      mappedCode = 310;
    } else if (weatherCode >= 1150 && weatherCode <= 1201) {
      // Rain
      mappedCode = 500;
    } else if (weatherCode >= 1202 && weatherCode <= 1237) {
      // Snow/Sleet
      mappedCode = 600;
    } else if (weatherCode >= 1238 && weatherCode <= 1282) {
      // Thunder
      mappedCode = 200;
    }
    
    // Store the mapped weather code
    (sportKey == SportName.MLB.name
            ? mlbSportEventsList
            : sportKey == SportName.NFL.name
                ? nflSportEventsList
                : ncaaSportEventsList)[index]
        .weather = mappedCode;
        
    // Store the temperature (already in F - no conversion needed)
    num tempF = currentData['temp_f'] ?? 0;
    
    (sportKey == SportName.MLB.name
            ? mlbSportEventsList
            : sportKey == SportName.NFL.name
                ? nflSportEventsList
                : ncaaSportEventsList)[index]
        .temp = tempF;
        
    // Store the weather icon URL directly from the API
    String iconUrl = "https:${conditionData['icon'] ?? ''}";
    print('🌡️ WEATHER ICON URL (current fallback): $iconUrl');
    
    (sportKey == SportName.MLB.name
            ? mlbSportEventsList
            : sportKey == SportName.NFL.name
                ? nflSportEventsList
                : ncaaSportEventsList)[index]
        .weatherIconUrl = iconUrl;
  }
}
