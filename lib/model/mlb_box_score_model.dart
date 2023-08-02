class MLBBoxScoreModel {
  MLBBoxScoreModel({
    required this.game,
  });
  late final Game game;

  MLBBoxScoreModel.fromJson(Map<String, dynamic> json) {
    game = Game.fromJson(json['game']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['game'] = game.toJson();
    return _data;
  }
}

class Game {
  Game({
    required this.id,
    required this.status,
    required this.coverage,
    required this.gameNumber,
    required this.dayNight,
    required this.scheduled,
    required this.homeTeam,
    required this.awayTeam,
    required this.attendance,
    required this.duration,
    required this.doubleHeader,
    required this.entryMode,
    required this.reference,
    required this.timeZones,
    required this.venue,
    required this.broadcast,
    required this.weather,
    required this.home,
    required this.away,
    required this.pitching,
  });
  late final String id;
  late final String status;
  late final String coverage;
  late final int gameNumber;
  late final String dayNight;
  late final String scheduled;
  late final String homeTeam;
  late final String awayTeam;
  late final int attendance;
  late final String duration;
  late final bool doubleHeader;
  late final String entryMode;
  late final String reference;
  late final TimeZones timeZones;
  late final Venue venue;
  late final Broadcast broadcast;
  late final Weather weather;

  late final Home home;
  late final Away away;
  late final Pitching pitching;

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
    duration = json['duration'];
    doubleHeader = json['double_header'];
    entryMode = json['entry_mode'];
    reference = json['reference'];
    timeZones = TimeZones.fromJson(json['time_zones']);
    venue = Venue.fromJson(json['venue']);
    broadcast = Broadcast.fromJson(json['broadcast']);
    weather = Weather.fromJson(json['weather']);
    home = Home.fromJson(json['home']);
    away = Away.fromJson(json['away']);
    pitching = Pitching.fromJson(json['pitching']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['status'] = status;
    _data['coverage'] = coverage;
    _data['game_number'] = gameNumber;
    _data['day_night'] = dayNight;
    _data['scheduled'] = scheduled;
    _data['home_team'] = homeTeam;
    _data['away_team'] = awayTeam;
    _data['attendance'] = attendance;
    _data['duration'] = duration;
    _data['double_header'] = doubleHeader;
    _data['entry_mode'] = entryMode;
    _data['reference'] = reference;
    _data['time_zones'] = timeZones.toJson();
    _data['venue'] = venue.toJson();
    _data['broadcast'] = broadcast.toJson();
    _data['weather'] = weather.toJson();
    _data['home'] = home.toJson();
    _data['away'] = away.toJson();
    _data['pitching'] = pitching.toJson();
    return _data;
  }
}

class TimeZones {
  TimeZones({
    required this.venue,
    required this.home,
    required this.away,
  });
  late final String venue;
  late final String home;
  late final String away;

  TimeZones.fromJson(Map<String, dynamic> json) {
    venue = json['venue'];
    home = json['home'];
    away = json['away'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['venue'] = venue;
    _data['home'] = home;
    _data['away'] = away;
    return _data;
  }
}

class Venue {
  Venue({
    required this.name,
    required this.market,
    required this.capacity,
    required this.surface,
    required this.address,
    required this.city,
    required this.state,
    required this.zip,
    required this.country,
    required this.id,
    required this.fieldOrientation,
    required this.stadiumType,
    required this.timeZone,
    required this.location,
  });
  late final String name;
  late final String market;
  late final int capacity;
  late final String surface;
  late final String address;
  late final String city;
  late final String state;
  late final String zip;
  late final String country;
  late final String id;
  late final String fieldOrientation;
  late final String stadiumType;
  late final String timeZone;
  late final Location location;

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
    location = Location.fromJson(json['location']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['market'] = market;
    _data['capacity'] = capacity;
    _data['surface'] = surface;
    _data['address'] = address;
    _data['city'] = city;
    _data['state'] = state;
    _data['zip'] = zip;
    _data['country'] = country;
    _data['id'] = id;
    _data['field_orientation'] = fieldOrientation;
    _data['stadium_type'] = stadiumType;
    _data['time_zone'] = timeZone;
    _data['location'] = location.toJson();
    return _data;
  }
}

class Location {
  Location({
    required this.lat,
    required this.lng,
  });
  late final String lat;
  late final String lng;

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['lat'] = lat;
    _data['lng'] = lng;
    return _data;
  }
}

class Broadcast {
  Broadcast({
    required this.network,
  });
  late final String network;

  Broadcast.fromJson(Map<String, dynamic> json) {
    network = json['network'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['network'] = network;
    return _data;
  }
}

class Weather {
  Weather({
    required this.forecast,
    required this.currentConditions,
  });
  late final Forecast forecast;
  late final CurrentConditions currentConditions;

  Weather.fromJson(Map<String, dynamic> json) {
    forecast = Forecast.fromJson(json['forecast']);
    currentConditions = CurrentConditions.fromJson(json['current_conditions']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['forecast'] = forecast.toJson();
    _data['current_conditions'] = currentConditions.toJson();
    return _data;
  }
}

class Forecast {
  Forecast({
    required this.tempF,
    required this.condition,
    required this.humidity,
    required this.dewPointF,
    required this.cloudCover,
    required this.obsTime,
    required this.wind,
  });
  late final int tempF;
  late final String condition;
  late final int humidity;
  late final int dewPointF;
  late final int cloudCover;
  late final String obsTime;
  late final Wind wind;

  Forecast.fromJson(Map<String, dynamic> json) {
    tempF = json['temp_f'];
    condition = json['condition'];
    humidity = json['humidity'];
    dewPointF = json['dew_point_f'];
    cloudCover = json['cloud_cover'];
    obsTime = json['obs_time'];
    wind = Wind.fromJson(json['wind']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['temp_f'] = tempF;
    _data['condition'] = condition;
    _data['humidity'] = humidity;
    _data['dew_point_f'] = dewPointF;
    _data['cloud_cover'] = cloudCover;
    _data['obs_time'] = obsTime;
    _data['wind'] = wind.toJson();
    return _data;
  }
}

class Wind {
  Wind({
    required this.speedMph,
    required this.direction,
  });
  late final int speedMph;
  late final String direction;

  Wind.fromJson(Map<String, dynamic> json) {
    speedMph = json['speed_mph'];
    direction = json['direction'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['speed_mph'] = speedMph;
    _data['direction'] = direction;
    return _data;
  }
}

class CurrentConditions {
  CurrentConditions({
    required this.tempF,
    required this.condition,
    required this.humidity,
    required this.dewPointF,
    required this.cloudCover,
    required this.obsTime,
    required this.wind,
  });
  late final int tempF;
  late final String condition;
  late final int humidity;
  late final int dewPointF;
  late final int cloudCover;
  late final String obsTime;
  late final Wind wind;

  CurrentConditions.fromJson(Map<String, dynamic> json) {
    tempF = json['temp_f'];
    condition = json['condition'];
    humidity = json['humidity'];
    dewPointF = json['dew_point_f'];
    cloudCover = json['cloud_cover'];
    obsTime = json['obs_time'];
    wind = Wind.fromJson(json['wind']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['temp_f'] = tempF;
    _data['condition'] = condition;
    _data['humidity'] = humidity;
    _data['dew_point_f'] = dewPointF;
    _data['cloud_cover'] = cloudCover;
    _data['obs_time'] = obsTime;
    _data['wind'] = wind.toJson();
    return _data;
  }
}

class Final {
  Final({
    required this.inning,
    required this.inningHalf,
  });
  late final int inning;
  late final String inningHalf;

  Final.fromJson(Map<String, dynamic> json) {
    inning = json['inning'];
    inningHalf = json['inning_half'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['inning'] = inning;
    _data['inning_half'] = inningHalf;
    return _data;
  }
}

class Home {
  Home({
    required this.name,
    required this.market,
    required this.abbr,
    required this.id,
    required this.runs,
    required this.hits,
    required this.errors,
    required this.win,
    required this.loss,
    required this.probablePitcher,
    required this.startingPitcher,
    required this.scoring,
    required this.events,
  });
  late final String name;
  late final String market;
  late final String abbr;
  late final String id;
  late final int runs;
  late final int hits;
  late final int errors;
  late final int win;
  late final int loss;
  late final ProbablePitcher probablePitcher;
  late final StartingPitcher startingPitcher;
  late final List<Scoring> scoring;
  late final List<Events> events;

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
    probablePitcher = ProbablePitcher.fromJson(json['probable_pitcher']);
    startingPitcher = StartingPitcher.fromJson(json['starting_pitcher']);
    scoring =
        List.from(json['scoring']).map((e) => Scoring.fromJson(e)).toList();
    events = List.from(json['events']).map((e) => Events.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['market'] = market;
    _data['abbr'] = abbr;
    _data['id'] = id;
    _data['runs'] = runs;
    _data['hits'] = hits;
    _data['errors'] = errors;
    _data['win'] = win;
    _data['loss'] = loss;
    _data['probable_pitcher'] = probablePitcher.toJson();
    _data['starting_pitcher'] = startingPitcher.toJson();
    _data['scoring'] = scoring.map((e) => e.toJson()).toList();
    _data['events'] = events.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ProbablePitcher {
  ProbablePitcher({
    required this.preferredName,
    required this.firstName,
    required this.lastName,
    required this.jerseyNumber,
    required this.id,
    required this.win,
    required this.loss,
    required this.era,
  });
  late final String preferredName;
  late final String firstName;
  late final String lastName;
  late final String jerseyNumber;
  late final String id;
  late final int win;
  late final int loss;
  late final double era;

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
    final _data = <String, dynamic>{};
    _data['preferred_name'] = preferredName;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['jersey_number'] = jerseyNumber;
    _data['id'] = id;
    _data['win'] = win;
    _data['loss'] = loss;
    _data['era'] = era;
    return _data;
  }
}

class StartingPitcher {
  StartingPitcher({
    required this.preferredName,
    required this.firstName,
    required this.lastName,
    required this.jerseyNumber,
    required this.id,
    required this.win,
    required this.loss,
    required this.era,
  });
  late final String preferredName;
  late final String firstName;
  late final String lastName;
  late final String jerseyNumber;
  late final String id;
  late final int win;
  late final int loss;
  late final double era;

  StartingPitcher.fromJson(Map<String, dynamic> json) {
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
    final _data = <String, dynamic>{};
    _data['preferred_name'] = preferredName;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['jersey_number'] = jerseyNumber;
    _data['id'] = id;
    _data['win'] = win;
    _data['loss'] = loss;
    _data['era'] = era;
    return _data;
  }
}

class Scoring {
  Scoring({
    required this.number,
    required this.sequence,
    required this.runs,
    required this.hits,
    required this.errors,
    required this.type,
  });
  late final int number;
  late final int sequence;
  late final int runs;
  late final int hits;
  late final int errors;
  late final String type;

  Scoring.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    sequence = json['sequence'];
    runs = json['runs'];
    hits = json['hits'];
    errors = json['errors'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['number'] = number;
    _data['sequence'] = sequence;
    _data['runs'] = runs;
    _data['hits'] = hits;
    _data['errors'] = errors;
    _data['type'] = type;
    return _data;
  }
}

class Events {
  Events({
    required this.hitterId,
    required this.pitcherId,
    required this.inning,
    required this.inningHalf,
    required this.type,
    required this.hitterOutcome,
    required this.id,
    required this.runners,
  });
  late final String hitterId;
  late final String pitcherId;
  late final int inning;
  late final String inningHalf;
  late final String type;
  late final String hitterOutcome;
  late final String id;
  late final List<Runners> runners;

  Events.fromJson(Map<String, dynamic> json) {
    hitterId = json['hitter_id'];
    pitcherId = json['pitcher_id'];
    inning = json['inning'];
    inningHalf = json['inning_half'];
    type = json['type'];
    hitterOutcome = json['hitter_outcome'];
    id = json['id'];
    runners =
        List.from(json['runners']).map((e) => Runners.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['hitter_id'] = hitterId;
    _data['pitcher_id'] = pitcherId;
    _data['inning'] = inning;
    _data['inning_half'] = inningHalf;
    _data['type'] = type;
    _data['hitter_outcome'] = hitterOutcome;
    _data['id'] = id;
    _data['runners'] = runners.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Runners {
  Runners({
    required this.startingBase,
    required this.firstName,
    required this.lastName,
    required this.preferredName,
    required this.jerseyNumber,
    required this.id,
  });
  late final int startingBase;
  late final String firstName;
  late final String lastName;
  late final String preferredName;
  late final String jerseyNumber;
  late final String id;

  Runners.fromJson(Map<String, dynamic> json) {
    startingBase = json['starting_base'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    preferredName = json['preferred_name'];
    jerseyNumber = json['jersey_number'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['starting_base'] = startingBase;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['preferred_name'] = preferredName;
    _data['jersey_number'] = jerseyNumber;
    _data['id'] = id;
    return _data;
  }
}

class Away {
  Away({
    required this.name,
    required this.market,
    required this.abbr,
    required this.id,
    required this.runs,
    required this.hits,
    required this.errors,
    required this.win,
    required this.loss,
    required this.probablePitcher,
    required this.startingPitcher,
    required this.scoring,
    required this.events,
  });
  late final String name;
  late final String market;
  late final String abbr;
  late final String id;
  late final int runs;
  late final int hits;
  late final int errors;
  late final int win;
  late final int loss;
  late final ProbablePitcher probablePitcher;
  late final StartingPitcher startingPitcher;
  late final List<Scoring> scoring;
  late final List<Events> events;

  Away.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    market = json['market'];
    abbr = json['abbr'];
    id = json['id'];
    runs = json['runs'];
    hits = json['hits'];
    errors = json['errors'];
    win = json['win'];
    loss = json['loss'];
    probablePitcher = ProbablePitcher.fromJson(json['probable_pitcher']);
    startingPitcher = StartingPitcher.fromJson(json['starting_pitcher']);
    scoring =
        List.from(json['scoring']).map((e) => Scoring.fromJson(e)).toList();
    events = List.from(json['events']).map((e) => Events.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['market'] = market;
    _data['abbr'] = abbr;
    _data['id'] = id;
    _data['runs'] = runs;
    _data['hits'] = hits;
    _data['errors'] = errors;
    _data['win'] = win;
    _data['loss'] = loss;
    _data['probable_pitcher'] = probablePitcher.toJson();
    _data['starting_pitcher'] = startingPitcher.toJson();
    _data['scoring'] = scoring.map((e) => e.toJson()).toList();
    _data['events'] = events.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Pitching {
  Pitching({
    required this.win,
    required this.loss,
  });
  late final Win win;
  late final Loss loss;

  Pitching.fromJson(Map<String, dynamic> json) {
    win = Win.fromJson(json['win']);
    loss = Loss.fromJson(json['loss']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['win'] = win.toJson();
    _data['loss'] = loss.toJson();
    return _data;
  }
}

class Win {
  Win({
    required this.preferredName,
    required this.firstName,
    required this.lastName,
    required this.jerseyNumber,
    required this.status,
    required this.position,
    required this.primaryPosition,
    required this.id,
    required this.win,
    required this.loss,
    required this.save,
    required this.hold,
    required this.blownSave,
  });
  late final String preferredName;
  late final String firstName;
  late final String lastName;
  late final String jerseyNumber;
  late final String status;
  late final String position;
  late final String primaryPosition;
  late final String id;
  late final int win;
  late final int loss;
  late final int save;
  late final int hold;
  late final int blownSave;

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
    final _data = <String, dynamic>{};
    _data['preferred_name'] = preferredName;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['jersey_number'] = jerseyNumber;
    _data['status'] = status;
    _data['position'] = position;
    _data['primary_position'] = primaryPosition;
    _data['id'] = id;
    _data['win'] = win;
    _data['loss'] = loss;
    _data['save'] = save;
    _data['hold'] = hold;
    _data['blown_save'] = blownSave;
    return _data;
  }
}

class Loss {
  Loss({
    required this.preferredName,
    required this.firstName,
    required this.lastName,
    required this.jerseyNumber,
    required this.status,
    required this.position,
    required this.primaryPosition,
    required this.id,
    required this.win,
    required this.loss,
    required this.save,
    required this.hold,
    required this.blownSave,
  });
  late final String preferredName;
  late final String firstName;
  late final String lastName;
  late final String jerseyNumber;
  late final String status;
  late final String position;
  late final String primaryPosition;
  late final String id;
  late final int win;
  late final int loss;
  late final int save;
  late final int hold;
  late final int blownSave;

  Loss.fromJson(Map<String, dynamic> json) {
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
    final _data = <String, dynamic>{};
    _data['preferred_name'] = preferredName;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['jersey_number'] = jerseyNumber;
    _data['status'] = status;
    _data['position'] = position;
    _data['primary_position'] = primaryPosition;
    _data['id'] = id;
    _data['win'] = win;
    _data['loss'] = loss;
    _data['save'] = save;
    _data['hold'] = hold;
    _data['blown_save'] = blownSave;
    return _data;
  }
}
