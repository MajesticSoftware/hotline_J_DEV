class MLBInjuriesModel {
  League? league;
  List<Teams>? teams;
  String? sComment;

  MLBInjuriesModel({this.league, this.teams, this.sComment});

  MLBInjuriesModel.fromJson(Map<String, dynamic> json) {
    league = json['league'] != null ? League.fromJson(json['league']) : null;
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
    if (league != null) {
      data['league'] = league!.toJson();
    }
    if (teams != null) {
      data['teams'] = teams!.map((v) => v.toJson()).toList();
    }
    data['_comment'] = sComment;
    return data;
  }
}

class League {
  String? alias;
  String? name;
  String? id;

  League({this.alias, this.name, this.id});

  League.fromJson(Map<String, dynamic> json) {
    alias = json['alias'];
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['alias'] = alias;
    data['name'] = name;
    data['id'] = id;
    return data;
  }
}

class Teams {
  String? name;
  String? market;
  String? abbr;
  String? id;
  List<Players>? players;

  Teams({this.name, this.market, this.abbr, this.id, this.players});

  Teams.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    market = json['market'];
    abbr = json['abbr'];
    id = json['id'];
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
    data['market'] = market;
    data['abbr'] = abbr;
    data['id'] = id;
    if (players != null) {
      data['players'] = players!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Players {
  String? id;
  String? status;
  String? position;
  String? primaryPosition;
  String? firstName;
  String? lastName;
  String? preferredName;
  String? jerseyNumber;
  List<Injuries>? injuries;

  Players(
      {this.id,
      this.status,
      this.position,
      this.primaryPosition,
      this.firstName,
      this.lastName,
      this.preferredName,
      this.jerseyNumber,
      this.injuries});

  Players.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    position = json['position'];
    primaryPosition = json['primary_position'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    preferredName = json['preferred_name'];
    jerseyNumber = json['jersey_number'];
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
    data['status'] = status;
    data['position'] = position;
    data['primary_position'] = primaryPosition;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['preferred_name'] = preferredName;
    data['jersey_number'] = jerseyNumber;
    if (injuries != null) {
      data['injuries'] = injuries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Injuries {
  String? id;
  String? comment;
  String? desc;
  String? status;
  String? startDate;
  String? updateDate;

  Injuries(
      {this.id,
      this.comment,
      this.desc,
      this.status,
      this.startDate,
      this.updateDate});

  Injuries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    desc = json['desc'];
    status = json['status'];
    startDate = json['start_date'];
    updateDate = json['update_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['comment'] = comment;
    data['desc'] = desc;
    data['status'] = status;
    data['start_date'] = startDate;
    data['update_date'] = updateDate;
    return data;
  }
}
