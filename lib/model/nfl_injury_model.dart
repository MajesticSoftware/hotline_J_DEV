class NFLInjuryModel {
  Season? season;
  Week? week;
  List<Teams>? teams;
  String? sComment;

  NFLInjuryModel({this.season, this.week, this.teams, this.sComment});

  NFLInjuryModel.fromJson(Map<String, dynamic> json) {
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
  List<Players>? players;

  Teams({this.id, this.name, this.market, this.alias, this.srId, this.players});

  Teams.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    market = json['market'];
    alias = json['alias'];
    srId = json['sr_id'];
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
    data['alias'] = alias;
    data['sr_id'] = srId;
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
  List<Injuries>? injuries;

  Players(
      {this.id,
      this.name,
      this.jersey,
      this.position,
      this.srId,
      this.injuries});

  Players.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    jersey = json['jersey'];
    position = json['position'];
    srId = json['sr_id'];
    if (json['injuries'] != null) {
      injuries = <Injuries>[];
      json['injuries'].forEach((v) {
        injuries!.add(Injuries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['jersey'] = jersey;
    data['position'] = position;
    data['sr_id'] = srId;
    if (injuries != null) {
      data['injuries'] = injuries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Injuries {
  String? statusDate;
  Practice? practice;
  String? primary;
  String? secondary;
  String? status;

  Injuries(
      {this.statusDate,
      this.practice,
      this.primary,
      this.secondary,
      this.status});

  Injuries.fromJson(Map<String, dynamic> json) {
    statusDate = json['status_date'];
    practice =
        json['practice'] != null ? Practice.fromJson(json['practice']) : null;
    primary = json['primary'];
    secondary = json['secondary'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_date'] = statusDate;
    if (practice != null) {
      data['practice'] = practice!.toJson();
    }
    data['primary'] = primary;
    data['secondary'] = secondary;
    data['status'] = status;
    return data;
  }
}

class Practice {
  String? status;

  Practice({this.status});

  Practice.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    return data;
  }
}
