class NBAPlayerProfileModel {
  String? id;
  String? status;
  String? fullName;
  String? firstName;
  String? lastName;
  String? abbrName;
  num? height;
  num? weight;
  String? position;
  String? primaryPosition;
  String? jerseyNumber;
  String? experience;
  String? college;
  String? highSchool;
  String? birthPlace;
  String? birthdate;
  String? updated;
  String? srId;
  num? rookieYear;
  String? reference;
  League? league;
  Team? team;
  Draft? draft;
  List<Seasons>? seasons;

  NBAPlayerProfileModel(
      {this.id,
      this.status,
      this.fullName,
      this.firstName,
      this.lastName,
      this.abbrName,
      this.height,
      this.weight,
      this.position,
      this.primaryPosition,
      this.jerseyNumber,
      this.experience,
      this.college,
      this.highSchool,
      this.birthPlace,
      this.birthdate,
      this.updated,
      this.srId,
      this.rookieYear,
      this.reference,
      this.league,
      this.team,
      this.draft,
      this.seasons});

  NBAPlayerProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    fullName = json['full_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    abbrName = json['abbr_name'];
    height = json['height'];
    weight = json['weight'];
    position = json['position'];
    primaryPosition = json['primary_position'];
    jerseyNumber = json['jersey_number'];
    experience = json['experience'];
    college = json['college'];
    highSchool = json['high_school'];
    birthPlace = json['birth_place'];
    birthdate = json['birthdate'];
    updated = json['updated'];
    srId = json['sr_id'];
    rookieYear = json['rookie_year'];
    reference = json['reference'];
    league = json['league'] != null ? League.fromJson(json['league']) : null;
    team = json['team'] != null ? Team.fromJson(json['team']) : null;
    draft = json['draft'] != null ? Draft.fromJson(json['draft']) : null;
    if (json['seasons'] != null) {
      seasons = <Seasons>[];
      json['seasons'].forEach((v) {
        seasons!.add(Seasons.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['full_name'] = fullName;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['abbr_name'] = abbrName;
    data['height'] = height;
    data['weight'] = weight;
    data['position'] = position;
    data['primary_position'] = primaryPosition;
    data['jersey_number'] = jerseyNumber;
    data['experience'] = experience;
    data['college'] = college;
    data['high_school'] = highSchool;
    data['birth_place'] = birthPlace;
    data['birthdate'] = birthdate;
    data['updated'] = updated;
    data['sr_id'] = srId;
    data['rookie_year'] = rookieYear;
    data['reference'] = reference;
    if (league != null) {
      data['league'] = league!.toJson();
    }
    if (team != null) {
      data['team'] = team!.toJson();
    }
    if (draft != null) {
      data['draft'] = draft!.toJson();
    }
    if (seasons != null) {
      data['seasons'] = seasons!.map((v) => v.toJson()).toList();
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

class Team {
  String? id;
  String? name;
  String? market;
  String? alias;
  String? srId;
  String? reference;

  Team(
      {this.id, this.name, this.market, this.alias, this.srId, this.reference});

  Team.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    market = json['market'];
    alias = json['alias'];
    srId = json['sr_id'];
    reference = json['reference'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['market'] = market;
    data['alias'] = alias;
    data['sr_id'] = srId;
    data['reference'] = reference;
    return data;
  }
}

class Draft {
  String? teamId;
  num? year;
  String? round;
  String? pick;

  Draft({this.teamId, this.year, this.round, this.pick});

  Draft.fromJson(Map<String, dynamic> json) {
    teamId = json['team_id'];
    year = json['year'];
    round = json['round'];
    pick = json['pick'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['team_id'] = teamId;
    data['year'] = year;
    data['round'] = round;
    data['pick'] = pick;
    return data;
  }
}

class Seasons {
  String? id;
  num? year;
  String? type;
  List<Teams>? teams;

  Seasons({this.id, this.year, this.type, this.teams});

  Seasons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    year = json['year'];
    type = json['type'];
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
  String? reference;
  Total? total;
  Average? average;

  Teams(
      {this.id,
      this.name,
      this.market,
      this.alias,
      this.srId,
      this.reference,
      this.total,
      this.average});

  Teams.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    market = json['market'];
    alias = json['alias'];
    srId = json['sr_id'];
    reference = json['reference'];
    total = json['total'] != null ? Total.fromJson(json['total']) : null;
    average =
        json['average'] != null ? Average.fromJson(json['average']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['market'] = market;
    data['alias'] = alias;
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

class Total {
  num? gamesPlayed;
  String? playerName;
  num? gamesStarted;
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
  num? flagrantFouls;
  num? ejections;
  num? foulouts;
  num? trueShootingAtt;
  num? trueShootingPct;
  num? efficiency;
  num? pointsOffTurnovers;
  num? pointsInPaint;
  num? pointsInPaintMade;
  num? pointsInPaintAtt;
  num? pointsInPaintPct;
  num? effectiveFgPct;
  num? doubleDoubles;
  num? tripleDoubles;
  num? foulsDrawn;
  num? offensiveFouls;
  num? fastBreakPts;
  num? fastBreakAtt;
  num? fastBreakMade;
  num? fastBreakPct;
  num? coachEjections;
  num? secondChancePct;
  num? secondChancePts;
  num? secondChanceAtt;
  num? secondChanceMade;
  num? minus;
  num? plus;
  num? coachTechFouls;

  Total(
      {this.gamesPlayed,
      this.gamesStarted,
      this.playerName,
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
      this.flagrantFouls,
      this.ejections,
      this.foulouts,
      this.trueShootingAtt,
      this.trueShootingPct,
      this.efficiency,
      this.pointsOffTurnovers,
      this.pointsInPaint,
      this.pointsInPaintMade,
      this.pointsInPaintAtt,
      this.pointsInPaintPct,
      this.effectiveFgPct,
      this.doubleDoubles,
      this.tripleDoubles,
      this.foulsDrawn,
      this.offensiveFouls,
      this.fastBreakPts,
      this.fastBreakAtt,
      this.fastBreakMade,
      this.fastBreakPct,
      this.coachEjections,
      this.secondChancePct,
      this.secondChancePts,
      this.secondChanceAtt,
      this.secondChanceMade,
      this.minus,
      this.plus,
      this.coachTechFouls});

  Total.fromJson(Map<String, dynamic> json) {
    gamesPlayed = json['games_played'];
    gamesStarted = json['games_started'];
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
    flagrantFouls = json['flagrant_fouls'];
    ejections = json['ejections'];
    foulouts = json['foulouts'];
    trueShootingAtt = json['true_shooting_att'];
    trueShootingPct = json['true_shooting_pct'];
    efficiency = json['efficiency'];
    pointsOffTurnovers = json['points_off_turnovers'];
    pointsInPaint = json['points_in_paint'];
    pointsInPaintMade = json['points_in_paint_made'];
    pointsInPaintAtt = json['points_in_paint_att'];
    pointsInPaintPct = json['points_in_paint_pct'];
    effectiveFgPct = json['effective_fg_pct'];
    doubleDoubles = json['double_doubles'];
    tripleDoubles = json['triple_doubles'];
    foulsDrawn = json['fouls_drawn'];
    offensiveFouls = json['offensive_fouls'];
    fastBreakPts = json['fast_break_pts'];
    fastBreakAtt = json['fast_break_att'];
    fastBreakMade = json['fast_break_made'];
    fastBreakPct = json['fast_break_pct'];
    coachEjections = json['coach_ejections'];
    secondChancePct = json['second_chance_pct'];
    secondChancePts = json['second_chance_pts'];
    secondChanceAtt = json['second_chance_att'];
    secondChanceMade = json['second_chance_made'];
    minus = json['minus'];
    plus = json['plus'];
    coachTechFouls = json['coach_tech_fouls'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['games_played'] = gamesPlayed;
    data['games_started'] = gamesStarted;
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
    data['flagrant_fouls'] = flagrantFouls;
    data['ejections'] = ejections;
    data['foulouts'] = foulouts;
    data['true_shooting_att'] = trueShootingAtt;
    data['true_shooting_pct'] = trueShootingPct;
    data['efficiency'] = efficiency;
    data['points_off_turnovers'] = pointsOffTurnovers;
    data['points_in_paint'] = pointsInPaint;
    data['points_in_paint_made'] = pointsInPaintMade;
    data['points_in_paint_att'] = pointsInPaintAtt;
    data['points_in_paint_pct'] = pointsInPaintPct;
    data['effective_fg_pct'] = effectiveFgPct;
    data['double_doubles'] = doubleDoubles;
    data['triple_doubles'] = tripleDoubles;
    data['fouls_drawn'] = foulsDrawn;
    data['offensive_fouls'] = offensiveFouls;
    data['fast_break_pts'] = fastBreakPts;
    data['fast_break_att'] = fastBreakAtt;
    data['fast_break_made'] = fastBreakMade;
    data['fast_break_pct'] = fastBreakPct;
    data['coach_ejections'] = coachEjections;
    data['second_chance_pct'] = secondChancePct;
    data['second_chance_pts'] = secondChancePts;
    data['second_chance_att'] = secondChanceAtt;
    data['second_chance_made'] = secondChanceMade;
    data['minus'] = minus;
    data['plus'] = plus;
    data['coach_tech_fouls'] = coachTechFouls;
    return data;
  }
}

class Average {
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
  num? efficiency;
  num? trueShootingAtt;
  num? pointsOffTurnovers;
  num? pointsInPaintMade;
  num? pointsInPaintAtt;
  num? pointsInPaint;
  num? foulsDrawn;
  num? offensiveFouls;
  num? fastBreakPts;
  num? fastBreakAtt;
  num? fastBreakMade;
  num? secondChancePts;
  num? secondChanceAtt;
  num? secondChanceMade;

  Average(
      {this.minutes,
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
      this.efficiency,
      this.trueShootingAtt,
      this.pointsOffTurnovers,
      this.pointsInPaintMade,
      this.pointsInPaintAtt,
      this.pointsInPaint,
      this.foulsDrawn,
      this.offensiveFouls,
      this.fastBreakPts,
      this.fastBreakAtt,
      this.fastBreakMade,
      this.secondChancePts,
      this.secondChanceAtt,
      this.secondChanceMade});

  Average.fromJson(Map<String, dynamic> json) {
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
    efficiency = json['efficiency'];
    trueShootingAtt = json['true_shooting_att'];
    pointsOffTurnovers = json['points_off_turnovers'];
    pointsInPaintMade = json['points_in_paint_made'];
    pointsInPaintAtt = json['points_in_paint_att'];
    pointsInPaint = json['points_in_paint'];
    foulsDrawn = json['fouls_drawn'];
    offensiveFouls = json['offensive_fouls'];
    fastBreakPts = json['fast_break_pts'];
    fastBreakAtt = json['fast_break_att'];
    fastBreakMade = json['fast_break_made'];
    secondChancePts = json['second_chance_pts'];
    secondChanceAtt = json['second_chance_att'];
    secondChanceMade = json['second_chance_made'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    data['efficiency'] = efficiency;
    data['true_shooting_att'] = trueShootingAtt;
    data['points_off_turnovers'] = pointsOffTurnovers;
    data['points_in_paint_made'] = pointsInPaintMade;
    data['points_in_paint_att'] = pointsInPaintAtt;
    data['points_in_paint'] = pointsInPaint;
    data['fouls_drawn'] = foulsDrawn;
    data['offensive_fouls'] = offensiveFouls;
    data['fast_break_pts'] = fastBreakPts;
    data['fast_break_att'] = fastBreakAtt;
    data['fast_break_made'] = fastBreakMade;
    data['second_chance_pts'] = secondChancePts;
    data['second_chance_att'] = secondChanceAtt;
    data['second_chance_made'] = secondChanceMade;
    return data;
  }
}
