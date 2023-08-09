class MLBBoxScoreModel {
  Game? game;
  String? sComment;

  MLBBoxScoreModel({this.game, this.sComment});

  MLBBoxScoreModel.fromJson(Map<String, dynamic> json) {
    game = json['game'] != null ? new Game.fromJson(json['game']) : null;
    sComment = json['_comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.game != null) {
      data['game'] = this.game!.toJson();
    }
    data['_comment'] = this.sComment;
    return data;
  }
}

class Game {
  String? id;
  String? status;
  String? coverage;
  dynamic gameNumber;
  String? dayNight;
  String? scheduled;
  String? homeTeam;
  String? awayTeam;
  dynamic attendance;
  Final? finals;
  String? duration;
  bool? doubleHeader;
  String? entryMode;
  String? reference;
  TimeZones? timeZones;
  Venue? venue;
  Broadcast? broadcast;
  Weather? weather;

  Home? home;
  Home? away;
  Pitching? pitching;

  Game(
      {this.id,
      this.status,
      this.coverage,
      this.gameNumber,
      this.dayNight,
      this.scheduled,
      this.homeTeam,
      this.awayTeam,
      this.attendance,
      this.finals,
      this.duration,
      this.doubleHeader,
      this.entryMode,
      this.reference,
      this.timeZones,
      this.venue,
      this.broadcast,
      this.weather,
      this.home,
      this.away,
      this.pitching});

  Game.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    coverage = json['coverage'];
    gameNumber = json['game_number'];
    dayNight = json['day_night'];
    scheduled = json['scheduled'];
    homeTeam = json['home_team'];
    awayTeam = json['away_team'];
    attendance = json['attendance'];
    finals = json['final'];
    duration = json['duration'];
    doubleHeader = json['double_header'];
    entryMode = json['entry_mode'];
    reference = json['reference'];
    timeZones = json['time_zones'] != null
        ? new TimeZones.fromJson(json['time_zones'])
        : null;
    venue = json['venue'] != null ? new Venue.fromJson(json['venue']) : null;
    broadcast = json['broadcast'] != null
        ? new Broadcast.fromJson(json['broadcast'])
        : null;
    weather =
        json['weather'] != null ? new Weather.fromJson(json['weather']) : null;
    home = json['home'] != null ? new Home.fromJson(json['home']) : null;
    away = json['away'] != null ? new Home.fromJson(json['away']) : null;
    pitching = json['pitching'] != null
        ? new Pitching.fromJson(json['pitching'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['coverage'] = this.coverage;
    data['game_number'] = this.gameNumber;
    data['day_night'] = this.dayNight;
    data['scheduled'] = this.scheduled;
    data['home_team'] = this.homeTeam;
    data['away_team'] = this.awayTeam;
    data['attendance'] = this.attendance;
    data['final'] = this.finals;
    data['duration'] = this.duration;
    data['double_header'] = this.doubleHeader;
    data['entry_mode'] = this.entryMode;
    data['reference'] = this.reference;
    if (this.timeZones != null) {
      data['time_zones'] = this.timeZones!.toJson();
    }
    if (this.venue != null) {
      data['venue'] = this.venue!.toJson();
    }
    if (this.broadcast != null) {
      data['broadcast'] = this.broadcast!.toJson();
    }
    if (this.weather != null) {
      data['weather'] = this.weather!.toJson();
    }
    if (this.home != null) {
      data['home'] = this.home!.toJson();
    }
    if (this.away != null) {
      data['away'] = this.away!.toJson();
    }
    if (this.pitching != null) {
      data['pitching'] = this.pitching!.toJson();
    }
    return data;
  }
}

class TimeZones {
  String? venue;
  String? home;
  String? away;

  TimeZones({this.venue, this.home, this.away});

  TimeZones.fromJson(Map<String, dynamic> json) {
    venue = json['venue'];
    home = json['home'];
    away = json['away'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['venue'] = this.venue;
    data['home'] = this.home;
    data['away'] = this.away;
    return data;
  }
}

class Venue {
  String? name;
  String? market;
  dynamic capacity;
  String? surface;
  String? address;
  String? city;
  String? state;
  String? zip;
  String? country;
  String? id;
  String? fieldOrientation;
  String? stadiumType;
  String? timeZone;
  Location? location;

  Venue(
      {this.name,
      this.market,
      this.capacity,
      this.surface,
      this.address,
      this.city,
      this.state,
      this.zip,
      this.country,
      this.id,
      this.fieldOrientation,
      this.stadiumType,
      this.timeZone,
      this.location});

