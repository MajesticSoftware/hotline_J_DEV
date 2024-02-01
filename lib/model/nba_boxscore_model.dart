class NBABoxScoreModel {
  String? id;
  String? status;
  String? coverage;
  String? scheduled;
  num? attendance;
  num? leadChanges;
  num? timesTied;
  String? clock;
  num? quarter;
  num? half;
  bool? inseasonTournament;
  bool? trackOnCourt;
  String? reference;
  String? entryMode;
  String? srId;
  String? clockDecimal;
  TimeZones? timeZones;
  Home? home;
  Home? away;

  NBABoxScoreModel(
      {this.id,
      this.status,
      this.coverage,
      this.scheduled,
      this.attendance,
      this.leadChanges,
      this.timesTied,
      this.clock,
      this.quarter,
      this.half,
      this.inseasonTournament,
      this.trackOnCourt,
      this.reference,
      this.entryMode,
      this.srId,
      this.clockDecimal,
      this.timeZones,
      this.home,
      this.away});

  NBABoxScoreModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    coverage = json['coverage'];
    scheduled = json['scheduled'];
    attendance = json['attendance'];
    leadChanges = json['lead_changes'];
    timesTied = json['times_tied'];
    clock = json['clock'];
    quarter = json['quarter'];
    half = json['half'];
    inseasonTournament = json['inseason_tournament'];
    trackOnCourt = json['track_on_court'];
    reference = json['reference'];
    entryMode = json['entry_mode'];
    srId = json['sr_id'];
    clockDecimal = json['clock_decimal'];
    timeZones = json['time_zones'] != null
        ? TimeZones.fromJson(json['time_zones'])
        : null;
    home = json['home'] != null ? Home.fromJson(json['home']) : null;
    away = json['away'] != null ? Home.fromJson(json['away']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['coverage'] = coverage;
    data['scheduled'] = scheduled;
    data['attendance'] = attendance;
    data['lead_changes'] = leadChanges;
    data['times_tied'] = timesTied;
    data['clock'] = clock;
    data['quarter'] = quarter;
    data['half'] = half;
    data['inseason_tournament'] = inseasonTournament;
    data['track_on_court'] = trackOnCourt;
    data['reference'] = reference;
    data['entry_mode'] = entryMode;
    data['sr_id'] = srId;
    data['clock_decimal'] = clockDecimal;
    if (timeZones != null) {
      data['time_zones'] = timeZones!.toJson();
    }
    if (home != null) {
      data['home'] = home!.toJson();
    }
    if (away != null) {
      data['away'] = away!.toJson();
    }
    return data;
  }
}

class TimeZones {
  String? venue;
  String? home;
  String? away;

  TimeZones({this.venue, this.home, this.away});

  TimeZones.fromJson(Map<String, dynamic> json) {
    venue = json['venue'];
    home = json['home'];
    away = json['away'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['venue'] = venue;
    data['home'] = home;
    data['away'] = away;
    return data;
  }
}

class Home {
  String? name;
  String? alias;
  String? market;
  String? id;
  num? points;
  bool? bonus;
  String? srId;
  num? remainingTimeouts;
  String? reference;
  Record? record;
  List<Scoring>? scoring;
  Leaders? leaders;

  Home(
      {this.name,
      this.alias,
      this.market,
      this.id,
      this.points,
      this.bonus,
      this.srId,
      this.remainingTimeouts,
      this.reference,
      this.record,
      this.scoring,
      this.leaders});

  Home.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    alias = json['alias'];
    market = json['market'];
    id = json['id'];
    points = json['points'];
    bonus = json['bonus'];
    srId = json['sr_id'];
    remainingTimeouts = json['remaining_timeouts'];
    reference = json['reference'];
    if (json['scoring'] != null) {
      scoring = <Scoring>[];
      json['scoring'].forEach((v) {
        scoring!.add(Scoring.fromJson(v));
      });
    }
    record = json['record'] != null ? Record.fromJson(json['record']) : null;
    leaders =
        json['leaders'] != null ? Leaders.fromJson(json['leaders']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['alias'] = alias;
    data['market'] = market;
    data['id'] = id;
    data['points'] = points;
    data['bonus'] = bonus;
    data['sr_id'] = srId;
    data['remaining_timeouts'] = remainingTimeouts;
    data['reference'] = reference;
    if (record != null) {
      data['record'] = record!.toJson();
    }
    if (scoring != null) {
      data['scoring'] = scoring!.map((v) => v.toJson()).toList();
    }
    if (leaders != null) {
      data['leaders'] = leaders!.toJson();
    }
    return data;
  }
}

class Record {
  int? wins;
  int? losses;

