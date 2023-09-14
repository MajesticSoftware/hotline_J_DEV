class NCAABoxScoreModel {
  String? id;
  String? status;
  String? scheduled;
  num? attendance;
  String? entryMode;
  String? clock;
  num? quarter;
  String? srId;
  bool? conferenceGame;
  String? duration;
  Weather? weather;
  Summary? summary;
  Home? home;
  Home? away;
  String? sComment;

  NCAABoxScoreModel(
      {this.id,
      this.status,
      this.scheduled,
      this.attendance,
      this.entryMode,
      this.clock,
      this.quarter,
      this.srId,
      this.conferenceGame,
      this.duration,
      this.weather,
      this.summary,
      this.home,
      this.away,
      this.sComment});

  NCAABoxScoreModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    scheduled = json['scheduled'];
    attendance = json['attendance'];
    entryMode = json['entry_mode'];
    clock = json['clock'];
    quarter = json['quarter'];
    srId = json['sr_id'];
    conferenceGame = json['conference_game'];
    duration = json['duration'];
    weather =
        json['weather'] != null ? new Weather.fromJson(json['weather']) : null;
    summary =
        json['summary'] != null ? new Summary.fromJson(json['summary']) : null;
    home = json['home'] != null ? new Home.fromJson(json['home']) : null;
    away = json['away'] != null ? new Home.fromJson(json['away']) : null;
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
    data['sr_id'] = this.srId;
    data['conference_game'] = this.conferenceGame;
    data['duration'] = this.duration;
    if (this.weather != null) {
      data['weather'] = this.weather!.toJson();
    }
    if (this.summary != null) {
      data['summary'] = this.summary!.toJson();
    }
    if (this.home != null) {
      data['home'] = this.home!.toJson();
    }
    if (this.away != null) {
      data['away'] = this.away!.toJson();
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
  Week? week;
  Venue? venue;
  Home? home;
  Home? away;

  Summary({this.season, this.week, this.venue, this.home, this.away});

  Summary.fromJson(Map<String, dynamic> json) {
    season =
        json['season'] != null ? new Season.fromJson(json['season']) : null;
    week = json['week'] != null ? new Week.fromJson(json['week']) : null;
    venue = json['venue'] != null ? new Venue.fromJson(json['venue']) : null;
    home = json['home'] != null ? new Home.fromJson(json['home']) : null;
    away = json['away'] != null ? new Home.fromJson(json['away']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.season != null) {
      data['season'] = this.season!.toJson();
    }
    if (this.week != null) {
      data['week'] = this.week!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sequence'] = this.sequence;
    data['title'] = this.title;
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
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
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
    data['sr_id'] = this.srId;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class Home {
  String? id;
  String? name;
  String? market;
  String? alias;
  String? srId;
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
      this.srId,
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
    srId = json['sr_id'];
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
    data['sr_id'] = this.srId;
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
