import 'package:intl/intl.dart';

import '../generated/assets.dart';

class LeagueModel {
  String image;
  String key;
  String apiKey;
  String date;
  String sportId;
  bool isAvailable;

  LeagueModel(
      {required this.image,
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
      image: Assets.imagesMLB,
      date: formatted,
      key: 'MLB',
      sportId: 'sr:sport:3',
      apiKey: 'brcnsyc4vqhxys2xhm8kbswz',
      isAvailable: true),
  LeagueModel(
      image: Assets.imagesNCAA,
      date: formatted,
      // date: '2023-08-26',
      key: 'NCAA',
      sportId: 'sr:sport:16',
      apiKey: 'brcnsyc4vqhxys2xhm8kbswz',
      isAvailable: true),
  LeagueModel(
      image: Assets.imagesNFT,
      date: formatted,
      // date: '2023-09-08',
      key: 'NFL',
      apiKey: 'brcnsyc4vqhxys2xhm8kbswz',
      sportId: 'sr:sport:16',
      isAvailable: true),
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
      image: Assets.imagesNBA,
      date: '',
      key: 'NBA',
      apiKey: '',
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
