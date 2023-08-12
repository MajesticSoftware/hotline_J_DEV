class NFLStaticsModel {
  Season? season;

  NFLStaticsModel({this.season});

  NFLStaticsModel.fromJson(Map<String, dynamic> json) {
    season =
        json['season'] != null ? new Season.fromJson(json['season']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.season != null) {
      data['season'] = this.season!.toJson();
    }
    return data;
  }
}

class Season {
  Team? team;

  Season({this.team});

  Season.fromJson(Map<String, dynamic> json) {
    team = json['team'] != null ? new Team.fromJson(json['team']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.team != null) {
      data['team'] = this.team!.toJson();
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
        ? new TeamRecords.fromJson(json['team_records'])
        : null;
    playerRecords = json['player_records'] != null
        ? new PlayerRecords.fromJson(json['player_records'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.teamRecords != null) {
      data['team_records'] = this.teamRecords!.toJson();
    }
    if (this.playerRecords != null) {
      data['player_records'] = this.playerRecords!.toJson();
    }
    return data;
  }
}

class TeamRecords {
  Record? record;
  Record? opponents;

  TeamRecords({this.record, this.opponents});

  TeamRecords.fromJson(Map<String, dynamic> json) {
    record =
        json['record'] != null ? new Record.fromJson(json['record']) : null;
    opponents = json['opponents'] != null
        ? new Record.fromJson(json['opponents'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.record != null) {
      data['record'] = this.record!.toJson();
    }
    if (this.opponents != null) {
      data['opponents'] = this.opponents!.toJson();
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
        ? new ExtraPoints.fromJson(json['extra_points'])
        : null;
    efficiency = json['efficiency'] != null
        ? new Efficiency.fromJson(json['efficiency'])
        : null;
    defense = json['defense'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['touchdowns'] = this.touchdowns;
    data['rushing'] = this.rushing;
    data['receiving'] = this.receiving;
    data['punts'] = this.punts;
    data['punt_returns'] = this.puntReturns;
    data['penalties'] = this.penalties;
    data['passing'] = this.passing;
    data['kickoffs'] = this.kickoffs;
    data['kick_returns'] = this.kickReturns;
    data['interceptions'] = this.interceptions;
    data['int_returns'] = this.intReturns;
    data['fumbles'] = this.fumbles;
    data['first_downs'] = this.firstDowns;
    data['field_goals'] = this.fieldGoals;
    if (this.extraPoints != null) {
      data['extra_points'] = this.extraPoints!.toJson();
    }
    if (this.efficiency != null) {
      data['efficiency'] = this.efficiency!.toJson();
    }
    data['defense'] = this.defense;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kicks'] = this.kicks;
    data['conversions'] = this.conversions;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goaltogo'] = this.goaltogo;
    data['redzone'] = this.redzone;
    data['thirddown'] = this.thirddown;
    data['fourthdown'] = this.fourthdown;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['player'] = this.player;
    return data;
  }
}
