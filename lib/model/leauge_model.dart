import 'package:intl/intl.dart';

import '../generated/assets.dart';

class LeagueModel {
  String image;
  String key;
  String date;
  bool isAvailable;

  LeagueModel(
      {required this.image,
      required this.key,
      required this.date,
      required this.isAvailable});
}

final DateTime now = DateTime.now().subtract(const Duration(days: 1));
final DateFormat formatter = DateFormat('yyyy-MM-dd');
final String formatted = formatter.format(now);

List<LeagueModel> sportsLeagueList = [
  LeagueModel(
      image: Assets.imagesNFT,
      date: '2023-09-07,2023-09-24',
      key: 'NFL',
      isAvailable: true),
  LeagueModel(
      image: Assets.imagesNCAA,
      date: '2023-08-26,2023-12-31',
      key: 'NCAA',
      isAvailable: true),
  LeagueModel(
      image: Assets.imagesMLB, date: formatted, key: 'MLB', isAvailable: true),
  LeagueModel(
      image: Assets.imagesNHL, date: '', key: 'NHL', isAvailable: false),
  LeagueModel(
      image: Assets.imagesNBA, date: '', key: 'NBA', isAvailable: false),
  LeagueModel(
      image: Assets.imagesGOLF, date: '', key: 'GOLF', isAvailable: false),
  // LeagueModel(
  //     image: Assets.imagesUFC, date: '', key: 'UFC', isAvailable: false),
  // LeagueModel(
  //     image: Assets.imagesAUTO,
  //     date: '',
  //     key: 'AUTO RACING',
  //     isAvailable: false),
];
