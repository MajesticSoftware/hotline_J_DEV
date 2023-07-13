// To parse this JSON data, do
//
//     final gameDetailsModel = gameDetailsModelFromJson(jsonString);

import 'dart:convert';

class GameDetailsModel {
  int status;
  DateTime time;
  int games;
  int skip;
  List<Result> results;

  GameDetailsModel({
    required this.status,
    required this.time,
    required this.games,
    required this.skip,
    required this.results,
  });

  GameDetailsModel copyWith({
    int? status,
    DateTime? time,
    int? games,
    int? skip,
    List<Result>? results,
  }) =>
      GameDetailsModel(
        status: status ?? this.status,
        time: time ?? this.time,
        games: games ?? this.games,
        skip: skip ?? this.skip,
        results: results ?? this.results,
      );

  factory GameDetailsModel.fromRawJson(String str) =>
      GameDetailsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GameDetailsModel.fromJson(Map<String, dynamic> json) =>
      GameDetailsModel(
        status: json["status"],
        time: DateTime.parse(json["time"]),
        games: json["games"],
        skip: json["skip"],
        results: json["results"] != null
            ? List<Result>.from(json["results"].map((x) => Result.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "time": time.toIso8601String(),
        "games": games,
        "skip": skip,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  String summary;
  Details details;
  Schedule schedule;
  Teams teams;
  DateTime lastUpdated;
  int gameId;
  Venue venue;
  List<Odd> odds;
  String homeGameLogo;
  String awayGameLogo;
  String awayScore;
  String homeScore;
  String spreadAwayRecord;
  String spreadHomeRecord;
  Scoreboard? scoreboard;

  Result({
    required this.summary,
    required this.details,
    required this.schedule,
    required this.teams,
    required this.lastUpdated,
    required this.gameId,
    required this.venue,
    required this.odds,
    this.homeGameLogo = '',
    this.awayGameLogo = '',
    this.awayScore = '',
    this.homeScore = '',
    this.spreadAwayRecord = '',
    this.spreadHomeRecord = '',
    required this.scoreboard,
  });
  String get liveSpreadHomeRecord {
    return spreadHomeRecord.isEmpty ? '0-0' : spreadHomeRecord;
  }

  String get liveSpreadAwayRecord {
    return spreadAwayRecord.isEmpty ? '0-0' : spreadAwayRecord;
  }

  String get gameHomeLogoLink {
    return homeGameLogo;
  }

  String get gameLogoAwayLink {
    return awayGameLogo;
  }

  String get homeLiveScores {
    return homeScore.isEmpty ? '0' : homeScore;
  }

  String get awayLiveScores {
    return awayScore.isEmpty ? '0' : awayScore;
  }

  Result copyWith(
          {String? summary,
          Details? details,
          Schedule? schedule,
          Teams? teams,
          DateTime? lastUpdated,
          int? gameId,
          Venue? venue,
          List<Odd>? odds,
          Scoreboard? scoreboard}) =>
      Result(
        summary: summary ?? this.summary,
        details: details ?? this.details,
        scoreboard: scoreboard ?? this.scoreboard,
        schedule: schedule ?? this.schedule,
        teams: teams ?? this.teams,
        lastUpdated: lastUpdated ?? this.lastUpdated,
        gameId: gameId ?? this.gameId,
        venue: venue ?? this.venue,
        odds: odds ?? this.odds,
      );

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        summary: json["summary"],
        details: Details.fromJson(json["details"]),
        scoreboard: json["scoreboard"] != null
            ? Scoreboard.fromJson(json["scoreboard"])
            : Scoreboard(),
        schedule: Schedule.fromJson(json["schedule"]),
        teams: Teams.fromJson(json["teams"]),
        lastUpdated: DateTime.parse(json["lastUpdated"]),
        gameId: json["gameId"],
        venue: Venue.fromJson(json["venue"]),
        odds: json["odds"] != null
            ? List<Odd>.from(json["odds"].map((x) => Odd.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "summary": summary,
        "details": details.toJson(),
        "scoreboard": scoreboard != null ? scoreboard?.toJson() : [],
        "schedule": schedule.toJson(),
        "teams": teams.toJson(),
        "lastUpdated": lastUpdated.toIso8601String(),
        "gameId": gameId,
        "venue": venue.toJson(),
        "odds":
            // ignore: unnecessary_null_comparison
            odds != null ? List<dynamic>.from(odds.map((x) => x.toJson())) : [],
      };
}

class Scoreboard {
  Score? score;

  Scoreboard({this.score});

  Scoreboard.fromJson(Map<String, dynamic> json) {
    score = json['score'] != null ? new Score.fromJson(json['score']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.score != null) {
      data['score'] = this.score!.toJson();
    }

    return data;
  }
}

class Score {
  int? away;
  int? home;
  List<int>? awayPeriods;
  List<int>? homePeriods;

  Score({this.away, this.home, this.awayPeriods, this.homePeriods});

  Score.fromJson(Map<String, dynamic> json) {
    away = json['away'];
    home = json['home'];
    awayPeriods = json['awayPeriods'].cast<int>();
    homePeriods = json['homePeriods'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['away'] = this.away;
    data['home'] = this.home;
    data['awayPeriods'] = this.awayPeriods;
    data['homePeriods'] = this.homePeriods;
    return data;
  }
}

class Details {
  League? league;
  SeasonType? seasonType;
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

  Details copyWith({
    League? league,
    SeasonType? seasonType,
    int? season,
    bool? conferenceGame,
    bool? divisionGame,
  }) =>
      Details(
        league: league ?? this.league,
        seasonType: seasonType ?? this.seasonType,
        season: season ?? this.season,
        conferenceGame: conferenceGame ?? this.conferenceGame,
        divisionGame: divisionGame ?? this.divisionGame,
      );

  factory Details.fromRawJson(String str) => Details.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        league: leagueValues.map[json["league"] ?? ""],
        seasonType: seasonTypeValues.map[json["seasonType"] ?? ""],
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
enum League { NFL }

final leagueValues = EnumValues({"NFL": League.NFL});

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

  Odd copyWith({
    Spread? spread,
    Moneyline? moneyline,
    Total? total,
    DateTime? openDate,
    DateTime? lastUpdated,
  }) =>
      Odd(
        spread: spread ?? this.spread,
        moneyline: moneyline ?? this.moneyline,
        total: total ?? this.total,
        openDate: openDate ?? this.openDate,
        lastUpdated: lastUpdated ?? this.lastUpdated,
      );

  factory Odd.fromRawJson(String str) => Odd.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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

  Moneyline copyWith({
    MoneylineCurrent? open,
    MoneylineCurrent? current,
  }) =>
      Moneyline(
        open: open ?? this.open,
        current: current ?? this.current,
      );

  factory Moneyline.fromRawJson(String str) =>
      Moneyline.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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

  MoneylineCurrent copyWith({
    int? awayOdds,
    int? homeOdds,
  }) =>
      MoneylineCurrent(
        awayOdds: awayOdds ?? this.awayOdds,
        homeOdds: homeOdds ?? this.homeOdds,
      );

  factory MoneylineCurrent.fromRawJson(String str) =>
      MoneylineCurrent.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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

  Spread copyWith({
    SpreadCurrent? open,
    SpreadCurrent? current,
  }) =>
      Spread(
        open: open ?? this.open,
        current: current ?? this.current,
      );

  factory Spread.fromRawJson(String str) => Spread.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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

  SpreadCurrent copyWith({
    double? away,
    double? home,
    int? awayOdds,
    int? homeOdds,
  }) =>
      SpreadCurrent(
        away: away ?? this.away,
        home: home ?? this.home,
        awayOdds: awayOdds ?? this.awayOdds,
        homeOdds: homeOdds ?? this.homeOdds,
      );

  factory SpreadCurrent.fromRawJson(String str) =>
      SpreadCurrent.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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

  Total copyWith({
    TotalCurrent? open,
    TotalCurrent? current,
  }) =>
      Total(
        open: open ?? this.open,
        current: current ?? this.current,
      );

  factory Total.fromRawJson(String str) => Total.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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

  TotalCurrent copyWith({
    double? total,
    int? overOdds,
    int? underOdds,
  }) =>
      TotalCurrent(
        total: total ?? this.total,
        overOdds: overOdds ?? this.overOdds,
        underOdds: underOdds ?? this.underOdds,
      );

  factory TotalCurrent.fromRawJson(String str) =>
      TotalCurrent.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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

  Schedule copyWith({
    DateTime? date,
    bool? tbaTime,
  }) =>
      Schedule(
        date: date ?? this.date,
        tbaTime: tbaTime ?? this.tbaTime,
      );

  factory Schedule.fromRawJson(String str) =>
      Schedule.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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

  Teams copyWith({
    Away? away,
    Away? home,
  }) =>
      Teams(
        away: away ?? this.away,
        home: home ?? this.home,
      );

  factory Teams.fromRawJson(String str) => Teams.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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
  Conference? conference;
  Division? division;

  Away({
    required this.team,
    required this.location,
    required this.mascot,
    required this.abbreviation,
    required this.conference,
    required this.division,
  });

  Away copyWith({
    String? team,
    String? location,
    String? mascot,
    String? abbreviation,
    Conference? conference,
    Division? division,
  }) =>
      Away(
        team: team ?? this.team,
        location: location ?? this.location,
        mascot: mascot ?? this.mascot,
        abbreviation: abbreviation ?? this.abbreviation,
        conference: conference ?? this.conference,
        division: division ?? this.division,
      );

  factory Away.fromRawJson(String str) => Away.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Away.fromJson(Map<String, dynamic> json) => Away(
        team: json["team"],
        location: json["location"],
        mascot: json["mascot"],
        abbreviation: json["abbreviation"],
        conference: conferenceValues.map[json["conference"] ?? ''],
        division: divisionValues.map[json["division"] ?? ''],
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
enum Conference { AFC, NFC }

final conferenceValues =
    EnumValues({"AFC": Conference.AFC, "NFC": Conference.NFC});

// ignore: constant_identifier_names
enum Division { SOUTH, WEST, NORTH, EAST }

final divisionValues = EnumValues({
  "East": Division.EAST,
  "North": Division.NORTH,
  "South": Division.SOUTH,
  "West": Division.WEST
});

class Venue {
  String name;
  bool neutralSite;
  String city;
  String? state;
  int temp;
  int weather;

  int get tmpInFahrenheit {
    return temp == 0 ? 0 : ((temp - 273.15) * (9 / 5) + 32).toInt();
  }

  Venue({
    required this.name,
    required this.neutralSite,
    required this.city,
    required this.state,
    this.temp = 0,
    this.weather = 0,
  });

  Venue copyWith({
    String? name,
    bool? neutralSite,
    String? city,
    String? state,
  }) =>
      Venue(
        name: name ?? this.name,
        neutralSite: neutralSite ?? this.neutralSite,
        city: city ?? this.city,
        state: state ?? this.state,
      );

  factory Venue.fromRawJson(String str) => Venue.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Venue.fromJson(Map<String, dynamic> json) => Venue(
        name: json["name"],
        neutralSite: json["neutralSite"],
        city: json["city"],
        state: json["state"] ?? "",
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
