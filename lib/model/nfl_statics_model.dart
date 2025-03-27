class NFLStaticsModel {
  String? id;
  String? name;
  String? market;
  String? alias;
  String? srId;
  Season? season;
  Record? record;
  Opponents? opponents;
  List<Players>? players;
  String? sComment;

  NFLStaticsModel(
      {this.id,
      this.name,
      this.market,
      this.alias,
      this.srId,
      this.season,
      this.record,
      this.opponents,
      this.players,
      this.sComment});

  NFLStaticsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    market = json['market'];
    alias = json['alias'];
    srId = json['sr_id'];
    season = json['season'] != null ? Season.fromJson(json['season']) : null;
    record = json['record'] != null ? Record.fromJson(json['record']) : null;
    opponents = json['opponents'] != null
        ? Opponents.fromJson(json['opponents'])
        : null;
    if (json['players'] != null) {
      players = <Players>[];
      json['players'].forEach((v) {
        players!.add(Players.fromJson(v));
      });
    }
    sComment = json['_comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['market'] = market;
    data['alias'] = alias;
    data['sr_id'] = srId;
    if (season != null) {
      data['season'] = season!.toJson();
    }
    if (record != null) {
      data['record'] = record!.toJson();
    }
    if (opponents != null) {
      data['opponents'] = opponents!.toJson();
    }
    if (players != null) {
      data['players'] = players!.map((v) => v.toJson()).toList();
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

class Record {
  num? gamesPlayed;
  Touchdowns? touchdowns;
  Rushing? rushing;
  Receiving? receiving;
  Punts? punts;
  PuntReturns? puntReturns;
  Penalties? penalties;
  Passing? passing;
  Kickoffs? kickoffs;
  Interceptions? interceptions;
  IntReturns? intReturns;
  Fumbles? fumbles;
  FirstDowns? firstDowns;
  FieldGoals? fieldGoals;
  Defense? defense;
  ExtraPoints? extraPoints;
  Efficiency? efficiency;

  Record(
      {this.gamesPlayed,
      this.touchdowns,
      this.rushing,
      this.receiving,
      this.punts,
      this.puntReturns,
      this.penalties,
      this.passing,
      this.kickoffs,
      this.interceptions,
      this.intReturns,
      this.fumbles,
      this.firstDowns,
      this.fieldGoals,
      this.defense,
      this.extraPoints,
      this.efficiency});

  Record.fromJson(Map<String, dynamic> json) {
    gamesPlayed = json['games_played'];
    touchdowns = json['touchdowns'] != null
        ? Touchdowns.fromJson(json['touchdowns'])
        : null;
    rushing =
        json['rushing'] != null ? Rushing.fromJson(json['rushing']) : null;
    receiving = json['receiving'] != null
        ? Receiving.fromJson(json['receiving'])
        : null;
    punts = json['punts'] != null ? Punts.fromJson(json['punts']) : null;
    puntReturns = json['punt_returns'] != null
        ? PuntReturns.fromJson(json['punt_returns'])
        : null;
    penalties = json['penalties'] != null
        ? Penalties.fromJson(json['penalties'])
        : null;
    passing =
        json['passing'] != null ? Passing.fromJson(json['passing']) : null;
    kickoffs =
        json['kickoffs'] != null ? Kickoffs.fromJson(json['kickoffs']) : null;
    interceptions = json['interceptions'] != null
        ? Interceptions.fromJson(json['interceptions'])
        : null;
    intReturns = json['int_returns'] != null
        ? IntReturns.fromJson(json['int_returns'])
        : null;
    fumbles =
        json['fumbles'] != null ? Fumbles.fromJson(json['fumbles']) : null;
    firstDowns = json['first_downs'] != null
        ? FirstDowns.fromJson(json['first_downs'])
        : null;
    fieldGoals = json['field_goals'] != null
        ? FieldGoals.fromJson(json['field_goals'])
        : null;
    defense =
        json['defense'] != null ? Defense.fromJson(json['defense']) : null;
    extraPoints = json['extra_points'] != null
        ? ExtraPoints.fromJson(json['extra_points'])
        : null;
    efficiency = json['efficiency'] != null
        ? Efficiency.fromJson(json['efficiency'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['games_played'] = gamesPlayed;
    if (touchdowns != null) {
      data['touchdowns'] = touchdowns!.toJson();
    }
    if (rushing != null) {
      data['rushing'] = rushing!.toJson();
    }
    if (receiving != null) {
      data['receiving'] = receiving!.toJson();
    }
    if (punts != null) {
      data['punts'] = punts!.toJson();
    }
    if (puntReturns != null) {
      data['punt_returns'] = puntReturns!.toJson();
    }
    if (penalties != null) {
      data['penalties'] = penalties!.toJson();
    }
    if (passing != null) {
      data['passing'] = passing!.toJson();
    }
    if (kickoffs != null) {
      data['kickoffs'] = kickoffs!.toJson();
    }
    if (interceptions != null) {
      data['interceptions'] = interceptions!.toJson();
    }
    if (intReturns != null) {
      data['int_returns'] = intReturns!.toJson();
    }
    if (fumbles != null) {
      data['fumbles'] = fumbles!.toJson();
    }
    if (firstDowns != null) {
      data['first_downs'] = firstDowns!.toJson();
    }
    if (fieldGoals != null) {
      data['field_goals'] = fieldGoals!.toJson();
    }
    if (defense != null) {
      data['defense'] = defense!.toJson();
    }
    if (extraPoints != null) {
      data['extra_points'] = extraPoints!.toJson();
    }
    if (efficiency != null) {
      data['efficiency'] = efficiency!.toJson();
    }
    return data;
  }
}

class Touchdowns {
  num? pass;
  num? rush;
  num? totalReturn;
  num? total;
  num? fumbleReturn;
  num? intReturn;
  num? kickReturn;
  num? puntReturn;
  num? other;

  Touchdowns(
      {this.pass,
      this.rush,
      this.totalReturn,
      this.total,
      this.fumbleReturn,
      this.intReturn,
      this.kickReturn,
      this.puntReturn,
      this.other});

  Touchdowns.fromJson(Map<String, dynamic> json) {
    pass = json['pass'];
    rush = json['rush'];
    totalReturn = json['total_return'];
    total = json['total'];
    fumbleReturn = json['fumble_return'];
    intReturn = json['int_return'];
    kickReturn = json['kick_return'];
    puntReturn = json['punt_return'];
    other = json['other'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pass'] = pass;
    data['rush'] = rush;
    data['total_return'] = totalReturn;
    data['total'] = total;
    data['fumble_return'] = fumbleReturn;
    data['int_return'] = intReturn;
    data['kick_return'] = kickReturn;
    data['punt_return'] = puntReturn;
    data['other'] = other;
    return data;
  }
}

class Rushing {
  num? avgYards;
  num? attempts;
  num? touchdowns;
  num? tlost;
  num? tlostYards;
  num? yards;
  num? longest;
  num? longestTouchdown;
  num? redzoneAttempts;
  num? brokenTackles;
  num? kneelDowns;
  num? scrambles;
  num? yardsAfterContact;

  Rushing(
      {this.avgYards,
      this.attempts,
      this.touchdowns,
      this.tlost,
      this.tlostYards,
      this.yards,
      this.longest,
      this.longestTouchdown,
      this.redzoneAttempts,
      this.brokenTackles,
      this.kneelDowns,
      this.scrambles,
      this.yardsAfterContact});

  Rushing.fromJson(Map<String, dynamic> json) {
    avgYards = json['avg_yards'];
    attempts = json['attempts'];
    touchdowns = json['touchdowns'];
    tlost = json['tlost'];
    tlostYards = json['tlost_yards'];
    yards = json['yards'];
    longest = json['longest'];
    longestTouchdown = json['longest_touchdown'];
    redzoneAttempts = json['redzone_attempts'];
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
    data['tlost'] = tlost;
    data['tlost_yards'] = tlostYards;
    data['yards'] = yards;
    data['longest'] = longest;
    data['longest_touchdown'] = longestTouchdown;
    data['redzone_attempts'] = redzoneAttempts;
    data['broken_tackles'] = brokenTackles;
    data['kneel_downs'] = kneelDowns;
    data['scrambles'] = scrambles;
    data['yards_after_contact'] = yardsAfterContact;
    return data;
  }
}

class Receiving {
  num? targets;
  num? receptions;
  num? avgYards;
  num? yards;
  num? touchdowns;
  num? yardsAfterCatch;
  num? longest;
  num? longestTouchdown;
  num? redzoneTargets;
  num? airYards;
  num? brokenTackles;
  num? droppedPasses;
  num? catchablePasses;
  num? yardsAfterContact;

  Receiving(
      {this.targets,
      this.receptions,
      this.avgYards,
      this.yards,
      this.touchdowns,
      this.yardsAfterCatch,
      this.longest,
      this.longestTouchdown,
      this.redzoneTargets,
      this.airYards,
      this.brokenTackles,
      this.droppedPasses,
      this.catchablePasses,
      this.yardsAfterContact});

  Receiving.fromJson(Map<String, dynamic> json) {
    targets = json['targets'];
    receptions = json['receptions'];
    avgYards = json['avg_yards'];
    yards = json['yards'];
    touchdowns = json['touchdowns'];
    yardsAfterCatch = json['yards_after_catch'];
    longest = json['longest'];
    longestTouchdown = json['longest_touchdown'];
    redzoneTargets = json['redzone_targets'];
    airYards = json['air_yards'];
    brokenTackles = json['broken_tackles'];
    droppedPasses = json['dropped_passes'];
    catchablePasses = json['catchable_passes'];
    yardsAfterContact = json['yards_after_contact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['targets'] = targets;
    data['receptions'] = receptions;
    data['avg_yards'] = avgYards;
    data['yards'] = yards;
    data['touchdowns'] = touchdowns;
    data['yards_after_catch'] = yardsAfterCatch;
    data['longest'] = longest;
    data['longest_touchdown'] = longestTouchdown;
    data['redzone_targets'] = redzoneTargets;
    data['air_yards'] = airYards;
    data['broken_tackles'] = brokenTackles;
    data['dropped_passes'] = droppedPasses;
    data['catchable_passes'] = catchablePasses;
    data['yards_after_contact'] = yardsAfterContact;
    return data;
  }
}

class Punts {
  num? attempts;
  num? yards;
  num? netYards;
  num? blocked;
  num? touchbacks;
  num? inside20;
  num? returnYards;
  num? avgNetYards;
  num? avgYards;
  num? longest;
  num? hangTime;
  num? avgHangTime;

  Punts(
      {this.attempts,
      this.yards,
      this.netYards,
      this.blocked,
      this.touchbacks,
      this.inside20,
      this.returnYards,
      this.avgNetYards,
      this.avgYards,
      this.longest,
      this.hangTime,
      this.avgHangTime});

  Punts.fromJson(Map<String, dynamic> json) {
    attempts = json['attempts'];
    yards = json['yards'];
    netYards = json['net_yards'];
    blocked = json['blocked'];
    touchbacks = json['touchbacks'];
    inside20 = json['inside_20'];
    returnYards = json['return_yards'];
    avgNetYards = json['avg_net_yards'];
    avgYards = json['avg_yards'];
    longest = json['longest'];
    hangTime = json['hang_time'];
    avgHangTime = json['avg_hang_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['attempts'] = attempts;
    data['yards'] = yards;
    data['net_yards'] = netYards;
    data['blocked'] = blocked;
    data['touchbacks'] = touchbacks;
    data['inside_20'] = inside20;
    data['return_yards'] = returnYards;
    data['avg_net_yards'] = avgNetYards;
    data['avg_yards'] = avgYards;
    data['longest'] = longest;
    data['hang_time'] = hangTime;
    data['avg_hang_time'] = avgHangTime;
    return data;
  }
}

class PuntReturns {
  num? avgYards;
  num? returns;
  num? yards;
  num? longest;
  num? touchdowns;
  num? longestTouchdown;
  num? faircatches;

  PuntReturns(
      {this.avgYards,
      this.returns,
      this.yards,
      this.longest,
      this.touchdowns,
      this.longestTouchdown,
      this.faircatches});

  PuntReturns.fromJson(Map<String, dynamic> json) {
    avgYards = json['avg_yards'];
    returns = json['returns'];
    yards = json['yards'];
    longest = json['longest'];
    touchdowns = json['touchdowns'];
    longestTouchdown = json['longest_touchdown'];
    faircatches = json['faircatches'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['avg_yards'] = avgYards;
    data['returns'] = returns;
    data['yards'] = yards;
    data['longest'] = longest;
    data['touchdowns'] = touchdowns;
    data['longest_touchdown'] = longestTouchdown;
    data['faircatches'] = faircatches;
    return data;
  }
}

class Penalties {
  num? penalties;
  num? yards;

  Penalties({this.penalties, this.yards});

  Penalties.fromJson(Map<String, dynamic> json) {
    penalties = json['penalties'];
    yards = json['yards'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['penalties'] = penalties;
    data['yards'] = yards;
    return data;
  }
}

class Passing {
  num? attempts;
  num? completions;
  num? cmpPct;
  num? interceptions;
  num? sackYards;
  num? rating;
  num? touchdowns;
  num? avgYards;
  num? sacks;
  num? longest;
  num? longestTouchdown;
  num? airYards;
  num? redzoneAttempts;
  num? netYards;
  num? yards;
  num? grossYards;
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
  num? battedPasses;
  num? onTargetThrows;

  Passing(
      {this.attempts,
      this.completions,
      this.cmpPct,
      this.interceptions,
      this.sackYards,
      this.rating,
      this.touchdowns,
      this.avgYards,
      this.sacks,
      this.longest,
      this.longestTouchdown,
      this.airYards,
      this.redzoneAttempts,
      this.netYards,
      this.yards,
      this.grossYards,
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
      this.battedPasses,
      this.onTargetThrows});

  Passing.fromJson(Map<String, dynamic> json) {
    attempts = json['attempts'];
    completions = json['completions'];
    cmpPct = json['cmp_pct'];
    interceptions = json['interceptions'];
    sackYards = json['sack_yards'];
    rating = json['rating'];
    touchdowns = json['touchdowns'];
    avgYards = json['avg_yards'];
    sacks = json['sacks'];
    longest = json['longest'];
    longestTouchdown = json['longest_touchdown'];
    airYards = json['air_yards'];
    redzoneAttempts = json['redzone_attempts'];
    netYards = json['net_yards'];
    yards = json['yards'];
    grossYards = json['gross_yards'];
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
    battedPasses = json['batted_passes'];
    onTargetThrows = json['on_target_throws'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['attempts'] = attempts;
    data['completions'] = completions;
    data['cmp_pct'] = cmpPct;
    data['interceptions'] = interceptions;
    data['sack_yards'] = sackYards;
    data['rating'] = rating;
    data['touchdowns'] = touchdowns;
    data['avg_yards'] = avgYards;
    data['sacks'] = sacks;
    data['longest'] = longest;
    data['longest_touchdown'] = longestTouchdown;
    data['air_yards'] = airYards;
    data['redzone_attempts'] = redzoneAttempts;
    data['net_yards'] = netYards;
    data['yards'] = yards;
    data['gross_yards'] = grossYards;
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
    data['batted_passes'] = battedPasses;
    data['on_target_throws'] = onTargetThrows;
    return data;
  }
}

class Kickoffs {
  num? endzone;
  num? inside20;
  num? returnYards;
  num? returned;
  num? touchbacks;
  num? yards;
  num? outOfBounds;
  num? kickoffs;
  num? onsideAttempts;
  num? onsideSuccesses;
  num? squibKicks;

  Kickoffs(
      {this.endzone,
      this.inside20,
      this.returnYards,
      this.returned,
      this.touchbacks,
      this.yards,
      this.outOfBounds,
      this.kickoffs,
      this.onsideAttempts,
      this.onsideSuccesses,
      this.squibKicks});

  Kickoffs.fromJson(Map<String, dynamic> json) {
    endzone = json['endzone'];
    inside20 = json['inside_20'];
    returnYards = json['return_yards'];
    returned = json['returned'];
    touchbacks = json['touchbacks'];
    yards = json['yards'];
    outOfBounds = json['out_of_bounds'];
    kickoffs = json['kickoffs'];
    onsideAttempts = json['onside_attempts'];
    onsideSuccesses = json['onside_successes'];
    squibKicks = json['squib_kicks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['endzone'] = endzone;
    data['inside_20'] = inside20;
    data['return_yards'] = returnYards;
    data['returned'] = returned;
    data['touchbacks'] = touchbacks;
    data['yards'] = yards;
    data['out_of_bounds'] = outOfBounds;
    data['kickoffs'] = kickoffs;
    data['onside_attempts'] = onsideAttempts;
    data['onside_successes'] = onsideSuccesses;
    data['squib_kicks'] = squibKicks;
    return data;
  }
}

class Interceptions {
  num? returnYards;
  num? returned;
  num? interceptions;

  Interceptions({this.returnYards, this.returned, this.interceptions});

  Interceptions.fromJson(Map<String, dynamic> json) {
    returnYards = json['return_yards'];
    returned = json['returned'];
    interceptions = json['interceptions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['return_yards'] = returnYards;
    data['returned'] = returned;
    data['interceptions'] = interceptions;
    return data;
  }
}

class IntReturns {
  num? avgYards;
  num? yards;
  num? longest;
  num? touchdowns;
  num? longestTouchdown;
  num? returns;

  IntReturns(
      {this.avgYards,
      this.yards,
      this.longest,
      this.touchdowns,
      this.longestTouchdown,
      this.returns});

  IntReturns.fromJson(Map<String, dynamic> json) {
    avgYards = json['avg_yards'];
    yards = json['yards'];
    longest = json['longest'];
    touchdowns = json['touchdowns'];
    longestTouchdown = json['longest_touchdown'];
    returns = json['returns'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['avg_yards'] = avgYards;
    data['yards'] = yards;
    data['longest'] = longest;
    data['touchdowns'] = touchdowns;
    data['longest_touchdown'] = longestTouchdown;
    data['returns'] = returns;
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

class FirstDowns {
  num? pass;
  num? penalty;
  num? rush;
  num? total;

  FirstDowns({this.pass, this.penalty, this.rush, this.total});

  FirstDowns.fromJson(Map<String, dynamic> json) {
    pass = json['pass'];
    penalty = json['penalty'];
    rush = json['rush'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pass'] = pass;
    data['penalty'] = penalty;
    data['rush'] = rush;
    data['total'] = total;
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
  num? threeAndOutsForced;
  num? fourthDownStops;

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
      this.threeAndOutsForced,
      this.fourthDownStops});

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
    threeAndOutsForced = json['three_and_outs_forced'];
    fourthDownStops = json['fourth_down_stops'];
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
    data['three_and_outs_forced'] = threeAndOutsForced;
    data['fourth_down_stops'] = fourthDownStops;
    return data;
  }
}

class ExtraPoints {
  Kicks? kicks;
  Conversions? conversions;

  ExtraPoints({this.kicks, this.conversions});

  ExtraPoints.fromJson(Map<String, dynamic> json) {
    kicks = json['kicks'] != null ? Kicks.fromJson(json['kicks']) : null;
    conversions = json['conversions'] != null
        ? Conversions.fromJson(json['conversions'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (kicks != null) {
      data['kicks'] = kicks!.toJson();
    }
    if (conversions != null) {
      data['conversions'] = conversions!.toJson();
    }
    return data;
  }
}

class Kicks {
  num? attempts;
  num? blocked;
  num? made;
  num? pct;

  Kicks({this.attempts, this.blocked, this.made, this.pct});

  Kicks.fromJson(Map<String, dynamic> json) {
    attempts = json['attempts'];
    blocked = json['blocked'];
    made = json['made'];
    pct = json['pct'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['attempts'] = attempts;
    data['blocked'] = blocked;
    data['made'] = made;
    data['pct'] = pct;
    return data;
  }
}

class Conversions {
  num? passAttempts;
  num? passSuccesses;
  num? rushAttempts;
  num? rushSuccesses;
  num? defenseAttempts;
  num? defenseSuccesses;
  num? turnoverSuccesses;

  Conversions(
      {this.passAttempts,
      this.passSuccesses,
      this.rushAttempts,
      this.rushSuccesses,
      this.defenseAttempts,
      this.defenseSuccesses,
      this.turnoverSuccesses});

  Conversions.fromJson(Map<String, dynamic> json) {
    passAttempts = json['pass_attempts'];
    passSuccesses = json['pass_successes'];
    rushAttempts = json['rush_attempts'];
    rushSuccesses = json['rush_successes'];
    defenseAttempts = json['defense_attempts'];
    defenseSuccesses = json['defense_successes'];
    turnoverSuccesses = json['turnover_successes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pass_attempts'] = passAttempts;
    data['pass_successes'] = passSuccesses;
    data['rush_attempts'] = rushAttempts;
    data['rush_successes'] = rushSuccesses;
    data['defense_attempts'] = defenseAttempts;
    data['defense_successes'] = defenseSuccesses;
    data['turnover_successes'] = turnoverSuccesses;
    return data;
  }
}

class Efficiency {
  Goaltogo? goaltogo;
  Redzone? redzone;
  Redzone? thirddown;
  Goaltogo? fourthdown;

  Efficiency({this.goaltogo, this.redzone, this.thirddown, this.fourthdown});

  Efficiency.fromJson(Map<String, dynamic> json) {
    goaltogo =
        json['goaltogo'] != null ? Goaltogo.fromJson(json['goaltogo']) : null;
    redzone =
        json['redzone'] != null ? Redzone.fromJson(json['redzone']) : null;
    thirddown =
        json['thirddown'] != null ? Redzone.fromJson(json['thirddown']) : null;
    fourthdown = json['fourthdown'] != null
        ? Goaltogo.fromJson(json['fourthdown'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (goaltogo != null) {
      data['goaltogo'] = goaltogo!.toJson();
    }
    if (redzone != null) {
      data['redzone'] = redzone!.toJson();
    }
    if (thirddown != null) {
      data['thirddown'] = thirddown!.toJson();
    }
    if (fourthdown != null) {
      data['fourthdown'] = fourthdown!.toJson();
    }
    return data;
  }
}

class Goaltogo {
  num? attempts;
  num? successes;
  num? pct;

  Goaltogo({this.attempts, this.successes, this.pct});

  Goaltogo.fromJson(Map<String, dynamic> json) {
    attempts = json['attempts'];
    successes = json['successes'];
    pct = json['pct'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['attempts'] = attempts;
    data['successes'] = successes;
    data['pct'] = pct;
    return data;
  }
}

class Redzone {
  num? attempts;
  num? successes;
  num? pct;

  Redzone({this.attempts, this.successes, this.pct});

  Redzone.fromJson(Map<String, dynamic> json) {
    attempts = json['attempts'];
    successes = json['successes'];
    pct = json['pct'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['attempts'] = attempts;
    data['successes'] = successes;
    data['pct'] = pct;
    return data;
  }
}

class Opponents {
  num? gamesPlayed;
  Touchdowns? touchdowns;
  Rushing? rushing;
  Receiving? receiving;
  Punts? punts;
  PuntReturns? puntReturns;
  Penalties? penalties;
  Passing? passing;
  Kickoffs? kickoffs;
  Fumbles? fumbles;
  FirstDowns? firstDowns;
  FieldGoals? fieldGoals;
  Defense? defense;
  ExtraPoints? extraPoints;
  Efficiency? efficiency;

  Opponents(
      {this.gamesPlayed,
      this.touchdowns,
      this.rushing,
      this.receiving,
      this.punts,
      this.puntReturns,
      this.penalties,
      this.passing,
      this.kickoffs,
      this.fumbles,
      this.firstDowns,
      this.fieldGoals,
      this.defense,
      this.extraPoints,
      this.efficiency});

  Opponents.fromJson(Map<String, dynamic> json) {
    gamesPlayed = json['games_played'];
    touchdowns = json['touchdowns'] != null
        ? Touchdowns.fromJson(json['touchdowns'])
        : null;
    rushing =
        json['rushing'] != null ? Rushing.fromJson(json['rushing']) : null;
    receiving = json['receiving'] != null
        ? Receiving.fromJson(json['receiving'])
        : null;
    punts = json['punts'] != null ? Punts.fromJson(json['punts']) : null;
    puntReturns = json['punt_returns'] != null
        ? PuntReturns.fromJson(json['punt_returns'])
        : null;
    penalties = json['penalties'] != null
        ? Penalties.fromJson(json['penalties'])
        : null;
    passing =
        json['passing'] != null ? Passing.fromJson(json['passing']) : null;
    kickoffs =
        json['kickoffs'] != null ? Kickoffs.fromJson(json['kickoffs']) : null;
    fumbles =
        json['fumbles'] != null ? Fumbles.fromJson(json['fumbles']) : null;
    firstDowns = json['first_downs'] != null
        ? FirstDowns.fromJson(json['first_downs'])
        : null;
    fieldGoals = json['field_goals'] != null
        ? FieldGoals.fromJson(json['field_goals'])
        : null;
    defense =
        json['defense'] != null ? Defense.fromJson(json['defense']) : null;
    extraPoints = json['extra_points'] != null
        ? ExtraPoints.fromJson(json['extra_points'])
        : null;
    efficiency = json['efficiency'] != null
        ? Efficiency.fromJson(json['efficiency'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['games_played'] = gamesPlayed;
    if (touchdowns != null) {
      data['touchdowns'] = touchdowns!.toJson();
    }
    if (rushing != null) {
      data['rushing'] = rushing!.toJson();
    }
    if (receiving != null) {
      data['receiving'] = receiving!.toJson();
    }
    if (punts != null) {
      data['punts'] = punts!.toJson();
    }
    if (puntReturns != null) {
      data['punt_returns'] = puntReturns!.toJson();
    }
    if (penalties != null) {
      data['penalties'] = penalties!.toJson();
    }
    if (passing != null) {
      data['passing'] = passing!.toJson();
    }
    if (kickoffs != null) {
      data['kickoffs'] = kickoffs!.toJson();
    }
    if (fumbles != null) {
      data['fumbles'] = fumbles!.toJson();
    }
    if (firstDowns != null) {
      data['first_downs'] = firstDowns!.toJson();
    }
    if (fieldGoals != null) {
      data['field_goals'] = fieldGoals!.toJson();
    }
    if (defense != null) {
      data['defense'] = defense!.toJson();
    }
    if (extraPoints != null) {
      data['extra_points'] = extraPoints!.toJson();
    }
    if (efficiency != null) {
      data['efficiency'] = efficiency!.toJson();
    }
    return data;
  }
}

class FieldGoals {
  num? attempts;
  num? made;
  num? blocked;
  num? yards;
  num? avgYards;
  num? longest;
  num? missed;
  num? pct;
  num? attempts19;
  num? attempts29;
  num? attempts39;
  num? attempts49;
  num? attempts50;
  num? made19;
  num? made29;
  num? made39;
  num? made49;
  num? made50;

  FieldGoals(
      {this.attempts,
      this.made,
      this.blocked,
      this.yards,
      this.avgYards,
      this.longest,
      this.missed,
      this.pct,
      this.attempts19,
      this.attempts29,
      this.attempts39,
      this.attempts49,
      this.attempts50,
      this.made19,
      this.made29,
      this.made39,
      this.made49,
      this.made50});

  FieldGoals.fromJson(Map<String, dynamic> json) {
    attempts = json['attempts'];
    made = json['made'];
    blocked = json['blocked'];
    yards = json['yards'];
    avgYards = json['avg_yards'];
    longest = json['longest'];
    missed = json['missed'];
    pct = json['pct'];
    attempts19 = json['attempts_19'];
    attempts29 = json['attempts_29'];
    attempts39 = json['attempts_39'];
    attempts49 = json['attempts_49'];
    attempts50 = json['attempts_50'];
    made19 = json['made_19'];
    made29 = json['made_29'];
    made39 = json['made_39'];
    made49 = json['made_49'];
    made50 = json['made_50'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['attempts'] = attempts;
    data['made'] = made;
    data['blocked'] = blocked;
    data['yards'] = yards;
    data['avg_yards'] = avgYards;
    data['longest'] = longest;
    data['missed'] = missed;
    data['pct'] = pct;
    data['attempts_19'] = attempts19;
    data['attempts_29'] = attempts29;
    data['attempts_39'] = attempts39;
    data['attempts_49'] = attempts49;
    data['attempts_50'] = attempts50;
    data['made_19'] = made19;
    data['made_29'] = made29;
    data['made_39'] = made39;
    data['made_49'] = made49;
    data['made_50'] = made50;
    return data;
  }
}

class Players {
  String? id;
  String? name;
  String? jersey;
  String? position;
  String? srId;
  num? gamesPlayed;
  num? gamesStarted;
  Defense? defense;
  Receiving? receiving;
  IntReturns? intReturns;
  Penalties? penalties;
  Fumbles? fumbles;
  Rushing? rushing;
  Punts? punts;
  Kickoffs? kickoffs;
  Passing? passing;
  ExtraPoints? extraPoints;
  PuntReturns? puntReturns;

  Players(
      {this.id,
      this.name,
      this.jersey,
      this.position,
      this.srId,
      this.gamesPlayed,
      this.gamesStarted,
      this.defense,
      this.receiving,
      this.intReturns,
      this.penalties,
      this.fumbles,
      this.rushing,
      this.punts,
      this.kickoffs,
      this.passing,
      this.extraPoints,
      this.puntReturns});

  Players.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    jersey = json['jersey'];
    position = json['position'];
    srId = json['sr_id'];
    gamesPlayed = json['games_played'];
    gamesStarted = json['games_started'];
    defense =
        json['defense'] != null ? Defense.fromJson(json['defense']) : null;
    receiving = json['receiving'] != null
        ? Receiving.fromJson(json['receiving'])
        : null;
    intReturns = json['int_returns'] != null
        ? IntReturns.fromJson(json['int_returns'])
        : null;
    penalties = json['penalties'] != null
        ? Penalties.fromJson(json['penalties'])
        : null;
    fumbles =
        json['fumbles'] != null ? Fumbles.fromJson(json['fumbles']) : null;
    rushing =
        json['rushing'] != null ? Rushing.fromJson(json['rushing']) : null;
    punts = json['punts'] != null ? Punts.fromJson(json['punts']) : null;
    kickoffs =
        json['kickoffs'] != null ? Kickoffs.fromJson(json['kickoffs']) : null;
    passing =
        json['passing'] != null ? Passing.fromJson(json['passing']) : null;
    extraPoints = json['extra_points'] != null
        ? ExtraPoints.fromJson(json['extra_points'])
        : null;
    puntReturns = json['punt_returns'] != null
        ? PuntReturns.fromJson(json['punt_returns'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['jersey'] = jersey;
    data['position'] = position;
    data['sr_id'] = srId;
    data['games_played'] = gamesPlayed;
    data['games_started'] = gamesStarted;
    if (defense != null) {
      data['defense'] = defense!.toJson();
    }
    if (receiving != null) {
      data['receiving'] = receiving!.toJson();
    }
    if (intReturns != null) {
      data['int_returns'] = intReturns!.toJson();
    }
    if (penalties != null) {
      data['penalties'] = penalties!.toJson();
    }
    if (fumbles != null) {
      data['fumbles'] = fumbles!.toJson();
    }
    if (rushing != null) {
      data['rushing'] = rushing!.toJson();
    }
    if (punts != null) {
      data['punts'] = punts!.toJson();
    }
    if (kickoffs != null) {
      data['kickoffs'] = kickoffs!.toJson();
    }
    if (passing != null) {
      data['passing'] = passing!.toJson();
    }
    if (extraPoints != null) {
      data['extra_points'] = extraPoints!.toJson();
    }
    if (puntReturns != null) {
      data['punt_returns'] = puntReturns!.toJson();
    }
    return data;
  }
}
