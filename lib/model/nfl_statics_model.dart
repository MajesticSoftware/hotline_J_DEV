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
    season =
        json['season'] != null ? new Season.fromJson(json['season']) : null;
    record =
        json['record'] != null ? new Record.fromJson(json['record']) : null;
    opponents = json['opponents'] != null
        ? new Opponents.fromJson(json['opponents'])
        : null;
    if (json['players'] != null) {
      players = <Players>[];
      json['players'].forEach((v) {
        players!.add(new Players.fromJson(v));
      });
    }
    sComment = json['_comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['market'] = this.market;
    data['alias'] = this.alias;
    data['sr_id'] = this.srId;
    if (this.season != null) {
      data['season'] = this.season!.toJson();
    }
    if (this.record != null) {
      data['record'] = this.record!.toJson();
    }
    if (this.opponents != null) {
      data['opponents'] = this.opponents!.toJson();
    }
    if (this.players != null) {
      data['players'] = this.players!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['year'] = this.year;
    data['type'] = this.type;
    data['name'] = this.name;
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
        ? new Touchdowns.fromJson(json['touchdowns'])
        : null;
    rushing =
        json['rushing'] != null ? new Rushing.fromJson(json['rushing']) : null;
    receiving = json['receiving'] != null
        ? new Receiving.fromJson(json['receiving'])
        : null;
    punts = json['punts'] != null ? new Punts.fromJson(json['punts']) : null;
    puntReturns = json['punt_returns'] != null
        ? new PuntReturns.fromJson(json['punt_returns'])
        : null;
    penalties = json['penalties'] != null
        ? new Penalties.fromJson(json['penalties'])
        : null;
    passing =
        json['passing'] != null ? new Passing.fromJson(json['passing']) : null;
    kickoffs = json['kickoffs'] != null
        ? new Kickoffs.fromJson(json['kickoffs'])
        : null;
    interceptions = json['interceptions'] != null
        ? new Interceptions.fromJson(json['interceptions'])
        : null;
    intReturns = json['int_returns'] != null
        ? new IntReturns.fromJson(json['int_returns'])
        : null;
    fumbles =
        json['fumbles'] != null ? new Fumbles.fromJson(json['fumbles']) : null;
    firstDowns = json['first_downs'] != null
        ? new FirstDowns.fromJson(json['first_downs'])
        : null;
    fieldGoals = json['field_goals'] != null
        ? new FieldGoals.fromJson(json['field_goals'])
        : null;
    defense =
        json['defense'] != null ? new Defense.fromJson(json['defense']) : null;
    extraPoints = json['extra_points'] != null
        ? new ExtraPoints.fromJson(json['extra_points'])
        : null;
    efficiency = json['efficiency'] != null
        ? new Efficiency.fromJson(json['efficiency'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['games_played'] = this.gamesPlayed;
    if (this.touchdowns != null) {
      data['touchdowns'] = this.touchdowns!.toJson();
    }
    if (this.rushing != null) {
      data['rushing'] = this.rushing!.toJson();
    }
    if (this.receiving != null) {
      data['receiving'] = this.receiving!.toJson();
    }
    if (this.punts != null) {
      data['punts'] = this.punts!.toJson();
    }
    if (this.puntReturns != null) {
      data['punt_returns'] = this.puntReturns!.toJson();
    }
    if (this.penalties != null) {
      data['penalties'] = this.penalties!.toJson();
    }
    if (this.passing != null) {
      data['passing'] = this.passing!.toJson();
    }
    if (this.kickoffs != null) {
      data['kickoffs'] = this.kickoffs!.toJson();
    }
    if (this.interceptions != null) {
      data['interceptions'] = this.interceptions!.toJson();
    }
    if (this.intReturns != null) {
      data['int_returns'] = this.intReturns!.toJson();
    }
    if (this.fumbles != null) {
      data['fumbles'] = this.fumbles!.toJson();
    }
    if (this.firstDowns != null) {
      data['first_downs'] = this.firstDowns!.toJson();
    }
    if (this.fieldGoals != null) {
      data['field_goals'] = this.fieldGoals!.toJson();
    }
    if (this.defense != null) {
      data['defense'] = this.defense!.toJson();
    }
    if (this.extraPoints != null) {
      data['extra_points'] = this.extraPoints!.toJson();
    }
    if (this.efficiency != null) {
      data['efficiency'] = this.efficiency!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pass'] = this.pass;
    data['rush'] = this.rush;
    data['total_return'] = this.totalReturn;
    data['total'] = this.total;
    data['fumble_return'] = this.fumbleReturn;
    data['int_return'] = this.intReturn;
    data['kick_return'] = this.kickReturn;
    data['punt_return'] = this.puntReturn;
    data['other'] = this.other;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avg_yards'] = this.avgYards;
    data['attempts'] = this.attempts;
    data['touchdowns'] = this.touchdowns;
    data['tlost'] = this.tlost;
    data['tlost_yards'] = this.tlostYards;
    data['yards'] = this.yards;
    data['longest'] = this.longest;
    data['longest_touchdown'] = this.longestTouchdown;
    data['redzone_attempts'] = this.redzoneAttempts;
    data['broken_tackles'] = this.brokenTackles;
    data['kneel_downs'] = this.kneelDowns;
    data['scrambles'] = this.scrambles;
    data['yards_after_contact'] = this.yardsAfterContact;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['targets'] = this.targets;
    data['receptions'] = this.receptions;
    data['avg_yards'] = this.avgYards;
    data['yards'] = this.yards;
    data['touchdowns'] = this.touchdowns;
    data['yards_after_catch'] = this.yardsAfterCatch;
    data['longest'] = this.longest;
    data['longest_touchdown'] = this.longestTouchdown;
    data['redzone_targets'] = this.redzoneTargets;
    data['air_yards'] = this.airYards;
    data['broken_tackles'] = this.brokenTackles;
    data['dropped_passes'] = this.droppedPasses;
    data['catchable_passes'] = this.catchablePasses;
    data['yards_after_contact'] = this.yardsAfterContact;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attempts'] = this.attempts;
    data['yards'] = this.yards;
    data['net_yards'] = this.netYards;
    data['blocked'] = this.blocked;
    data['touchbacks'] = this.touchbacks;
    data['inside_20'] = this.inside20;
    data['return_yards'] = this.returnYards;
    data['avg_net_yards'] = this.avgNetYards;
    data['avg_yards'] = this.avgYards;
    data['longest'] = this.longest;
    data['hang_time'] = this.hangTime;
    data['avg_hang_time'] = this.avgHangTime;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avg_yards'] = this.avgYards;
    data['returns'] = this.returns;
    data['yards'] = this.yards;
    data['longest'] = this.longest;
    data['touchdowns'] = this.touchdowns;
    data['longest_touchdown'] = this.longestTouchdown;
    data['faircatches'] = this.faircatches;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['penalties'] = this.penalties;
    data['yards'] = this.yards;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attempts'] = this.attempts;
    data['completions'] = this.completions;
    data['cmp_pct'] = this.cmpPct;
    data['interceptions'] = this.interceptions;
    data['sack_yards'] = this.sackYards;
    data['rating'] = this.rating;
    data['touchdowns'] = this.touchdowns;
    data['avg_yards'] = this.avgYards;
    data['sacks'] = this.sacks;
    data['longest'] = this.longest;
    data['longest_touchdown'] = this.longestTouchdown;
    data['air_yards'] = this.airYards;
    data['redzone_attempts'] = this.redzoneAttempts;
    data['net_yards'] = this.netYards;
    data['yards'] = this.yards;
    data['gross_yards'] = this.grossYards;
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
    data['batted_passes'] = this.battedPasses;
    data['on_target_throws'] = this.onTargetThrows;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['endzone'] = this.endzone;
    data['inside_20'] = this.inside20;
    data['return_yards'] = this.returnYards;
    data['returned'] = this.returned;
    data['touchbacks'] = this.touchbacks;
    data['yards'] = this.yards;
    data['out_of_bounds'] = this.outOfBounds;
    data['kickoffs'] = this.kickoffs;
    data['onside_attempts'] = this.onsideAttempts;
    data['onside_successes'] = this.onsideSuccesses;
    data['squib_kicks'] = this.squibKicks;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['return_yards'] = this.returnYards;
    data['returned'] = this.returned;
    data['interceptions'] = this.interceptions;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avg_yards'] = this.avgYards;
    data['yards'] = this.yards;
    data['longest'] = this.longest;
    data['touchdowns'] = this.touchdowns;
    data['longest_touchdown'] = this.longestTouchdown;
    data['returns'] = this.returns;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pass'] = this.pass;
    data['penalty'] = this.penalty;
    data['rush'] = this.rush;
    data['total'] = this.total;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tackles'] = this.tackles;
    data['assists'] = this.assists;
    data['combined'] = this.combined;
    data['sacks'] = this.sacks;
    data['sack_yards'] = this.sackYards;
    data['interceptions'] = this.interceptions;
    data['passes_defended'] = this.passesDefended;
    data['forced_fumbles'] = this.forcedFumbles;
    data['fumble_recoveries'] = this.fumbleRecoveries;
    data['qb_hits'] = this.qbHits;
    data['tloss'] = this.tloss;
    data['tloss_yards'] = this.tlossYards;
    data['safeties'] = this.safeties;
    data['sp_tackles'] = this.spTackles;
    data['sp_assists'] = this.spAssists;
    data['sp_forced_fumbles'] = this.spForcedFumbles;
    data['sp_fumble_recoveries'] = this.spFumbleRecoveries;
    data['sp_blocks'] = this.spBlocks;
    data['misc_tackles'] = this.miscTackles;
    data['misc_assists'] = this.miscAssists;
    data['misc_forced_fumbles'] = this.miscForcedFumbles;
    data['misc_fumble_recoveries'] = this.miscFumbleRecoveries;
    data['def_targets'] = this.defTargets;
    data['def_comps'] = this.defComps;
    data['blitzes'] = this.blitzes;
    data['hurries'] = this.hurries;
    data['knockdowns'] = this.knockdowns;
    data['missed_tackles'] = this.missedTackles;
    data['batted_passes'] = this.battedPasses;
    data['three_and_outs_forced'] = this.threeAndOutsForced;
    data['fourth_down_stops'] = this.fourthDownStops;
    return data;
  }
}

class ExtraPoints {
  Kicks? kicks;
  Conversions? conversions;

  ExtraPoints({this.kicks, this.conversions});

  ExtraPoints.fromJson(Map<String, dynamic> json) {
    kicks = json['kicks'] != null ? new Kicks.fromJson(json['kicks']) : null;
    conversions = json['conversions'] != null
        ? new Conversions.fromJson(json['conversions'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.kicks != null) {
      data['kicks'] = this.kicks!.toJson();
    }
    if (this.conversions != null) {
      data['conversions'] = this.conversions!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attempts'] = this.attempts;
    data['blocked'] = this.blocked;
    data['made'] = this.made;
    data['pct'] = this.pct;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pass_attempts'] = this.passAttempts;
    data['pass_successes'] = this.passSuccesses;
    data['rush_attempts'] = this.rushAttempts;
    data['rush_successes'] = this.rushSuccesses;
    data['defense_attempts'] = this.defenseAttempts;
    data['defense_successes'] = this.defenseSuccesses;
    data['turnover_successes'] = this.turnoverSuccesses;
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
    goaltogo = json['goaltogo'] != null
        ? new Goaltogo.fromJson(json['goaltogo'])
        : null;
    redzone =
        json['redzone'] != null ? new Redzone.fromJson(json['redzone']) : null;
    thirddown = json['thirddown'] != null
        ? new Redzone.fromJson(json['thirddown'])
        : null;
    fourthdown = json['fourthdown'] != null
        ? new Goaltogo.fromJson(json['fourthdown'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.goaltogo != null) {
      data['goaltogo'] = this.goaltogo!.toJson();
    }
    if (this.redzone != null) {
      data['redzone'] = this.redzone!.toJson();
    }
    if (this.thirddown != null) {
      data['thirddown'] = this.thirddown!.toJson();
    }
    if (this.fourthdown != null) {
      data['fourthdown'] = this.fourthdown!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attempts'] = this.attempts;
    data['successes'] = this.successes;
    data['pct'] = this.pct;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attempts'] = this.attempts;
    data['successes'] = this.successes;
    data['pct'] = this.pct;
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
        ? new Touchdowns.fromJson(json['touchdowns'])
        : null;
    rushing =
        json['rushing'] != null ? new Rushing.fromJson(json['rushing']) : null;
    receiving = json['receiving'] != null
        ? new Receiving.fromJson(json['receiving'])
        : null;
    punts = json['punts'] != null ? new Punts.fromJson(json['punts']) : null;
    puntReturns = json['punt_returns'] != null
        ? new PuntReturns.fromJson(json['punt_returns'])
        : null;
    penalties = json['penalties'] != null
        ? new Penalties.fromJson(json['penalties'])
        : null;
    passing =
        json['passing'] != null ? new Passing.fromJson(json['passing']) : null;
    kickoffs = json['kickoffs'] != null
        ? new Kickoffs.fromJson(json['kickoffs'])
        : null;
    fumbles =
        json['fumbles'] != null ? new Fumbles.fromJson(json['fumbles']) : null;
    firstDowns = json['first_downs'] != null
        ? new FirstDowns.fromJson(json['first_downs'])
        : null;
    fieldGoals = json['field_goals'] != null
        ? new FieldGoals.fromJson(json['field_goals'])
        : null;
    defense =
        json['defense'] != null ? new Defense.fromJson(json['defense']) : null;
    extraPoints = json['extra_points'] != null
        ? new ExtraPoints.fromJson(json['extra_points'])
        : null;
    efficiency = json['efficiency'] != null
        ? new Efficiency.fromJson(json['efficiency'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['games_played'] = this.gamesPlayed;
    if (this.touchdowns != null) {
      data['touchdowns'] = this.touchdowns!.toJson();
    }
    if (this.rushing != null) {
      data['rushing'] = this.rushing!.toJson();
    }
    if (this.receiving != null) {
      data['receiving'] = this.receiving!.toJson();
    }
    if (this.punts != null) {
      data['punts'] = this.punts!.toJson();
    }
    if (this.puntReturns != null) {
      data['punt_returns'] = this.puntReturns!.toJson();
    }
    if (this.penalties != null) {
      data['penalties'] = this.penalties!.toJson();
    }
    if (this.passing != null) {
      data['passing'] = this.passing!.toJson();
    }
    if (this.kickoffs != null) {
      data['kickoffs'] = this.kickoffs!.toJson();
    }
    if (this.fumbles != null) {
      data['fumbles'] = this.fumbles!.toJson();
    }
    if (this.firstDowns != null) {
      data['first_downs'] = this.firstDowns!.toJson();
    }
    if (this.fieldGoals != null) {
      data['field_goals'] = this.fieldGoals!.toJson();
    }
    if (this.defense != null) {
      data['defense'] = this.defense!.toJson();
    }
    if (this.extraPoints != null) {
      data['extra_points'] = this.extraPoints!.toJson();
    }
    if (this.efficiency != null) {
      data['efficiency'] = this.efficiency!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attempts'] = this.attempts;
    data['made'] = this.made;
    data['blocked'] = this.blocked;
    data['yards'] = this.yards;
    data['avg_yards'] = this.avgYards;
    data['longest'] = this.longest;
    data['missed'] = this.missed;
    data['pct'] = this.pct;
    data['attempts_19'] = this.attempts19;
    data['attempts_29'] = this.attempts29;
    data['attempts_39'] = this.attempts39;
    data['attempts_49'] = this.attempts49;
    data['attempts_50'] = this.attempts50;
    data['made_19'] = this.made19;
    data['made_29'] = this.made29;
    data['made_39'] = this.made39;
    data['made_49'] = this.made49;
    data['made_50'] = this.made50;
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
        json['defense'] != null ? new Defense.fromJson(json['defense']) : null;
    receiving = json['receiving'] != null
        ? new Receiving.fromJson(json['receiving'])
        : null;
    intReturns = json['int_returns'] != null
        ? new IntReturns.fromJson(json['int_returns'])
        : null;
    penalties = json['penalties'] != null
        ? new Penalties.fromJson(json['penalties'])
        : null;
    fumbles =
        json['fumbles'] != null ? new Fumbles.fromJson(json['fumbles']) : null;
    rushing =
        json['rushing'] != null ? new Rushing.fromJson(json['rushing']) : null;
    punts = json['punts'] != null ? new Punts.fromJson(json['punts']) : null;
    kickoffs = json['kickoffs'] != null
        ? new Kickoffs.fromJson(json['kickoffs'])
        : null;
    passing =
        json['passing'] != null ? new Passing.fromJson(json['passing']) : null;
    extraPoints = json['extra_points'] != null
        ? new ExtraPoints.fromJson(json['extra_points'])
        : null;
    puntReturns = json['punt_returns'] != null
        ? new PuntReturns.fromJson(json['punt_returns'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['jersey'] = this.jersey;
    data['position'] = this.position;
    data['sr_id'] = this.srId;
    data['games_played'] = this.gamesPlayed;
    data['games_started'] = this.gamesStarted;
    if (this.defense != null) {
      data['defense'] = this.defense!.toJson();
    }
    if (this.receiving != null) {
      data['receiving'] = this.receiving!.toJson();
    }
    if (this.intReturns != null) {
      data['int_returns'] = this.intReturns!.toJson();
    }
    if (this.penalties != null) {
      data['penalties'] = this.penalties!.toJson();
    }
    if (this.fumbles != null) {
      data['fumbles'] = this.fumbles!.toJson();
    }
    if (this.rushing != null) {
      data['rushing'] = this.rushing!.toJson();
    }
    if (this.punts != null) {
      data['punts'] = this.punts!.toJson();
    }
    if (this.kickoffs != null) {
      data['kickoffs'] = this.kickoffs!.toJson();
    }
    if (this.passing != null) {
      data['passing'] = this.passing!.toJson();
    }
    if (this.extraPoints != null) {
      data['extra_points'] = this.extraPoints!.toJson();
    }
    if (this.puntReturns != null) {
      data['punt_returns'] = this.puntReturns!.toJson();
    }
    return data;
  }
}
