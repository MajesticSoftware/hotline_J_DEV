class GameListingDataModel {
  String? generatedAt;
  String? schema;
  Sport? sport;
  List<SportEvents>? sportEvents;

  GameListingDataModel(
      {this.generatedAt, this.schema, this.sport, this.sportEvents});

  GameListingDataModel.fromJson(Map<String, dynamic> json) {
    generatedAt = json['generated_at'];
    schema = json['schema'];
    sport = json['sport'] != null ? Sport.fromJson(json['sport']) : null;
    if (json['sport_events'] != null) {
      sportEvents = <SportEvents>[];
      json['sport_events'].forEach((v) {
        sportEvents!.add(SportEvents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['generated_at'] = this.generatedAt;
    data['schema'] = this.schema;
    if (this.sport != null) {
      data['sport'] = this.sport!.toJson();
    }
    if (this.sportEvents != null) {
      data['sport_events'] = this.sportEvents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sport {
  String? id;
  String? name;

  Sport({this.id, this.name});

  Sport.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class SportEvents {
  String? id;
  String? scheduled;
  bool? startTimeTbd;
  String? status;
  TournamentRound? tournamentRound;
  Season? season;
  Tournament? tournament;
  List<Competitors> competitors = [];
  Venue? venue;
  List<Markets> markets = [];
  String? marketsLastUpdated;
  Consensus? consensus;
  String? uuids;
  String? homeGameLogo;
  String? awayGameLogo;
  String awayTeam = '';
  String homeTeam = '';
  String homeMoneyLine = '00';
  String homeSpread = '00';
  String homeOU = '00';
  String awayMoneyLine = '00';
  String awaySpread = '00';
  String awayOU = '0';
  String awayScore = '0';
  String homeScore = '0';
  String awayWin = '0';
  String homeWin = '0';
  String awayLoss = '0';
  String homeLoss = '0';
  List awayTeamInjuredPlayer = [];
  List homeTeamInjuredPlayer = [];
  SportEvents({
    this.id,
    this.scheduled,
    this.startTimeTbd,
    this.status,
    this.tournamentRound,
    this.season,
    this.tournament,
    required this.competitors,
    this.venue,
    required this.markets,
    this.marketsLastUpdated,
    this.consensus,
    this.uuids,
    this.awayTeam = '',
    this.homeTeam = '',
    this.homeGameLogo = '',
    this.awayGameLogo = '',
    this.homeMoneyLine = '',
    this.homeSpread = '',
    this.homeOU = '',
    this.awayMoneyLine = '',
    this.awaySpread = '',
    this.awayOU = '',
    this.awayScore = '',
    this.homeScore = '',
    this.awayWin = '',
    this.homeWin = '',
    this.awayLoss = '',
    this.homeLoss = '',
    this.homeTeamInjuredPlayer = const [],
    this.awayTeamInjuredPlayer = const [],
  });

  String get gameHomeLogoLink {
    return homeGameLogo ?? '';
  }

  String get gameLogoAwayLink {
    return awayGameLogo ?? '';
  }

  String get homeMoneyLineValue {
    return homeMoneyLine;
  }

  String get awayMoneyLineValue {
    return awayMoneyLine;
  }

  String get homeSpreadValue {
    return homeSpread;
  }

  String get awaySpreadValue {
    return awaySpread;
  }

  String get awayOUValue {
    return awayOU;
  }

  String get homeOUValue {
    return homeOU;
  }

  SportEvents.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    scheduled = json['scheduled'];
    startTimeTbd = json['start_time_tbd'];
    status = json['status'];
    tournamentRound = json['tournament_round'] != null
        ? TournamentRound.fromJson(json['tournament_round'])
        : null;
    season = json['season'] != null ? Season.fromJson(json['season']) : null;
    tournament = json['tournament'] != null
        ? Tournament.fromJson(json['tournament'])
        : null;
    if (json['competitors'] != null) {
      competitors = <Competitors>[];
      json['competitors'].forEach((v) {
        competitors!.add(Competitors.fromJson(v));
      });
    }
    venue = json['venue'] != null ? Venue.fromJson(json['venue']) : null;
    if (json['markets'] != null) {
      markets = <Markets>[];
      json['markets'].forEach((v) {
        markets!.add(Markets.fromJson(v));
      });
    }
    marketsLastUpdated = json['markets_last_updated'];
    consensus = json['consensus'] != null
        ? Consensus.fromJson(json['consensus'])
        : null;
    uuids = json['uuids'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['scheduled'] = this.scheduled;
    data['start_time_tbd'] = this.startTimeTbd;
    data['status'] = this.status;
    if (this.tournamentRound != null) {
      data['tournament_round'] = this.tournamentRound!.toJson();
    }
    if (this.season != null) {
      data['season'] = this.season!.toJson();
    }
    if (this.tournament != null) {
      data['tournament'] = this.tournament!.toJson();
    }
    if (this.competitors != null) {
      data['competitors'] = this.competitors!.map((v) => v.toJson()).toList();
    }
    if (this.venue != null) {
      data['venue'] = this.venue!.toJson();
    }
    if (this.markets != null) {
      data['markets'] = this.markets!.map((v) => v.toJson()).toList();
    }
    data['markets_last_updated'] = this.marketsLastUpdated;
    if (this.consensus != null) {
      data['consensus'] = this.consensus!.toJson();
    }
    data['uuids'] = this.uuids;
    return data;
  }
}

class TournamentRound {
  String? type;
  num? number;
  String? group;

  TournamentRound({this.type, this.number, this.group});

  TournamentRound.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    number = json['number'];
    group = json['group'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['type'] = this.type;
    data['number'] = this.number;
    data['group'] = this.group;
    return data;
  }
}

class Season {
  String? id;
  String? name;
  String? startDate;
  String? endDate;
  String? year;
  String? tournamentId;
  String? uuids;

  Season(
      {this.id,
      this.name,
      this.startDate,
      this.endDate,
      this.year,
      this.tournamentId,
      this.uuids});

  Season.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    year = json['year'];
    tournamentId = json['tournament_id'];
    uuids = json['uuids'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['year'] = this.year;
    data['tournament_id'] = this.tournamentId;
    data['uuids'] = this.uuids;
    return data;
  }
}

class Tournament {
  String? id;
  String? name;
  Sport? sport;
  Category? category;
  String? uuids;

  Tournament({this.id, this.name, this.sport, this.category, this.uuids});

  Tournament.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sport = json['sport'] != null ? Sport.fromJson(json['sport']) : null;
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    uuids = json['uuids'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.sport != null) {
      data['sport'] = this.sport!.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    data['uuids'] = this.uuids;
    return data;
  }
}

class Category {
  String? id;
  String? name;
  String? countryCode;

  Category({this.id, this.name, this.countryCode});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    countryCode = json['country_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['country_code'] = this.countryCode;
    return data;
  }
}

class Competitors {
  String? id;
  String? name;
  String? country;
  String? countryCode;
  String? abbreviation;
  String? qualifier;
  num? rotationNumber;
  String? uuids;

  Competitors({
    this.id,
    this.name,
    this.country,
    this.countryCode,
    this.abbreviation,
    this.qualifier,
    this.rotationNumber,
    this.uuids,
  });

  Competitors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    country = json['country'];
    countryCode = json['country_code'];
    abbreviation = json['abbreviation'];
    qualifier = json['qualifier'];
    rotationNumber = json['rotation_number'];
    uuids = json['uuids'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['country'] = this.country;
    data['country_code'] = this.countryCode;
    data['abbreviation'] = this.abbreviation;
    data['qualifier'] = this.qualifier;
    data['rotation_number'] = this.rotationNumber;
    data['uuids'] = this.uuids;
    return data;
  }
}

class Venue {
  String? id;
  String? name;
  num? capacity;
  String? cityName;
  String? countryName;
  String? mapCoordinates;
  String? countryCode;
  String? uuids;
  int? temp;
  int? weather;

  int get tmpInFahrenheit {
    return temp == 0 ? 0 : temp ?? 0;
  }

  Venue(
      {this.id,
      this.name,
      this.capacity,
      this.cityName,
      this.countryName,
      this.mapCoordinates,
      this.countryCode,
      this.temp = 0,
      this.weather = 0,
      this.uuids});

  Venue.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    capacity = json['capacity'];
    cityName = json['city_name'];
    countryName = json['country_name'];
    mapCoordinates = json['map_coordinates'];
    countryCode = json['country_code'];
    uuids = json['uuids'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['capacity'] = this.capacity;
    data['city_name'] = this.cityName;
    data['country_name'] = this.countryName;
    data['map_coordinates'] = this.mapCoordinates;
    data['country_code'] = this.countryCode;
    data['uuids'] = this.uuids;
    return data;
  }
}

class Markets {
  num? oddsTypeId;
  String? name;
  String? groupName;
  List<Books> books = [];

  Markets({this.oddsTypeId, this.name, this.groupName, required this.books});

  Markets.fromJson(Map<String, dynamic> json) {
    oddsTypeId = json['odds_type_id'];
    name = json['name'];
    groupName = json['group_name'];
    if (json['books'] != null) {
      books = <Books>[];
      json['books'].forEach((v) {
        books.add(Books.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['odds_type_id'] = this.oddsTypeId;
    data['name'] = this.name;
    data['group_name'] = this.groupName;
    if (this.books != null) {
      data['books'] = this.books!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Books {
  String? id;
  String name = '';
  List<Outcomes>? outcomes;
  bool? removed;

  Books({this.id, required this.name, this.outcomes, this.removed});

  Books.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['outcomes'] != null) {
      outcomes = <Outcomes>[];
      json['outcomes'].forEach((v) {
        outcomes!.add(Outcomes.fromJson(v));
      });
    }
    removed = json['removed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.outcomes != null) {
      data['outcomes'] = this.outcomes!.map((v) => v.toJson()).toList();
    }
    data['removed'] = this.removed;
    return data;
  }
}

class Outcomes {
  num? oddsFieldId;
  String? type;
  String? odds;
  String? openingOdds;
  String? oddsTrend;
  num? openingTotal;
  String? total;
  String? spread;
  num? openingSpread;

  Outcomes(
      {this.oddsFieldId,
      this.type,
      this.odds,
      this.openingOdds,
      this.oddsTrend,
      this.openingTotal,
      this.total,
      this.spread,
      this.openingSpread});

  Outcomes.fromJson(Map<String, dynamic> json) {
    oddsFieldId = json['odds_field_id'];
    type = json['type'];
    odds = json['odds'];
    openingOdds = json['opening_odds'];
    oddsTrend = json['odds_trend'];
    openingTotal = json['opening_total'];
    total = json['total'];
    spread = json['spread'];
    openingSpread = json['opening_spread'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['odds_field_id'] = this.oddsFieldId;
    data['type'] = this.type;
    data['odds'] = this.odds;
    data['opening_odds'] = this.openingOdds;
    data['odds_trend'] = this.oddsTrend;
    data['opening_total'] = this.openingTotal;
    data['total'] = this.total;
    data['spread'] = this.spread;
    data['opening_spread'] = this.openingSpread;
    return data;
  }
}

class Consensus {
  List<Lines>? lines;
  List<BetPercentageOutcomes>? betPercentageOutcomes;

  Consensus({this.lines, this.betPercentageOutcomes});

  Consensus.fromJson(Map<String, dynamic> json) {
    if (json['lines'] != null) {
      lines = <Lines>[];
      json['lines'].forEach((v) {
        lines!.add(Lines.fromJson(v));
      });
    }
    if (json['bet_percentage_outcomes'] != null) {
      betPercentageOutcomes = <BetPercentageOutcomes>[];
      json['bet_percentage_outcomes'].forEach((v) {
        betPercentageOutcomes!.add(BetPercentageOutcomes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.lines != null) {
      data['lines'] = this.lines!.map((v) => v.toJson()).toList();
    }
    if (this.betPercentageOutcomes != null) {
      data['bet_percentage_outcomes'] =
          this.betPercentageOutcomes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Lines {
  String? name;
  List<Outcomes>? outcomes;
  String? spread;
  String? total;
  String? lastUpdated;

  Lines({this.name, this.outcomes, this.spread, this.total, this.lastUpdated});

  Lines.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['outcomes'] != null) {
      outcomes = <Outcomes>[];
      json['outcomes'].forEach((v) {
        outcomes!.add(Outcomes.fromJson(v));
      });
    }
    spread = json['spread'];
    total = json['total'];
    lastUpdated = json['last_updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    if (this.outcomes != null) {
      data['outcomes'] = this.outcomes!.map((v) => v.toJson()).toList();
    }
    data['spread'] = this.spread;
    data['total'] = this.total;
    data['last_updated'] = this.lastUpdated;
    return data;
  }
}

class BetPercentageOutcomes {
  String? name;
  List<Outcomes>? outcomes;

  BetPercentageOutcomes({this.name, this.outcomes});

  BetPercentageOutcomes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['outcomes'] != null) {
      outcomes = <Outcomes>[];
      json['outcomes'].forEach((v) {
        outcomes!.add(Outcomes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    if (this.outcomes != null) {
      data['outcomes'] = this.outcomes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
