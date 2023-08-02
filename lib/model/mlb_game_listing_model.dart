class MLBGameListingModel {
  MLBGameListingModel({
    required this.league,
    required this.date,
    required this.games,
  });
  late final League league;
  late final String date;
  late final List<Games> games;

  MLBGameListingModel.fromJson(Map<String, dynamic> json) {
    league = League.fromJson(json['league']);
    date = json['date'];
    games = List.from(json['games']).map((e) => Games.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['league'] = league.toJson();
    _data['date'] = date;
    _data['games'] = games.map((e) => e.toJson()).toList();

    return _data;
  }
}

class League {
  League({
    required this.alias,
    required this.name,
    required this.id,
  });
  late final String alias;
  late final String name;
  late final String id;

  League.fromJson(Map<String, dynamic> json) {
    alias = json['alias'];
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['alias'] = alias;
    _data['name'] = name;
    _data['id'] = id;
    return _data;
  }
}

class Games {
  Games({
    required this.id,
    required this.status,
    required this.coverage,
    required this.gameNumber,
    required this.dayNight,
    required this.scheduled,
    required this.homeTeam,
    required this.awayTeam,
    required this.doubleHeader,
    required this.entryMode,
    required this.reference,
    required this.venue,
    required this.home,
    required this.away,
    required this.broadcast,
  });
  late final String id;
  late final String status;
  late final String coverage;
  late final int gameNumber;
  late final String dayNight;
  late final String scheduled;
  late final String homeTeam;
  late final String awayTeam;
  late final bool doubleHeader;
  late final String entryMode;
  late final String reference;
  late final Venue venue;
  late final Home home;
  late final Away away;
  late final Broadcast broadcast;

  Games.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    coverage = json['coverage'];
    gameNumber = json['game_number'];
    dayNight = json['day_night'];
    scheduled = json['scheduled'];
    homeTeam = json['home_team'];
    awayTeam = json['away_team'];
    doubleHeader = json['double_header'];
    entryMode = json['entry_mode'];
    reference = json['reference'];
    venue = Venue.fromJson(json['venue']);
    home = Home.fromJson(json['home']);
    away = Away.fromJson(json['away']);
    broadcast = Broadcast.fromJson(json['broadcast']);
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
    _data['double_header'] = doubleHeader;
    _data['entry_mode'] = entryMode;
    _data['reference'] = reference;
    _data['venue'] = venue.toJson();
    _data['home'] = home.toJson();
    _data['away'] = away.toJson();
    _data['broadcast'] = broadcast.toJson();
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
    this.temp = 0,
    this.weather = 0,
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
  int? temp;
  int? weather;
  int get tmpInFahrenheit {
    return temp == 0 ? 0 : (((temp ?? 0) - 273.15) * (9 / 5) + 32).toInt();
  }

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

class Home {
  Home({
    required this.name,
    required this.market,
    required this.abbr,
    required this.id,
    this.homeGameLogo = '',
    this.homeScore = '',
    this.spreadHomeRecord = '',
  });
  late final String name;
  late final String market;
  late final String abbr;
  late final String id;
  String? homeGameLogo;

  String? homeScore;

  String? spreadHomeRecord;
  String get liveSpreadHomeRecord {
    return (spreadHomeRecord ?? "").isEmpty ? '0-0' : spreadHomeRecord ?? '';
  }

  String get homeLiveScores {
    return (homeScore ?? "").isEmpty ? '0' : homeScore ?? "";
  }

  String get gameHomeLogoLink {
    return homeGameLogo ?? '';
  }

  Home.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    market = json['market'];
    abbr = json['abbr'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['market'] = market;
    _data['abbr'] = abbr;
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
    this.awayGameLogo = '',
    this.awayScore = '',
    this.spreadAwayRecord = '',
  });
  late final String name;
  late final String market;
  late final String abbr;
  late final String id;
  String? awayGameLogo;
  String? awayScore;
  String? spreadAwayRecord;

  String get liveSpreadAwayRecord {
    return (spreadAwayRecord ?? "").isEmpty ? '0-0' : spreadAwayRecord ?? '';
  }

  String get gameLogoAwayLink {
    return awayGameLogo ?? '';
  }

  String get awayLiveScores {
    return (awayScore ?? "").isEmpty ? '0' : awayScore ?? "";
  }

  Away.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    market = json['market'];
    abbr = json['abbr'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['market'] = market;
    _data['abbr'] = abbr;
    _data['id'] = id;
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
