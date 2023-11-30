import 'nba_player_profile_model.dart' as pro;
import 'nfl_statics_model.dart';
import 'nba_roster_model.dart' as nba;

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['generated_at'] = generatedAt;
    data['schema'] = schema;
    if (sport != null) {
      data['sport'] = sport!.toJson();
    }
    if (sportEvents != null) {
      data['sport_events'] = sportEvents!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class SportEvents {
  String? id;
  String currentTime = "";
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
  String awayTeamAbb = '';
  String homeTeam = '';
  String homeTeamAbb = '';
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
  String inning = '0';
  String inningHalf = 'T';
  String wlHome = '0';
  String wlAway = '0';
  String eraHome = '0';
  String eraAway = '0';
  String awayPlayerId = '';
  String homePlayerId = '';
  String homePlayerName = '';
  String awayPlayerName = '';
  String awayRushingYard = '0';
  String awayPassingYard = '0';
  String awayRushingTds = '0';
  String awayPassingTds = '0';
  String awayInterCaption = '0';
  String homeRushingYard = '0';
  String homePassingYard = '0';
  String homeRushingTds = '0';
  String homePassingTds = '0';
  String homeInterCaption = '0';
  String homeFumble = '0';
  String awayFumble = '0';
  String awayRank = '0';
  String homeRank = '0';
  List awayTeamInjuredPlayer = [];
  List<Players> awayReceiversPlayer = [];
  List<Players> homeReceiversPlayer = [];
  List<Players> awayRunningBackPlayer = [];
  List<Players> homeRunningBackPlayer = [];
  List<pro.Total> homeRushingPlayer = [];
  List<pro.Total> awayRushingPlayer = [];
  List<nba.Players> homeRushingPlayerName = [];
  List<nba.Players> awayRushingPlayerName = [];
  List homeTeamInjuredPlayer = [];
  num temp = 273.15;
  int weather = 805;
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
    this.currentTime = "",
    this.awayTeam = '',
    this.awayTeamAbb = '',
    this.homeTeam = '',
    this.homeTeamAbb = '',
    this.homeGameLogo = '',
    this.awayGameLogo = '',
    this.homeMoneyLine = '0',
    this.homeSpread = '0',
    this.homeOU = '0',
    this.awayMoneyLine = '',
    this.awaySpread = '0',
    this.awayOU = '0',
    this.awayScore = '0',
    this.homeScore = '0',
    this.awayWin = '0',
    this.homeWin = '0',
    this.awayLoss = '0',
    this.homeLoss = '0',
    this.eraHome = "0",
    this.eraAway = "0",
    this.wlHome = "0",
    this.wlAway = '0',
    this.awayRushingYard = '0',
    this.awayPassingYard = '0',
    this.awayRushingTds = '0',
    this.awayPassingTds = '0',
    this.awayInterCaption = '0',
    this.homeRushingYard = '0',
    this.homePassingYard = '0',
    this.homeRushingTds = '0',
    this.homePassingTds = '0',
    this.homeInterCaption = '0',
    this.homeFumble = '0',
    this.awayFumble = '0',
    this.awayPlayerId = '',
    this.homePlayerId = '',
    this.awayRank = '',
    this.homeRank = '',
    this.temp = 273.15,
    this.weather = 805,
    this.homeTeamInjuredPlayer = const [],
    this.awayTeamInjuredPlayer = const [],
    this.awayReceiversPlayer = const [],
    this.homeReceiversPlayer = const [],
    this.awayRunningBackPlayer = const [],
    this.homeRunningBackPlayer = const [],
  });
  num get tmpInFahrenheit {
    return ((((temp) - 273.15) * (9 / 5))) + 32;
  }

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
        competitors.add(Competitors.fromJson(v));
      });
    }
    venue = json['venue'] != null ? Venue.fromJson(json['venue']) : null;
    if (json['markets'] != null) {
      markets = <Markets>[];
      json['markets'].forEach((v) {
        markets.add(Markets.fromJson(v));
      });
    }
    marketsLastUpdated = json['markets_last_updated'];
    consensus = json['consensus'] != null
        ? Consensus.fromJson(json['consensus'])
        : null;
    uuids = json['uuids'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['scheduled'] = scheduled;
    data['start_time_tbd'] = startTimeTbd;
    data['status'] = status;
    if (tournamentRound != null) {
      data['tournament_round'] = tournamentRound!.toJson();
    }
    if (season != null) {
      data['season'] = season!.toJson();
    }
    if (tournament != null) {
      data['tournament'] = tournament!.toJson();
    }
    data['competitors'] = competitors.map((v) => v.toJson()).toList();
    if (venue != null) {
      data['venue'] = venue!.toJson();
    }
    data['markets'] = markets.map((v) => v.toJson()).toList();
    data['markets_last_updated'] = marketsLastUpdated;
    if (consensus != null) {
      data['consensus'] = consensus!.toJson();
    }
    data['uuids'] = uuids;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['number'] = number;
    data['group'] = group;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['year'] = year;
    data['tournament_id'] = tournamentId;
    data['uuids'] = uuids;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (sport != null) {
      data['sport'] = sport!.toJson();
    }
    if (category != null) {
      data['category'] = category!.toJson();
    }
    data['uuids'] = uuids;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['country_code'] = countryCode;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['country'] = country;
    data['country_code'] = countryCode;
    data['abbreviation'] = abbreviation;
    data['qualifier'] = qualifier;
    data['rotation_number'] = rotationNumber;
    data['uuids'] = uuids;
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

  Venue(
      {this.id,
      this.name,
      this.capacity,
      this.cityName,
      this.countryName,
      this.mapCoordinates,
      this.countryCode,
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['capacity'] = capacity;
    data['city_name'] = cityName;
    data['country_name'] = countryName;
    data['map_coordinates'] = mapCoordinates;
    data['country_code'] = countryCode;
    data['uuids'] = uuids;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['odds_type_id'] = oddsTypeId;
    data['name'] = name;
    data['group_name'] = groupName;
    data['books'] = books.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (outcomes != null) {
      data['outcomes'] = outcomes!.map((v) => v.toJson()).toList();
    }
    data['removed'] = removed;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['odds_field_id'] = oddsFieldId;
    data['type'] = type;
    data['odds'] = odds;
    data['opening_odds'] = openingOdds;
    data['odds_trend'] = oddsTrend;
    data['opening_total'] = openingTotal;
    data['total'] = total;
    data['spread'] = spread;
    data['opening_spread'] = openingSpread;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    if (lines != null) {
      data['lines'] = lines!.map((v) => v.toJson()).toList();
    }
    if (betPercentageOutcomes != null) {
      data['bet_percentage_outcomes'] =
          betPercentageOutcomes!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (outcomes != null) {
      data['outcomes'] = outcomes!.map((v) => v.toJson()).toList();
    }
    data['spread'] = spread;
    data['total'] = total;
    data['last_updated'] = lastUpdated;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (outcomes != null) {
      data['outcomes'] = outcomes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
