import 'dart:developer';

import 'nba_statics_model.dart' as pro;
import 'nfl_statics_model.dart';

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
  num flamValue = 0;
  String? scheduled;
  bool? startTimeTbd;
  String? status;
  List<String> nflHomeOffensiveRank = [];
  List<String> nflHomeDefensiveRank = [];
  List<String> nflAwayOffensiveRank = [];
  List<String> nflAwayDefensiveRank = [];
  num? awayPointOffenseRank;
  num? awayPointDefenseRank;
  num? awayRushingOffenseRank;
  num? awayRushingDefenseRank;
  num? homePointOffenseRank;
  num? homePointDefenseRank;
  num? homeRushingOffenseRank;
  num? homeRushingDefenseRank;
  num? awayPointOffense;
  num? awayPointDefense;
  num? awayRushingOffense;
  num? awayRushingDefense;
  num? homePointOffense;
  num? homePointDefense;
  num? homeRushingOffense;
  num? homeRushingDefense;
  num? homePassingYardOffense;
  num? homePassingYardDefense;
  num? homeRushingTDSOffense;
  num? homeRushingTDSDefence;
  num? homePassingTDSOffense;
  num? homePassingTDSDefence;
  num? homeRedZonEfficiencyOffence;
  num? homeOpponentRedZonEfficiency;
  num? homeThirdDownOffence;
  num? homeOpponentThirdDown;
  num? homeFourthDownOffense;
  num? homeOpponentFourthDown;
  num? homeFieldGoalOffense;
  num? homeFieldGoalDefense;
  num? homeTernOverOffense;
  num? homeTernOverDefense;
  num? awayPassingYardOffense;
  num? awayPassingYardDefense;
  num? awayRushingTDSOffense;
  num? awayRushingTDSDefence;
  num? awayPassingTDSOffense;
  num? awayPassingTDSDefence;
  num? awayRedZonEfficiencyOffence;
  num? awayOpponentRedZonEfficiency;
  num? awayThirdDownOffence;
  num? awayOpponentThirdDown;
  num? awayFourthDownOffense;
  num? awayOpponentFourthDown;
  num? awayFieldGoalOffense;
  num? awayFieldGoalDefense;
  num? awayTernOverOffense;
  num? awayTernOverDefense;
  num? homePassingYardOffenseRank;
  num? homePassingYardDefenseRank;
  num? homeRushingTDSOffenseRank;
  num? homeRushingTDSDefenceRank;
  num? homePassingTDSOffenseRank;
  num? homePassingTDSDefenceRank;
  num? homeRedZonEfficiencyOffenceRank;
  num? homeOpponentRedZonEfficiencyRank;
  num? homeThirdDownOffenceRank;
  num? homeOpponentThirdDownRank;
  num? homeFourthDownOffenseRank;
  num? homeOpponentFourthDownRank;
  num? homeFieldGoalOffenseRank;
  num? homeFieldGoalDefenseRank;
  num? homeTernOverOffenseRank;
  num? homeTernOverDefenseRank;
  num? awayPassingYardOffenseRank;
  num? awayPassingYardDefenseRank;
  num? awayRushingTDSOffenseRank;
  num? awayRushingTDSDefenceRank;
  num? awayPassingTDSOffenseRank;
  num? awayPassingTDSDefenceRank;
  num? awayRedZonEfficiencyOffenceRank;
  num? awayOpponentRedZonEfficiencyRank;
  num? awayThirdDownOffenceRank;
  num? awayOpponentThirdDownRank;
  num? awayFourthDownOffenseRank;
  num? awayOpponentFourthDownRank;
  num? awayFieldGoalOffenseRank;
  num? awayFieldGoalDefenseRank;
  num? awayTernOverOffenseRank;
  num? awayTernOverDefenseRank;
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
  List<pro.Players> homeRushingPlayer = [];
  List<pro.Players> awayRushingPlayer = [];
  List homeTeamInjuredPlayer = [];
  num temp = 273.15;
  int weather = 805;

  SportEvents({
    this.id,
    this.scheduled,
    this.flamValue = 0,
    this.startTimeTbd,
    this.status,
  this.nflHomeOffensiveRank =const [],
  this.nflHomeDefensiveRank =const [],
  this.nflAwayOffensiveRank =const [],
  this.nflAwayDefensiveRank =const [],
    this.awayPointOffenseRank = 0,
    this.awayPointDefenseRank = 0,
    this.awayRushingOffenseRank = 0,
    this.awayRushingDefenseRank = 0,
    this.homePointOffenseRank = 0,
    this.homePointDefenseRank = 0,
    this.homeRushingOffenseRank = 0,
    this.homeRushingDefenseRank = 0,
    this.awayPointOffense = 0,
    this.awayPointDefense = 0,
    this.awayRushingOffense = 0,
    this.awayRushingDefense = 0,
    this.homePointOffense = 0,
    this.homePointDefense = 0,
    this.homeRushingOffense = 0,
    this.homeRushingDefense = 0,
    this.homePassingYardOffense=0,
    this.homePassingYardDefense=0,
    this.homeRushingTDSOffense=0,
    this.homeRushingTDSDefence=0,
    this.homePassingTDSOffense=0,
    this.homePassingTDSDefence=0,
    this.homeRedZonEfficiencyOffence=0,
    this.homeOpponentRedZonEfficiency=0,
    this.homeThirdDownOffence=0,
    this.homeOpponentThirdDown=0,
    this.homeFourthDownOffense=0,
    this.homeOpponentFourthDown=0,
    this.homeFieldGoalOffense=0,
    this.homeFieldGoalDefense=0,
    this.homeTernOverOffense=0,
    this.homeTernOverDefense=0,
    this.awayPassingYardOffense=0,
    this.awayPassingYardDefense=0,
    this.awayRushingTDSOffense=0,
    this.awayRushingTDSDefence=0,
    this.awayPassingTDSOffense=0,
    this.awayPassingTDSDefence=0,
    this.awayRedZonEfficiencyOffence=0,
    this.awayOpponentRedZonEfficiency=0,
    this.awayThirdDownOffence=0,
    this.awayOpponentThirdDown=0,
    this.awayFourthDownOffense=0,
    this.awayOpponentFourthDown=0,
    this.awayFieldGoalOffense=0,
    this.awayFieldGoalDefense=0,
    this.awayTernOverOffense=0,
    this.awayTernOverDefense=0,
    this.homePassingYardOffenseRank=0,
    this.homePassingYardDefenseRank=0,
    this.homeRushingTDSOffenseRank=0,
    this.homeRushingTDSDefenceRank=0,
    this.homePassingTDSOffenseRank=0,
    this.homePassingTDSDefenceRank=0,
    this.homeRedZonEfficiencyOffenceRank=0,
    this.homeOpponentRedZonEfficiencyRank=0,
    this.homeThirdDownOffenceRank=0,
    this.homeOpponentThirdDownRank=0,
    this.homeFourthDownOffenseRank=0,
    this.homeOpponentFourthDownRank=0,
    this.homeFieldGoalOffenseRank=0,
    this.homeFieldGoalDefenseRank=0,
    this.homeTernOverOffenseRank=0,
    this.homeTernOverDefenseRank=0,
    this.awayPassingYardOffenseRank=0,
    this.awayPassingYardDefenseRank=0,
    this.awayRushingTDSOffenseRank=0,
    this.awayRushingTDSDefenceRank=0,
    this.awayPassingTDSOffenseRank=0,
    this.awayPassingTDSDefenceRank=0,
    this.awayRedZonEfficiencyOffenceRank=0,
    this.awayOpponentRedZonEfficiencyRank=0,
    this.awayThirdDownOffenceRank=0,
    this.awayOpponentThirdDownRank=0,
    this.awayFourthDownOffenseRank=0,
    this.awayOpponentFourthDownRank=0,
    this.awayFieldGoalOffenseRank=0,
    this.awayFieldGoalDefenseRank=0,
    this.awayTernOverOffenseRank=0,
    this.awayTernOverDefenseRank=0,
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
List<int> flameValues=[];
  num get getFlameValue {
   /* for (int index=0;index<=10;index++) {
      int condition1 = ((int.tryParse(
          nflHomeDefensiveRank.isEmpty ? "0" :
          nflHomeDefensiveRank[index]) ?? 0) - (int.tryParse(
          nflAwayOffensiveRank.isEmpty ? "0" :
          nflAwayOffensiveRank[index]) ?? 0));

          int condition2= (int.tryParse(nflHomeOffensiveRank.isEmpty ? "0" :
          nflHomeOffensiveRank[index]) ?? 0) - (int.tryParse(
      nflAwayDefensiveRank.isEmpty ? "0" :         nflAwayDefensiveRank[index]) ?? 0);

     if ((condition1 >= 15 || condition1 <= -15)||(condition2 >= 15 || condition2 <= -15)){
       flameValues.add(1);
       flamValue=flameValues.length;
       return flamValue;
     }

    }*/
    bool condition1 =
        (((homePointDefenseRank ?? 0) - (awayPointOffenseRank ?? 0)) >= 15) ||
            (((homePointDefenseRank ?? 0) - (awayPointOffenseRank ?? 0)) <=
                -15);
    bool condition2 =
        (((homePointOffenseRank ?? 0) - (awayPointDefenseRank ?? 0)) >= 15) ||
            (((homePointOffenseRank ?? 0) - (awayPointDefenseRank ?? 0)) <=
                -15);
    bool condition3 =
        (((homeRushingDefenseRank ?? 0) - (awayRushingOffenseRank ?? 0)) >=
                15) ||
            (((homeRushingDefenseRank ?? 0) - (awayRushingOffenseRank ?? 0)) <=
                -15);
    bool condition4 =
        (((homeRushingOffenseRank ?? 0) - (awayRushingDefenseRank ?? 0)) >=
                15) ||
            (((homeRushingOffenseRank ?? 0) - (awayRushingDefenseRank ?? 0)) <=
                -15);


    if ((condition1 && condition2 && condition3) ||
        (condition2 && condition3 && condition4) ||
        (condition3 && condition4 && condition1) ||
        (condition2 && condition4 && condition1)) {
      return flamValue + 3;
    }
    if (condition1 && condition2 && condition3 && condition4) {
      return flamValue + 4;
    }
    if ((condition1 && condition2) ||
        (condition1 && condition3) ||
        (condition1 && condition4) ||
        (condition2 && condition3) ||
        (condition2 && condition4) ||
        (condition3 && condition4)) {
      return flamValue + 2;
    }

    if (condition1 || condition2 || condition3 || condition4) {
      return flamValue + 1;
    }
    return flamValue;
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
