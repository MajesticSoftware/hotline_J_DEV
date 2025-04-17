class GameData {
  final Game? game;
  final String? comment;

  GameData({this.game, this.comment});

  factory GameData.fromJson(Map<String, dynamic>? json) => GameData(
        game: json?['game'] != null ? Game.fromJson(json!['game']) : Game(id: ""),
        comment: json?['_comment'],
      );

  Map<String, dynamic> toJson() => {
        'game': game?.toJson() ?? {},
        '_comment': comment,
      };
}

class Game {
  final String id;
  final Team? home;
  final Team? away;

  Game({required this.id, this.home, this.away});

  factory Game.fromJson(Map<String, dynamic>? json) => Game(
        id: json?['id'] ?? '',
        home: json?['home'] != null ? Team.fromJson(json!['home']) : Team(players: [],probablePitcher: null,startingPitcher: null),
        away: json?['away'] != null ? Team.fromJson(json!['away']) : Team(players: [],probablePitcher: null,startingPitcher: null),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'home': home?.toJson() ?? {},
        'away': away?.toJson() ?? {},
      };
}

class Team {
  final Pitcher? probablePitcher;
  final Pitcher? startingPitcher;
  final List<Player>? players;

  Team({this.probablePitcher, this.startingPitcher, this.players});

  factory Team.fromJson(Map<String, dynamic>? json) => Team(
        probablePitcher: json?['probable_pitcher'] != null
            ? Pitcher.fromJson(json!['probable_pitcher'])
            : null,
        startingPitcher: json?['starting_pitcher'] != null
            ? Pitcher.fromJson(json!['starting_pitcher'])
            : null,
        players: json?['players'] != null && (json?['players'] as List).isNotEmpty
            ? List<Player>.from(json!['players'].map((x) => Player.fromJson(x)))
            : [], // Handle empty or null players list
      );

  Map<String, dynamic> toJson() => {
        'probable_pitcher': probablePitcher?.toJson() ?? {},
        'starting_pitcher': startingPitcher?.toJson() ?? {},
        'players': players?.map((x) => x.toJson()).toList() ?? [],
      };
}

class Pitcher {
  final String preferredName;
  final String firstName;
  final String lastName;
  final String jerseyNumber;
  final String id;
  final String fullName;
  final int win;
  final int loss;
  final double era;

  Pitcher({
    required this.preferredName,
    required this.firstName,
    required this.lastName,
    required this.jerseyNumber,
    required this.id,
    required this.fullName,
    required this.win,
    required this.loss,
    required this.era,
  });

  factory Pitcher.fromJson(Map<String, dynamic>? json) => Pitcher(
        preferredName: json?['preferred_name'] ?? '',
        firstName: json?['first_name'] ?? '',
        lastName: json?['last_name'] ?? '',
        jerseyNumber: json?['jersey_number'] ?? '',
        id: json?['id'] ?? '',
        fullName: json?['full_name'] ?? '',
        win: json?['win'] ?? 0,
        loss: json?['loss'] ?? 0,
        era: (json?['era'] ?? 0).toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'preferred_name': preferredName,
        'first_name': firstName,
        'last_name': lastName,
        'jersey_number': jerseyNumber,
        'id': id,
        'full_name': fullName,
        'win': win,
        'loss': loss,
        'era': era,
      };
}

class Player {
  final String preferredName;
  final String firstName;
  final String lastName;
  final String jerseyNumber;
  final String id;
  final String fullName;
  final String status;
  final String position;
  final String primaryPosition;
  final Statistics? statistics;

  Player({
    required this.preferredName,
    required this.firstName,
    required this.lastName,
    required this.jerseyNumber,
    required this.id,
    required this.fullName,
    required this.status,
    required this.position,
    required this.primaryPosition,
    this.statistics,
  });

  factory Player.fromJson(Map<String, dynamic>? json) => Player(
        preferredName: json?['preferred_name'] ?? '',
        firstName: json?['first_name'] ?? '',
        lastName: json?['last_name'] ?? '',
        jerseyNumber: json?['jersey_number'] ?? '',
        id: json?['id'] ?? '',
        fullName: json?['full_name'] ?? '',
        status: json?['status'] ?? '',
        position: json?['position'] ?? '',
        primaryPosition: json?['primary_position'] ?? '',
        statistics: json?['statistics'] != null
            ? Statistics.fromJson(json!['statistics'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'preferred_name': preferredName,
        'first_name': firstName,
        'last_name': lastName,
        'jersey_number': jerseyNumber,
        'id': id,
        'full_name': fullName,
        'status': status,
        'position': position,
        'primary_position': primaryPosition,
        'statistics': statistics?.toJson() ?? {},
      };
}

class Statistics {
  final Pitching? pitching;

  Statistics({this.pitching});

  factory Statistics.fromJson(Map<String, dynamic>? json) => Statistics(
        pitching: json?['pitching'] != null
            ? Pitching.fromJson(json!['pitching'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'pitching': pitching?.toJson() ?? {},
      };
}

class Pitching {
  final Overall? overall;

  Pitching({this.overall});

  factory Pitching.fromJson(Map<String, dynamic>? json) => Pitching(
        overall: json?['overall'] != null
            ? Overall.fromJson(json!['overall'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'overall': overall?.toJson() ?? {},
      };
}

class Overall {
  final double whip;
  final num ip1;
  final num ip2;
  final OnBase? onbase;
  final Outs? outs;

  Overall({
    required this.whip,
    required this.ip1,
    required this.ip2,
    this.onbase,
    this.outs,
  });

  factory Overall.fromJson(Map<String, dynamic>? json) => Overall(
        whip: (json?['whip'] ?? 0).toDouble(),
        ip1: json?['ip_1'] ?? 0,
        ip2: json?['ip_2'] ?? 0,
        onbase: json?['onbase'] != null
            ? OnBase.fromJson(json!['onbase'])
            : null,
        outs: json?['outs'] != null ? Outs.fromJson(json!['outs']) : null,
      );

  Map<String, dynamic> toJson() => {
        'whip': whip,
        'ip_1': ip1,
        'ip_2': ip2,
        'onbase': onbase?.toJson() ?? {},
        'outs': outs?.toJson() ?? {},
      };
}

class OnBase {
  final num bb;
  final num h;

  OnBase({required this.bb, required this.h});

  factory OnBase.fromJson(Map<String, dynamic>? json) => OnBase(
        bb: json?['bb'] ?? 0,
        h: json?['h'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'bb': bb,
        'h': h,
      };
}

class Outs {
  final num ktotal;

  Outs({required this.ktotal});

  factory Outs.fromJson(Map<String, dynamic>? json) => Outs(
        ktotal: json?['ktotal'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'ktotal': ktotal,
      };
}