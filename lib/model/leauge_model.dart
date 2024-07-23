import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';

import '../generated/assets.dart';

class LeagueModel {
  // String image;
  String gameImage;
  String gameName;
  String key;
  String apiKey;
  String date;
  String sportId;
  bool isAvailable;

  LeagueModel(
      {
      // required this.image,
      required this.gameImage,
      required this.gameName,
      required this.key,
      required this.date,
      required this.apiKey,
      required this.sportId,
      required this.isAvailable});
}

final DateTime now = DateTime.now().subtract(const Duration(days: 1)).toUtc();
final DateFormat formatter = DateFormat('yyyy-MM-dd');
final String formatted = formatter.format(now);

List<LeagueModel> sportsLeagueList = [

 /* LeagueModel(
      sportId: 'sr:sport:2',
      gameName: 'NCAAB',
      date: formatted,
      key: 'NCAAB',
      apiKey: dotenv.env['GAME_LISTING_APIKEY']??"",
      isAvailable: true,
      gameImage: Assets.imagesNcaab),
  LeagueModel(
      sportId: 'sr:sport:2',
      gameName: 'NBA',
      date: formatted,
      key: 'NBA',
      apiKey: dotenv.env['GAME_LISTING_APIKEY']??"",
      isAvailable: true,
      gameImage: Assets.imagesNcaab),
  LeagueModel(
      gameImage: Assets.imagesMlb,
      gameName: 'MLB',
      date: formatted,
      key: 'MLB',
      sportId: 'sr:sport:3',
      apiKey: dotenv.env['GAME_LISTING_APIKEY']??"",
      isAvailable: true),*/
  LeagueModel(
      gameImage: Assets.imagesNfl,
      gameName: 'NFL',
      date: '2024-09-06',
      key: 'NFL',
      apiKey: dotenv.env['GAME_LISTING_APIKEY']??"",
      sportId: 'sr:sport:16',
      isAvailable: true),
  /*LeagueModel(
      gameImage: Assets.imagesNcaa,
      date: formatted,
      key: 'NCAA',
      gameName: 'NCAAF',
      sportId: 'sr:sport:16',
      apiKey: dotenv.env['GAME_LISTING_APIKEY']??"",
      isAvailable: true),*/

];
