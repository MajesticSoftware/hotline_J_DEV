class NFLStaticsModel {
  Season? season;

  NFLStaticsModel({this.season});

  NFLStaticsModel.fromJson(Map<String, dynamic> json) {
    season = json['season'] != null ? Season.fromJson(json['season']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (season != null) {
      data['season'] = season!.toJson();
    }
    return data;
  }
}

class Season {
  Team? team;

  Season({this.team});

  Season.fromJson(Map<String, dynamic> json) {
    team = json['team'] != null ? Team.fromJson(json['team']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (team != null) {
      data['team'] = team!.toJson();
    }
    return data;
  }
}

class Team {
  TeamRecords? teamRecords;
  PlayerRecords? playerRecords;

  Team({this.teamRecords, this.playerRecords});

  Team.fromJson(Map<String, dynamic> json) {
    teamRecords = json['team_records'] != null
        ? TeamRecords.fromJson(json['team_records'])
        : null;
    playerRecords = json['player_records'] != null
        ? PlayerRecords.fromJson(json['player_records'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (teamRecords != null) {
      data['team_records'] = teamRecords!.toJson();
    }
    if (playerRecords != null) {
      data['player_records'] = playerRecords!.toJson();
    }
    return data;
  }
}

class TeamRecords {
  Record? record;
  Record? opponents;

  TeamRecords({this.record, this.opponents});

  TeamRecords.fromJson(Map<String, dynamic> json) {
    record = json['record'] != null ? Record.fromJson(json['record']) : null;
    opponents =
        json['opponents'] != null ? Record.fromJson(json['opponents']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (record != null) {
      data['record'] = record!.toJson();
    }
    if (opponents != null) {
      data['opponents'] = opponents!.toJson();
    }
    return data;
  }
}

class Record {
  String? touchdowns;
  String? rushing;
  String? receiving;
  String? punts;
  String? puntReturns;
  String? penalties;
  String? passing;
  String? kickoffs;
  String? kickReturns;
  String? interceptions;
  String? intReturns;
  String? fumbles;
  String? firstDowns;
  String? fieldGoals;
  ExtraPoints? extraPoints;
  Efficiency? efficiency;
  String? defense;

  Record(
      {this.touchdowns,
      this.rushing,
      this.receiving,
      this.punts,
      this.puntReturns,
      this.penalties,
      this.passing,
      this.kickoffs,
      this.kickReturns,
      this.interceptions,
      this.intReturns,
      this.fumbles,
      this.firstDowns,
      this.fieldGoals,
      this.extraPoints,
      this.efficiency,
      this.defense});

  Record.fromJson(Map<String, dynamic> json) {
    touchdowns = json['touchdowns'];
    rushing = json['rushing'];
    receiving = json['receiving'];
    punts = json['punts'];
    puntReturns = json['punt_returns'];
    penalties = json['penalties'];
    passing = json['passing'];
    kickoffs = json['kickoffs'];
    kickReturns = json['kick_returns'];
    interceptions = json['interceptions'];
    intReturns = json['int_returns'];
    fumbles = json['fumbles'];
    firstDowns = json['first_downs'];
    fieldGoals = json['field_goals'];
    extraPoints = json['extra_points'] != null
        ? ExtraPoints.fromJson(json['extra_points'])
        : null;
    efficiency = json['efficiency'] != null
        ? Efficiency.fromJson(json['efficiency'])
        : null;
    defense = json['defense'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['touchdowns'] = touchdowns;
    data['rushing'] = rushing;
    data['receiving'] = receiving;
    data['punts'] = punts;
    data['punt_returns'] = puntReturns;
    data['penalties'] = penalties;
    data['passing'] = passing;
    data['kickoffs'] = kickoffs;
    data['kick_returns'] = kickReturns;
    data['interceptions'] = interceptions;
    data['int_returns'] = intReturns;
    data['fumbles'] = fumbles;
    data['first_downs'] = firstDowns;
    data['field_goals'] = fieldGoals;
    if (extraPoints != null) {
      data['extra_points'] = extraPoints!.toJson();
    }
    if (efficiency != null) {
      data['efficiency'] = efficiency!.toJson();
    }
    data['defense'] = defense;
    return data;
  }
}

class ExtraPoints {
  String? kicks;
  String? conversions;

  ExtraPoints({this.kicks, this.conversions});

  ExtraPoints.fromJson(Map<String, dynamic> json) {
    kicks = json['kicks'];
    conversions = json['conversions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kicks'] = kicks;
    data['conversions'] = conversions;
    return data;
  }
}

class Efficiency {
  String? goaltogo;
  String? redzone;
  String? thirddown;
  String? fourthdown;

  Efficiency({this.goaltogo, this.redzone, this.thirddown, this.fourthdown});

  Efficiency.fromJson(Map<String, dynamic> json) {
    goaltogo = json['goaltogo'];
    redzone = json['redzone'];
    thirddown = json['thirddown'];
    fourthdown = json['fourthdown'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['goaltogo'] = goaltogo;
    data['redzone'] = redzone;
    data['thirddown'] = thirddown;
    data['fourthdown'] = fourthdown;
    return data;
  }
}

class PlayerRecords {
  List<String>? player;

  PlayerRecords({this.player});

  PlayerRecords.fromJson(Map<String, dynamic> json) {
    player = json['player'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['player'] = player;
    return data;
  }
}
