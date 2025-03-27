class MLBBoxScoreModel {
  Game? game;
  String? sComment;

  MLBBoxScoreModel({this.game, this.sComment});

  MLBBoxScoreModel.fromJson(Map<String, dynamic> json) {
    game = json['game'] != null ? Game.fromJson(json['game']) : null;
    sComment = json['_comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (game != null) {
      data['game'] = game!.toJson();
    }
    data['_comment'] = sComment;
    return data;
  }
}

class Game {
  String? id;
  String? status;
  String? coverage;
  num? gameNumber;
  String? dayNight;
  String? scheduled;
  String? homeTeam;
  String? awayTeam;
  bool? numHeader;
  String? entryMode;
  String? reference;
  TimeZones? timeZones;
  Venue? venue;
  Broadcast? broadcast;
  Weather? weather;
  Outcome? outcome;
  Home? home;
  Home? away;

  Game(
      {this.id,
      this.status,
      this.coverage,
      this.gameNumber,
      this.dayNight,
      this.scheduled,
      this.homeTeam,
      this.awayTeam,
      this.numHeader,
      this.entryMode,
      this.reference,
      this.timeZones,
      this.venue,
      this.broadcast,
      this.weather,
      this.outcome,
      this.home,
      this.away});

  Game.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    coverage = json['coverage'];
    gameNumber = json['game_number'];
    dayNight = json['day_night'];
    scheduled = json['scheduled'];
    homeTeam = json['home_team'];
    awayTeam = json['away_team'];
    numHeader = json['num_header'];
    entryMode = json['entry_mode'];
    reference = json['reference'];
    timeZones = json['time_zones'] != null
        ? TimeZones.fromJson(json['time_zones'])
        : null;
    venue = json['venue'] != null ? Venue.fromJson(json['venue']) : null;
    broadcast = json['broadcast'] != null
        ? Broadcast.fromJson(json['broadcast'])
        : null;
    weather =
        json['weather'] != null ? Weather.fromJson(json['weather']) : null;
    outcome =
        json['outcome'] != null ? Outcome.fromJson(json['outcome']) : null;
    home = json['home'] != null ? Home.fromJson(json['home']) : null;
    away = json['away'] != null ? Home.fromJson(json['away']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['coverage'] = coverage;
    data['game_number'] = gameNumber;
    data['day_night'] = dayNight;
    data['scheduled'] = scheduled;
    data['home_team'] = homeTeam;
    data['away_team'] = awayTeam;
    data['num_header'] = numHeader;
    data['entry_mode'] = entryMode;
    data['reference'] = reference;
    if (timeZones != null) {
      data['time_zones'] = timeZones!.toJson();
    }
    if (venue != null) {
      data['venue'] = venue!.toJson();
    }
    if (broadcast != null) {
      data['broadcast'] = broadcast!.toJson();
    }
    if (weather != null) {
      data['weather'] = weather!.toJson();
    }
    if (outcome != null) {
      data['outcome'] = outcome!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['venue'] = venue;
    data['home'] = home;
    data['away'] = away;
    return data;
  }
}

class Venue {
  String? name;
  String? market;
  num? capacity;
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
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['market'] = market;
    data['capacity'] = capacity;
    data['surface'] = surface;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['zip'] = zip;
    data['country'] = country;
    data['id'] = id;
    data['field_orientation'] = fieldOrientation;
    data['stadium_type'] = stadiumType;
    data['time_zone'] = timeZone;
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

class Broadcast {
  String? network;

  Broadcast({this.network});

  Broadcast.fromJson(Map<String, dynamic> json) {
    network = json['network'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['network'] = network;
    return data;
  }
}

class Weather {
  Forecast? forecast;
  Forecast? currentConditions;

  Weather({this.forecast, this.currentConditions});

