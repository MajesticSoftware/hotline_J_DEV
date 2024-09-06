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
  Receiving? receiving;
  KickReturns? kickReturns;
  Defense? defense;
  Penalties? penalties;
  Fumbles? fumbles;

  Statistics(
      {this.gamesPlayed,
        this.gamesStarted,
        this.rushing,
        this.receiving,
        this.kickReturns,
        this.defense,
        this.penalties,
        this.fumbles});

  Statistics.fromJson(Map<String, dynamic> json) {
    gamesPlayed = json['games_played'];
    gamesStarted = json['games_started'];
    rushing =
    json['rushing'] != null ? Rushing.fromJson(json['rushing']) : null;
    receiving = json['receiving'] != null
        ? Receiving.fromJson(json['receiving'])
        : null;
    kickReturns = json['kick_returns'] != null
        ? KickReturns.fromJson(json['kick_returns'])
        : null;
    defense =
    json['defense'] != null ? Defense.fromJson(json['defense']) : null;
    penalties = json['penalties'] != null
        ? Penalties.fromJson(json['penalties'])
        : null;
    fumbles =
    json['fumbles'] != null ? Fumbles.fromJson(json['fumbles']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['games_played'] = gamesPlayed;
    data['games_started'] = gamesStarted;
    if (rushing != null) {
      data['rushing'] = rushing!.toJson();
    }
    if (receiving != null) {
      data['receiving'] = receiving!.toJson();
    }
    if (kickReturns != null) {
      data['kick_returns'] = kickReturns!.toJson();
    }
    if (defense != null) {
      data['defense'] = defense!.toJson();
    }
    if (penalties != null) {
      data['penalties'] = penalties!.toJson();
    }
    if (fumbles != null) {
      data['fumbles'] = fumbles!.toJson();
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

class Receiving {
  num? receptions;
  num? targets;
  num? yards;
  num? avgYards;
  num? longest;
  num? touchdowns;
  num? longestTouchdown;
  num? yardsAfterCatch;
  num? redzoneTargets;
  num? airYards;
  num? firstDowns;
  num? brokenTackles;
  num? droppedPasses;
  num? catchablePasses;
  num? yardsAfterContact;

  Receiving(
      {this.receptions,
        this.targets,
        this.yards,
        this.avgYards,
        this.longest,
        this.touchdowns,
        this.longestTouchdown,
        this.yardsAfterCatch,
        this.redzoneTargets,
        this.airYards,
        this.firstDowns,
        this.brokenTackles,
        this.droppedPasses,
        this.catchablePasses,
        this.yardsAfterContact});

  Receiving.fromJson(Map<String, dynamic> json) {
    receptions = json['receptions'];
    targets = json['targets'];
    yards = json['yards'];
    avgYards = json['avg_yards'];
    longest = json['longest'];
    touchdowns = json['touchdowns'];
    longestTouchdown = json['longest_touchdown'];
    yardsAfterCatch = json['yards_after_catch'];
    redzoneTargets = json['redzone_targets'];
    airYards = json['air_yards'];
    firstDowns = json['first_downs'];
    brokenTackles = json['broken_tackles'];
    droppedPasses = json['dropped_passes'];
    catchablePasses = json['catchable_passes'];
    yardsAfterContact = json['yards_after_contact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['receptions'] = receptions;
    data['targets'] = targets;
    data['yards'] = yards;
    data['avg_yards'] = avgYards;
    data['longest'] = longest;
    data['touchdowns'] = touchdowns;
    data['longest_touchdown'] = longestTouchdown;
    data['yards_after_catch'] = yardsAfterCatch;
    data['redzone_targets'] = redzoneTargets;
    data['air_yards'] = airYards;
    data['first_downs'] = firstDowns;
    data['broken_tackles'] = brokenTackles;
    data['dropped_passes'] = droppedPasses;
    data['catchable_passes'] = catchablePasses;
    data['yards_after_contact'] = yardsAfterContact;
    return data;
  }
}

class KickReturns {
  num? returns;
  num? yards;
  num? avgYards;
  num? touchdowns;
  num? longest;
  num? faircatches;
  num? longestTouchdown;

  KickReturns(
      {this.returns,
        this.yards,
        this.avgYards,
        this.touchdowns,
        this.longest,
        this.faircatches,
        this.longestTouchdown});

  KickReturns.fromJson(Map<String, dynamic> json) {
    returns = json['returns'];
    yards = json['yards'];
    avgYards = json['avg_yards'];
    touchdowns = json['touchdowns'];
    longest = json['longest'];
    faircatches = json['faircatches'];
    longestTouchdown = json['longest_touchdown'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['returns'] = returns;
    data['yards'] = yards;
    data['avg_yards'] = avgYards;
    data['touchdowns'] = touchdowns;
    data['longest'] = longest;
    data['faircatches'] = faircatches;
    data['longest_touchdown'] = longestTouchdown;
    return data;
  }
}

class Defense {
  num? tackles;
  num? assists;
  num? combined;
  num? sacks;
  num? sackYards;
  num? interceptions;
  num? passesDefended;
  num? forcedFumbles;
  num? fumbleRecoveries;
  num? qbHits;
  num? tloss;
  num? tlossYards;
  num? safeties;
  num? spTackles;
  num? spAssists;
  num? spForcedFumbles;
  num? spFumbleRecoveries;
  num? spBlocks;
  num? miscTackles;
  num? miscAssists;
  num? miscForcedFumbles;
  num? miscFumbleRecoveries;
  num? defTargets;
  num? defComps;
  num? blitzes;
  num? hurries;
  num? knockdowns;
  num? missedTackles;
  num? battedPasses;
  num? spOwnFumbleRecoveries;
  num? spOppFumbleRecoveries;

  Defense(
      {this.tackles,
        this.assists,
        this.combined,
        this.sacks,
        this.sackYards,
        this.interceptions,
        this.passesDefended,
        this.forcedFumbles,
        this.fumbleRecoveries,
        this.qbHits,
        this.tloss,
        this.tlossYards,
        this.safeties,
        this.spTackles,
        this.spAssists,
        this.spForcedFumbles,
        this.spFumbleRecoveries,
        this.spBlocks,
        this.miscTackles,
        this.miscAssists,
        this.miscForcedFumbles,
        this.miscFumbleRecoveries,
        this.defTargets,
        this.defComps,
        this.blitzes,
        this.hurries,
        this.knockdowns,
        this.missedTackles,
        this.battedPasses,
        this.spOwnFumbleRecoveries,
        this.spOppFumbleRecoveries});

  Defense.fromJson(Map<String, dynamic> json) {
    tackles = json['tackles'];
    assists = json['assists'];
    combined = json['combined'];
    sacks = json['sacks'];
    sackYards = json['sack_yards'];
    interceptions = json['interceptions'];
    passesDefended = json['passes_defended'];
    forcedFumbles = json['forced_fumbles'];
    fumbleRecoveries = json['fumble_recoveries'];
    qbHits = json['qb_hits'];
    tloss = json['tloss'];
    tlossYards = json['tloss_yards'];
    safeties = json['safeties'];
    spTackles = json['sp_tackles'];
    spAssists = json['sp_assists'];
    spForcedFumbles = json['sp_forced_fumbles'];
    spFumbleRecoveries = json['sp_fumble_recoveries'];
    spBlocks = json['sp_blocks'];
    miscTackles = json['misc_tackles'];
    miscAssists = json['misc_assists'];
    miscForcedFumbles = json['misc_forced_fumbles'];
    miscFumbleRecoveries = json['misc_fumble_recoveries'];
    defTargets = json['def_targets'];
    defComps = json['def_comps'];
    blitzes = json['blitzes'];
    hurries = json['hurries'];
    knockdowns = json['knockdowns'];
    missedTackles = json['missed_tackles'];
    battedPasses = json['batted_passes'];
    spOwnFumbleRecoveries = json['sp_own_fumble_recoveries'];
    spOppFumbleRecoveries = json['sp_opp_fumble_recoveries'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tackles'] = tackles;
    data['assists'] = assists;
    data['combined'] = combined;
    data['sacks'] = sacks;
    data['sack_yards'] = sackYards;
    data['interceptions'] = interceptions;
    data['passes_defended'] = passesDefended;
    data['forced_fumbles'] = forcedFumbles;
    data['fumble_recoveries'] = fumbleRecoveries;
    data['qb_hits'] = qbHits;
    data['tloss'] = tloss;
    data['tloss_yards'] = tlossYards;
    data['safeties'] = safeties;
    data['sp_tackles'] = spTackles;
    data['sp_assists'] = spAssists;
    data['sp_forced_fumbles'] = spForcedFumbles;
    data['sp_fumble_recoveries'] = spFumbleRecoveries;
    data['sp_blocks'] = spBlocks;
    data['misc_tackles'] = miscTackles;
    data['misc_assists'] = miscAssists;
    data['misc_forced_fumbles'] = miscForcedFumbles;
    data['misc_fumble_recoveries'] = miscFumbleRecoveries;
    data['def_targets'] = defTargets;
    data['def_comps'] = defComps;
    data['blitzes'] = blitzes;
    data['hurries'] = hurries;
    data['knockdowns'] = knockdowns;
    data['missed_tackles'] = missedTackles;
    data['batted_passes'] = battedPasses;
    data['sp_own_fumble_recoveries'] = spOwnFumbleRecoveries;
    data['sp_opp_fumble_recoveries'] = spOppFumbleRecoveries;
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
