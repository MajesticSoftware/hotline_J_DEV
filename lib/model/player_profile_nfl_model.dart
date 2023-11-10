class NFLProfileModel {
  String? id;
  String? name;
  String? jersey;
  String? lastName;
  String? firstName;
  String? abbrName;
  String? birthDate;
  num? weight;
  num? height;
  String? position;
  String? birthPlace;
  String? highSchool;
  String? college;
  String? collegeConf;
  num? rookieYear;
  String? status;
  String? srId;
  num? experience;
  Team? team;
  Draft? draft;
  List<Seasons>? seasons;
  String? sComment;

  NFLProfileModel(
      {this.id,
      this.name,
      this.jersey,
      this.lastName,
      this.firstName,
      this.abbrName,
      this.birthDate,
      this.weight,
      this.height,
      this.position,
      this.birthPlace,
      this.highSchool,
      this.college,
      this.collegeConf,
      this.rookieYear,
      this.status,
      this.srId,
      this.experience,
      this.team,
      this.draft,
      this.seasons,
      this.sComment});

  NFLProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    jersey = json['jersey'];
    lastName = json['last_name'];
    firstName = json['first_name'];
    abbrName = json['abbr_name'];
    birthDate = json['birth_date'];
    weight = json['weight'];
    height = json['height'];
    position = json['position'];
    birthPlace = json['birth_place'];
    highSchool = json['high_school'];
    college = json['college'];
    collegeConf = json['college_conf'];
    rookieYear = json['rookie_year'];
    status = json['status'];
    srId = json['sr_id'];
    experience = json['experience'];
    team = json['team'] != null ? new Team.fromJson(json['team']) : null;
    draft = json['draft'] != null ? new Draft.fromJson(json['draft']) : null;
    if (json['seasons'] != null) {
      seasons = <Seasons>[];
      json['seasons'].forEach((v) {
        seasons!.add(new Seasons.fromJson(v));
      });
    }
    sComment = json['_comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['jersey'] = this.jersey;
    data['last_name'] = this.lastName;
    data['first_name'] = this.firstName;
    data['abbr_name'] = this.abbrName;
    data['birth_date'] = this.birthDate;
    data['weight'] = this.weight;
    data['height'] = this.height;
    data['position'] = this.position;
    data['birth_place'] = this.birthPlace;
    data['high_school'] = this.highSchool;
    data['college'] = this.college;
    data['college_conf'] = this.collegeConf;
    data['rookie_year'] = this.rookieYear;
    data['status'] = this.status;
    data['sr_id'] = this.srId;
    data['experience'] = this.experience;
    if (this.team != null) {
      data['team'] = this.team!.toJson();
    }
    if (this.draft != null) {
      data['draft'] = this.draft!.toJson();
    }
    if (this.seasons != null) {
      data['seasons'] = this.seasons!.map((v) => v.toJson()).toList();
    }
    data['_comment'] = this.sComment;
    return data;
  }
}

class Team {
  String? id;
  String? name;
  String? market;
  String? alias;
  String? srId;

  Team({this.id, this.name, this.market, this.alias, this.srId});

  Team.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    market = json['market'];
    alias = json['alias'];
    srId = json['sr_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['market'] = this.market;
    data['alias'] = this.alias;
    data['sr_id'] = this.srId;
    return data;
  }
}

class Draft {
  num? year;
  num? round;
  num? number;
  Team? team;

  Draft({this.year, this.round, this.number, this.team});

  Draft.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    round = json['round'];
    number = json['number'];
    team = json['team'] != null ? new Team.fromJson(json['team']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['year'] = this.year;
    data['round'] = this.round;
    data['number'] = this.number;
    if (this.team != null) {
      data['team'] = this.team!.toJson();
    }
    return data;
  }
}

class Seasons {
  String? id;
  num? year;
  String? type;
  String? name;
  List<Teams>? teams;

  Seasons({this.id, this.year, this.type, this.name, this.teams});