  Venue.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    market = json['market'];
    capacity = json['capacity'];
    surface = json['surface'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    zip = json['zip'];
    country = json['country'];
    id = json['id'];
    fieldOrientation = json['field_orientation'];
    stadiumType = json['stadium_type'];
    timeZone = json['time_zone'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['market'] = this.market;
    data['capacity'] = this.capacity;
    data['surface'] = this.surface;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zip'] = this.zip;
    data['country'] = this.country;
    data['id'] = this.id;
    data['field_orientation'] = this.fieldOrientation;
    data['stadium_type'] = this.stadiumType;
    data['time_zone'] = this.timeZone;
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

class Broadcast {
  String? network;

  Broadcast({this.network});

  Broadcast.fromJson(Map<String, dynamic> json) {
    network = json['network'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['network'] = this.network;
    return data;
  }
}

class Weather {
  Forecast? forecast;
  Forecast? currentConditions;

  Weather({this.forecast, this.currentConditions});

  Weather.fromJson(Map<String, dynamic> json) {
    forecast = json['forecast'] != null
        ? new Forecast.fromJson(json['forecast'])
        : null;
    currentConditions = json['current_conditions'] != null
        ? new Forecast.fromJson(json['current_conditions'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.forecast != null) {
      data['forecast'] = this.forecast!.toJson();
    }
    if (this.currentConditions != null) {
      data['current_conditions'] = this.currentConditions!.toJson();
    }
    return data;
  }
}

class Forecast {
  dynamic tempF;
  String? condition;
  dynamic humidity;
  dynamic dewPodynamicF;
  dynamic cloudCover;
  String? obsTime;
  Wind? wind;

  Forecast(
      {this.tempF,
      this.condition,
      this.humidity,
      this.dewPodynamicF,
      this.cloudCover,
      this.obsTime,
      this.wind});

  Forecast.fromJson(Map<String, dynamic> json) {
    tempF = json['temp_f'];
    condition = json['condition'];
    humidity = json['humidity'];
    dewPodynamicF = json['dew_podynamic_f'];
    cloudCover = json['cloud_cover'];
    obsTime = json['obs_time'];
    wind = json['wind'] != null ? new Wind.fromJson(json['wind']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['temp_f'] = this.tempF;
    data['condition'] = this.condition;
    data['humidity'] = this.humidity;
    data['dew_podynamic_f'] = this.dewPodynamicF;
    data['cloud_cover'] = this.cloudCover;
    data['obs_time'] = this.obsTime;
    if (this.wind != null) {
      data['wind'] = this.wind!.toJson();
    }
    return data;
  }
}

class Wind {
  dynamic speedMph;
  String? direction;

  Wind({this.speedMph, this.direction});

  Wind.fromJson(Map<String, dynamic> json) {
    speedMph = json['speed_mph'];
    direction = json['direction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['speed_mph'] = this.speedMph;
    data['direction'] = this.direction;
    return data;
  }
}

class Final {
  dynamic inning;
  String? inningHalf;

  Final({this.inning, this.inningHalf});

  Final.fromJson(Map<String, dynamic> json) {
    inning = json['inning'];
    inningHalf = json['inning_half'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['inning'] = this.inning;
    data['inning_half'] = this.inningHalf;
    return data;
  }
}

class Home {
  String? name;
  String? market;
  String? abbr;
  String? id;
  dynamic runs;
  dynamic hits;
  dynamic errors;
  dynamic win;
  dynamic loss;
  ProbablePitcher? probablePitcher;
  ProbablePitcher? startingPitcher;
  List<Scoring>? scoring;
  List<Events>? events;

  Home(
      {this.name,
      this.market,
      this.abbr,
      this.id,
      this.runs,
      this.hits,
      this.errors,
      this.win,
      this.loss,
      this.probablePitcher,
      this.startingPitcher,
      this.scoring,
      this.events});

  Home.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    market = json['market'];
    abbr = json['abbr'];
    id = json['id'];
    runs = json['runs'];
    hits = json['hits'];
    errors = json['errors'];
    win = json['win'];
    loss = json['loss'];
    probablePitcher = json['probable_pitcher'] != null
        ? new ProbablePitcher.fromJson(json['probable_pitcher'])
        : null;
    startingPitcher = json['starting_pitcher'] != null
        ? new ProbablePitcher.fromJson(json['starting_pitcher'])
        : null;
    if (json['scoring'] != null) {
      scoring = <Scoring>[];
      json['scoring'].forEach((v) {
        scoring!.add(new Scoring.fromJson(v));
      });
    }
    if (json['events'] != null) {
      events = <Events>[];
      json['events'].forEach((v) {
        events!.add(new Events.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['market'] = this.market;
    data['abbr'] = this.abbr;
    data['id'] = this.id;
    data['runs'] = this.runs;
    data['hits'] = this.hits;
    data['errors'] = this.errors;
    data['win'] = this.win;
    data['loss'] = this.loss;
    if (this.probablePitcher != null) {
      data['probable_pitcher'] = this.probablePitcher!.toJson();
    }
    if (this.startingPitcher != null) {
      data['starting_pitcher'] = this.startingPitcher!.toJson();
    }
    if (this.scoring != null) {
      data['scoring'] = this.scoring!.map((v) => v.toJson()).toList();
    }
    if (this.events != null) {
      data['events'] = this.events!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProbablePitcher {
  String? preferredName;
  String? firstName;
  String? lastName;
  String? jerseyNumber;
  String? id;
  dynamic? win;
  dynamic? loss;
  double? era;

  ProbablePitcher(
      {this.preferredName,
      this.firstName,
      this.lastName,
      this.jerseyNumber,
      this.id,
      this.win,
      this.loss,
      this.era});

  ProbablePitcher.fromJson(Map<String, dynamic> json) {
    preferredName = json['preferred_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    jerseyNumber = json['jersey_number'];
    id = json['id'];
    win = json['win'];
    loss = json['loss'];
    era = json['era'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['preferred_name'] = this.preferredName;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['jersey_number'] = this.jerseyNumber;
    data['id'] = this.id;
    data['win'] = this.win;
    data['loss'] = this.loss;
    data['era'] = this.era;
    return data;
  }
}

class Scoring {
  dynamic? number;
  dynamic? sequence;
  dynamic? runs;
  dynamic? hits;
  dynamic? errors;
  String? type;

  Scoring(
      {this.number,
      this.sequence,
      this.runs,
      this.hits,
      this.errors,
      this.type});

  Scoring.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    sequence = json['sequence'];
    runs = json['runs'];
    hits = json['hits'];
    errors = json['errors'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = this.number;
    data['sequence'] = this.sequence;
    data['runs'] = this.runs;
    data['hits'] = this.hits;
    data['errors'] = this.errors;
    data['type'] = this.type;
    return data;
  }
}

class Events {
  String? hitterId;
  String? pitcherId;
  dynamic? inning;
  String? inningHalf;
  String? type;
  String? hitterOutcome;
  String? id;
  List<Runners>? runners;

  Events(
      {this.hitterId,
      this.pitcherId,
      this.inning,
      this.inningHalf,
      this.type,
      this.hitterOutcome,
      this.id,
      this.runners});

  Events.fromJson(Map<String, dynamic> json) {
    hitterId = json['hitter_id'];
    pitcherId = json['pitcher_id'];
    inning = json['inning'];
    inningHalf = json['inning_half'];
    type = json['type'];
    hitterOutcome = json['hitter_outcome'];
    id = json['id'];
    if (json['runners'] != null) {
      runners = <Runners>[];
      json['runners'].forEach((v) {
        runners!.add(new Runners.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hitter_id'] = this.hitterId;
    data['pitcher_id'] = this.pitcherId;
    data['inning'] = this.inning;
    data['inning_half'] = this.inningHalf;
    data['type'] = this.type;
    data['hitter_outcome'] = this.hitterOutcome;
    data['id'] = this.id;
    if (this.runners != null) {
      data['runners'] = this.runners!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Runners {
  dynamic? startingBase;
  String? firstName;
  String? lastName;
  String? preferredName;
  String? jerseyNumber;
  String? id;

  Runners(
      {this.startingBase,
      this.firstName,
      this.lastName,
      this.preferredName,
      this.jerseyNumber,
      this.id});

  Runners.fromJson(Map<String, dynamic> json) {
    startingBase = json['starting_base'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    preferredName = json['preferred_name'];
    jerseyNumber = json['jersey_number'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['starting_base'] = this.startingBase;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['preferred_name'] = this.preferredName;
    data['jersey_number'] = this.jerseyNumber;
    data['id'] = this.id;
    return data;
  }
}

class Pitching {
  Win? win;
  Win? loss;

  Pitching({this.win, this.loss});

  Pitching.fromJson(Map<String, dynamic> json) {
    win = json['win'] != null ? new Win.fromJson(json['win']) : null;
    loss = json['loss'] != null ? new Win.fromJson(json['loss']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.win != null) {
      data['win'] = this.win!.toJson();
    }
    if (this.loss != null) {
      data['loss'] = this.loss!.toJson();
    }
    return data;
  }
}

class Win {
  String? preferredName;
  String? firstName;
  String? lastName;
  String? jerseyNumber;
  String? status;
  String? position;
  String? primaryPosition;
  String? id;
  dynamic? win;
  dynamic? loss;
  dynamic? save;
  dynamic? hold;
  dynamic? blownSave;

  Win(
      {this.preferredName,
      this.firstName,
      this.lastName,
      this.jerseyNumber,
      this.status,
      this.position,
      this.primaryPosition,
      this.id,
      this.win,
      this.loss,
      this.save,
      this.hold,
      this.blownSave});

  Win.fromJson(Map<String, dynamic> json) {
    preferredName = json['preferred_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    jerseyNumber = json['jersey_number'];
    status = json['status'];
    position = json['position'];
    primaryPosition = json['primary_position'];
    id = json['id'];
    win = json['win'];
    loss = json['loss'];
    save = json['save'];
    hold = json['hold'];
    blownSave = json['blown_save'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['preferred_name'] = this.preferredName;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['jersey_number'] = this.jerseyNumber;
    data['status'] = this.status;
    data['position'] = this.position;
    data['primary_position'] = this.primaryPosition;
    data['id'] = this.id;
    data['win'] = this.win;
    data['loss'] = this.loss;
    data['save'] = this.save;
    data['hold'] = this.hold;
    data['blown_save'] = this.blownSave;
    return data;
  }
}
