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

final DateTime now = DateTime.now();
final DateFormat formatter = DateFormat('yyyy-MM-dd');
final String formatted = formatter.format(now);

List<LeagueModel> sportsLeagueList = [
  LeagueModel(
      image: Assets.imagesNFT,
      date: '2023-09-08',
      key: 'NFL',
      apiKey: '3xtbdf9h3669rn4rf6x87c4a',
      sportId: 'sr:sport:16',
      isAvailable: true),
  LeagueModel(
      image: Assets.imagesNCAA,
      //date: '2023',
      date: '2023-08-26',
      key: 'NCAA',
      sportId: 'sr:sport:2',
      apiKey: '3xtbdf9h3669rn4rf6x87c4a',
      isAvailable: true),
  LeagueModel(
      image: Assets.imagesMLB,
      date: formatted,
      key: 'MLB',
      sportId: 'sr:sport:3',
      apiKey: '3xtbdf9h3669rn4rf6x87c4a',
      isAvailable: true),
  LeagueModel(
      sportId: '',
      image: Assets.imagesNHL,
      date: '',
      key: 'NHL',
      apiKey: '',
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
      isAvailable: false),
  // LeagueModel(
  //     image: Assets.imagesUFC, date: '', key: 'UFC', isAvailable: false),
  // LeagueModel(
  //     image: Assets.imagesAUTO,
  //     date: '',
  //     key: 'AUTO RACING',
  //     isAvailable: false),
];