  Weather.fromJson(Map<String, dynamic> json) {
    forecast =
        json['forecast'] != null ? Forecast.fromJson(json['forecast']) : null;
    currentConditions = json['current_conditions'] != null
        ? Forecast.fromJson(json['current_conditions'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (forecast != null) {
      data['forecast'] = forecast!.toJson();
    }
    if (currentConditions != null) {
      data['current_conditions'] = currentConditions!.toJson();
    }
    return data;
  }
}

class Forecast {
  dynamic tempF;
  String? condition;
  num? humidity;
  num? dewPonumF;
  num? cloudCover;
  String? obsTime;
  Wind? wind;

  Forecast(
      {this.tempF,
      this.condition,
      this.humidity,
      this.dewPonumF,
      this.cloudCover,
      this.obsTime,
      this.wind});

  Forecast.fromJson(Map<String, dynamic> json) {
    tempF = json['temp_f'];
    condition = json['condition'];
    humidity = json['humidity'];
    dewPonumF = json['dew_ponum_f'];
    cloudCover = json['cloud_cover'];
    obsTime = json['obs_time'];
    wind = json['wind'] != null ? Wind.fromJson(json['wind']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['temp_f'] = tempF;
    data['condition'] = condition;
    data['humidity'] = humidity;
    data['dew_ponum_f'] = dewPonumF;
    data['cloud_cover'] = cloudCover;
    data['obs_time'] = obsTime;
    if (wind != null) {
      data['wind'] = wind!.toJson();
    }
    return data;
  }
}

class Wind {
  num? speedMph;
  String? direction;

  Wind({this.speedMph, this.direction});

  Wind.fromJson(Map<String, dynamic> json) {
    speedMph = json['speed_mph'];
    direction = json['direction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['speed_mph'] = speedMph;
    data['direction'] = direction;
    return data;
  }
}

class Outcome {
  String? type;
  num? currentInning;
  String? currentInningHalf;
  Count? count;
  Hitter? hitter;
  Pitcher? pitcher;

  Outcome(
      {this.type,
      this.currentInning,
      this.currentInningHalf,
      this.count,
      this.hitter,
      this.pitcher});

  Outcome.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    currentInning = json['current_inning'];
    currentInningHalf = json['current_inning_half'];
    count = json['count'] != null ? Count.fromJson(json['count']) : null;
    hitter = json['hitter'] != null ? Hitter.fromJson(json['hitter']) : null;
    pitcher =
        json['pitcher'] != null ? Pitcher.fromJson(json['pitcher']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['current_inning'] = currentInning;
    data['current_inning_half'] = currentInningHalf;
    if (count != null) {
      data['count'] = count!.toJson();
    }
    if (hitter != null) {
      data['hitter'] = hitter!.toJson();
    }
    if (pitcher != null) {
      data['pitcher'] = pitcher!.toJson();
    }
    return data;
  }
}

class Count {
  num? balls;
  num? strikes;
  num? outs;
  num? inning;
  String? inningHalf;
  bool? halfOver;

  Count(
      {this.balls,
      this.strikes,
      this.outs,
      this.inning,
      this.inningHalf,
      this.halfOver});

  Count.fromJson(Map<String, dynamic> json) {
    balls = json['balls'];
    strikes = json['strikes'];
    outs = json['outs'];
    inning = json['inning'];
    inningHalf = json['inning_half'];
    halfOver = json['half_over'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['balls'] = balls;
    data['strikes'] = strikes;
    data['outs'] = outs;
    data['inning'] = inning;
    data['inning_half'] = inningHalf;
    data['half_over'] = halfOver;
    return data;
  }
}

class Hitter {
  String? preferredName;
  String? firstName;
  String? lastName;
  String? jerseyNumber;
  String? id;
  String? outcomeId;
  bool? abOver;

  Hitter(
      {this.preferredName,
      this.firstName,
      this.lastName,
      this.jerseyNumber,
      this.id,
      this.outcomeId,
      this.abOver});

  Hitter.fromJson(Map<String, dynamic> json) {
    preferredName = json['preferred_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    jerseyNumber = json['jersey_number'];
    id = json['id'];
    outcomeId = json['outcome_id'];
    abOver = json['ab_over'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['preferred_name'] = preferredName;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['jersey_number'] = jerseyNumber;
    data['id'] = id;
    data['outcome_id'] = outcomeId;
    data['ab_over'] = abOver;
    return data;
  }
}

class Pitcher {
  String? preferredName;
  String? firstName;
  String? lastName;
  String? jerseyNumber;
  String? id;
  num? pitchSpeed;
  String? pitchType;
  num? pitchZone;
  num? pitchX;
  num? pitchY;

  Pitcher(
      {this.preferredName,
      this.firstName,
      this.lastName,
      this.jerseyNumber,
      this.id,
      this.pitchSpeed,
      this.pitchType,
      this.pitchZone,
      this.pitchX,
      this.pitchY});

  Pitcher.fromJson(Map<String, dynamic> json) {
    preferredName = json['preferred_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    jerseyNumber = json['jersey_number'];
    id = json['id'];
    pitchSpeed = json['pitch_speed'];
    pitchType = json['pitch_type'];
    pitchZone = json['pitch_zone'];
    pitchX = json['pitch_x'];
    pitchY = json['pitch_y'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['preferred_name'] = preferredName;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['jersey_number'] = jerseyNumber;
    data['id'] = id;
    data['pitch_speed'] = pitchSpeed;
    data['pitch_type'] = pitchType;
    data['pitch_zone'] = pitchZone;
    data['pitch_x'] = pitchX;
    data['pitch_y'] = pitchY;
    return data;
  }
}

class Home {
  String? name;
  String? market;
  String? abbr;
  String? id;
  num? runs;
  num? hits;
  num? errors;
  num? win;
  num? loss;
  CurrentPitcher? probablePitcher;
  CurrentPitcher? startingPitcher;
  CurrentPitcher? currentPitcher;
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
      this.currentPitcher,
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
        ? CurrentPitcher.fromJson(json['probable_pitcher'])
        : null;
    startingPitcher = json['starting_pitcher'] != null
        ? CurrentPitcher.fromJson(json['starting_pitcher'])
        : null;
    currentPitcher = json['current_pitcher'] != null
        ? CurrentPitcher.fromJson(json['current_pitcher'])
        : null;
    if (json['scoring'] != null) {
      scoring = <Scoring>[];
      json['scoring'].forEach((v) {
        scoring!.add(Scoring.fromJson(v));
      });
    }
    if (json['events'] != null) {
      events = <Events>[];
      json['events'].forEach((v) {
        events!.add(Events.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['market'] = market;
    data['abbr'] = abbr;
    data['id'] = id;
    data['runs'] = runs;
    data['hits'] = hits;
    data['errors'] = errors;
    data['win'] = win;
    data['loss'] = loss;
    if (probablePitcher != null) {
      data['probable_pitcher'] = probablePitcher!.toJson();
    }
    if (startingPitcher != null) {
      data['starting_pitcher'] = startingPitcher!.toJson();
    }
    if (currentPitcher != null) {
      data['current_pitcher'] = currentPitcher!.toJson();
    }
    if (scoring != null) {
      data['scoring'] = scoring!.map((v) => v.toJson()).toList();
    }
    if (events != null) {
      data['events'] = events!.map((v) => v.toJson()).toList();
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

  ProbablePitcher(
      {this.preferredName,
      this.firstName,
      this.lastName,
      this.jerseyNumber,
      this.id});

  ProbablePitcher.fromJson(Map<String, dynamic> json) {
    preferredName = json['preferred_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    jerseyNumber = json['jersey_number'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['preferred_name'] = preferredName;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['jersey_number'] = jerseyNumber;
    data['id'] = id;
    return data;
  }
}

class CurrentPitcher {
  String? preferredName;
  String? firstName;
  String? lastName;
  String? jerseyNumber;
  String? id;
  num? win;
  num? loss;
  num? era;

  CurrentPitcher(
      {this.preferredName,
      this.firstName,
      this.lastName,
      this.jerseyNumber,
      this.id,
      this.win,
      this.loss,
      this.era});

  CurrentPitcher.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['preferred_name'] = preferredName;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['jersey_number'] = jerseyNumber;
    data['id'] = id;
    data['win'] = win;
    data['loss'] = loss;
    data['era'] = era;
    return data;
  }
}

class Scoring {
  dynamic number;
  dynamic sequence;
  dynamic runs;
  dynamic hits;
  dynamic errors;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['number'] = number;
    data['sequence'] = sequence;
    data['runs'] = runs;
    data['hits'] = hits;
    data['errors'] = errors;
    data['type'] = type;
    return data;
  }
}

class Events {
  String? hitterId;
  String? pitcherId;
  num? inning;
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
        runners!.add(Runners.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hitter_id'] = hitterId;
    data['pitcher_id'] = pitcherId;
    data['inning'] = inning;
    data['inning_half'] = inningHalf;
    data['type'] = type;
    data['hitter_outcome'] = hitterOutcome;
    data['id'] = id;
    if (runners != null) {
      data['runners'] = runners!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Runners {
  num? startingBase;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['starting_base'] = startingBase;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['preferred_name'] = preferredName;
    data['jersey_number'] = jerseyNumber;
    data['id'] = id;
    return data;
  }
}
