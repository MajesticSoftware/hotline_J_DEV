class NFLInjuryModel {
  Season? season;
  Week? week;
  List<Teams>? teams;
  String? sComment;

  NFLInjuryModel({this.season, this.week, this.teams, this.sComment});

  NFLInjuryModel.fromJson(Map<String, dynamic> json) {
    season =
        json['season'] != null ? new Season.fromJson(json['season']) : null;
    week = json['week'] != null ? new Week.fromJson(json['week']) : null;
    if (json['teams'] != null) {
      teams = <Teams>[];
      json['teams'].forEach((v) {
        teams!.add(new Teams.fromJson(v));
      });
    }
    sComment = json['_comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.season != null) {
      data['season'] = this.season!.toJson();
    }
    if (this.week != null) {
      data['week'] = this.week!.toJson();
    }
    if (this.teams != null) {
      data['teams'] = this.teams!.map((v) => v.toJson()).toList();
    }
    data['_comment'] = this.sComment;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['year'] = this.year;
    data['type'] = this.type;
    data['name'] = this.name;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sequence'] = this.sequence;
    data['title'] = this.title;
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
        players!.add(new Players.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['market'] = this.market;
    data['alias'] = this.alias;
    data['sr_id'] = this.srId;
    if (this.players != null) {
      data['players'] = this.players!.map((v) => v.toJson()).toList();
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
        injuries!.add(new Injuries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['jersey'] = this.jersey;
    data['position'] = this.position;
    data['sr_id'] = this.srId;
    if (this.injuries != null) {
      data['injuries'] = this.injuries!.map((v) => v.toJson()).toList();
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
    practice = json['practice'] != null
        ? new Practice.fromJson(json['practice'])
        : null;
    primary = json['primary'];
    secondary = json['secondary'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_date'] = this.statusDate;
    if (this.practice != null) {
      data['practice'] = this.practice!.toJson();
    }
    data['primary'] = this.primary;
    data['secondary'] = this.secondary;
    data['status'] = this.status;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    return data;
  }
}
