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
    team = json['team'] != null ? Team.fromJson(json['team']) : null;
    draft = json['draft'] != null ? Draft.fromJson(json['draft']) : null;
    if (json['seasons'] != null) {
      seasons = <Seasons>[];
      json['seasons'].forEach((v) {
        seasons!.add(Seasons.fromJson(v));
      });
    }
    sComment = json['_comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['jersey'] = jersey;
    data['last_name'] = lastName;
    data['first_name'] = firstName;
    data['abbr_name'] = abbrName;
    data['birth_date'] = birthDate;
    data['weight'] = weight;
    data['height'] = height;
    data['position'] = position;
    data['birth_place'] = birthPlace;
    data['high_school'] = highSchool;
    data['college'] = college;
    data['college_conf'] = collegeConf;
    data['rookie_year'] = rookieYear;
    data['status'] = status;
    data['sr_id'] = srId;
    data['experience'] = experience;
    if (team != null) {
      data['team'] = team!.toJson();
    }
    if (draft != null) {
      data['draft'] = draft!.toJson();
    }
    if (seasons != null) {
      data['seasons'] = seasons!.map((v) => v.toJson()).toList();
    }
    data['_comment'] = sComment;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['market'] = market;
    data['alias'] = alias;
    data['sr_id'] = srId;
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
    team = json['team'] != null ? Team.fromJson(json['team']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['year'] = year;
    data['round'] = round;
    data['number'] = number;
    if (team != null) {
      data['team'] = team!.toJson();
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
        teams!.add(Teams.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['year'] = year;
    data['type'] = type;
    data['name'] = name;
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
        ? Statistics.fromJson(json['statistics'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['market'] = market;
    data['alias'] = alias;
    data['sr_id'] = srId;
    if (statistics != null) {
      data['statistics'] = statistics!.toJson();
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
        json['rushing'] != null ? Rushing.fromJson(json['rushing']) : null;
    penalties = json['penalties'] != null
        ? Penalties.fromJson(json['penalties'])
        : null;
    passing =
        json['passing'] != null ? Passing.fromJson(json['passing']) : null;
    fumbles =
        json['fumbles'] != null ? Fumbles.fromJson(json['fumbles']) : null;
    conversions = json['conversions'] != null
        ? Conversions.fromJson(json['conversions'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['games_played'] = gamesPlayed;
    data['games_started'] = gamesStarted;
    if (rushing != null) {
      data['rushing'] = rushing!.toJson();
    }
    if (penalties != null) {
      data['penalties'] = penalties!.toJson();
    }
    if (passing != null) {
      data['passing'] = passing!.toJson();
    }
    if (fumbles != null) {
      data['fumbles'] = fumbles!.toJson();
    }
    if (conversions != null) {
      data['conversions'] = conversions!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['avg_yards'] = avgYards;
    data['attempts'] = attempts;
    data['touchdowns'] = touchdowns;
    data['yards'] = yards;
    data['longest'] = longest;
    data['longest_touchdown'] = longestTouchdown;
    data['redzone_attempts'] = redzoneAttempts;
    data['tlost'] = tlost;
    data['tlost_yards'] = tlostYards;
    data['first_downs'] = firstDowns;
    data['broken_tackles'] = brokenTackles;
    data['kneel_downs'] = kneelDowns;
    data['scrambles'] = scrambles;
    data['yards_after_contact'] = yardsAfterContact;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['penalties'] = penalties;
    data['yards'] = yards;
    data['first_downs'] = firstDowns;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['attempts'] = attempts;
    data['completions'] = completions;
    data['cmp_pct'] = cmpPct;
    data['yards'] = yards;
    data['avg_yards'] = avgYards;
    data['sacks'] = sacks;
    data['sack_yards'] = sackYards;
    data['touchdowns'] = touchdowns;
    data['longest'] = longest;
    data['interceptions'] = interceptions;
    data['rating'] = rating;
    data['longest_touchdown'] = longestTouchdown;
    data['air_yards'] = airYards;
    data['redzone_attempts'] = redzoneAttempts;
    data['gross_yards'] = grossYards;
    data['first_downs'] = firstDowns;
    data['int_touchdowns'] = intTouchdowns;
    data['throw_aways'] = throwAways;
    data['poor_throws'] = poorThrows;
    data['defended_passes'] = defendedPasses;
    data['dropped_passes'] = droppedPasses;
    data['spikes'] = spikes;
    data['blitzes'] = blitzes;
    data['hurries'] = hurries;
    data['knockdowns'] = knockdowns;
    data['pocket_time'] = pocketTime;
    data['avg_pocket_time'] = avgPocketTime;
    data['net_yards'] = netYards;
    data['batted_passes'] = battedPasses;
    data['on_target_throws'] = onTargetThrows;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fumbles'] = fumbles;
    data['lost_fumbles'] = lostFumbles;
    data['own_rec'] = ownRec;
    data['own_rec_yards'] = ownRecYards;
    data['opp_rec'] = oppRec;
    data['opp_rec_yards'] = oppRecYards;
    data['out_of_bounds'] = outOfBounds;
    data['forced_fumbles'] = forcedFumbles;
    data['own_rec_tds'] = ownRecTds;
    data['opp_rec_tds'] = oppRecTds;
    data['ez_rec_tds'] = ezRecTds;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pass_attempts'] = passAttempts;
    data['pass_successes'] = passSuccesses;
    data['rush_attempts'] = rushAttempts;
    data['rush_successes'] = rushSuccesses;
    data['receive_attempts'] = receiveAttempts;
    data['receive_successes'] = receiveSuccesses;
    data['defense_attempts'] = defenseAttempts;
    data['defense_successes'] = defenseSuccesses;
    return data;
  }
}
