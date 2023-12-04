class NCAABStandingsModel {
  League? league;
  Season? season;
  List<Conferences>? conferences;

  NCAABStandingsModel({this.league, this.season, this.conferences});

  NCAABStandingsModel.fromJson(Map<String, dynamic> json) {
    league = json['league'] != null ? League.fromJson(json['league']) : null;
    season = json['season'] != null ? Season.fromJson(json['season']) : null;
    if (json['conferences'] != null) {
      conferences = <Conferences>[];
      json['conferences'].forEach((v) {
        conferences!.add(Conferences.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (league != null) {
      data['league'] = league!.toJson();
    }
    if (season != null) {
      data['season'] = season!.toJson();
    }
    if (conferences != null) {
      data['conferences'] = conferences!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class League {
  String? id;
  String? name;
  String? alias;

  League({this.id, this.name, this.alias});

  League.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    alias = json['alias'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['alias'] = alias;
    return data;
  }
}

class Season {
  String? id;
  num? year;
  String? type;

  Season({this.id, this.year, this.type});

  Season.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    year = json['year'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['year'] = year;
    data['type'] = type;
    return data;
  }
}

class Conferences {
  String? id;
  String? name;
  String? alias;
  List<Teams>? teams;

  Conferences({this.id, this.name, this.alias, this.teams});

  Conferences.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    alias = json['alias'];
    if (json['teams'] != null) {
      teams = <Teams>[];
      json['teams'].forEach((v) {
        teams!.add(Teams.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['alias'] = alias;
    if (teams != null) {
      data['teams'] = teams!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Teams {
  String? id;
  String? name;
  String? market;
  num? wins;
  num? losses;
  num? winPct;
  num? pointsFor;
  num? pointsAgainst;
  num? pointDiff;
  num? confPointsFor;
  num? confPointsAgainst;
  num? clinched;
  bool? postSeasonIneligible;
  num? strengthOfScheduleRank;
  num? conferenceRank;
  num? subdivisionRank;
  GamesBehind? gamesBehind;
  Streak? streak;
  List<Records>? records;
  String? subdivision;

  Teams(
      {this.id,
      this.name,
      this.market,
      this.wins,
      this.losses,
      this.winPct,
      this.pointsFor,
      this.pointsAgainst,
      this.pointDiff,
      this.confPointsFor,
      this.confPointsAgainst,
      this.clinched,
      this.postSeasonIneligible,
      this.strengthOfScheduleRank,
      this.conferenceRank,
      this.subdivisionRank,
      this.gamesBehind,
      this.streak,
      this.records,
      this.subdivision});

  Teams.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    market = json['market'];
    wins = json['wins'];
    losses = json['losses'];
    winPct = json['win_pct'];
    pointsFor = json['points_for'];
    pointsAgainst = json['points_against'];
    pointDiff = json['point_diff'];
    confPointsFor = json['conf_points_for'];
    confPointsAgainst = json['conf_points_against'];
    clinched = json['clinched'];
    postSeasonIneligible = json['post_season_ineligible'];
    strengthOfScheduleRank = json['strength_of_schedule_rank'];
    conferenceRank = json['conference_rank'];
    subdivisionRank = json['subdivision_rank'];
    gamesBehind = json['games_behind'] != null
        ? GamesBehind.fromJson(json['games_behind'])
        : null;
    streak = json['streak'] != null ? Streak.fromJson(json['streak']) : null;
    if (json['records'] != null) {
      records = <Records>[];
      json['records'].forEach((v) {
        records!.add(Records.fromJson(v));
      });
    }
    subdivision = json['subdivision'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['market'] = market;
    data['wins'] = wins;
    data['losses'] = losses;
    data['win_pct'] = winPct;
    data['points_for'] = pointsFor;
    data['points_against'] = pointsAgainst;
    data['point_diff'] = pointDiff;
    data['conf_points_for'] = confPointsFor;
    data['conf_points_against'] = confPointsAgainst;
    data['clinched'] = clinched;
    data['post_season_ineligible'] = postSeasonIneligible;
    data['strength_of_schedule_rank'] = strengthOfScheduleRank;
    data['conference_rank'] = conferenceRank;
    data['subdivision_rank'] = subdivisionRank;
    if (gamesBehind != null) {
      data['games_behind'] = gamesBehind!.toJson();
    }
    if (streak != null) {
      data['streak'] = streak!.toJson();
    }
    if (records != null) {
      data['records'] = records!.map((v) => v.toJson()).toList();
    }
    data['subdivision'] = subdivision;
    return data;
  }
}

class GamesBehind {
  num? conference;

  GamesBehind({this.conference});

  GamesBehind.fromJson(Map<String, dynamic> json) {
    conference = json['conference'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['conference'] = conference;
    return data;
  }
}

class Streak {
  String? kind;
  num? length;

  Streak({this.kind, this.length});

  Streak.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    length = json['length'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kind'] = kind;
    data['length'] = length;
    return data;
  }
}

class Records {
  String? recordType;
  num? wins;
  num? losses;
  num? winPct;

  Records({this.recordType, this.wins, this.losses, this.winPct});

  Records.fromJson(Map<String, dynamic> json) {
    recordType = json['record_type'];
    wins = json['wins'];
    losses = json['losses'];
    winPct = json['win_pct'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['record_type'] = recordType;
    data['wins'] = wins;
    data['losses'] = losses;
    data['win_pct'] = winPct;
    return data;
  }
}
