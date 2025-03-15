import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';

import '../generated/assets.dart';
import '../utils/app_helper.dart';

class LeagueModel {
  String gameImage;
  String gameName;
  String key;
  String apiKey;
  String date;
  String sportId;
  bool isAvailable;

  LeagueModel(
      {required this.gameImage,
      required this.gameName,
      required this.key,
      required this.date,
      required this.apiKey,
      required this.sportId,
      required this.isAvailable});
}

final DateTime now = DateTime.now();
final DateFormat formatter = DateFormat('yyyy-MM-dd');
final String formatted = formatter.format(now);

List<LeagueModel> sportsLeagueList = [
  /*LeagueModel(
      gameImage: Assets.imagesNfl,
      gameName: SportName.NFL.name,
      date: staticDateNFL,
      key: SportName.NFL.name,
      apiKey: dotenv.env['ODDS_COMPARISON_REGULAR_API'] ?? "",
      sportId: nflSportId,
      isAvailable: true),*/
  LeagueModel(
        sportId: ncaabSportId,
      gameName: SportName.NCAAB.name,
      date: formatted,
      key: SportName.NCAAB.name,
      apiKey: dotenv.env['ODDS_COMPARISON_REGULAR_API'] ?? "",
      isAvailable: true,
      gameImage: Assets.imagesNcaab),
  /* LeagueModel(
      sportId: nbaSportId,
      gameName: SportName.NBA.name,
      date: formatted,
      key: SportName.NBA.name,
      apiKey: dotenv.env['ODDS_COMPARISON_REGULAR_API']??"",
      isAvailable: true,
      gameImage: Assets.imagesNcaab),
  LeagueModel(
      gameImage: Assets.imagesMlb,
      gameName: SportName.MLB.name,
      date: formatted,
      key: SportName.MLB.name,
      sportId: mlbSportId,
      apiKey: dotenv.env['ODDS_COMPARISON_REGULAR_API']??"",
      isAvailable: true),*/
  /*LeagueModel(
      gameImage: Assets.imagesNcaa,
      date: formatted,
      key: SportName.NCAA.name,
      gameName: SportName.NCAAF.name,
      sportId: ncaafSportId,
      apiKey: dotenv.env['ODDS_COMPARISON_REGULAR_API']??"",
      isAvailable: true),*/
];
