// To parse this JSON data, do
//
//     final gameDetailsModel = gameDetailsModelFromJson(jsonString);

import 'dart:convert';

GameDetailsModel gameDetailsModelFromJson(String str) =>
    GameDetailsModel.fromJson(json.decode(str));

String gameDetailsModelToJson(GameDetailsModel data) =>
    json.encode(data.toJson());

class GameDetailsModel {
  int status;
  int games;
  int skip;
  List<Result> results;

  GameDetailsModel({
    required this.status,
    required this.games,
    required this.skip,
    required this.results,
  });

  factory GameDetailsModel.fromJson(Map<String, dynamic> json) =>
      GameDetailsModel(
        status: json["status"],
        games: json["games"],
        skip: json["skip"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "games": games,
        "skip": skip,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  String summary;
  Details details;
  Schedule schedule;
  Status status;
  Teams teams;
  DateTime lastUpdated;
  int gameId;
  Venue venue;
  List<Odd> odds;

  Result({
    required this.summary,
    required this.details,
    required this.schedule,
    required this.status,
    required this.teams,
    required this.lastUpdated,
    required this.gameId,
    required this.venue,
    required this.odds,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        summary: json["summary"],
        details: Details.fromJson(json["details"]),
        schedule: Schedule.fromJson(json["schedule"]),
        status: statusValues.map[json["status"]]!,
        teams: Teams.fromJson(json["teams"]),
        lastUpdated: DateTime.parse(json["lastUpdated"]),
        gameId: json["gameId"],
        venue: Venue.fromJson(json["venue"]),
        odds: List<Odd>.from(json["odds"] == null
            ? []
            : json["odds"]
                .map((x) => json["odds"] == null ? [] : Odd.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "summary": summary,
        "details": details.toJson(),
        "schedule": schedule.toJson(),
        "status": statusValues.reverse[status],
        "teams": teams.toJson(),
        "lastUpdated": lastUpdated.toIso8601String(),
        "gameId": gameId,
        "venue": venue.toJson(),
        "odds": List<dynamic>.from(odds.map((x) => x.toJson())),
      };
}

class Details {
  League league;
  SeasonType seasonType;
  int season;
  bool conferenceGame;
  bool divisionGame;

  Details({
    required this.league,
    required this.seasonType,
    required this.season,
    required this.conferenceGame,
    required this.divisionGame,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        league: leagueValues.map[json["league"]]!,
        seasonType: seasonTypeValues.map[json["seasonType"]]!,
        season: json["season"],
        conferenceGame: json["conferenceGame"],
        divisionGame: json["divisionGame"],
      );

  Map<String, dynamic> toJson() => {
        "league": leagueValues.reverse[league],
        "seasonType": seasonTypeValues.reverse[seasonType],
        "season": season,
        "conferenceGame": conferenceGame,
        "divisionGame": divisionGame,
      };
}

// ignore: constant_identifier_names
enum League { MLB }

final leagueValues = EnumValues({"MLB": League.MLB});

// ignore: constant_identifier_names
enum SeasonType { REGULAR }

final seasonTypeValues = EnumValues({"regular": SeasonType.REGULAR});

class Odd {
  Spread spread;
  Moneyline moneyline;
  Total total;
  DateTime openDate;
  DateTime lastUpdated;

  Odd({
    required this.spread,
    required this.moneyline,
    required this.total,
    required this.openDate,
    required this.lastUpdated,
  });

  factory Odd.fromJson(Map<String, dynamic> json) => Odd(
        spread: Spread.fromJson(json["spread"]),
        moneyline: Moneyline.fromJson(json["moneyline"]),
        total: Total.fromJson(json["total"]),
        openDate: DateTime.parse(json["openDate"]),
        lastUpdated: DateTime.parse(json["lastUpdated"]),
      );

  Map<String, dynamic> toJson() => {
        "spread": spread.toJson(),
        "moneyline": moneyline.toJson(),
        "total": total.toJson(),
        "openDate": openDate.toIso8601String(),
        "lastUpdated": lastUpdated.toIso8601String(),
      };
}

class Moneyline {
  MoneylineCurrent open;
  MoneylineCurrent current;

  Moneyline({
    required this.open,
    required this.current,
  });

  factory Moneyline.fromJson(Map<String, dynamic> json) => Moneyline(
        open: MoneylineCurrent.fromJson(json["open"]),
        current: MoneylineCurrent.fromJson(json["current"]),
      );

  Map<String, dynamic> toJson() => {
        "open": open.toJson(),
        "current": current.toJson(),
      };
}

class MoneylineCurrent {
  int awayOdds;
  int homeOdds;

  MoneylineCurrent({
    required this.awayOdds,
    required this.homeOdds,
  });

  factory MoneylineCurrent.fromJson(Map<String, dynamic> json) =>
      MoneylineCurrent(
        awayOdds: json["awayOdds"],
        homeOdds: json["homeOdds"],
      );

  Map<String, dynamic> toJson() => {
        "awayOdds": awayOdds,
        "homeOdds": homeOdds,
      };
}

class Spread {
  SpreadCurrent open;
  SpreadCurrent current;

  Spread({
    required this.open,
    required this.current,
  });

  factory Spread.fromJson(Map<String, dynamic> json) => Spread(
        open: SpreadCurrent.fromJson(json["open"]),
        current: SpreadCurrent.fromJson(json["current"]),
      );

  Map<String, dynamic> toJson() => {
        "open": open.toJson(),
        "current": current.toJson(),
      };
}

class SpreadCurrent {
  double away;
  double home;
  int awayOdds;
  int homeOdds;

  SpreadCurrent({
    required this.away,
    required this.home,
    required this.awayOdds,
    required this.homeOdds,
  });

  factory SpreadCurrent.fromJson(Map<String, dynamic> json) => SpreadCurrent(
        away: json["away"]?.toDouble(),
        home: json["home"]?.toDouble(),
        awayOdds: json["awayOdds"],
        homeOdds: json["homeOdds"],
      );

  Map<String, dynamic> toJson() => {
        "away": away,
        "home": home,
        "awayOdds": awayOdds,
        "homeOdds": homeOdds,
      };
}

class Total {
  TotalCurrent open;
  TotalCurrent current;

  Total({
    required this.open,
    required this.current,
  });

  factory Total.fromJson(Map<String, dynamic> json) => Total(
        open: TotalCurrent.fromJson(json["open"]),
        current: TotalCurrent.fromJson(json["current"]),
      );

  Map<String, dynamic> toJson() => {
        "open": open.toJson(),
        "current": current.toJson(),
      };
}

class TotalCurrent {
  double total;
  int overOdds;
  int underOdds;

  TotalCurrent({
    required this.total,
    required this.overOdds,
    required this.underOdds,
  });

  factory TotalCurrent.fromJson(Map<String, dynamic> json) => TotalCurrent(
        total: json["total"]?.toDouble(),
        overOdds: json["overOdds"],
        underOdds: json["underOdds"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "overOdds": overOdds,
        "underOdds": underOdds,
      };
}

class Schedule {
  DateTime date;
  bool tbaTime;

  Schedule({
    required this.date,
    required this.tbaTime,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        date: DateTime.parse(json["date"]),
        tbaTime: json["tbaTime"],
      );

  Map<String, dynamic> toJson() => {
        "date": date.toIso8601String(),
        "tbaTime": tbaTime,
      };
}

// ignore: constant_identifier_names
enum Status { SCHEDULED }

final statusValues = EnumValues({"scheduled": Status.SCHEDULED});

class Teams {
  Away away;
  Away home;

  Teams({
    required this.away,
    required this.home,
  });

  factory Teams.fromJson(Map<String, dynamic> json) => Teams(
        away: Away.fromJson(json["away"]),
        home: Away.fromJson(json["home"]),
      );

  Map<String, dynamic> toJson() => {
        "away": away.toJson(),
        "home": home.toJson(),
      };
}

class Away {
  String team;
  String location;
  String mascot;
  String abbreviation;
  Conference conference;
  Division division;

  Away({
    required this.team,
    required this.location,
    required this.mascot,
    required this.abbreviation,
    required this.conference,
    required this.division,
  });

  factory Away.fromJson(Map<String, dynamic> json) => Away(
        team: json["team"],
        location: json["location"],
        mascot: json["mascot"],
        abbreviation: json["abbreviation"],
        conference: conferenceValues.map[json["conference"]]!,
        division: divisionValues.map[json["division"]]!,
      );

  Map<String, dynamic> toJson() => {
        "team": team,
        "location": location,
        "mascot": mascot,
        "abbreviation": abbreviation,
        "conference": conferenceValues.reverse[conference],
        "division": divisionValues.reverse[division],
      };
}

// ignore: constant_identifier_names
enum Conference { AMERICAN_LEAGUE, NATIONAL_LEAGUE }

final conferenceValues = EnumValues({
  "American League": Conference.AMERICAN_LEAGUE,
  "National League": Conference.NATIONAL_LEAGUE
});

// ignore: constant_identifier_names
enum Division { EAST, CENTRAL, WEST }

final divisionValues = EnumValues({
  "Central": Division.CENTRAL,
  "East": Division.EAST,
  "West": Division.WEST
});

class Venue {
  String name;
  bool neutralSite;
  String city;
  String state;

  Venue({
    required this.name,
    required this.neutralSite,
    required this.city,
    required this.state,
  });

  factory Venue.fromJson(Map<String, dynamic> json) => Venue(
        name: json["name"],
        neutralSite: json["neutralSite"],
        city: json["city"],
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "neutralSite": neutralSite,
        "city": city,
        "state": state,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
