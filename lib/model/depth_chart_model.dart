class DepthChartModel {
  Season? season;
  Week? week;
  List<Teams>? teams;
  String? sComment;

  DepthChartModel({this.season, this.week, this.teams, this.sComment});

  DepthChartModel.fromJson(Map<String, dynamic> json) {
    season = json['season'] != null ? Season.fromJson(json['season']) : null;
    week = json['week'] != null ? Week.fromJson(json['week']) : null;
    if (json['teams'] != null) {
      teams = <Teams>[];
      json['teams'].forEach((v) {
        teams!.add(Teams.fromJson(v));
      });
    }
    sComment = json['_comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (season != null) {
      data['season'] = season!.toJson();
    }
    if (week != null) {
      data['week'] = week!.toJson();
    }
    if (teams != null) {
      data['teams'] = teams!.map((v) => v.toJson()).toList();
    }
    data['_comment'] = sComment;
    return data;
  }
}

class Season {
  String? id;
  int? year;
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

class Week {
  String? id;
  int? sequence;
  String? title;

  Week({this.id, this.sequence, this.title});

  Week.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sequence = json['sequence'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sequence'] = sequence;
    data['title'] = title;
    return data;
  }
}

class Teams {
  String? id;
  String? name;
  String? market;
  String? alias;
  String? srId;
  List<Offense>? offense;
  List<Offense>? defense;
  List<Offense>? specialTeams;

  Teams(
      {this.id,
      this.name,
      this.market,
      this.alias,
      this.srId,
      this.offense,
      this.defense,
      this.specialTeams});

  Teams.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    market = json['market'];
    alias = json['alias'];
    srId = json['sr_id'];
    if (json['offense'] != null) {
      offense = <Offense>[];
      json['offense'].forEach((v) {
        offense!.add(Offense.fromJson(v));
      });
    }
    if (json['defense'] != null) {
      defense = <Offense>[];
      json['defense'].forEach((v) {
        defense!.add(Offense.fromJson(v));
      });
    }
    if (json['special_teams'] != null) {
      specialTeams = <Offense>[];
      json['special_teams'].forEach((v) {
        specialTeams!.add(Offense.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['market'] = market;
    data['alias'] = alias;
    data['sr_id'] = srId;
    if (offense != null) {
      data['offense'] = offense!.map((v) => v.toJson()).toList();
    }
    if (defense != null) {
      data['defense'] = defense!.map((v) => v.toJson()).toList();
    }
    if (specialTeams != null) {
      data['special_teams'] = specialTeams!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Offense {
  Position? position;

  Offense({this.position});

  Offense.fromJson(Map<String, dynamic> json) {
    position =
        json['position'] != null ? Position.fromJson(json['position']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (position != null) {
      data['position'] = position!.toJson();
    }
    return data;
  }
}

class Position {
  String? name;
  List<Players>? players;

  Position({this.name, this.players});

  Position.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['players'] != null) {
      players = <Players>[];
      json['players'].forEach((v) {
        players!.add(Players.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (players != null) {
      data['players'] = players!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Players {
  String? id;
  String? name;
  String? jersey;
  String? position;
  String? srId;
  int? depth;

  Players(
      {this.id, this.name, this.jersey, this.position, this.srId, this.depth});

  Players.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    jersey = json['jersey'];
    position = json['position'];
    srId = json['sr_id'];
    depth = json['depth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['jersey'] = jersey;
    data['position'] = position;
    data['sr_id'] = srId;
    data['depth'] = depth;
    return data;
  }
}
