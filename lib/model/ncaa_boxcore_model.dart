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
        json['weather'] != null ? Weather.fromJson(json['weather']) : null;
    summary =
        json['summary'] != null ? Summary.fromJson(json['summary']) : null;
    home = json['home'] != null ? Home.fromJson(json['home']) : null;
    away = json['away'] != null ? Home.fromJson(json['away']) : null;
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
    record = json['record'] != null ? Record.fromJson(json['record']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['market'] = market;
    data['alias'] = alias;
    data['sr_id'] = srId;
    data['used_timeouts'] = usedTimeouts;
    data['remaining_timeouts'] = remainingTimeouts;
    data['points'] = points;
    data['used_challenges'] = usedChallenges;
    data['remaining_challenges'] = remainingChallenges;
    if (record != null) {
      data['record'] = record!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wins'] = wins;
    data['losses'] = losses;
    data['ties'] = ties;
    return data;
  }
}
