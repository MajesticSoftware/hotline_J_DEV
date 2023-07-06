class GameLogoResponse {
  The20230907 the20230907;

  GameLogoResponse({
    required this.the20230907,
  });
}

class The20230907 {
  List<Game> games;

  The20230907({
    required this.games,
  });
}

class Game {
  List<Competition> competitions;

  Game({
    required this.competitions,
  });
}

class Competition {
  List<Competitor> competitors;

  Competition({
    required this.competitors,
  });
}

class Competitor {
  String abbreviation;
  String logo;

  Competitor({
    required this.abbreviation,
    required this.logo,
  });
}
