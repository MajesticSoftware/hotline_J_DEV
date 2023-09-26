class NFLTeamRecordModel {
  Season? season;
  List<Conferences>? conferences;
  String? sComment;

  NFLTeamRecordModel({this.season, this.conferences, this.sComment});

  NFLTeamRecordModel.fromJson(Map<String, dynamic> json) {
    season = json['season'] != null ? Season.fromJson(json['season']) : null;
    if (json['conferences'] != null) {
      conferences = <Conferences>[];
      json['conferences'].forEach((v) {
        conferences!.add(Conferences.fromJson(v));
      });
    }
    sComment = json['_comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (season != null) {
      data['season'] = season!.toJson();
    }
    if (conferences != null) {
      data['conferences'] = conferences!.map((v) => v.toJson()).toList();
    }
    data['_comment'] = sComment;
    return data;
  }
}

class Season {
  String? id;
  num? year;
  String? type;
  String? name;

  Season({this.id, this.year, this.type, this.name});

  Season.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    year = json['year'];
    type = json['type'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['year'] = year;
    data['type'] = type;
    data['name'] = name;
    return data;
  }
}

class Conferences {
  String? id;
  String? name;
  String? alias;
  List<Divisions>? divisions;

  Conferences({this.id, this.name, this.alias, this.divisions});

  Conferences.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    alias = json['alias'];
    if (json['divisions'] != null) {
      divisions = <Divisions>[];
      json['divisions'].forEach((v) {
        divisions!.add(Divisions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['alias'] = alias;
    if (divisions != null) {
      data['divisions'] = divisions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Divisions {
  String? id;
  String? name;
  String? alias;
  List<Teams>? teams;

  Divisions({this.id, this.name, this.alias, this.teams});

  Divisions.fromJson(Map<String, dynamic> json) {
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
  String? alias;
  String? srId;
  Rank? rank;
  Streak? streak;
  StrengthOfSchedule? strengthOfSchedule;
  StrengthOfVictory? strengthOfVictory;
  num? wins;
  num? losses;
  num? ties;
  num? winPct;
  num? pointsFor;
  num? pointsAgainst;
  List<Records>? records;

  Teams(
      {this.id,
      this.name,
      this.market,
      this.alias,
      this.srId,
      this.rank,
      this.streak,
      this.strengthOfSchedule,
      this.strengthOfVictory,
      this.wins,
      this.losses,
      this.ties,
      this.winPct,
      this.pointsFor,
      this.pointsAgainst,
      this.records});

  Teams.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    market = json['market'];
    alias = json['alias'];
    srId = json['sr_id'];
    rank = json['rank'] != null ? Rank.fromJson(json['rank']) : null;
    streak = json['streak'] != null ? Streak.fromJson(json['streak']) : null;
    strengthOfSchedule = json['strength_of_schedule'] != null
        ? StrengthOfSchedule.fromJson(json['strength_of_schedule'])
        : null;
    strengthOfVictory = json['strength_of_victory'] != null
        ? StrengthOfVictory.fromJson(json['strength_of_victory'])
        : null;
    wins = json['wins'];
    losses = json['losses'];
    ties = json['ties'];
    winPct = json['win_pct'];
    pointsFor = json['points_for'];
    pointsAgainst = json['points_against'];
    if (json['records'] != null) {
      records = <Records>[];
      json['records'].forEach((v) {
        records!.add(Records.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['market'] = market;
    data['alias'] = alias;
    data['sr_id'] = srId;
    if (rank != null) {
      data['rank'] = rank!.toJson();
    }
    if (streak != null) {
      data['streak'] = streak!.toJson();
    }
    if (strengthOfSchedule != null) {
      data['strength_of_schedule'] = strengthOfSchedule!.toJson();
    }
    if (strengthOfVictory != null) {
      data['strength_of_victory'] = strengthOfVictory!.toJson();
    }
    data['wins'] = wins;
    data['losses'] = losses;
    data['ties'] = ties;
    data['win_pct'] = winPct;
    data['points_for'] = pointsFor;
    data['points_against'] = pointsAgainst;
    if (records != null) {
      data['records'] = records!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rank {
  num? conference;
  num? division;

  Rank({this.conference, this.division});

  Rank.fromJson(Map<String, dynamic> json) {
    conference = json['conference'];
    division = json['division'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['conference'] = conference;
    data['division'] = division;
    return data;
  }
}

class Streak {
  String? type;
  num? length;
  String? desc;

  Streak({this.type, this.length, this.desc});

  Streak.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    length = json['length'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['length'] = length;
    data['desc'] = desc;
    return data;
  }
}

class StrengthOfSchedule {
  num? sos;
  num? wins;
  num? total;

  StrengthOfSchedule({this.sos, this.wins, this.total});

  StrengthOfSchedule.fromJson(Map<String, dynamic> json) {
    sos = json['sos'];
    wins = json['wins'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sos'] = sos;
    data['wins'] = wins;
    data['total'] = total;
    return data;
  }
}

class StrengthOfVictory {
  num? sov;
  num? wins;
  num? total;

  StrengthOfVictory({this.sov, this.wins, this.total});

  StrengthOfVictory.fromJson(Map<String, dynamic> json) {
    sov = json['sov'];
    wins = json['wins'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sov'] = sov;
    data['wins'] = wins;
    data['total'] = total;
    return data;
  }
}

class Records {
  String? category;
  num? wins;
  num? losses;
  num? ties;
  num? winPct;
  num? pointsFor;
  num? pointsAgainst;

  Records(
      {this.category,
      this.wins,
      this.losses,
      this.ties,
      this.winPct,
      this.pointsFor,
      this.pointsAgainst});

  Records.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    wins = json['wins'];
    losses = json['losses'];
    ties = json['ties'];
    winPct = json['win_pct'];
    pointsFor = json['points_for'];
    pointsAgainst = json['points_against'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category'] = category;
    data['wins'] = wins;
    data['losses'] = losses;
    data['ties'] = ties;
    data['win_pct'] = winPct;
    data['points_for'] = pointsFor;
    data['points_against'] = pointsAgainst;
    return data;
  }
}