  Record({this.wins, this.losses});

  Record.fromJson(Map<String, dynamic> json) {
    wins = json['wins'];
    losses = json['losses'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wins'] = wins;
    data['losses'] = losses;
    return data;
  }
}

class Scoring {
  String? type;
  num? number;
  num? sequence;
  num? points;

  Scoring({this.type, this.number, this.sequence, this.points});

  Scoring.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    number = json['number'];
    sequence = json['sequence'];
    points = json['points'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['number'] = number;
    data['sequence'] = sequence;
    data['points'] = points;
    return data;
  }
}

class Leaders {
  List<Points>? points;
  List<Points>? rebounds;
  List<Points>? assists;

  Leaders({this.points, this.rebounds, this.assists});

  Leaders.fromJson(Map<String, dynamic> json) {
    if (json['points'] != null) {
      points = <Points>[];
      json['points'].forEach((v) {
        points!.add(Points.fromJson(v));
      });
    }
    if (json['rebounds'] != null) {
      rebounds = <Points>[];
      json['rebounds'].forEach((v) {
        rebounds!.add(Points.fromJson(v));
      });
    }
    if (json['assists'] != null) {
      assists = <Points>[];
      json['assists'].forEach((v) {
        assists!.add(Points.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (points != null) {
      data['points'] = points!.map((v) => v.toJson()).toList();
    }
    if (rebounds != null) {
      data['rebounds'] = rebounds!.map((v) => v.toJson()).toList();
    }
    if (assists != null) {
      data['assists'] = assists!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Points {
  String? fullName;
  String? jerseyNumber;
  String? id;
  String? position;
  String? primaryPosition;
  String? srId;
  String? reference;
  Statistics? statistics;

  Points(
      {this.fullName,
      this.jerseyNumber,
      this.id,
      this.position,
      this.primaryPosition,
      this.srId,
      this.reference,
      this.statistics});

  Points.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    jerseyNumber = json['jersey_number'];
    id = json['id'];
    position = json['position'];
    primaryPosition = json['primary_position'];
    srId = json['sr_id'];
    reference = json['reference'];
    statistics = json['statistics'] != null
        ? Statistics.fromJson(json['statistics'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['full_name'] = fullName;
    data['jersey_number'] = jerseyNumber;
    data['id'] = id;
    data['position'] = position;
    data['primary_position'] = primaryPosition;
    data['sr_id'] = srId;
    data['reference'] = reference;
    if (statistics != null) {
      data['statistics'] = statistics!.toJson();
    }
    return data;
  }
}

class Statistics {
  String? minutes;
  num? fieldGoalsMade;
  num? fieldGoalsAtt;
  num? fieldGoalsPct;
  num? threePointsMade;
  num? threePointsAtt;
  num? threePointsPct;
  num? twoPointsMade;
  num? twoPointsAtt;
  num? twoPointsPct;
  num? blockedAtt;
  num? freeThrowsMade;
  num? freeThrowsAtt;
  num? freeThrowsPct;
  num? offensiveRebounds;
  num? defensiveRebounds;
  num? rebounds;
  num? assists;
  num? turnovers;
  num? steals;
  num? blocks;
  num? assistsTurnoverRatio;
  num? personalFouls;
  num? techFouls;
  num? flagrantFouls;
  num? plsMin;
  num? points;
  bool? doubleDouble;
  bool? tripleDouble;
  num? effectiveFgPct;
  num? efficiency;
  num? efficiencyGameScore;
  num? pointsInPaint;
  num? pointsInPaintAtt;
  num? pointsInPaintMade;
  num? pointsInPaintPct;
  num? trueShootingAtt;
  num? trueShootingPct;
  num? foulsDrawn;
  num? offensiveFouls;
  num? pointsOffTurnovers;
  num? secondChancePts;

  Statistics(
      {this.minutes,
      this.fieldGoalsMade,
      this.fieldGoalsAtt,
      this.fieldGoalsPct,
      this.threePointsMade,
      this.threePointsAtt,
      this.threePointsPct,
      this.twoPointsMade,
      this.twoPointsAtt,
      this.twoPointsPct,
      this.blockedAtt,
      this.freeThrowsMade,
      this.freeThrowsAtt,
      this.freeThrowsPct,
      this.offensiveRebounds,
      this.defensiveRebounds,
      this.rebounds,
      this.assists,
      this.turnovers,
      this.steals,
      this.blocks,
      this.assistsTurnoverRatio,
      this.personalFouls,
      this.techFouls,
      this.flagrantFouls,
      this.plsMin,
      this.points,
      this.doubleDouble,
      this.tripleDouble,
      this.effectiveFgPct,
      this.efficiency,
      this.efficiencyGameScore,
      this.pointsInPaint,
      this.pointsInPaintAtt,
      this.pointsInPaintMade,
      this.pointsInPaintPct,
      this.trueShootingAtt,
      this.trueShootingPct,
      this.foulsDrawn,
      this.offensiveFouls,
      this.pointsOffTurnovers,
      this.secondChancePts});

  Statistics.fromJson(Map<String, dynamic> json) {
    minutes = json['minutes'];
    fieldGoalsMade = json['field_goals_made'];
    fieldGoalsAtt = json['field_goals_att'];
    fieldGoalsPct = json['field_goals_pct'];
    threePointsMade = json['three_points_made'];
    threePointsAtt = json['three_points_att'];
    threePointsPct = json['three_points_pct'];
    twoPointsMade = json['two_points_made'];
    twoPointsAtt = json['two_points_att'];
    twoPointsPct = json['two_points_pct'];
    blockedAtt = json['blocked_att'];
    freeThrowsMade = json['free_throws_made'];
    freeThrowsAtt = json['free_throws_att'];
    freeThrowsPct = json['free_throws_pct'];
    offensiveRebounds = json['offensive_rebounds'];
    defensiveRebounds = json['defensive_rebounds'];
    rebounds = json['rebounds'];
    assists = json['assists'];
    turnovers = json['turnovers'];
    steals = json['steals'];
    blocks = json['blocks'];
    assistsTurnoverRatio = json['assists_turnover_ratio'];
    personalFouls = json['personal_fouls'];
    techFouls = json['tech_fouls'];
    flagrantFouls = json['flagrant_fouls'];
    plsMin = json['pls_min'];
    points = json['points'];
    doubleDouble = json['double_double'];
    tripleDouble = json['triple_double'];
    effectiveFgPct = json['effective_fg_pct'];
    efficiency = json['efficiency'];
    efficiencyGameScore = json['efficiency_game_score'];
    pointsInPaint = json['points_in_paint'];
    pointsInPaintAtt = json['points_in_paint_att'];
    pointsInPaintMade = json['points_in_paint_made'];
    pointsInPaintPct = json['points_in_paint_pct'];
    trueShootingAtt = json['true_shooting_att'];
    trueShootingPct = json['true_shooting_pct'];
    foulsDrawn = json['fouls_drawn'];
    offensiveFouls = json['offensive_fouls'];
    pointsOffTurnovers = json['points_off_turnovers'];
    secondChancePts = json['second_chance_pts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['minutes'] = minutes;
    data['field_goals_made'] = fieldGoalsMade;
    data['field_goals_att'] = fieldGoalsAtt;
    data['field_goals_pct'] = fieldGoalsPct;
    data['three_points_made'] = threePointsMade;
    data['three_points_att'] = threePointsAtt;
    data['three_points_pct'] = threePointsPct;
    data['two_points_made'] = twoPointsMade;
    data['two_points_att'] = twoPointsAtt;
    data['two_points_pct'] = twoPointsPct;
    data['blocked_att'] = blockedAtt;
    data['free_throws_made'] = freeThrowsMade;
    data['free_throws_att'] = freeThrowsAtt;
    data['free_throws_pct'] = freeThrowsPct;
    data['offensive_rebounds'] = offensiveRebounds;
    data['defensive_rebounds'] = defensiveRebounds;
    data['rebounds'] = rebounds;
    data['assists'] = assists;
    data['turnovers'] = turnovers;
    data['steals'] = steals;
    data['blocks'] = blocks;
    data['assists_turnover_ratio'] = assistsTurnoverRatio;
    data['personal_fouls'] = personalFouls;
    data['tech_fouls'] = techFouls;
    data['flagrant_fouls'] = flagrantFouls;
    data['pls_min'] = plsMin;
    data['points'] = points;
    data['double_double'] = doubleDouble;
    data['triple_double'] = tripleDouble;
    data['effective_fg_pct'] = effectiveFgPct;
    data['efficiency'] = efficiency;
    data['efficiency_game_score'] = efficiencyGameScore;
    data['points_in_paint'] = pointsInPaint;
    data['points_in_paint_att'] = pointsInPaintAtt;
    data['points_in_paint_made'] = pointsInPaintMade;
    data['points_in_paint_pct'] = pointsInPaintPct;
    data['true_shooting_att'] = trueShootingAtt;
    data['true_shooting_pct'] = trueShootingPct;
    data['fouls_drawn'] = foulsDrawn;
    data['offensive_fouls'] = offensiveFouls;
    data['points_off_turnovers'] = pointsOffTurnovers;
    data['second_chance_pts'] = secondChancePts;
    return data;
  }
}
