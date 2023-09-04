class NCAABoxScoreModel {
  String? id;
  String? status;
  String? scheduled;
  num? attendance;
  String? entryMode;
  String? clock;
  num? quarter;
  String? coverage;
  String? srId;
  String? gameType;
  bool? conferenceGame;
  String? duration;
  Weather? weather;
  Summary? summary;
  Statistics? statistics;
  String? sComment;

  NCAABoxScoreModel(
      {this.id,
      this.status,
      this.scheduled,
      this.attendance,
      this.entryMode,
      this.clock,
      this.quarter,
      this.coverage,
      this.srId,
      this.gameType,
      this.conferenceGame,
      this.duration,
      this.weather,
      this.summary,
      this.statistics,
      this.sComment});

  NCAABoxScoreModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    scheduled = json['scheduled'];
    attendance = json['attendance'];
    entryMode = json['entry_mode'];
    clock = json['clock'];
    quarter = json['quarter'];
    coverage = json['coverage'];
    srId = json['sr_id'];
    gameType = json['game_type'];
    conferenceGame = json['conference_game'];
    duration = json['duration'];
    weather =
        json['weather'] != null ? new Weather.fromJson(json['weather']) : null;
    summary =
        json['summary'] != null ? new Summary.fromJson(json['summary']) : null;
    statistics = json['statistics'] != null
        ? new Statistics.fromJson(json['statistics'])
        : null;
    sComment = json['_comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['scheduled'] = this.scheduled;
    data['attendance'] = this.attendance;
    data['entry_mode'] = this.entryMode;
    data['clock'] = this.clock;
    data['quarter'] = this.quarter;
    data['coverage'] = this.coverage;
    data['sr_id'] = this.srId;
    data['game_type'] = this.gameType;
    data['conference_game'] = this.conferenceGame;
    data['duration'] = this.duration;
    if (this.weather != null) {
      data['weather'] = this.weather!.toJson();
    }
    if (this.summary != null) {
      data['summary'] = this.summary!.toJson();
    }
    if (this.statistics != null) {
      data['statistics'] = this.statistics!.toJson();
    }
    data['_comment'] = this.sComment;
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
    wind = json['wind'] != null ? new Wind.fromJson(json['wind']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['humidity'] = this.humidity;
    data['temp'] = this.temp;
    if (this.wind != null) {
      data['wind'] = this.wind!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['speed'] = this.speed;
    data['direction'] = this.direction;
    return data;
  }
}

class Summary {
  Season? season;
  Venue? venue;
  Home? home;
  Home? away;

  Summary({this.season, this.venue, this.home, this.away});

  Summary.fromJson(Map<String, dynamic> json) {
    season =
        json['season'] != null ? new Season.fromJson(json['season']) : null;
    venue = json['venue'] != null ? new Venue.fromJson(json['venue']) : null;
    home = json['home'] != null ? new Home.fromJson(json['home']) : null;
    away = json['away'] != null ? new Home.fromJson(json['away']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.season != null) {
      data['season'] = this.season!.toJson();
    }
    if (this.venue != null) {
      data['venue'] = this.venue!.toJson();
    }
    if (this.home != null) {
      data['home'] = this.home!.toJson();
    }
    if (this.away != null) {
      data['away'] = this.away!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['year'] = this.year;
    data['type'] = this.type;
    data['name'] = this.name;
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
      this.roofType});

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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['zip'] = this.zip;
    data['address'] = this.address;
    data['capacity'] = this.capacity;
    data['surface'] = this.surface;
    data['roof_type'] = this.roofType;
    return data;
  }
}

class Home {
  String? id;
  String? name;
  String? market;
  String? alias;
  num? usedTimeouts;
  num? remainingTimeouts;
  num? points;
  num? usedChallenges;
  num? remainingChallenges;
  Record? record;

  Home(
      {this.id,
      this.name,
      this.market,
      this.alias,
      this.usedTimeouts,
      this.remainingTimeouts,
      this.points,
      this.usedChallenges,
      this.remainingChallenges,
      this.record});

  Home.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    market = json['market'];
    alias = json['alias'];
    usedTimeouts = json['used_timeouts'];
    remainingTimeouts = json['remaining_timeouts'];
    points = json['points'];
    usedChallenges = json['used_challenges'];
    remainingChallenges = json['remaining_challenges'];
    record =
        json['record'] != null ? new Record.fromJson(json['record']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['market'] = this.market;
    data['alias'] = this.alias;
    data['used_timeouts'] = this.usedTimeouts;
    data['remaining_timeouts'] = this.remainingTimeouts;
    data['points'] = this.points;
    data['used_challenges'] = this.usedChallenges;
    data['remaining_challenges'] = this.remainingChallenges;
    if (this.record != null) {
      data['record'] = this.record!.toJson();
    }
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wins'] = this.wins;
    data['losses'] = this.losses;
    data['ties'] = this.ties;
    return data;
  }
}

class Statistics {
  HomeStatic? home;
  HomeStatic? away;

  Statistics({this.home, this.away});

  Statistics.fromJson(Map<String, dynamic> json) {
    home = json['home'] != null ? new HomeStatic.fromJson(json['home']) : null;
    away = json['away'] != null ? new HomeStatic.fromJson(json['away']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.home != null) {
      data['home'] = this.home!.toJson();
    }
    if (this.away != null) {
      data['away'] = this.away!.toJson();
    }
    return data;
  }
}

class Rushing {
  Totals? totals;
  List<Players>? players;

  Rushing({this.totals, this.players});

  Rushing.fromJson(Map<String, dynamic> json) {
    totals =
        json['totals'] != null ? new Totals.fromJson(json['totals']) : null;
    if (json['players'] != null) {
      players = <Players>[];
      json['players'].forEach((v) {
        players!.add(new Players.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.totals != null) {
      data['totals'] = this.totals!.toJson();
    }
    if (this.players != null) {
      data['players'] = this.players!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Totals {
  double? avgYards;
  num? attempts;
  num? touchdowns;
  num? tlost;
  num? tlostYards;
  num? yards;
  num? longest;
  num? longestTouchdown;
  num? redzoneAttempts;
  num? firstDowns;

  Totals(
      {this.avgYards,
      this.attempts,
      this.touchdowns,
      this.tlost,
      this.tlostYards,
      this.yards,
      this.longest,
      this.longestTouchdown,
      this.redzoneAttempts,
      this.firstDowns});

  Totals.fromJson(Map<String, dynamic> json) {
    avgYards = json['avg_yards'];
    attempts = json['attempts'];
    touchdowns = json['touchdowns'];
    tlost = json['tlost'];
    tlostYards = json['tlost_yards'];
    yards = json['yards'];
    longest = json['longest'];
    longestTouchdown = json['longest_touchdown'];
    redzoneAttempts = json['redzone_attempts'];
    firstDowns = json['first_downs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avg_yards'] = this.avgYards;
    data['attempts'] = this.attempts;
    data['touchdowns'] = this.touchdowns;
    data['tlost'] = this.tlost;
    data['tlost_yards'] = this.tlostYards;
    data['yards'] = this.yards;
    data['longest'] = this.longest;
    data['longest_touchdown'] = this.longestTouchdown;
    data['redzone_attempts'] = this.redzoneAttempts;
    data['first_downs'] = this.firstDowns;
    return data;
  }
}

class HomeStatic {
  String? id;
  String? name;
  String? market;
  String? alias;
  Rushing? rushing;
  Rushing? receiving;
  Rushing? passing;
  Rushing? defense;
  FirstDowns? firstDowns;
  Interceptions? interceptions;
  Touchdowns? touchdowns;
  Efficiency? efficiency;

  HomeStatic(
      {this.id,
      this.name,
      this.market,
      this.alias,
      this.rushing,
      this.receiving,
      this.passing,
      this.defense,
      this.firstDowns,
      this.interceptions,
      this.touchdowns,
      this.efficiency});

  HomeStatic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    market = json['market'];
    alias = json['alias'];
    rushing =
        json['rushing'] != null ? new Rushing.fromJson(json['rushing']) : null;
    receiving = json['receiving'] != null
        ? new Rushing.fromJson(json['receiving'])
        : null;
    passing =
        json['passing'] != null ? new Rushing.fromJson(json['passing']) : null;
    defense =
        json['defense'] != null ? new Rushing.fromJson(json['defense']) : null;
    firstDowns = json['first_downs'] != null
        ? new FirstDowns.fromJson(json['first_downs'])
        : null;
    interceptions = json['interceptions'] != null
        ? new Interceptions.fromJson(json['interceptions'])
        : null;
    touchdowns = json['touchdowns'] != null
        ? new Touchdowns.fromJson(json['touchdowns'])
        : null;
    efficiency = json['efficiency'] != null
        ? new Efficiency.fromJson(json['efficiency'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['market'] = this.market;
    data['alias'] = this.alias;
    if (this.rushing != null) {
      data['rushing'] = this.rushing!.toJson();
    }
    if (this.receiving != null) {
      data['receiving'] = this.receiving!.toJson();
    }
    if (this.passing != null) {
      data['passing'] = this.passing!.toJson();
    }
    if (this.defense != null) {
      data['defense'] = this.defense!.toJson();
    }
    if (this.firstDowns != null) {
      data['first_downs'] = this.firstDowns!.toJson();
    }
    if (this.interceptions != null) {
      data['interceptions'] = this.interceptions!.toJson();
    }
    if (this.touchdowns != null) {
      data['touchdowns'] = this.touchdowns!.toJson();
    }
    if (this.efficiency != null) {
      data['efficiency'] = this.efficiency!.toJson();
    }
    return data;
  }
}

class Players {
  String? id;
  String? name;
  String? jersey;
  String? position;
  num? avgYards;
  num? attempts;
  num? touchdowns;
  num? yards;

  Players(
      {this.id,
      this.name,
      this.jersey,
      this.position,
      this.avgYards,
      this.attempts,
      this.touchdowns,
      this.yards});

  Players.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    jersey = json['jersey'];
    position = json['position'];
    avgYards = json['avg_yards'];
    attempts = json['attempts'];
    touchdowns = json['touchdowns'];
    yards = json['yards'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['jersey'] = this.jersey;
    data['position'] = this.position;
    data['avg_yards'] = this.avgYards;
    data['attempts'] = this.attempts;
    data['touchdowns'] = this.touchdowns;
    data['yards'] = this.yards;
    return data;
  }
}

class Defense {
  Totals? totals;

  Defense({this.totals});

  Defense.fromJson(Map<String, dynamic> json) {
    totals =
        json['totals'] != null ? new Totals.fromJson(json['totals']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.totals != null) {
      data['totals'] = this.totals!.toJson();
    }
    return data;
  }
}

class FirstDowns {
  num? pass;
  num? penalty;
  num? rush;
  num? total;

  FirstDowns({this.pass, this.penalty, this.rush, this.total});

  FirstDowns.fromJson(Map<String, dynamic> json) {
    pass = json['pass'];
    penalty = json['penalty'];
    rush = json['rush'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pass'] = this.pass;
    data['penalty'] = this.penalty;
    data['rush'] = this.rush;
    data['total'] = this.total;
    return data;
  }
}

class Interceptions {
  num? returnYards;
  num? returned;
  num? number;

  Interceptions({this.returnYards, this.returned, this.number});

  Interceptions.fromJson(Map<String, dynamic> json) {
    returnYards = json['return_yards'];
    returned = json['returned'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['return_yards'] = this.returnYards;
    data['returned'] = this.returned;
    data['number'] = this.number;
    return data;
  }
}

class Touchdowns {
  num? pass;
  num? rush;
  num? total;

  Touchdowns({this.pass, this.rush, this.total});

  Touchdowns.fromJson(Map<String, dynamic> json) {
    pass = json['pass'];
    rush = json['rush'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pass'] = this.pass;
    data['rush'] = this.rush;
    data['total'] = this.total;
    return data;
  }
}

class Efficiency {
  Goaltogo? goaltogo;
  Thirddown? redzone;
  Thirddown? thirddown;
  Goaltogo? fourthdown;

  Efficiency({this.goaltogo, this.redzone, this.thirddown, this.fourthdown});

  Efficiency.fromJson(Map<String, dynamic> json) {
    goaltogo = json['goaltogo'] != null
        ? new Goaltogo.fromJson(json['goaltogo'])
        : null;
    redzone = json['redzone'] != null
        ? new Thirddown.fromJson(json['redzone'])
        : null;
    thirddown = json['thirddown'] != null
        ? new Thirddown.fromJson(json['thirddown'])
        : null;
    fourthdown = json['fourthdown'] != null
        ? new Goaltogo.fromJson(json['fourthdown'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.goaltogo != null) {
      data['goaltogo'] = this.goaltogo!.toJson();
    }
    if (this.redzone != null) {
      data['redzone'] = this.redzone!.toJson();
    }
    if (this.thirddown != null) {
      data['thirddown'] = this.thirddown!.toJson();
    }
    if (this.fourthdown != null) {
      data['fourthdown'] = this.fourthdown!.toJson();
    }
    return data;
  }
}

class Goaltogo {
  num? attempts;
  num? successes;
  num? pct;

  Goaltogo({this.attempts, this.successes, this.pct});

  Goaltogo.fromJson(Map<String, dynamic> json) {
    attempts = json['attempts'];
    successes = json['successes'];
    pct = json['pct'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attempts'] = this.attempts;
    data['successes'] = this.successes;
    data['pct'] = this.pct;
    return data;
  }
}

class Thirddown {
  num? attempts;
  num? successes;
  num? pct;

  Thirddown({this.attempts, this.successes, this.pct});

  Thirddown.fromJson(Map<String, dynamic> json) {
    attempts = json['attempts'];
    successes = json['successes'];
    pct = json['pct'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attempts'] = this.attempts;
    data['successes'] = this.successes;
    data['pct'] = this.pct;
    return data;
  }
}
