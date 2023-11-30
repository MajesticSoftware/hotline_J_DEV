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

final DateTime now = DateTime.now().toUtc();
final DateFormat formatter = DateFormat('yyyy-MM-dd');
final String formatted = formatter.format(now);

List<LeagueModel> sportsLeagueList = [
  LeagueModel(
      gameImage: Assets.imagesNfl,
      gameName: 'NFL',
      date: formatted,
      key: 'NFL',
      apiKey: 'brcnsyc4vqhxys2xhm8kbswz',
      sportId: 'sr:sport:16',
      isAvailable: true),
  LeagueModel(
      gameImage: Assets.imagesNcaa,
      date: formatted,
      key: 'NCAA',
      gameName: 'NCAAF',
      sportId: 'sr:sport:16',
      apiKey: 'brcnsyc4vqhxys2xhm8kbswz',
      isAvailable: true),
  LeagueModel(
      gameImage: Assets.imagesMlb,
      gameName: 'MLB',
      date: formatted,
      key: 'MLB',
      sportId: 'sr:sport:3',
      apiKey: 'brcnsyc4vqhxys2xhm8kbswz',
      isAvailable: true),
  LeagueModel(
      sportId: 'sr:sport:2',
      gameName: 'NBA',
      date: formatted,
      key: 'NBA',
      apiKey: 'brcnsyc4vqhxys2xhm8kbswz',
      isAvailable: true,
      gameImage: Assets.imagesNcaab),
  LeagueModel(
      sportId: 'sr:sport:2',
      gameName: 'NCAAB',
      date: formatted,
      key: 'NCAAB',
      apiKey: 'brcnsyc4vqhxys2xhm8kbswz',
      isAvailable: true,
      gameImage: Assets.imagesNcaab),
/*
  LeagueModel(
      sportId: 'sr:sport:2',
      image: Assets.imagesNHL,
      date: formatted,
      key: 'NHL',
      apiKey: 'brcnsyc4vqhxys2xhm8kbswz',
      isAvailable: false),

  LeagueModel(
      sportId: '',
      image: Assets.imagesGOLF,
      date: '',
      key: 'GOLF',
      apiKey: '',
      isAvailable: false),*/
  // LeagueModel(
  //     image: Assets.imagesUFC, date: '', key: 'UFC', isAvailable: false),
  // LeagueModel(
  //     image: Assets.imagesAUTO,
  //     date: '',
  //     key: 'AUTO RACING',
  //     isAvailable: false),
];
