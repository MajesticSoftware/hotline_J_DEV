class MLBGameSummaryResponse {
  String? generatedAt;
  League? league;
  MLBGame? game;

  MLBGameSummaryResponse({this.generatedAt, this.league, this.game});

  MLBGameSummaryResponse.fromJson(Map<String, dynamic> json) {
    generatedAt = json['generated_at'];
    league = json['league'] != null ? League.fromJson(json['league']) : null;
    game = json['game'] != null ? MLBGame.fromJson(json['game']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['generated_at'] = generatedAt;
    if (league != null) {
      data['league'] = league!.toJson();
    }
    if (game != null) {
      data['game'] = game!.toJson();
    }
    return data;
  }
}

class League {
  String? id;
  String? name;
  String? alias;

  League({this.id, this.name, this.alias});

  League.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    alias = json['alias'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['alias'] = alias;
    return data;
  }
}

class MLBGame {
  String? id;
  String? reference;
  String? scheduled;
  dynamic attendance; // Could be int or String in API response
  String? dayNight;
  String? duration;
  String? status;
  String? entryMode;
  String? coverage;
  dynamic gameNumber; // Could be int or String in API response
  bool? doubleHeader;
  bool? splitSquad;
  bool? tbd;
  MLBGameTeam? homeTeam;
  MLBGameTeam? awayTeam;
  MLBGameVenue? venue;
  List<Broadcast>? broadcasts;

  MLBGame({
    this.id,
    this.reference,
    this.scheduled,
    this.attendance,
    this.dayNight,
    this.duration,
    this.status,
    this.entryMode,
    this.coverage,
    this.gameNumber,
    this.doubleHeader,
    this.splitSquad,
    this.tbd,
    this.homeTeam,
    this.awayTeam,
    this.venue,
    this.broadcasts,
  });

  MLBGame.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reference = json['reference'];
    scheduled = json['scheduled'];
    attendance = json['attendance'];
    dayNight = json['day_night'];
    duration = json['duration'];
    status = json['status'];
    entryMode = json['entry_mode'];
    coverage = json['coverage'];
    gameNumber = json['game_number'];
    doubleHeader = json['double_header'];
    splitSquad = json['split_squad'];
    tbd = json['tbd'];
    homeTeam = json['home'] != null ? MLBGameTeam.fromJson(json['home']) : null;
    awayTeam = json['away'] != null ? MLBGameTeam.fromJson(json['away']) : null;
    venue = json['venue'] != null ? MLBGameVenue.fromJson(json['venue']) : null;
    if (json['broadcasts'] != null) {
      broadcasts = <Broadcast>[];
      json['broadcasts'].forEach((v) {
        broadcasts!.add(Broadcast.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['reference'] = reference;
    data['scheduled'] = scheduled;
    data['attendance'] = attendance;
    data['day_night'] = dayNight;
    data['duration'] = duration;
    data['status'] = status;
    data['entry_mode'] = entryMode;
    data['coverage'] = coverage;
    data['game_number'] = gameNumber;
    data['double_header'] = doubleHeader;
    data['split_squad'] = splitSquad;
    data['tbd'] = tbd;
    if (homeTeam != null) {
      data['home'] = homeTeam!.toJson();
    }
    if (awayTeam != null) {
      data['away'] = awayTeam!.toJson();
    }
    if (venue != null) {
      data['venue'] = venue!.toJson();
    }
    if (broadcasts != null) {
      data['broadcasts'] = broadcasts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MLBGameTeam {
  String? id;
  String? name;
  String? market;
  String? abbr;
  dynamic win;  // Could be int or String in API response
  dynamic loss; // Could be int or String in API response
  dynamic seed; // Could be int or String in API response
  String? logoUrl; // Will be populated from another source

  MLBGameTeam({
    this.id,
    this.name,
    this.market,
    this.abbr,
    this.win,
    this.loss,
    this.seed,
    this.logoUrl,
  });

  MLBGameTeam.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    market = json['market'];
    abbr = json['abbr'];
    win = json['win'];
    loss = json['loss'];
    seed = json['seed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['market'] = market;
    data['abbr'] = abbr;
    data['win'] = win;
    data['loss'] = loss;
    data['seed'] = seed;
    data['logo_url'] = logoUrl;
    return data;
  }
}

class MLBGameVenue {
  String? id;
  String? name;
  dynamic capacity; // Could be int or String in API response
  String? address;
  String? city;
  String? state;
  dynamic zip; // Could be int or String in API response

  MLBGameVenue({
    this.id,
    this.name,
    this.capacity,
    this.address,
    this.city,
    this.state,
    this.zip,
  });

  MLBGameVenue.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    capacity = json['capacity']; // Accept any type
    address = json['address'];
    city = json['city'];
    state = json['state'];
    zip = json['zip']; // Accept any type
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['capacity'] = capacity;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['zip'] = zip;
    return data;
  }
}

class Broadcast {
  String? network;
  String? type;
  String? locale;
  String? channel;

  Broadcast({this.network, this.type, this.locale, this.channel});

  Broadcast.fromJson(Map<String, dynamic> json) {
    network = json['network'];
    type = json['type'];
    locale = json['locale'];
    channel = json['channel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['network'] = network;
    data['type'] = type;
    data['locale'] = locale;
    data['channel'] = channel;
    return data;
  }
}