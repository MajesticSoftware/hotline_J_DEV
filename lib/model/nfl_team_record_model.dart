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
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.season != null) {
      data['season'] = this.season!.toJson();
    }
    if (this.conferences != null) {
      data['conferences'] = this.conferences!.map((v) => v.toJson()).toList();
    }
    data['_comment'] = this.sComment;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['year'] = this.year;
    data['type'] = this.type;
    data['name'] = this.name;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['alias'] = this.alias;
    if (this.divisions != null) {
      data['divisions'] = this.divisions!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['alias'] = this.alias;
    if (this.teams != null) {
      data['teams'] = this.teams!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['market'] = this.market;
    data['alias'] = this.alias;
    data['sr_id'] = this.srId;
    if (this.rank != null) {
      data['rank'] = this.rank!.toJson();
    }
    if (this.streak != null) {
      data['streak'] = this.streak!.toJson();
    }
    if (this.strengthOfSchedule != null) {
      data['strength_of_schedule'] = this.strengthOfSchedule!.toJson();
    }
    if (this.strengthOfVictory != null) {
      data['strength_of_victory'] = this.strengthOfVictory!.toJson();
    }
    data['wins'] = this.wins;
    data['losses'] = this.losses;
    data['ties'] = this.ties;
    data['win_pct'] = this.winPct;
    data['points_for'] = this.pointsFor;
    data['points_against'] = this.pointsAgainst;
    if (this.records != null) {
      data['records'] = this.records!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['conference'] = this.conference;
    data['division'] = this.division;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['type'] = this.type;
    data['length'] = this.length;
    data['desc'] = this.desc;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['sos'] = this.sos;
    data['wins'] = this.wins;
    data['total'] = this.total;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['sov'] = this.sov;
    data['wins'] = this.wins;
    data['total'] = this.total;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['category'] = this.category;
    data['wins'] = this.wins;
    data['losses'] = this.losses;
    data['ties'] = this.ties;
    data['win_pct'] = this.winPct;
    data['points_for'] = this.pointsFor;
    data['points_against'] = this.pointsAgainst;
    return data;
  }
}
