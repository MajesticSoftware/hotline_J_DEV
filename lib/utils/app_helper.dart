enum SportName {
  NCAAB,
  NFL,
  NBA,
  MLB,
  NCAAF,
  NCAA
}


String ncaabSportId="sr:sport:2";
String nflSportId="sr:sport:16";
String nbaSportId="sr:sport:2";
String mlbSportId="sr:sport:3";
String ncaafSportId="sr:sport:16";


enum GameStatus{
  live,inprogress,halftime,closed,Final,postponed
}


List<String> ncaabGameSeasonId=['sr:season:117465'];
List<String> ncaabGameSeasonUid=['b2e4c0e0-5571-47c3-ab8b-1db65d74234e'];
List<String> ncaabGameTournamentId=['sr:tournament:28370'];
// List<String> nflGameSeasonId=['sr:season:117435'];
// List<String> nbaGameSeasonId=['sr:season:117435'];
List<String> mlbGameSeasonId=['sr:season:100127','sr:season:114297','sr:season:109651'];
// List<String> ncaafGameSeasonId=['sr:season:117435'];