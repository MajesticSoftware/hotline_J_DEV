class GameRosterModel {
  String? id;
  String? status;
  String? scheduled;
  num? attendance;
  String? entryMode;
  String? clock;
  num? quarter;
  String? srId;
  String? gameType;
  bool? conferenceGame;
  String? duration;
  Weather? weather;
  Summary? summary;
  Home? home;
  Home? away;
  List<Officials>? officials;
  String? sComment;

  GameRosterModel(
      {this.id,
      this.status,
      this.scheduled,
      this.attendance,
      this.entryMode,
      this.clock,
      this.quarter,
      this.srId,
      this.gameType,
      this.conferenceGame,
      this.duration,
      this.weather,
      this.summary,
      this.home,
      this.away,
      this.officials,
      this.sComment});

  GameRosterModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    scheduled = json['scheduled'];
    attendance = json['attendance'];
    entryMode = json['entry_mode'];
    clock = json['clock'];
    quarter = json['quarter'];
    srId = json['sr_id'];
    gameType = json['game_type'];
    conferenceGame = json['conference_game'];
    duration = json['duration'];
    weather =
        json['weather'] != null ? Weather.fromJson(json['weather']) : null;
    summary =
        json['summary'] != null ? Summary.fromJson(json['summary']) : null;
    home = json['home'] != null ? Home.fromJson(json['home']) : null;
    away = json['away'] != null ? Home.fromJson(json['away']) : null;
    if (json['officials'] != null) {
      officials = <Officials>[];
      json['officials'].forEach((v) {
        officials!.add(Officials.fromJson(v));
      });
    }
    sComment = json['_comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['scheduled'] = scheduled;
    data['attendance'] = attendance;
    data['entry_mode'] = entryMode;
    data['clock'] = clock;
    data['quarter'] = quarter;
    data['sr_id'] = srId;
    data['game_type'] = gameType;
    data['conference_game'] = conferenceGame;
    data['duration'] = duration;
    if (weather != null) {
      data['weather'] = weather!.toJson();
    }
    if (summary != null) {
      data['summary'] = summary!.toJson();
    }
    if (home != null) {
      data['home'] = home!.toJson();
    }
    if (away != null) {
      data['away'] = away!.toJson();
    }
    if (officials != null) {
      data['officials'] = officials!.map((v) => v.toJson()).toList();
    }
    data['_comment'] = sComment;
    return data;
  }
}

class Weather {
  String? condition;
  num? humidity;
  num? temp;
  Wind? wind;

  Weather({this.condition, this.humidity, this.temp, this.wind});

  Weather.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    humidity = json['humidity'];
    temp = json['temp'];
    wind = json['wind'] != null ? Wind.fromJson(json['wind']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['condition'] = condition;
    data['humidity'] = humidity;
    data['temp'] = temp;
    if (wind != null) {
      data['wind'] = wind!.toJson();
    }
    return data;
  }
}

class Wind {
  num? speed;
  String? direction;

  Wind({this.speed, this.direction});

  Wind.fromJson(Map<String, dynamic> json) {
    speed = json['speed'];
    direction = json['direction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['speed'] = speed;
    data['direction'] = direction;
    return data;
  }
}

class Summary {
  Season? season;
  Week? week;
  Venue? venue;
  Home? home;
  Home? away;

  Summary({this.season, this.week, this.venue, this.home, this.away});

