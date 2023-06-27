class GameDetailsModel {
  int? status;
  String? time;
  int? games;
  int? skip;
  List<Results>? results;

  GameDetailsModel(
      {this.status, this.time, this.games, this.skip, this.results});

  GameDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    time = json['time'];
    games = json['games'];
    skip = json['skip'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['time'] = this.time;
    data['games'] = this.games;
    data['skip'] = this.skip;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String? summary;
  Details? details;
  Schedule? schedule;
  String? status;
  Teams? teams;
  String? lastUpdated;
  int? gameId;
  Venue? venue;

  Results(
      {this.summary,
      this.details,
      this.schedule,
      this.status,
      this.teams,
      this.lastUpdated,
      this.gameId,
      this.venue});

  Results.fromJson(Map<String, dynamic> json) {
    summary = json['summary'];
    details =
        json['details'] != null ? new Details.fromJson(json['details']) : null;
    schedule = json['schedule'] != null
        ? new Schedule.fromJson(json['schedule'])
        : null;
    status = json['status'];
    teams = json['teams'] != null ? new Teams.fromJson(json['teams']) : null;
    lastUpdated = json['lastUpdated'];
    gameId = json['gameId'];
    venue = json['venue'] != null ? new Venue.fromJson(json['venue']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['summary'] = this.summary;
    if (this.details != null) {
      data['details'] = this.details!.toJson();
    }
    if (this.schedule != null) {
      data['schedule'] = this.schedule!.toJson();
    }
    data['status'] = this.status;
    if (this.teams != null) {
      data['teams'] = this.teams!.toJson();
    }
    data['lastUpdated'] = this.lastUpdated;
    data['gameId'] = this.gameId;
    if (this.venue != null) {
      data['venue'] = this.venue!.toJson();
    }
    return data;
  }
}

class Details {
  String? league;
  String? seasonType;
  int? season;
  bool? conferenceGame;
  bool? divisionGame;

  Details(
      {this.league,
      this.seasonType,
      this.season,
      this.conferenceGame,
      this.divisionGame});

  Details.fromJson(Map<String, dynamic> json) {
    league = json['league'];
    seasonType = json['seasonType'];
    season = json['season'];
    conferenceGame = json['conferenceGame'];
    divisionGame = json['divisionGame'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['league'] = this.league;
    data['seasonType'] = this.seasonType;
    data['season'] = this.season;
    data['conferenceGame'] = this.conferenceGame;
    data['divisionGame'] = this.divisionGame;
    return data;
  }
}

class Schedule {
  String? date;
  bool? tbaTime;

  Schedule({this.date, this.tbaTime});

  Schedule.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    tbaTime = json['tbaTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['tbaTime'] = this.tbaTime;
    return data;
  }
}

class Teams {
  Away? away;
  Away? home;

  Teams({this.away, this.home});

  Teams.fromJson(Map<String, dynamic> json) {
    away = json['away'] != null ? new Away.fromJson(json['away']) : null;
    home = json['home'] != null ? new Away.fromJson(json['home']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.away != null) {
      data['away'] = this.away!.toJson();
    }
    if (this.home != null) {
      data['home'] = this.home!.toJson();
    }
    return data;
  }
}

class Away {
  String? team;
  String? location;
  String? mascot;
  String? abbreviation;
  String? conference;
  String? division;

  Away(
      {this.team,
      this.location,
      this.mascot,
      this.abbreviation,
      this.conference,
      this.division});

  Away.fromJson(Map<String, dynamic> json) {
    team = json['team'];
    location = json['location'];
    mascot = json['mascot'];
    abbreviation = json['abbreviation'];
    conference = json['conference'];
    division = json['division'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['team'] = this.team;
    data['location'] = this.location;
    data['mascot'] = this.mascot;
    data['abbreviation'] = this.abbreviation;
    data['conference'] = this.conference;
    data['division'] = this.division;
    return data;
  }
}

class Venue {
  String? name;
  bool? neutralSite;
  String? city;
  String? state;

  Venue({this.name, this.neutralSite, this.city, this.state});

  Venue.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    neutralSite = json['neutralSite'];
    city = json['city'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['neutralSite'] = this.neutralSite;
    data['city'] = this.city;
    data['state'] = this.state;
    return data;
  }
}