  Seasons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    year = json['year'];
    type = json['type'];
    name = json['name'];
    if (json['teams'] != null) {
      teams = <Teams>[];
      json['teams'].forEach((v) {
        teams!.add(new Teams.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['year'] = this.year;
    data['type'] = this.type;
    data['name'] = this.name;
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
  Statistics? statistics;

  Teams(
      {this.id,
      this.name,
      this.market,
      this.alias,
      this.srId,
      this.statistics});

  Teams.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    market = json['market'];
    alias = json['alias'];
    srId = json['sr_id'];
    statistics = json['statistics'] != null
        ? new Statistics.fromJson(json['statistics'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['market'] = this.market;
    data['alias'] = this.alias;
    data['sr_id'] = this.srId;
    if (this.statistics != null) {
      data['statistics'] = this.statistics!.toJson();
    }
    return data;
  }
}

class Statistics {
  num? gamesPlayed;
  num? gamesStarted;
  Rushing? rushing;
  Penalties? penalties;
  Passing? passing;
  Fumbles? fumbles;
  Conversions? conversions;

  Statistics(
      {this.gamesPlayed,
      this.gamesStarted,
      this.rushing,
      this.penalties,
      this.passing,
      this.fumbles,
      this.conversions});

  Statistics.fromJson(Map<String, dynamic> json) {
    gamesPlayed = json['games_played'];
    gamesStarted = json['games_started'];
    rushing =
        json['rushing'] != null ? new Rushing.fromJson(json['rushing']) : null;
    penalties = json['penalties'] != null
        ? new Penalties.fromJson(json['penalties'])
        : null;
    passing =
        json['passing'] != null ? new Passing.fromJson(json['passing']) : null;
    fumbles =
        json['fumbles'] != null ? new Fumbles.fromJson(json['fumbles']) : null;
    conversions = json['conversions'] != null
        ? new Conversions.fromJson(json['conversions'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['games_played'] = this.gamesPlayed;
    data['games_started'] = this.gamesStarted;
    if (this.rushing != null) {
      data['rushing'] = this.rushing!.toJson();
    }
    if (this.penalties != null) {
      data['penalties'] = this.penalties!.toJson();
    }
    if (this.passing != null) {
      data['passing'] = this.passing!.toJson();
    }
    if (this.fumbles != null) {
      data['fumbles'] = this.fumbles!.toJson();
    }
    if (this.conversions != null) {
      data['conversions'] = this.conversions!.toJson();
    }
    return data;
  }
}

class Rushing {
  num? avgYards;
  num? attempts;
  num? touchdowns;
  num? yards;
  num? longest;
  num? longestTouchdown;
  num? redzoneAttempts;
  num? tlost;
  num? tlostYards;
  num? firstDowns;
  num? brokenTackles;
  num? kneelDowns;
  num? scrambles;
  num? yardsAfterContact;

  Rushing(
      {this.avgYards,
      this.attempts,
      this.touchdowns,
      this.yards,
      this.longest,
      this.longestTouchdown,
      this.redzoneAttempts,
      this.tlost,
      this.tlostYards,
      this.firstDowns,
      this.brokenTackles,
      this.kneelDowns,
      this.scrambles,
      this.yardsAfterContact});

  Rushing.fromJson(Map<String, dynamic> json) {
    avgYards = json['avg_yards'];
    attempts = json['attempts'];
    touchdowns = json['touchdowns'];
    yards = json['yards'];
    longest = json['longest'];
    longestTouchdown = json['longest_touchdown'];
    redzoneAttempts = json['redzone_attempts'];
    tlost = json['tlost'];
    tlostYards = json['tlost_yards'];
    firstDowns = json['first_downs'];
    brokenTackles = json['broken_tackles'];
    kneelDowns = json['kneel_downs'];
    scrambles = json['scrambles'];
    yardsAfterContact = json['yards_after_contact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avg_yards'] = this.avgYards;
    data['attempts'] = this.attempts;
    data['touchdowns'] = this.touchdowns;
    data['yards'] = this.yards;
    data['longest'] = this.longest;
    data['longest_touchdown'] = this.longestTouchdown;
    data['redzone_attempts'] = this.redzoneAttempts;
    data['tlost'] = this.tlost;
    data['tlost_yards'] = this.tlostYards;
    data['first_downs'] = this.firstDowns;
    data['broken_tackles'] = this.brokenTackles;
    data['kneel_downs'] = this.kneelDowns;
    data['scrambles'] = this.scrambles;
    data['yards_after_contact'] = this.yardsAfterContact;
    return data;
  }
}

class Penalties {
  num? penalties;
  num? yards;
  num? firstDowns;

  Penalties({this.penalties, this.yards, this.firstDowns});

  Penalties.fromJson(Map<String, dynamic> json) {
    penalties = json['penalties'];
    yards = json['yards'];
    firstDowns = json['first_downs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['penalties'] = this.penalties;
    data['yards'] = this.yards;
    data['first_downs'] = this.firstDowns;
    return data;
  }
}

class Passing {
  num? attempts;
  num? completions;
  num? cmpPct;
  num? yards;
  num? avgYards;
  num? sacks;
  num? sackYards;
  num? touchdowns;
  num? longest;
  num? interceptions;
  num? rating;
  num? longestTouchdown;
  num? airYards;
  num? redzoneAttempts;
  num? grossYards;
  num? firstDowns;
  num? intTouchdowns;
  num? throwAways;
  num? poorThrows;
  num? defendedPasses;
  num? droppedPasses;
  num? spikes;
  num? blitzes;
  num? hurries;
  num? knockdowns;
  num? pocketTime;
  num? avgPocketTime;
  num? netYards;
  num? battedPasses;
  num? onTargetThrows;

  Passing(
      {this.attempts,
      this.completions,
      this.cmpPct,
      this.yards,
      this.avgYards,
      this.sacks,
      this.sackYards,
      this.touchdowns,
      this.longest,
      this.interceptions,
      this.rating,
      this.longestTouchdown,
      this.airYards,
      this.redzoneAttempts,
      this.grossYards,
      this.firstDowns,
      this.intTouchdowns,
      this.throwAways,
      this.poorThrows,
      this.defendedPasses,
      this.droppedPasses,
      this.spikes,
      this.blitzes,
      this.hurries,
      this.knockdowns,
      this.pocketTime,
      this.avgPocketTime,
      this.netYards,
      this.battedPasses,
      this.onTargetThrows});

  Passing.fromJson(Map<String, dynamic> json) {
    attempts = json['attempts'];
    completions = json['completions'];
    cmpPct = json['cmp_pct'];
    yards = json['yards'];
    avgYards = json['avg_yards'];
    sacks = json['sacks'];
    sackYards = json['sack_yards'];
    touchdowns = json['touchdowns'];
    longest = json['longest'];
    interceptions = json['interceptions'];
    rating = json['rating'];
    longestTouchdown = json['longest_touchdown'];
    airYards = json['air_yards'];
    redzoneAttempts = json['redzone_attempts'];
    grossYards = json['gross_yards'];
    firstDowns = json['first_downs'];
    intTouchdowns = json['int_touchdowns'];
    throwAways = json['throw_aways'];
    poorThrows = json['poor_throws'];
    defendedPasses = json['defended_passes'];
    droppedPasses = json['dropped_passes'];
    spikes = json['spikes'];
    blitzes = json['blitzes'];
    hurries = json['hurries'];
    knockdowns = json['knockdowns'];
    pocketTime = json['pocket_time'];
    avgPocketTime = json['avg_pocket_time'];
    netYards = json['net_yards'];
    battedPasses = json['batted_passes'];
    onTargetThrows = json['on_target_throws'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attempts'] = this.attempts;
    data['completions'] = this.completions;
    data['cmp_pct'] = this.cmpPct;
    data['yards'] = this.yards;
    data['avg_yards'] = this.avgYards;
    data['sacks'] = this.sacks;
    data['sack_yards'] = this.sackYards;
    data['touchdowns'] = this.touchdowns;
    data['longest'] = this.longest;
    data['interceptions'] = this.interceptions;
    data['rating'] = this.rating;
    data['longest_touchdown'] = this.longestTouchdown;
    data['air_yards'] = this.airYards;
    data['redzone_attempts'] = this.redzoneAttempts;
    data['gross_yards'] = this.grossYards;
    data['first_downs'] = this.firstDowns;
    data['int_touchdowns'] = this.intTouchdowns;
    data['throw_aways'] = this.throwAways;
    data['poor_throws'] = this.poorThrows;
    data['defended_passes'] = this.defendedPasses;
    data['dropped_passes'] = this.droppedPasses;
    data['spikes'] = this.spikes;
    data['blitzes'] = this.blitzes;
    data['hurries'] = this.hurries;
    data['knockdowns'] = this.knockdowns;
    data['pocket_time'] = this.pocketTime;
    data['avg_pocket_time'] = this.avgPocketTime;
    data['net_yards'] = this.netYards;
    data['batted_passes'] = this.battedPasses;
    data['on_target_throws'] = this.onTargetThrows;
    return data;
  }
}

class Fumbles {
  num? fumbles;
  num? lostFumbles;
  num? ownRec;
  num? ownRecYards;
  num? oppRec;
  num? oppRecYards;
  num? outOfBounds;
  num? forcedFumbles;
  num? ownRecTds;
  num? oppRecTds;
  num? ezRecTds;

  Fumbles(
      {this.fumbles,
      this.lostFumbles,
      this.ownRec,
      this.ownRecYards,
      this.oppRec,
      this.oppRecYards,
      this.outOfBounds,
      this.forcedFumbles,
      this.ownRecTds,
      this.oppRecTds,
      this.ezRecTds});

  Fumbles.fromJson(Map<String, dynamic> json) {
    fumbles = json['fumbles'];
    lostFumbles = json['lost_fumbles'];
    ownRec = json['own_rec'];
    ownRecYards = json['own_rec_yards'];
    oppRec = json['opp_rec'];
    oppRecYards = json['opp_rec_yards'];
    outOfBounds = json['out_of_bounds'];
    forcedFumbles = json['forced_fumbles'];
    ownRecTds = json['own_rec_tds'];
    oppRecTds = json['opp_rec_tds'];
    ezRecTds = json['ez_rec_tds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fumbles'] = this.fumbles;
    data['lost_fumbles'] = this.lostFumbles;
    data['own_rec'] = this.ownRec;
    data['own_rec_yards'] = this.ownRecYards;
    data['opp_rec'] = this.oppRec;
    data['opp_rec_yards'] = this.oppRecYards;
    data['out_of_bounds'] = this.outOfBounds;
    data['forced_fumbles'] = this.forcedFumbles;
    data['own_rec_tds'] = this.ownRecTds;
    data['opp_rec_tds'] = this.oppRecTds;
    data['ez_rec_tds'] = this.ezRecTds;
    return data;
  }
}

class Conversions {
  num? passAttempts;
  num? passSuccesses;
  num? rushAttempts;
  num? rushSuccesses;
  num? receiveAttempts;
  num? receiveSuccesses;
  num? defenseAttempts;
  num? defenseSuccesses;

  Conversions(
      {this.passAttempts,
      this.passSuccesses,
      this.rushAttempts,
      this.rushSuccesses,
      this.receiveAttempts,
      this.receiveSuccesses,
      this.defenseAttempts,
      this.defenseSuccesses});

  Conversions.fromJson(Map<String, dynamic> json) {
    passAttempts = json['pass_attempts'];
    passSuccesses = json['pass_successes'];
    rushAttempts = json['rush_attempts'];
    rushSuccesses = json['rush_successes'];
    receiveAttempts = json['receive_attempts'];
    receiveSuccesses = json['receive_successes'];
    defenseAttempts = json['defense_attempts'];
    defenseSuccesses = json['defense_successes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pass_attempts'] = this.passAttempts;
    data['pass_successes'] = this.passSuccesses;
    data['rush_attempts'] = this.rushAttempts;
    data['rush_successes'] = this.rushSuccesses;
    data['receive_attempts'] = this.receiveAttempts;
    data['receive_successes'] = this.receiveSuccesses;
    data['defense_attempts'] = this.defenseAttempts;
    data['defense_successes'] = this.defenseSuccesses;
    return data;
  }
}
