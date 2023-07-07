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
  List<Odds>? odds;
  Game({
    required this.competitions,
  });
}

class Odds {
  double? overUnder;
  Provider? provider;
  String? details;
  AwayTeamOdds? awayTeamOdds;
  AwayTeamOdds? homeTeamOdds;

  Odds(
      {this.overUnder,
      this.provider,
      this.details,
      this.awayTeamOdds,
      this.homeTeamOdds});

  Odds.fromJson(Map<String, dynamic> json) {
    overUnder = json['overUnder'];
    provider =
        json['provider'] != null ? Provider.fromJson(json['provider']) : null;
    details = json['details'];
    awayTeamOdds = json['awayTeamOdds'] != null
        ? AwayTeamOdds.fromJson(json['awayTeamOdds'])
        : null;
    homeTeamOdds = json['homeTeamOdds'] != null
        ? AwayTeamOdds.fromJson(json['homeTeamOdds'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['overUnder'] = overUnder;
    if (provider != null) {
      data['provider'] = provider!.toJson();
    }
    data['details'] = details;
    if (awayTeamOdds != null) {
      data['awayTeamOdds'] = awayTeamOdds!.toJson();
    }
    if (homeTeamOdds != null) {
      data['homeTeamOdds'] = homeTeamOdds!.toJson();
    }
    return data;
  }
}

class Provider {
  String? name;
  String? id;
  int? priority;

  Provider({this.name, this.id, this.priority});

  Provider.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    priority = json['priority'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['priority'] = priority;
    return data;
  }
}

class AwayTeamOdds {
  int? spreadOdds;
  bool? underdog;
  SpreadRecord? spreadRecord;
  Team? team;
  bool? favorite;
  int? moneyLine;
  double? averageScore;

  AwayTeamOdds(
      {this.spreadOdds,
      this.underdog,
      this.spreadRecord,
      this.team,
      this.favorite,
      this.moneyLine,
      this.averageScore});

  AwayTeamOdds.fromJson(Map<String, dynamic> json) {
    spreadOdds = json['spreadOdds'];
    underdog = json['underdog'];
    spreadRecord = json['spreadRecord'] != null
        ? SpreadRecord.fromJson(json['spreadRecord'])
        : null;
    team = json['team'] != null ? Team.fromJson(json['team']) : null;
    favorite = json['favorite'];
    moneyLine = json['moneyLine'];
    averageScore = json['averageScore'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['spreadOdds'] = spreadOdds;
    data['underdog'] = underdog;
    if (spreadRecord != null) {
      data['spreadRecord'] = spreadRecord!.toJson();
    }
    if (team != null) {
      data['team'] = team!.toJson();
    }
    data['favorite'] = favorite;
    data['moneyLine'] = moneyLine;
    data['averageScore'] = averageScore;
    return data;
  }
}

class SpreadRecord {
  int? wins;
  String? summary;
  int? losses;
  int? pushes;

  SpreadRecord({this.wins, this.summary, this.losses, this.pushes});

  SpreadRecord.fromJson(Map<String, dynamic> json) {
    wins = json['wins'];
    summary = json['summary'];
    losses = json['losses'];
    pushes = json['pushes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wins'] = wins;
    data['summary'] = summary;
    data['losses'] = losses;
    data['pushes'] = pushes;
    return data;
  }
}

class Team {
  String? uid;
  String? displayName;
  String? logo;
  String? id;
  String? abbreviation;

  Team({this.uid, this.displayName, this.logo, this.id, this.abbreviation});

  Team.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    displayName = json['displayName'];
    logo = json['logo'];
    id = json['id'];
    abbreviation = json['abbreviation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['displayName'] = displayName;
    data['logo'] = logo;
    data['id'] = id;
    data['abbreviation'] = abbreviation;
    return data;
  }
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
