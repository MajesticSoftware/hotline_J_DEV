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
  LeagueModel(image: Assets.imagesMLB, date: '', key: 'MLB', isAvailable: true),
  LeagueModel(
      image: Assets.imagesNHL, date: '', key: 'NHL', isAvailable: false),
  LeagueModel(
      image: Assets.imagesNBA, date: '', key: 'NBA', isAvailable: false),
  LeagueModel(
      image: Assets.imagesSOCCER, date: '', key: 'SOCCER', isAvailable: false),
  LeagueModel(
      image: Assets.imagesUFC, date: '', key: 'UFC', isAvailable: false),
  LeagueModel(
      image: Assets.imagesAUTO,
      date: '',
      key: 'AUTO RACING',
      isAvailable: false),
];