  Summary.fromJson(Map<String, dynamic> json) {
    season = json['season'] != null ? Season.fromJson(json['season']) : null;
    week = json['week'] != null ? Week.fromJson(json['week']) : null;
    venue = json['venue'] != null ? Venue.fromJson(json['venue']) : null;
    home = json['home'] != null ? Home.fromJson(json['home']) : null;
    away = json['away'] != null ? Home.fromJson(json['away']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (season != null) {
      data['season'] = season!.toJson();
    }
    if (week != null) {
      data['week'] = week!.toJson();
    }
    if (venue != null) {
      data['venue'] = venue!.toJson();
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

class Season {
  String? id;
  num? year;
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
  num? sequence;
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

class Venue {
  String? id;
  String? name;
  String? city;
  String? state;
  String? country;
  String? zip;
  String? address;
  num? capacity;
  String? surface;
  String? roofType;
  String? srId;
  Location? location;

  Venue(
      {this.id,
      this.name,
      this.city,
      this.state,
      this.country,
      this.zip,
      this.address,
      this.capacity,
      this.surface,
      this.roofType,
      this.srId,
      this.location});

  Venue.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    zip = json['zip'];
    address = json['address'];
    capacity = json['capacity'];
    surface = json['surface'];
    roofType = json['roof_type'];
    srId = json['sr_id'];
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['zip'] = zip;
    data['address'] = address;
    data['capacity'] = capacity;
    data['surface'] = surface;
    data['roof_type'] = roofType;
    data['sr_id'] = srId;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    return data;
  }
}

class Location {
  String? lat;
  String? lng;

  Location({this.lat, this.lng});

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}

class Record {
  num? wins;
  num? losses;
  num? ties;

  Record({this.wins, this.losses, this.ties});

  Record.fromJson(Map<String, dynamic> json) {
    wins = json['wins'];
    losses = json['losses'];
    ties = json['ties'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wins'] = wins;
    data['losses'] = losses;
    data['ties'] = ties;
    return data;
  }
}

class Home {
  String? id;
  String? name;
  String? market;
  String? alias;
  String? srId;
  List<Coaches>? coaches;
  List<Players>? players;

  Home(
      {this.id,
      this.name,
      this.market,
      this.alias,
      this.srId,
      this.coaches,
      this.players});

  Home.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    market = json['market'];
    alias = json['alias'];
    srId = json['sr_id'];
    if (json['coaches'] != null) {
      coaches = <Coaches>[];
      json['coaches'].forEach((v) {
        coaches!.add(Coaches.fromJson(v));
      });
    }
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
    if (coaches != null) {
      data['coaches'] = coaches!.map((v) => v.toJson()).toList();
    }
    if (players != null) {
      data['players'] = players!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Coaches {
  String? id;
  String? fullName;
  String? firstName;
  String? lastName;
  String? position;

  Coaches(
      {this.id, this.fullName, this.firstName, this.lastName, this.position});

  Coaches.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = fullName;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['position'] = position;
    return data;
  }
}

class Players {
  String? id;
  String? name;
  String? jersey;
  String? lastName;
  String? firstName;
  String? abbrName;
  String? birthDate;
  num? weight;
  num? height;
  String? position;
  num? age;
  String? birthPlace;
  String? highSchool;
  String? college;
  String? collegeConf;
  num? rookieYear;
  String? status;
  String? srId;
  String? inGameStatus;
  Draft? draft;
  String? nameSuffix;

  Players(
      {this.id,
      this.name,
      this.jersey,
      this.lastName,
      this.firstName,
      this.abbrName,
      this.birthDate,
      this.weight,
      this.height,
      this.position,
      this.age,
      this.birthPlace,
      this.highSchool,
      this.college,
      this.collegeConf,
      this.rookieYear,
      this.status,
      this.srId,
      this.inGameStatus,
      this.draft,
      this.nameSuffix});

  Players.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    jersey = json['jersey'];
    lastName = json['last_name'];
    firstName = json['first_name'];
    abbrName = json['abbr_name'];
    birthDate = json['birth_date'];
    weight = json['weight'];
    height = json['height'];
    position = json['position'];
    age = json['age'];
    birthPlace = json['birth_place'];
    highSchool = json['high_school'];
    college = json['college'];
    collegeConf = json['college_conf'];
    rookieYear = json['rookie_year'];
    status = json['status'];
    srId = json['sr_id'];
    inGameStatus = json['in_game_status'];
    draft = json['draft'] != null ? Draft.fromJson(json['draft']) : null;
    nameSuffix = json['name_suffix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['jersey'] = jersey;
    data['last_name'] = lastName;
    data['first_name'] = firstName;
    data['abbr_name'] = abbrName;
    data['birth_date'] = birthDate;
    data['weight'] = weight;
    data['height'] = height;
    data['position'] = position;
    data['age'] = age;
    data['birth_place'] = birthPlace;
    data['high_school'] = highSchool;
    data['college'] = college;
    data['college_conf'] = collegeConf;
    data['rookie_year'] = rookieYear;
    data['status'] = status;
    data['sr_id'] = srId;
    data['in_game_status'] = inGameStatus;
    if (draft != null) {
      data['draft'] = draft!.toJson();
    }
    data['name_suffix'] = nameSuffix;
    return data;
  }
}

class Draft {
  num? year;
  num? round;
  num? number;
  Team? team;

  Draft({this.year, this.round, this.number, this.team});

  Draft.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    round = json['round'];
    number = json['number'];
    team = json['team'] != null ? Team.fromJson(json['team']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['year'] = year;
    data['round'] = round;
    data['number'] = number;
    if (team != null) {
      data['team'] = team!.toJson();
    }
    return data;
  }
}

class Team {
  String? id;
  String? name;
  String? market;
  String? alias;
  String? srId;

  Team({this.id, this.name, this.market, this.alias, this.srId});

  Team.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    market = json['market'];
    alias = json['alias'];
    srId = json['sr_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['market'] = market;
    data['alias'] = alias;
    data['sr_id'] = srId;
    return data;
  }
}

class Officials {
  String? fullName;
  String? number;
  String? assignment;

  Officials({this.fullName, this.number, this.assignment});

  Officials.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    number = json['number'];
    assignment = json['assignment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['full_name'] = fullName;
    data['number'] = number;
    data['assignment'] = assignment;
    return data;
  }
}
