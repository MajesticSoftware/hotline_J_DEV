class NBAStaticsModel {
  String? id;
  String? name;
  String? market;
  String? srId;
  String? reference;
  Season? season;
  OwnRecord? ownRecord;
  OwnRecord? opponents;
  List<Players>? players;

  NBAStaticsModel(
      {this.id,
      this.name,
      this.market,
      this.srId,
      this.reference,
      this.season,
      this.ownRecord,
      this.opponents,
      this.players});

  NBAStaticsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    market = json['market'];
    srId = json['sr_id'];
    reference = json['reference'];
    season = json['season'] != null ? Season.fromJson(json['season']) : null;
    ownRecord = json['own_record'] != null
        ? OwnRecord.fromJson(json['own_record'])
        : null;
    opponents = json['opponents'] != null
        ? OwnRecord.fromJson(json['opponents'])
        : null;
    if (json['players'] != null) {
      players = <Players>[];
      json['players'].forEach((v) {
        players!.add(Players.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['market'] = market;
    data['sr_id'] = srId;
    data['reference'] = reference;
    if (season != null) {
      data['season'] = season!.toJson();
    }
    if (ownRecord != null) {
      data['own_record'] = ownRecord!.toJson();
    }
    if (opponents != null) {
      data['opponents'] = opponents!.toJson();
    }
    if (players != null) {
      data['players'] = players!.map((v) => v.toJson()).toList();
    }
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

class OwnRecord {
  Total? total;
  Average? average;

  OwnRecord({this.total, this.average});

  OwnRecord.fromJson(Map<String, dynamic> json) {
    total = json['total'] != null ? Total.fromJson(json['total']) : null;
    average =
        json['average'] != null ? Average.fromJson(json['average']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (total != null) {
      data['total'] = total!.toJson();
    }
    if (average != null) {
      data['average'] = average!.toJson();
    }
    return data;
  }
}

class Total {
  num? gamesPlayed;
  num? minutes;
  num? fieldGoalsMade;
  num? fieldGoalsAtt;
  num? fieldGoalsPct;
  num? twoPointsMade;
  num? twoPointsAtt;
  num? twoPointsPct;
  num? threePointsMade;
  num? threePointsAtt;
  num? threePointsPct;
  num? blockedAtt;
  num? freeThrowsMade;
  num? freeThrowsAtt;
  num? freeThrowsPct;
  num? offensiveRebounds;
  num? defensiveRebounds;
  num? rebounds;
  num? assists;
  num? turnovers;
  num? assistsTurnoverRatio;
  num? steals;
  num? blocks;
  num? personalFouls;
  num? techFouls;
  num? points;
  num? fastBreakPts;
  num? flagrantFouls;
  num? pointsOffTurnovers;
  num? secondChancePts;
  num? ejections;
  num? foulouts;
  num? efficiency;
  num? pointsInPaint;
  num? teamOffensiveRebounds;
  num? teamDefensiveRebounds;
  num? teamRebounds;
  num? teamTurnovers;
  num? totalRebounds;
  num? totalTurnovers;
  num? trueShootingAtt;
  num? trueShootingPct;
  num? pointsInPaintMade;
  num? pointsInPaintAtt;
  num? pointsInPaintPct;
  num? effectiveFgPct;
  num? benchPoints;
  num? foulsDrawn;
  num? offensiveFouls;
  num? teamTechFouls;
  num? defensiveAssists;
  num? fastBreakAtt;
  num? fastBreakMade;
  num? fastBreakPct;
  num? technicalOther;
  num? coachEjections;
  num? pointsAgainst;
  num? secondChanceAtt;
  num? secondChanceMade;
  num? secondChancePct;
  num? coachTechFouls;
  num? teamFouls;
  num? totalFouls;
  num? minus;
  num? plus;

  Total(
      {this.gamesPlayed,
      this.minutes,
      this.fieldGoalsMade,
      this.fieldGoalsAtt,
      this.fieldGoalsPct,
      this.twoPointsMade,
      this.twoPointsAtt,
      this.twoPointsPct,
      this.threePointsMade,
      this.threePointsAtt,
      this.threePointsPct,
      this.blockedAtt,
      this.freeThrowsMade,
      this.freeThrowsAtt,
      this.freeThrowsPct,
      this.offensiveRebounds,
      this.defensiveRebounds,
      this.rebounds,
      this.assists,
      this.turnovers,
      this.assistsTurnoverRatio,
      this.steals,
      this.blocks,
      this.personalFouls,
      this.techFouls,
      this.points,
      this.fastBreakPts,
      this.flagrantFouls,
      this.pointsOffTurnovers,
      this.secondChancePts,
      this.ejections,
      this.foulouts,
      this.efficiency,
      this.pointsInPaint,
      this.teamOffensiveRebounds,
      this.teamDefensiveRebounds,
      this.teamRebounds,
      this.teamTurnovers,
      this.totalRebounds,
      this.totalTurnovers,
      this.trueShootingAtt,
      this.trueShootingPct,
      this.pointsInPaintMade,
      this.pointsInPaintAtt,
      this.pointsInPaintPct,
      this.effectiveFgPct,
      this.benchPoints,
      this.foulsDrawn,
      this.offensiveFouls,
      this.teamTechFouls,
      this.defensiveAssists,
      this.fastBreakAtt,
      this.fastBreakMade,
      this.fastBreakPct,
      this.technicalOther,
      this.coachEjections,
      this.pointsAgainst,
      this.secondChanceAtt,
      this.secondChanceMade,
      this.secondChancePct,
      this.coachTechFouls,
      this.teamFouls,
      this.minus,
      this.plus,
      this.totalFouls});

  Total.fromJson(Map<String, dynamic> json) {
    gamesPlayed = json['games_played'];
    minutes = json['minutes'];
    fieldGoalsMade = json['field_goals_made'];
    fieldGoalsAtt = json['field_goals_att'];
    fieldGoalsPct = json['field_goals_pct'];
    twoPointsMade = json['two_points_made'];
    twoPointsAtt = json['two_points_att'];
    twoPointsPct = json['two_points_pct'];
    threePointsMade = json['three_points_made'];
    threePointsAtt = json['three_points_att'];
    threePointsPct = json['three_points_pct'];
    blockedAtt = json['blocked_att'];
    freeThrowsMade = json['free_throws_made'];
    freeThrowsAtt = json['free_throws_att'];
    freeThrowsPct = json['free_throws_pct'];
    offensiveRebounds = json['offensive_rebounds'];
    defensiveRebounds = json['defensive_rebounds'];
    rebounds = json['rebounds'];
    assists = json['assists'];
    turnovers = json['turnovers'];
    assistsTurnoverRatio = json['assists_turnover_ratio'];
    steals = json['steals'];
    blocks = json['blocks'];
    personalFouls = json['personal_fouls'];
    techFouls = json['tech_fouls'];
    points = json['points'];
    fastBreakPts = json['fast_break_pts'];
    flagrantFouls = json['flagrant_fouls'];
    pointsOffTurnovers = json['points_off_turnovers'];
    secondChancePts = json['second_chance_pts'];
    ejections = json['ejections'];
    foulouts = json['foulouts'];
    efficiency = json['efficiency'];
    pointsInPaint = json['points_in_paint'];
    teamOffensiveRebounds = json['team_offensive_rebounds'];
    teamDefensiveRebounds = json['team_defensive_rebounds'];
    teamRebounds = json['team_rebounds'];
    teamTurnovers = json['team_turnovers'];
    totalRebounds = json['total_rebounds'];
    totalTurnovers = json['total_turnovers'];
    trueShootingAtt = json['true_shooting_att'];
    trueShootingPct = json['true_shooting_pct'];
    pointsInPaintMade = json['points_in_paint_made'];
    pointsInPaintAtt = json['points_in_paint_att'];
    pointsInPaintPct = json['points_in_paint_pct'];
    effectiveFgPct = json['effective_fg_pct'];
    benchPoints = json['bench_points'];
    foulsDrawn = json['fouls_drawn'];
    offensiveFouls = json['offensive_fouls'];
    teamTechFouls = json['team_tech_fouls'];
    defensiveAssists = json['defensive_assists'];
    fastBreakAtt = json['fast_break_att'];
    fastBreakMade = json['fast_break_made'];
    fastBreakPct = json['fast_break_pct'];
    technicalOther = json['technical_other'];
    coachEjections = json['coach_ejections'];
    pointsAgainst = json['points_against'];
    secondChanceAtt = json['second_chance_att'];
    secondChanceMade = json['second_chance_made'];
    secondChancePct = json['second_chance_pct'];
    coachTechFouls = json['coach_tech_fouls'];
    teamFouls = json['team_fouls'];
    totalFouls = json['total_fouls'];
   minus = json['minus'];
   plus = json ['plus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['games_played'] = gamesPlayed;
    data['minutes'] = minutes;
    data['field_goals_made'] = fieldGoalsMade;
    data['field_goals_att'] = fieldGoalsAtt;
    data['field_goals_pct'] = fieldGoalsPct;
    data['two_points_made'] = twoPointsMade;
    data['two_points_att'] = twoPointsAtt;
    data['two_points_pct'] = twoPointsPct;
    data['three_points_made'] = threePointsMade;
    data['three_points_att'] = threePointsAtt;
    data['three_points_pct'] = threePointsPct;
    data['blocked_att'] = blockedAtt;
    data['free_throws_made'] = freeThrowsMade;
    data['free_throws_att'] = freeThrowsAtt;
    data['free_throws_pct'] = freeThrowsPct;
    data['offensive_rebounds'] = offensiveRebounds;
    data['defensive_rebounds'] = defensiveRebounds;
    data['rebounds'] = rebounds;
    data['assists'] = assists;
    data['turnovers'] = turnovers;
    data['assists_turnover_ratio'] = assistsTurnoverRatio;
    data['steals'] = steals;
    data['blocks'] = blocks;
    data['personal_fouls'] = personalFouls;
    data['tech_fouls'] = techFouls;
    data['points'] = points;
    data['fast_break_pts'] = fastBreakPts;
    data['flagrant_fouls'] = flagrantFouls;
    data['points_off_turnovers'] = pointsOffTurnovers;
    data['second_chance_pts'] = secondChancePts;
    data['ejections'] = ejections;
    data['foulouts'] = foulouts;
    data['efficiency'] = efficiency;
    data['points_in_paint'] = pointsInPaint;
    data['team_offensive_rebounds'] = teamOffensiveRebounds;
    data['team_defensive_rebounds'] = teamDefensiveRebounds;
    data['team_rebounds'] = teamRebounds;
    data['team_turnovers'] = teamTurnovers;
    data['total_rebounds'] = totalRebounds;
    data['total_turnovers'] = totalTurnovers;
    data['true_shooting_att'] = trueShootingAtt;
    data['true_shooting_pct'] = trueShootingPct;
    data['points_in_paint_made'] = pointsInPaintMade;
    data['points_in_paint_att'] = pointsInPaintAtt;
    data['points_in_paint_pct'] = pointsInPaintPct;
    data['effective_fg_pct'] = effectiveFgPct;
    data['bench_points'] = benchPoints;
    data['fouls_drawn'] = foulsDrawn;
    data['offensive_fouls'] = offensiveFouls;
    data['team_tech_fouls'] = teamTechFouls;
    data['defensive_assists'] = defensiveAssists;
    data['fast_break_att'] = fastBreakAtt;
    data['fast_break_made'] = fastBreakMade;
    data['fast_break_pct'] = fastBreakPct;
    data['technical_other'] = technicalOther;
    data['coach_ejections'] = coachEjections;
    data['points_against'] = pointsAgainst;
    data['second_chance_att'] = secondChanceAtt;
    data['second_chance_made'] = secondChanceMade;
    data['second_chance_pct'] = secondChancePct;
    data['coach_tech_fouls'] = coachTechFouls;
    data['team_fouls'] = teamFouls;
    data['total_fouls'] = totalFouls;
    data['minus'] = minus;
    data['plus'] =  plus;
    return data;
  }
}

class Average {
  num? fastBreakPts;
  num? pointsOffTurnovers;
  num? secondChancePts;
  num? minutes;
  num? points;
  num? offRebounds;
  num? defRebounds;
  num? rebounds;
  num? assists;
  num? steals;
  num? blocks;
  num? turnovers;
  num? personalFouls;
  num? flagrantFouls;
  num? blockedAtt;
  num? fieldGoalsMade;
  num? fieldGoalsAtt;
  num? threePointsMade;
  num? threePointsAtt;
  num? freeThrowsMade;
  num? freeThrowsAtt;
  num? twoPointsMade;
  num? twoPointsAtt;
  num? pointsInPaint;
  num? efficiency;
  num? trueShootingAtt;
  num? pointsInPaintAtt;
  num? pointsInPaintMade;
  num? benchPoints;
  num? foulsDrawn;
  num? offensiveFouls;
  num? fastBreakAtt;
  num? fastBreakMade;
  num? secondChanceAtt;
  num? secondChanceMade;

  Average(
      {this.fastBreakPts,
      this.pointsOffTurnovers,
      this.secondChancePts,
      this.minutes,
      this.points,
      this.offRebounds,
      this.defRebounds,
      this.rebounds,
      this.assists,
      this.steals,
      this.blocks,
      this.turnovers,
      this.personalFouls,
      this.flagrantFouls,
      this.blockedAtt,
      this.fieldGoalsMade,
      this.fieldGoalsAtt,
      this.threePointsMade,
      this.threePointsAtt,
      this.freeThrowsMade,
      this.freeThrowsAtt,
      this.twoPointsMade,
      this.twoPointsAtt,
      this.pointsInPaint,
      this.efficiency,
      this.trueShootingAtt,
      this.pointsInPaintAtt,
      this.pointsInPaintMade,
      this.benchPoints,
      this.foulsDrawn,
      this.offensiveFouls,
      this.fastBreakAtt,
      this.fastBreakMade,
      this.secondChanceAtt,
      this.secondChanceMade});

  Average.fromJson(Map<String, dynamic> json) {
    fastBreakPts = json['fast_break_pts'];
    pointsOffTurnovers = json['points_off_turnovers'];
    secondChancePts = json['second_chance_pts'];
    minutes = json['minutes'];
    points = json['points'];
    offRebounds = json['off_rebounds'];
    defRebounds = json['def_rebounds'];
    rebounds = json['rebounds'];
    assists = json['assists'];
    steals = json['steals'];
    blocks = json['blocks'];
    turnovers = json['turnovers'];
    personalFouls = json['personal_fouls'];
    flagrantFouls = json['flagrant_fouls'];
    blockedAtt = json['blocked_att'];
    fieldGoalsMade = json['field_goals_made'];
    fieldGoalsAtt = json['field_goals_att'];
    threePointsMade = json['three_points_made'];
    threePointsAtt = json['three_points_att'];
    freeThrowsMade = json['free_throws_made'];
    freeThrowsAtt = json['free_throws_att'];
    twoPointsMade = json['two_points_made'];
    twoPointsAtt = json['two_points_att'];
    pointsInPaint = json['points_in_paint'];
    efficiency = json['efficiency'];
    trueShootingAtt = json['true_shooting_att'];
    pointsInPaintAtt = json['points_in_paint_att'];
    pointsInPaintMade = json['points_in_paint_made'];
    benchPoints = json['bench_points'];
    foulsDrawn = json['fouls_drawn'];
    offensiveFouls = json['offensive_fouls'];
    fastBreakAtt = json['fast_break_att'];
    fastBreakMade = json['fast_break_made'];
    secondChanceAtt = json['second_chance_att'];
    secondChanceMade = json['second_chance_made'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fast_break_pts'] = fastBreakPts;
    data['points_off_turnovers'] = pointsOffTurnovers;
    data['second_chance_pts'] = secondChancePts;
    data['minutes'] = minutes;
    data['points'] = points;
    data['off_rebounds'] = offRebounds;
    data['def_rebounds'] = defRebounds;
    data['rebounds'] = rebounds;
    data['assists'] = assists;
    data['steals'] = steals;
    data['blocks'] = blocks;
    data['turnovers'] = turnovers;
    data['personal_fouls'] = personalFouls;
    data['flagrant_fouls'] = flagrantFouls;
    data['blocked_att'] = blockedAtt;
    data['field_goals_made'] = fieldGoalsMade;
    data['field_goals_att'] = fieldGoalsAtt;
    data['three_points_made'] = threePointsMade;
    data['three_points_att'] = threePointsAtt;
    data['free_throws_made'] = freeThrowsMade;
    data['free_throws_att'] = freeThrowsAtt;
    data['two_points_made'] = twoPointsMade;
    data['two_points_att'] = twoPointsAtt;
    data['points_in_paint'] = pointsInPaint;
    data['efficiency'] = efficiency;
    data['true_shooting_att'] = trueShootingAtt;
    data['points_in_paint_att'] = pointsInPaintAtt;
    data['points_in_paint_made'] = pointsInPaintMade;
    data['bench_points'] = benchPoints;
    data['fouls_drawn'] = foulsDrawn;
    data['offensive_fouls'] = offensiveFouls;
    data['fast_break_att'] = fastBreakAtt;
    data['fast_break_made'] = fastBreakMade;
    data['second_chance_att'] = secondChanceAtt;
    data['second_chance_made'] = secondChanceMade;
    return data;
  }
}

class Players {
  String? id;
  String? fullName;
  String? firstName;
  String? lastName;
  String? position;
  String? primaryPosition;
  String? jerseyNumber;
  String? srId;
  String? reference;
  Total? total;
  Average? average;

  Players(
      {this.id,
      this.fullName,
      this.firstName,
      this.lastName,
      this.position,
      this.primaryPosition,
      this.jerseyNumber,
      this.srId,
      this.reference,
      this.total,
      this.average});

  Players.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    position = json['position'];
    primaryPosition = json['primary_position'];
    jerseyNumber = json['jersey_number'];
    srId = json['sr_id'];
    reference = json['reference'];
    total = json['total'] != null ? Total.fromJson(json['total']) : null;
    average =
        json['average'] != null ? Average.fromJson(json['average']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = fullName;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['position'] = position;
    data['primary_position'] = primaryPosition;
    data['jersey_number'] = jerseyNumber;
    data['sr_id'] = srId;
    data['reference'] = reference;
    if (total != null) {
      data['total'] = total!.toJson();
    }
    if (average != null) {
      data['average'] = average!.toJson();
    }
    return data;
  }
}
