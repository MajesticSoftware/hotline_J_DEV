import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hotlines/model/leauge_model.dart';
import 'package:hotlines/model/mlb_box_score_model.dart';
import 'package:hotlines/utils/animated_search.dart';
import 'package:intl/intl.dart';

import '../../../constant/constant.dart';
import '../../../constant/shred_preference.dart';
import '../../../extras/constants.dart';
import '../../../model/forgot_pass_model.dart';
import '../../../model/game_listing.dart';
import '../../../model/nba_boxscore_model.dart';
import '../../../model/nba_rank_model.dart';
import '../../../model/ncaa_boxcore_model.dart';
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
    log('I am closed');
  }

  String sportId = ((PreferenceManager.getFavoriteSport() ?? "NFL") == 'MLB'
      ? 'sr:sport:3'
      : ((PreferenceManager.getFavoriteSport() ?? "NFL") == 'NBA') ||
              ((PreferenceManager.getFavoriteSport() ?? "NFL") == 'NCAAB')
          ? 'sr:sport:2'
          : 'sr:sport:16');
  String _sportKey = (PreferenceManager.getFavoriteSport() == "NCAAF"
          ? "NCAA"
          : PreferenceManager.getFavoriteSport()) ??
      "NFL";

  String get sportKey => _sportKey;

  set sportKey(String value) {
    _sportKey = value;
    update();
  }

  favoriteGameCall() {
    sportId = ((PreferenceManager.getFavoriteSport() ?? "NFL") == 'MLB'
        ? 'sr:sport:3'
        : ((PreferenceManager.getFavoriteSport() ?? "NFL") == 'NBA') ||
                ((PreferenceManager.getFavoriteSport() ?? "NFL") == 'NCAAB')
            ? 'sr:sport:2'
            : 'sr:sport:16');
    sportKey = (PreferenceManager.getFavoriteSport() == "NCAAF"
            ? "NCAA"
            : PreferenceManager.getFavoriteSport()) ??
        "NFL";
    isSelected.add(PreferenceManager.getFavoriteSport() ?? "NFL");
    isSelectedGame = PreferenceManager.getFavoriteSport() ?? "NFL";
    Future.delayed(
      Duration.zero,
      () async {
        isPagination = true;
        isLoading.value = true;
        await getResponse(
            true,
            (PreferenceManager.getFavoriteSport() == "NCAAF"
                    ? "NCAA"
                    : PreferenceManager.getFavoriteSport()) ??
                "NFL");
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

  gameOnClick(BuildContext context, int index) {
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
      gameDetails: (getSportEventList(sportKey))[index],
      sportKey: sportKey,
      sportId: sportId,
      date: date,
    ));
    update();
  }

  Future<void> getSubscriptionStatus() async {
    isLoading.value = true;
    ResponseItem result = Platform.isIOS
        ? await SubscriptionRepo.getReceiptStatus()
        : await SubscriptionRepo.getGoogleCloudStatus();
    try {
      if (result.status) {
        UserData subscriptionModel = UserData.fromJson(result.data);
        PreferenceManager().saveSubscription(subscriptionModel);
        update();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    isLoading.value = false;
    update();
  }

  searchGameOnClick(BuildContext context, int index) {
    toggle = 0;
    FocusScope.of(context).unfocus();
    if ((PreferenceManager.getIsOpenDialog() == null) &&
        ((PreferenceManager.getSubscriptionActive() ?? "1") == "0")) {
      PreferenceManager.setIsOpenDialog(true);
    } else {
      PreferenceManager.setIsOpenDialog(false);
    }
    searchCon.clear();
    searchCon.text = '';
    Get.to(SportDetailsScreen(
      gameDetails: searchList[index],
      sportKey: sportKey,
      sportId: sportId,
      date: date,
    ));
    update();
  }

  String apiKey = 'brcnsyc4vqhxys2xhm8kbswz';
  String date = (PreferenceManager.getFavoriteSport() ?? "NFL") == "NFL"
      ? "2024-02-11"
      : DateFormat('yyyy-MM-dd').format(DateTime.now());
  List<String> _isSelected = [PreferenceManager.getFavoriteSport() ?? "NFL"];

  List<String> get isSelected => _isSelected;

  set isSelected(List<String> value) {
    _isSelected = value;
    update();
  }

  String _isSelectedGame = PreferenceManager.getFavoriteSport() ?? "NFL";

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
        log('RESPONSE--${result.status}');
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
      showAppSnackBar(errorText);
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
        log('RESPONSE--${result.status}');
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
      showAppSnackBar(errorText);
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
    _nflSportEventsList = value;
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
    _searchList = value;
    update();
  }

  bool _isPagination = false;

  bool get isPagination => _isPagination;

  set isPagination(bool value) {
    _isPagination = value;
    update();
  }

/*  bool _isBack = false;

  bool get isBack => _isBack;

  setIsBack(bool value) {
    _isBack = value;
    update();
  }

  bool _isBackNFL = false;

  bool get isBackNFL => _isBackNFL;

  setIsBackNFL(bool value) {
    _isBackNFL = value;
    update();
  }

  bool _isBackNCAA = false;

  bool get isBackNCAA => _isBackNCAA;

  setIsBackNCAA(bool value) {
    _isBackNCAA = value;
    update();
  }*/
  Future getResponse(bool isLoad, String sportKey) async {
    if (sportKey == 'MLB') {
      return await getGameListingForMLBRes(isLoad,
          apiKey: apiKey, sportKey: 'MLB', date: date, sportId: sportId);
    } else if (sportKey == 'NFL') {
      return await getGameListingForNFLGame(isLoad,
          apiKey: apiKey, sportKey: "NFL", date: date, sportId: sportId);
    } else if (sportKey == 'NCAA') {
      return getGameListingForNCAAGame(isLoad,
          apiKey: apiKey, sportKey: sportKey, date: date, sportId: sportId);
    } else if (sportKey == 'NBA') {
      return getGameListingForNBARes(isLoad,
          apiKey: apiKey, sportKey: sportKey, date: date, sportId: sportId);
    } else if (sportKey == 'NCAAB') {
      return getGameListingForNCAABRes(isLoad,
          apiKey: apiKey, sportKey: sportKey, date: date, sportId: sportId);
    }
  }

  searchData(String text, String sportKey) {
    searchList.clear();
    if (text.isNotEmpty) {
      for (var element in (getSportEventList(sportKey))) {
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

  /* List<SportEvents> get sportEventList => sportEventList
      .where((id) => (getShovlerJobListByIndex(selectedTab) == "ALL"
          ? true
          : (status.status == getShovlerJobListByIndex(selectedTab) ||
              (selectedTab == 2 &&
                  status.isArrive &&
                  status.status == 'ACTIVE'))))
      .toList();*/

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
    _nflTomorrowEventsList = value;
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
  Future gameListingTodayApiRes(
      {String sportId = '',
      String date = "",
      String sportKey = "",
      bool isLoad = false,
      String key = ''}) async {
    isLoading.value = !isLoad ? false : true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo()
        .gameListingRepo(key: key, date: date, spotId: sportId);
    try {
      getTodayList(sportKey).clear();

      if (result.status) {
        GameListingDataModel response =
            GameListingDataModel.fromJson(result.data);
        final sportEvents = response.sportEvents;
        if (sportEvents != null) {
          for (var event in sportEvents) {
            DateTime time = (DateTime.parse(event.scheduled ?? ''));
            // log('UTC TIME---> ${time.toUtc()} |||| ${DateTime.now().toUtc()}');
            var difference =
                (time.toUtc().difference((DateTime.now().toUtc())));
            // log('difference----->>  ${difference.inHours}');
            if (event.season?.id == 'sr:season:100127' &&
                sportKey == 'MLB' &&
                (difference.inHours >= (-6))) {
              mlbTodayEventsList.add(event);
            } else if (event.season?.id == 'sr:season:102797' &&
                sportKey == 'NFL' &&
                (difference.inHours >= (-6))) {
              nflTodayEventsList.add(event);
            } else if ((event.season?.id == 'sr:season:101983' ||
                    event.season?.id == "sr:season:101811") &&
                sportKey == 'NCAA' &&
                (difference.inHours >= (-6))) {
              ncaaTodayEventsList.add(event);
            } else if (event.season?.id == 'sr:season:104319' &&
                sportKey == 'NCAAB' &&
                (difference.inHours >= (-6))) {
              ncaabTodayEventsList.add(event);
            } else if (event.season?.id == 'sr:season:106289' &&
                sportKey == 'NBA' &&
                (difference.inHours >= (-6))) {
              nbaTodayEventsList.add(event);
            }
          }
        }
        (getTodayList(sportKey)).sort((a, b) =>
            DateTime.parse(a.scheduled ?? "")
                .compareTo(DateTime.parse(b.scheduled ?? "")));
      } else {
        isLoading.value = false;
        if (result.message == 'Error in response: No internet connection') {
          showAppSnackBar(
            result.message,
          );
        }
      }
    } catch (e) {
      isLoading.value = false;
      log('ERROR TODAY GAME LISTING--------$e');
      // showAppSnackBar(
      //   result.message,
      // );
    }
    update();
    return getTodayList(sportKey);
  }

  List<SportEvents> getTodayList(sportKey) {
    return (sportKey == 'NFL'
        ? nflTodayEventsList
        : sportKey == 'MLB'
            ? mlbTodayEventsList
            : sportKey == 'NBA'
                ? nbaTodayEventsList
                : sportKey == 'NCAAB'
                    ? ncaabTodayEventsList
                    : ncaaTodayEventsList);
  }

  List<SportEvents> getTomorrowList(sportKey) {
    return (sportKey == 'NFL'
        ? nflTomorrowEventsList
        : sportKey == 'MLB'
            ? mlbTomorrowEventsList
            : sportKey == 'NBA'
                ? nbaTomorrowEventsList
                : sportKey == 'NCAAB'
                    ? ncaabTomorrowEventsList
                    : ncaaTomorrowEventsList);
  }

  List<SportEvents> getSportEventList(sportKey) {
    return sportKey == 'NFL'
        ? nflSportEventsList
        : sportKey == 'MLB'
            ? mlbSportEventsList
            : sportKey == 'NCAAB'
                ? ncaabSportEventsList
                : sportKey == 'NBA'
                    ? nbaSportEventsList
                    : ncaaSportEventsList;
  }

  Future gameListingTomorrowApiRes(
      {String sportId = '',
      String date = "",
      String sportKey = "",
      bool isLoad = false,
      String key = ''}) async {
    // isLoading.value = !isLoad ? false : true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo()
        .gameListingRepo(key: key, date: date, spotId: sportId);
    try {
      // getTomorrowList(sportKey).clear();
      if (result.status) {
        GameListingDataModel response =
            GameListingDataModel.fromJson(result.data);
        final sportEvents = response.sportEvents;
        if (sportEvents != null) {
          for (var event in sportEvents) {
            if (event.season?.id == 'sr:season:100127' &&
                sportKey == 'MLB' &&
                DateTime.parse(event.scheduled ?? '').toLocal().day !=
                    DateTime.now().add(const Duration(days: 1)).toLocal().day) {
              mlbTomorrowEventsList.add(event);
            } else if (event.season?.id == 'sr:season:102797' &&
                sportKey == 'NFL') {
              nflTomorrowEventsList.add(event);
            } else if ((event.season?.id == 'sr:season:101983' ||
                    (event.season?.id == 'sr:season:101811')) &&
                sportKey == 'NCAA') {
              ncaaTomorrowEventsList.add(event);
            } else if (event.season?.id == 'sr:season:104319' &&
                sportKey == 'NCAAB') {
              ncaabTomorrowEventsList.add(event);
            } else if (event.season?.id == 'sr:season:106289' &&
                sportKey == 'NBA') {
              nbaTomorrowEventsList.add(event);
            }
          }
        }
        getTomorrowList(sportKey).sort((a, b) =>
            DateTime.parse(a.scheduled ?? "")
                .compareTo(DateTime.parse(b.scheduled ?? "")));
      } else {
        isLoading.value = false;
        // showAppSnackBar(
        //   result.message,
        // );
      }
    } catch (e) {
      // isLoading.value = false;
      log('ERROR TOMORROW GAME LISTING-----$e');
      showAppSnackBar(errorText);
    }
    update();
  }

  ///GET ALL EVENT BY HOME AWAY FILTER
  getAllEventList(String sportKey, bool isLoad) {
    getSportEventList(sportKey).clear();
    getSportEventList(sportKey).addAll(getTodayList(sportKey));
    getSportEventList(sportKey).addAll(getTomorrowList(sportKey));
    getSportEventList(sportKey).sort((a, b) => DateTime.parse(a.scheduled ?? "")
        .compareTo(DateTime.parse(b.scheduled ?? "")));
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

      if (event.consensus != null) {
        ///MONEY LINES
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
        if (event.consensus?.lines != null) {
          event.consensus?.lines?.forEach((consensus) {
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

            if (consensus.name == 'total_current') {
              event.homeOU = consensus.total.toString();
              event.awayOU = consensus.total.toString();
            }
            /*if (consensus.name == 'run_line_current' ||
                consensus.name == 'spread_current') {
              event.homeSpread = '${consensus.spread}'.toString();
              event.awaySpread = '${consensus.spread}'.toString();
            }*/
          });
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
                game.outcome?.currentInning.toString() ?? '';
            mlbSportEventsList[index].inningHalf =
                game.outcome?.currentInningHalf.toString() ?? '';
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
      log('ERROR BOX SCORE MLB----$e');
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
          if (key == 'NFL') {
            nflSportEventsList[index].inning = (game.quarter ?? "0").toString();
            nflSportEventsList[index].inningHalf = "Q";
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
      log('ERROR BOX SCORE NFL && NCAA--------$e');
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
          if (sportKey == "NBA") {
            nbaSportEventsList[index].inning = (game.quarter ?? "0").toString();
            nbaSportEventsList[index].inningHalf = 'Q';
          } else {
            ncaabSportEventsList[index].inning = (game.half ?? "0").toString();
            ncaabSportEventsList[index].inningHalf = 'H';
          }
          if (homeTeamId == game.home?.id) {
            if (sportKey == "NBA") {
              nbaSportEventsList[index].homeScore =
                  (game.home?.points ?? "0").toString();
            } else {
              ncaabSportEventsList[index].homeScore =
                  (game.home?.points ?? "0").toString();
            }
          }
          if (awayTeamId == game.away?.id) {
            if (sportKey == "NBA") {
              nbaSportEventsList[index].awayScore =
                  (game.away?.points ?? "0").toString();
            } else {
              ncaabSportEventsList[index].awayScore =
                  (game.away?.points ?? "0").toString();
            }
          }
        }
        update();
      } else {
        // showAppSnackBar(
        //   result.message,
        // );
      }
    } catch (e) {
      log('ERROR BOX SCORE MLB----$e');
      // showAppSnackBar(
      //   errorText,
      // );
    }
    update();
  }

  ///NCAA RANKING
  Future ncaaGameRanking(
      {String awayTeamId = '',
      String homeTeamId = '',
      bool isLoad = false,
      required SportEvents gameDetails}) async {
    // isLoading.value = !isLoad ? false : true;
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo().ncaaGameRanking();
    try {
      if (result.status) {
        RankingModel response = RankingModel.fromJson(result.data);
        if (response.rankings != null) {
          response.rankings?.forEach((player) {
            if (player.id.toString() == homeTeamId) {
              gameDetails.homeRank = player.rank.toString();
            }
            if (player.id.toString() == awayTeamId) {
              gameDetails.awayRank = player.rank.toString();
            }
          });
        }
      } else {
        isLoading.value = false;
        // showAppSnackBar(
        //   result.message,
        // );
      }
    } catch (e) {
      // isLoading.value = false;
      log('ERROR NCAA RANKING-------$e');
      showAppSnackBar(
        errorText,
      );
    }
    update();
  }

  setOdds(List<SportEvents> sportList) {
    sportList.sort((a, b) => DateTime.parse(a.scheduled ?? "")
        .compareTo(DateTime.parse(b.scheduled ?? "")));
    for (var event in sportList) {
      ///MONEY LINES
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
      if (event.consensus != null) {
        if (event.consensus?.lines != null) {
          event.consensus?.lines?.forEach((consensus) {
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

            if (consensus.name == 'total_current') {
              event.homeOU = consensus.total.toString();
              event.awayOU = consensus.total.toString();
            }
          });
        }
      }
    }
  }

  ///GAME LISTING FOR ALL GAME
  Timer? timer;
  Timer? timerNCAA;
  Timer? timerNFL;

  getGameListingForNCAAGame(bool isLoad,
      {String apiKey = '',
      String sportKey = '',
      String date = '',
      String sportId = ''}) {
    gameListingTodayApiRes(
            key: apiKey,
            isLoad: isLoad,
            sportKey: sportKey,
            date: date,
            sportId: sportId)
        .then((value) {
      isLoading.value = false;
      isPagination = isLoad;
      ncaaTomorrowEventsList.clear();
      for (int i = 1; i <= 12; i++) {
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
          gameListingsWithLogoResponse(DateTime.now().year.toString(), sportKey,
              isLoad: isLoad);
          if (i == 12) {
            isPagination = false;
          }
        }).then((value) {
          if (ncaaSportEventsList.isNotEmpty) {
            for (int i = 0; i < ncaaSportEventsList.length; i++) {
              if (ncaaSportEventsList[i].uuids != null) {
                getWeather(ncaaSportEventsList[i].venue?.cityName ?? "",
                    index: i, sportKey: sportKey);
                boxScoreResponseNCAA(
                    key: sportKey,
                    gameId: replaceId(ncaaSportEventsList[i].uuids ?? ''),
                    index: i);
                ncaaGameRanking(
                  isLoad: false,
                  gameDetails: ncaaSportEventsList[i],
                  homeTeamId: replaceId(
                          ncaaSportEventsList[i].competitors[0].uuids ?? '') ??
                      "",
                  awayTeamId: replaceId(
                          ncaaSportEventsList[i].competitors[1].uuids ?? '') ??
                      "",
                );
              }
            }
          }
        });
      }
      if (ncaaTodayEventsList.isNotEmpty) {
        timerNCAA = Timer.periodic(const Duration(seconds: 45), (t) async {
          await gameListingTodayApiRes(
                  key: apiKey,
                  isLoad: false,
                  sportKey: sportKey,
                  date: date,
                  sportId: sportId)
              .then((value) {
            setOdds(ncaaTodayEventsList);
            for (int i = 0; i < ncaaTodayEventsList.length; i++) {
              int newIndex = (ncaaSportEventsList.indexWhere(
                  (element) => element.id == ncaaTodayEventsList[i].id));
              if (newIndex >= 0) {
                ncaaSportEventsList[newIndex].status =
                    ncaaTodayEventsList[i].status;
                if (ncaaTodayEventsList[i].consensus != null) {
                  ///MONEY LINES
                  if (ncaaTodayEventsList[i].markets.isNotEmpty) {
                    for (var marketData in ncaaTodayEventsList[i].markets) {
                      if (marketData.oddsTypeId == 4) {
                        int fanDuelIndex = marketData.books.indexWhere(
                            (element) => element.id == 'sr:book:18186');
                        for (var bookData in marketData.books) {
                          if (fanDuelIndex >= 0) {
                            if (bookData.id == 'sr:book:18186') {
                              if (bookData.outcomes?[0].type == 'home') {
                                ncaaSportEventsList[newIndex].homeSpread =
                                    bookData.outcomes?[0].spread.toString() ??
                                        '00';
                              }
                              if (bookData.outcomes?[1].type == 'away') {
                                ncaaSportEventsList[newIndex].awaySpread =
                                    bookData.outcomes?[1].spread.toString() ??
                                        '00';
                              }
                            }
                          } else if (bookData.id == 'sr:book:28901') {
                            if (bookData.outcomes?[0].type == 'home') {
                              ncaaSportEventsList[newIndex].homeSpread =
                                  bookData.outcomes?[0].spread.toString() ?? '';
                            }
                            if (bookData.outcomes?[1].type == 'away') {
                              ncaaSportEventsList[newIndex].awaySpread =
                                  bookData.outcomes?[1].spread.toString() ?? '';
                            }
                          } else if (bookData.id == 'sr:book:17324') {
                            if (bookData.outcomes?[0].type == 'home') {
                              ncaaSportEventsList[newIndex].homeSpread =
                                  bookData.outcomes?[0].spread.toString() ?? '';
                            }
                            if (bookData.outcomes?[1].type == 'away') {
                              ncaaSportEventsList[newIndex].awaySpread =
                                  bookData.outcomes?[1].spread.toString() ?? '';
                            }
                          }
                        }
                      }
                    }
                  }

                  if (ncaaTodayEventsList[i].consensus?.lines != null) {
                    ncaaTodayEventsList[i]
                        .consensus
                        ?.lines
                        ?.forEach((consensus) {
                      if (consensus.name == 'moneyline_current') {
                        consensus.outcomes?.forEach((lines) {
                          if (lines.type == 'home') {
                            ncaaSportEventsList[newIndex].homeMoneyLine =
                                lines.odds.toString();
                          }
                          if (lines.type == 'away') {
                            ncaaSportEventsList[newIndex].awayMoneyLine =
                                lines.odds.toString();
                          }
                        });
                      }
                      if (consensus.name == 'total_current') {
                        ncaaSportEventsList[newIndex].homeOU =
                            consensus.total.toString();
                        ncaaSportEventsList[newIndex].awayOU =
                            consensus.total.toString();
                      }
                    });
                  }
                }
              }
              if (DateTime.parse(ncaaTodayEventsList[i].scheduled ?? "")
                          .toLocal()
                          .day ==
                      DateTime.now().day &&
                  ncaaTodayEventsList[i].status != 'closed') {
                if (ncaaTodayEventsList[i].uuids != null) {
                  boxScoreResponseNCAA(
                      key: sportKey,
                      gameId: replaceId(ncaaTodayEventsList[i].uuids ?? ''),
                      index: i);
                }
              }
            }
          });
          update();
        });
      }
    });
  }

  getGameListingForNFLGame(bool isLoad,
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
      isLoading.value = false;
      isPagination = isLoad;
      nflTomorrowEventsList.clear();
      for (int i = 1; i <= 7; i++) {
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
          if (i == 7) {
            isPagination = false;
          }
          gameListingsWithLogoResponseNCAAB(
              DateTime.now().year.toString(), sportKey,
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
          gameListingTodayApiRes(
                  key: apiKey,
                  isLoad: false,
                  sportKey: sportKey,
                  date: date,
                  sportId: sportId)
              .then((value) {
            setOdds(nflTodayEventsList);
            for (int i = 0; i < nflTodayEventsList.length; i++) {
              int newIndex = (nflSportEventsList.indexWhere(
                  (element) => element.id == nflTodayEventsList[i].id));
              if (newIndex >= 0) {
                // log('IS UPDATE NFL------>');
                nflSportEventsList[newIndex].status =
                    nflTodayEventsList[i].status;

                ///MONEY LINES
                if (nflTodayEventsList[i].markets.isNotEmpty) {
                  // log('IS UPDATE NFL------>111');
                  for (var marketData in nflTodayEventsList[i].markets) {
                    if (marketData.oddsTypeId == 4) {
                      int fanDuelIndex = marketData.books.indexWhere(
                          (element) => element.id == 'sr:book:18186');
                      for (var bookData in marketData.books) {
                        if (fanDuelIndex >= 0) {
                          if (bookData.id == 'sr:book:18186') {
                            if (bookData.outcomes?[0].type == 'home') {
                              nflSportEventsList[newIndex].homeSpread =
                                  bookData.outcomes?[0].spread.toString() ??
                                      '00';
                            }
                            if (bookData.outcomes?[1].type == 'away') {
                              nflSportEventsList[newIndex].awaySpread =
                                  bookData.outcomes?[1].spread.toString() ??
                                      '00';
                            }
                          }
                        } else if (bookData.id == 'sr:book:28901') {
                          if (bookData.outcomes?[0].type == 'home') {
                            nflSportEventsList[newIndex].homeSpread =
                                bookData.outcomes?[0].spread.toString() ?? '';
                          }
                          if (bookData.outcomes?[1].type == 'away') {
                            nflSportEventsList[newIndex].awaySpread =
                                bookData.outcomes?[1].spread.toString() ?? '';
                          }
                        } else if (bookData.id == 'sr:book:17324') {
                          if (bookData.outcomes?[0].type == 'home') {
                            nflSportEventsList[newIndex].homeSpread =
                                bookData.outcomes?[0].spread.toString() ?? '';
                          }
                          if (bookData.outcomes?[1].type == 'away') {
                            nflSportEventsList[newIndex].awaySpread =
                                bookData.outcomes?[1].spread.toString() ?? '';
                          }
                        }
                      }
                    }
                  }
                }
                if (nflTodayEventsList[i].consensus != null) {
                  // log('IS UPDATE NFL------>222');
                  if (nflTodayEventsList[i].consensus?.lines != null) {
                    nflTodayEventsList[i]
                        .consensus
                        ?.lines
                        ?.forEach((consensus) {
                      if (consensus.name == 'moneyline_current') {
                        consensus.outcomes?.forEach((lines) {
                          if (lines.type == 'home') {
                            nflSportEventsList[newIndex].homeMoneyLine =
                                lines.odds.toString();
                          }
                          if (lines.type == 'away') {
                            nflSportEventsList[newIndex].awayMoneyLine =
                                lines.odds.toString();
                            nflSportEventsList[newIndex].awayMoneyLine;
                          }
                        });
                      }
                      if (consensus.name == 'total_current') {
                        nflSportEventsList[newIndex].homeOU =
                            consensus.total.toString();
                        nflSportEventsList[newIndex].awayOU =
                            consensus.total.toString();
                      }
                    });
                  }
                }
              }
              if (DateTime.parse(nflTodayEventsList[i].scheduled ?? "")
                          .toLocal()
                          .day ==
                      DateTime.now().day &&
                  nflTodayEventsList[i].status != 'closed') {
                if (nflTodayEventsList[i].uuids != null) {
                  boxScoreResponseNCAA(
                      key: sportKey,
                      gameId: replaceId(nflTodayEventsList[i].uuids ?? ''),
                      index: i);
                }
              }
            }
          });
          update();
        });
      }
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
      log('ERROR NFL GAME RANK-----$e');
      showAppSnackBar(errorText);
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
                  (element.passingYardOffense ?? 0).toString(),
                  (element.passingTDSOffense ?? 0).toString(),
                  (element.rushingYardOffense ?? 0).toString(),
                  (element.rushingTDsOffense ?? 0).toString(),
                  (element.interceptionOffense ?? 0).toString(),
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
                  (element.passingYardOffense ?? 0).toString(),
                  (element.passingTDSOffense ?? 0).toString(),
                  (element.rushingYardOffense ?? 0).toString(),
                  (element.rushingTDsOffense ?? 0).toString(),
                  (element.interceptionOffense ?? 0).toString(),
                ];
              }
            });
          }
        }
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      log('ERROR NFL GAME RANK-----$e');
      showAppSnackBar(errorText);
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
                  team.reboundesOffense.toString(),
                  team.assistOffense.toString(),
                  team.stealsOffense.toString(),
                  team.blocksOffense.toString(),
                  team.turnOverOffense.toString(),
                  team.foulsOffense.toString(),
                  '${team.fgAttOffense} / ${team.fgMadeOffense} / ${team.fgOffense}%',
                  '${team.threePAttOffense} / ${team.threePMadeOffense} / ${team.threePOffense}%',
                  '${team.ftAttOffense} / ${team.ftMadeOffense} / ${team.ftOffense}%',
                  '${((team.trueShootingOffense ?? 0) * 100).toStringAsFixed(1)}%'
                      .toString(),
                  team.teamPerOffense.toString(),
                ];
                element.nbaAwayOffensiveRank = [
                  (team.pointOffenseRank ?? 0).toString(),
                  (team.reboundesOffenseRank ?? 0).toString(),
                  (team.assistOffenseRank ?? 0).toString(),
                  (team.stealsOffenseRank ?? 0).toString(),
                  (team.blocksOffenseRank ?? 0).toString(),
                  (team.turnOverOffenseRank ?? 0).toString(),
                  (team.foulsOffenseRank ?? 0).toString(),
                  '${team.fgOffenseRank ?? 0}',
                  '${team.threePOffenseRank ?? 0}',
                  '${team.ftOffenseRank ?? 0}',
                  (team.trueShootingOffenseRank ?? 0).toString(),
                  (team.teamPerOffenseRank ?? 0).toString(),
                ];
                element.nbaAwayDefensiveList = [
                  team.pointDefense.toString(),
                  team.reboundesDefense.toString(),
                  team.assistDefense.toString(),
                  team.stealsDefense.toString(),
                  team.blocksDefense.toString(),
                  team.turnOverDefense.toString(),
                  team.foulsDefense.toString(),
                  '${team.fgAttDefense} / ${team.fgMadeDefense} / ${team.fgDefense}%',
                  '${team.threePAttDefense} / ${team.threePMadeDefense} / ${team.threePDefense}%',
                  '${team.ftAttDefense} / ${team.ftMadeDefense} / ${team.ftDefense}%',
                  '${((team.trueShootingDefense ?? 0) * 100).toStringAsFixed(1)}%'
                      .toString(),
                  team.teamPerDefense.toString(),
                ];
                element.nbaAwayDefensiveRank = [
                  (team.pointDefenseRank ?? 0).toString(),
                  (team.reboundesDefenseRank ?? 0).toString(),
                  (team.assistDefenseRank ?? 0).toString(),
                  (team.stealsDefenseRank ?? 0).toString(),
                  (team.blocksDefenseRank ?? 0).toString(),
                  (team.turnOverDefenseRank ?? 0).toString(),
                  (team.foulsDefenseRank ?? 0).toString(),
                  '${team.fgDefenseRank ?? 0}',
                  '${team.threePDefenseRank ?? 0}',
                  '${team.ftDefenseRank ?? 0}',
                  (team.trueShootingDefenseRank ?? 0).toString(),
                  (team.teamPerDefenseRank ?? 0).toString(),
                ];
              }
              if ((replaceId(homeTeam?.uuids ?? '')) ==
                  replaceId(team.teamId ?? "")) {
                element.nbaHomeOffensiveList = [
                  team.pointOffense.toString(),
                  team.reboundesOffense.toString(),
                  team.assistOffense.toString(),
                  team.stealsOffense.toString(),
                  team.blocksOffense.toString(),
                  team.turnOverOffense.toString(),
                  team.foulsOffense.toString(),
                  '${team.fgAttOffense} / ${team.fgMadeOffense} / ${team.fgOffense}%',
                  '${team.threePAttOffense} / ${team.threePMadeOffense} / ${team.threePOffense}%',
                  '${team.ftAttOffense} / ${team.ftMadeOffense} / ${team.ftOffense}%',
                  '${((team.trueShootingOffense ?? 0) * 100).toStringAsFixed(1)}%'
                      .toString(),
                  team.teamPerOffense.toString(),
                ];
                element.nbaHomeOffensiveRank = [
                  (team.pointOffenseRank ?? 0).toString(),
                  (team.reboundesOffenseRank ?? 0).toString(),
                  (team.assistOffenseRank ?? 0).toString(),
                  (team.stealsOffenseRank ?? 0).toString(),
                  (team.blocksOffenseRank ?? 0).toString(),
                  (team.turnOverOffenseRank ?? 0).toString(),
                  (team.foulsOffenseRank ?? 0).toString(),
                  '${team.fgOffenseRank ?? 0}',
                  '${team.threePOffenseRank ?? 0}',
                  '${team.ftOffenseRank ?? 0}',
                  (team.trueShootingOffenseRank ?? 0).toString(),
                  (team.teamPerOffenseRank ?? 0).toString(),
                ];
                element.nbaHomeDefensiveList = [
                  team.pointDefense.toString(),
                  team.reboundesDefense.toString(),
                  team.assistDefense.toString(),
                  team.stealsDefense.toString(),
                  team.blocksDefense.toString(),
                  team.turnOverDefense.toString(),
                  team.foulsDefense.toString(),
                  '${team.fgAttDefense} / ${team.fgMadeDefense} / ${team.fgDefense}%',
                  '${team.threePAttDefense} / ${team.threePMadeDefense} / ${team.threePDefense}%',
                  '${team.ftAttDefense} / ${team.ftMadeDefense} / ${team.ftDefense}%',
                  '${((team.trueShootingDefense ?? 0) * 100).toStringAsFixed(1)}%'
                      .toString(),
                  team.teamPerDefense.toString(),
                ];
                element.nbaHomeDefensiveRank = [
                  (team.pointDefenseRank ?? 0).toString(),
                  (team.reboundesDefenseRank ?? 0).toString(),
                  (team.assistDefenseRank ?? 0).toString(),
                  (team.stealsDefenseRank ?? 0).toString(),
                  (team.blocksDefenseRank ?? 0).toString(),
                  (team.turnOverDefenseRank ?? 0).toString(),
                  (team.foulsDefenseRank ?? 0).toString(),
                  '${team.fgDefenseRank ?? 0}',
                  '${team.threePDefenseRank ?? 0}',
                  '${team.ftDefenseRank ?? 0}',
                  (team.trueShootingDefenseRank ?? 0).toString(),
                  (team.teamPerDefenseRank ?? 0).toString(),
                ];
              }
            });
          }
        }
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      log('ERROR NFL GAME RANK-----$e');
      showAppSnackBar(errorText);
    }
    update();
  }

  getGameListingForMLBRes(bool isLoad,
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
      isLoading.value = false;
      isPagination = isLoad;
      mlbTomorrowEventsList.clear();
      for (int i = 1; i <= 3; i++) {
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
                    homeTeamId: replaceId(
                            mlbSportEventsList[i].competitors[0].uuids ?? '') ??
                        "",
                    awayTeamId: replaceId(
                            mlbSportEventsList[i].competitors[1].uuids ?? '') ??
                        "",
                    gameId: replaceId(mlbSportEventsList[i].uuids ?? ''),
                    index: i);
              }
            }
          }
          gameListingsWithLogoResponse(DateTime.now().year.toString(), sportKey,
              isLoad: isLoad);
        });
        if (i == 3) {
          isPagination = false;
        }
      }
      if (mlbTodayEventsList.isNotEmpty) {
        timer = Timer.periodic(const Duration(seconds: 45), (t) {
          gameListingTodayApiRes(
                  key: apiKey,
                  isLoad: false,
                  sportKey: sportKey,
                  date: date,
                  sportId: sportId)
              .then((value) {
            setOdds(mlbTodayEventsList);
            for (int i = 0; i < mlbTodayEventsList.length; i++) {
              int newIndex = (mlbSportEventsList.indexWhere(
                  (element) => element.id == mlbTodayEventsList[i].id));
              if (newIndex >= 0) {
                mlbSportEventsList[newIndex].status =
                    mlbTodayEventsList[i].status;
                if (mlbTodayEventsList[i].consensus != null) {
                  ///MONEY LINES
                  if (mlbTodayEventsList[i].markets.isNotEmpty) {
                    for (var marketData in mlbTodayEventsList[i].markets) {
                      if (marketData.oddsTypeId == 4) {
                        int fanDuelIndex = marketData.books.indexWhere(
                            (element) => element.id == 'sr:book:18186');
                        for (var bookData in marketData.books) {
                          if (fanDuelIndex >= 0) {
                            if (bookData.id == 'sr:book:18186') {
                              if (bookData.outcomes?[0].type == 'home') {
                                mlbSportEventsList[newIndex].homeSpread =
                                    bookData.outcomes?[0].spread.toString() ??
                                        '00';
                              }
                              if (bookData.outcomes?[1].type == 'away') {
                                mlbSportEventsList[newIndex].awaySpread =
                                    bookData.outcomes?[1].spread.toString() ??
                                        '00';
                              }
                            }
                          } else if (bookData.id == 'sr:book:28901') {
                            if (bookData.outcomes?[0].type == 'home') {
                              mlbSportEventsList[newIndex].homeSpread =
                                  bookData.outcomes?[0].spread.toString() ?? '';
                            }
                            if (bookData.outcomes?[1].type == 'away') {
                              mlbSportEventsList[newIndex].awaySpread =
                                  bookData.outcomes?[1].spread.toString() ?? '';
                            }
                          } else if (bookData.id == 'sr:book:17324') {
                            if (bookData.outcomes?[0].type == 'home') {
                              mlbSportEventsList[newIndex].homeSpread =
                                  bookData.outcomes?[0].spread.toString() ?? '';
                            }
                            if (bookData.outcomes?[1].type == 'away') {
                              mlbSportEventsList[newIndex].awaySpread =
                                  bookData.outcomes?[1].spread.toString() ?? '';
                            }
                          }
                        }
                      }
                    }
                  }
                  if (mlbTodayEventsList[i].consensus?.lines != null) {
                    mlbTodayEventsList[i]
                        .consensus
                        ?.lines
                        ?.forEach((consensus) {
                      if (consensus.name == 'moneyline_current') {
                        consensus.outcomes?.forEach((lines) {
                          if (lines.type == 'home') {
                            mlbSportEventsList[newIndex].homeMoneyLine =
                                lines.odds.toString();
                          }
                          if (lines.type == 'away') {
                            mlbSportEventsList[newIndex].awayMoneyLine =
                                lines.odds.toString();
                          }
                        });
                      }
                      if (consensus.name == 'total_current') {
                        mlbSportEventsList[newIndex].homeOU =
                            consensus.total.toString();
                        mlbSportEventsList[newIndex].awayOU =
                            consensus.total.toString();
                      }
                    });
                  }
                }
              }
              if (DateTime.parse(mlbTodayEventsList[i].scheduled ?? "")
                          .toLocal()
                          .day ==
                      DateTime.now().day &&
                  mlbTodayEventsList[i].status != 'closed') {
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
          update();
        });
      }
    });
  }

  getGameListingForNBARes(bool isLoad,
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
      isLoading.value = false;
      isPagination = isLoad;
      nbaTomorrowEventsList.clear();
      for (int i = 1; i <= 1; i++) {
        gameListingTomorrowApiRes(
                key: apiKey,
                isLoad: isLoad,
                sportKey: sportKey,
                date: DateFormat('yyyy-MM-dd')
                    .format(DateTime.parse(date).add(Duration(days: i))),
                sportId: sportId)
            .then((value) async {
          getAllEventList(sportKey, isLoad);
          if (i == 1) {
            isPagination = false;
          }
          gameListingsWithLogoResponse(DateTime.now().year.toString(), sportKey,
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
      }
      if (nbaTodayEventsList.isNotEmpty) {
        timer = Timer.periodic(const Duration(seconds: 45), (t) {
          gameListingTodayApiRes(
                  key: apiKey,
                  isLoad: false,
                  sportKey: sportKey,
                  date: date,
                  sportId: sportId)
              .then((value) async {
            setOdds(nbaTodayEventsList);
            for (int i = 0; i < nbaTodayEventsList.length; i++) {
              int newIndex = (nbaSportEventsList.indexWhere(
                  (element) => element.id == nbaTodayEventsList[i].id));
              if (newIndex >= 0) {
                nbaSportEventsList[newIndex].status =
                    nbaTodayEventsList[i].status;
                if (nbaTodayEventsList[i].consensus != null) {
                  ///MONEY LINES
                  if (nbaTodayEventsList[i].markets.isNotEmpty) {
                    for (var marketData in nbaTodayEventsList[i].markets) {
                      if (marketData.oddsTypeId == 4) {
                        int fanDuelIndex = marketData.books.indexWhere(
                            (element) => element.id == 'sr:book:18186');
                        for (var bookData in marketData.books) {
                          if (fanDuelIndex >= 0) {
                            if (bookData.id == 'sr:book:18186') {
                              if (bookData.outcomes?[0].type == 'home') {
                                nbaSportEventsList[newIndex].homeSpread =
                                    bookData.outcomes?[0].spread.toString() ??
                                        '00';
                              }
                              if (bookData.outcomes?[1].type == 'away') {
                                nbaSportEventsList[newIndex].awaySpread =
                                    bookData.outcomes?[1].spread.toString() ??
                                        '00';
                              }
                            }
                          } else if (bookData.id == 'sr:book:28901') {
                            if (bookData.outcomes?[0].type == 'home') {
                              nbaSportEventsList[newIndex].homeSpread =
                                  bookData.outcomes?[0].spread.toString() ?? '';
                            }
                            if (bookData.outcomes?[1].type == 'away') {
                              nbaSportEventsList[newIndex].awaySpread =
                                  bookData.outcomes?[1].spread.toString() ?? '';
                            }
                          } else if (bookData.id == 'sr:book:17324') {
                            if (bookData.outcomes?[0].type == 'home') {
                              nbaSportEventsList[newIndex].homeSpread =
                                  bookData.outcomes?[0].spread.toString() ?? '';
                            }
                            if (bookData.outcomes?[1].type == 'away') {
                              nbaSportEventsList[newIndex].awaySpread =
                                  bookData.outcomes?[1].spread.toString() ?? '';
                            }
                          }
                        }
                      }
                    }
                  }
                  if (nbaTodayEventsList[i].consensus?.lines != null) {
                    nbaTodayEventsList[i]
                        .consensus
                        ?.lines
                        ?.forEach((consensus) {
                      if (consensus.name == 'moneyline_current') {
                        consensus.outcomes?.forEach((lines) {
                          if (lines.type == 'home') {
                            nbaSportEventsList[newIndex].homeMoneyLine =
                                lines.odds.toString();
                          }
                          if (lines.type == 'away') {
                            nbaSportEventsList[newIndex].awayMoneyLine =
                                lines.odds.toString();
                          }
                        });
                      }
                      if (consensus.name == 'total_current') {
                        nbaSportEventsList[newIndex].homeOU =
                            consensus.total.toString();
                        nbaSportEventsList[newIndex].awayOU =
                            consensus.total.toString();
                      }
                    });
                  }
                }
              }
              if (DateTime.parse(nbaTodayEventsList[i].scheduled ?? "")
                          .toLocal()
                          .day ==
                      DateTime.now().day &&
                  nbaTodayEventsList[i].status != 'closed') {
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
          update();
        });
      }
    });
  }

  getGameListingForNCAABRes(bool isLoad,
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
      isLoading.value = false;
      isPagination = isLoad;
      ncaabTomorrowEventsList.clear();
      for (int i = 1; i <= 2; i++) {
        getAllEventList(sportKey, isLoad);
        nbaGameRankApi(isLoad: isLoad, sportKey: sportKey);
        gameListingTomorrowApiRes(
                key: apiKey,
                isLoad: isLoad,
                sportKey: sportKey,
                date: DateFormat('yyyy-MM-dd')
                    .format(DateTime.parse(date).add(Duration(days: i))),
                sportId: sportId)
            .then((value) async {
          getAllEventList(sportKey, isLoad);
          nbaGameRankApi(isLoad: isLoad, sportKey: sportKey);
          if (i == 2) {
            isPagination = false;
          }
          gameListingsWithLogoResponseNCAAB(
              DateTime.now().year.toString(), sportKey,
              isLoad: isLoad);
          if (ncaabSportEventsList.isNotEmpty) {
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
          gameListingTodayApiRes(
                  key: apiKey,
                  isLoad: false,
                  sportKey: sportKey,
                  date: date,
                  sportId: sportId)
              .then((value) async {
            setOdds(ncaabTodayEventsList);
            for (int i = 0; i < ncaabTodayEventsList.length; i++) {
              int newIndex = (ncaabSportEventsList.indexWhere(
                  (element) => element.id == ncaabTodayEventsList[i].id));
              if (newIndex >= 0) {
                ncaabSportEventsList[newIndex].status =
                    ncaabTodayEventsList[i].status;
                if (ncaabTodayEventsList[i].consensus != null) {
                  ///MONEY LINES
                  if (ncaabTodayEventsList[i].markets.isNotEmpty) {
                    for (var marketData in ncaabTodayEventsList[i].markets) {
                      if (marketData.oddsTypeId == 4) {
                        int fanDuelIndex = marketData.books.indexWhere(
                            (element) => element.id == 'sr:book:18186');
                        for (var bookData in marketData.books) {
                          if (fanDuelIndex >= 0) {
                            if (bookData.id == 'sr:book:18186') {
                              if (bookData.outcomes?[0].type == 'home') {
                                ncaabSportEventsList[newIndex].homeSpread =
                                    bookData.outcomes?[0].spread.toString() ??
                                        '00';
                              }
                              if (bookData.outcomes?[1].type == 'away') {
                                ncaabSportEventsList[newIndex].awaySpread =
                                    bookData.outcomes?[1].spread.toString() ??
                                        '00';
                              }
                            }
                          } else if (bookData.id == 'sr:book:28901') {
                            if (bookData.outcomes?[0].type == 'home') {
                              ncaabSportEventsList[newIndex].homeSpread =
                                  bookData.outcomes?[0].spread.toString() ?? '';
                            }
                            if (bookData.outcomes?[1].type == 'away') {
                              ncaabSportEventsList[newIndex].awaySpread =
                                  bookData.outcomes?[1].spread.toString() ?? '';
                            }
                          } else if (bookData.id == 'sr:book:17324') {
                            if (bookData.outcomes?[0].type == 'home') {
                              ncaabSportEventsList[newIndex].homeSpread =
                                  bookData.outcomes?[0].spread.toString() ?? '';
                            }
                            if (bookData.outcomes?[1].type == 'away') {
                              ncaabSportEventsList[newIndex].awaySpread =
                                  bookData.outcomes?[1].spread.toString() ?? '';
                            }
                          }
                        }
                      }
                    }
                  }
                  if (ncaabTodayEventsList[i].consensus?.lines != null) {
                    ncaabTodayEventsList[i]
                        .consensus
                        ?.lines
                        ?.forEach((consensus) {
                      if (consensus.name == 'moneyline_current') {
                        consensus.outcomes?.forEach((lines) {
                          if (lines.type == 'home') {
                            ncaabSportEventsList[newIndex].homeMoneyLine =
                                lines.odds.toString();
                          }
                          if (lines.type == 'away') {
                            ncaabSportEventsList[newIndex].awayMoneyLine =
                                lines.odds.toString();
                          }
                        });
                      }
                      if (consensus.name == 'total_current') {
                        ncaabSportEventsList[newIndex].homeOU =
                            consensus.total.toString();
                        ncaabSportEventsList[newIndex].awayOU =
                            consensus.total.toString();
                      }
                    });
                  }
                }
              }
              if (DateTime.parse(ncaabTodayEventsList[i].scheduled ?? "")
                          .toLocal()
                          .day ==
                      DateTime.now().day &&
                  ncaabTodayEventsList[i].status != 'closed') {
                if (ncaabTodayEventsList[i].uuids != null) {
                  boxScoreNBAResponse(
                      sportKey: sportKey,
                      homeTeamId: replaceId(
                              ncaabTodayEventsList[i].competitors[0].uuids ??
                                  '') ??
                          "",
                      awayTeamId: replaceId(
                              ncaabTodayEventsList[i].competitors[1].uuids ??
                                  '') ??
                          "",
                      gameId: replaceId(ncaabTodayEventsList[i].uuids ?? ''),
                      index: i);
                }
              }
            }
          });
          update();
        });
      }
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
          log('error--$e');
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
          log('error--$e');
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
    ResponseItem result =
        ResponseItem(data: null, message: errorText.tr, status: false);
    result = await GameListingRepo().getWeather(cityName.split(',').first);
    try {
      if (result.status) {
        if (result.data != null) {
          (sportKey == 'MLB'
                  ? mlbSportEventsList
                  : sportKey == 'NFL'
                      ? nflSportEventsList
                      : ncaaSportEventsList)[index]
              .weather = result.data['weather'][0]['id'];
          (sportKey == 'MLB'
                  ? mlbSportEventsList
                  : sportKey == 'NFL'
                      ? nflSportEventsList
                      : ncaaSportEventsList)[index]
              .temp = result.data['main']['temp'] ?? 0;
        }
      } else {
        isLoading.value = false;
        // showAppSnackBar(
        //   result.message,
        // );
      }
    } catch (e) {
      // isLoading.value = false;
      log('ERROR WEATHER----$e');
      // showAppSnackBar(e.toString());
    }
    update();
  }
}
