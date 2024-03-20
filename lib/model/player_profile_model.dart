import 'dart:convert';

class PlayerProfileModel {
  Player player;
  String comment;

  PlayerProfileModel({
    required this.player,
    required this.comment,
  });

  PlayerProfileModel copyWith({
    Player? player,
    String? comment,
  }) =>
      PlayerProfileModel(
        player: player ?? this.player,
        comment: comment ?? this.comment,
      );

  factory PlayerProfileModel.fromRawJson(String str) =>
      PlayerProfileModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PlayerProfileModel.fromJson(Map<String, dynamic> json) =>
      PlayerProfileModel(
        player: Player.fromJson(json["player"]),
        comment: json["_comment"],
      );

  Map<String, dynamic> toJson() => {
        "player": player.toJson(),
        "_comment": comment,
      };
}

class Player {
  String id;
  String full_name;
  List<Season> seasons;

  Player({
    required this.id,
    required this.full_name,
    required this.seasons,
  });

  Player copyWith({
    String? id,
    String? full_name,
    List<Season>? seasons,
  }) =>
      Player(
        id: id ?? this.id,
        full_name: full_name ?? this.full_name,
        seasons: seasons ?? this.seasons,
      );

  factory Player.fromRawJson(String str) => Player.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Player.fromJson(Map<String, dynamic> json) => Player(
        id: json["id"],
    full_name: json["full_name"],
        seasons:
            List<Season>.from(json["seasons"].map((x) => Season.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": full_name,
        "seasons": List<dynamic>.from(seasons.map((x) => x.toJson())),
      };
}

class Draft {
  String teamId;
  int year;
  int round;
  int pick;

  Draft({
    required this.teamId,
    required this.year,
    required this.round,
    required this.pick,
  });

  Draft copyWith({
    String? teamId,
    int? year,
    int? round,
    int? pick,
  }) =>
      Draft(
        teamId: teamId ?? this.teamId,
        year: year ?? this.year,
        round: round ?? this.round,
        pick: pick ?? this.pick,
      );

  factory Draft.fromRawJson(String str) => Draft.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Draft.fromJson(Map<String, dynamic> json) => Draft(
        teamId: json["team_id"],
        year: json["year"],
        round: json["round"],
        pick: json["pick"],
      );

  Map<String, dynamic> toJson() => {
        "team_id": teamId,
        "year": year,
        "round": round,
        "pick": pick,
      };
}

class Season {
  String id;
  int year;
  String type;
  Totals totals;

  Season({
    required this.id,
    required this.year,
    required this.type,
    required this.totals,
  });

  Season copyWith({
    String? id,
    int? year,
    String? type,
    Totals? totals,
  }) =>
      Season(
        id: id ?? this.id,
        year: year ?? this.year,
        type: type ?? this.type,
        totals: totals ?? this.totals,
      );

  factory Season.fromRawJson(String str) => Season.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Season.fromJson(Map<String, dynamic> json) => Season(
        id: json["id"],
        year: json["year"],
        type: json["type"],
        totals: Totals.fromJson(json["totals"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "year": year,
        "type": type,
        "totals": totals.toJson(),
      };
}

class Totals {
  Statistics statistics;

  Totals({
    required this.statistics,
  });

  Totals copyWith({
    Statistics? statistics,
  }) =>
      Totals(
        statistics: statistics ?? this.statistics,
      );

  factory Totals.fromRawJson(String str) => Totals.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Totals.fromJson(Map<String, dynamic> json) => Totals(
        statistics: Statistics.fromJson(json["statistics"]),
      );

  Map<String, dynamic> toJson() => {
        "statistics": statistics.toJson(),
      };
}

class Statistics {
  Pitching pitching;

  Statistics({
    required this.pitching,
  });

  Statistics copyWith({
    Pitching? pitching,
  }) =>
      Statistics(
        pitching: pitching ?? this.pitching,
      );

  factory Statistics.fromRawJson(String str) =>
      Statistics.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Statistics.fromJson(Map<String, dynamic> json) => Statistics(
        pitching: Pitching.fromJson(json["pitching"]),
      );

  Map<String, dynamic> toJson() => {
        "pitching": pitching.toJson(),
      };
}

class Pitching {
  Bullpen overall;

  Pitching({
    required this.overall,
  });

  Pitching copyWith({
    Bullpen? overall,
  }) =>
      Pitching(
        overall: overall ?? this.overall,
      );

  factory Pitching.fromRawJson(String str) =>
      Pitching.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Pitching.fromJson(Map<String, dynamic> json) => Pitching(
        overall: Bullpen.fromJson(json["overall"]),
      );

  Map<String, dynamic> toJson() => {
        "overall": overall.toJson(),
      };
}

class Bullpen {
  num? whip;
  num? ip2;
  Onbase? onbase;
  Outcome? outcome;
  Outs? outs;

  Bullpen({
    required this.whip,
    required this.onbase,
    required this.ip2,
    required this.outcome,
    required this.outs,
  });

  Bullpen copyWith({
    num? whip,
    num? ip1,
    Outcome? outcome,
    Onbase? onbase,
    Outs? outs,
  }) =>
      Bullpen(
        whip: whip ?? this.whip,
        ip2: ip2 ?? ip2,
        outcome: outcome ?? this.outcome,
        onbase: onbase ?? this.onbase,
        outs: outs ?? this.outs,
      );

  factory Bullpen.fromRawJson(String str) => Bullpen.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Bullpen.fromJson(Map<String, dynamic> json) => Bullpen(
        whip: json["whip"] ?? 0,
        outcome: Outcome.fromJson(json["outcome"]),
        ip2: json["ip_2"] ?? 0,
        onbase: Onbase.fromJson(json["onbase"]),
        outs: Outs.fromJson(json["outs"]),
      );

  Map<String, dynamic> toJson() => {
        "whip": whip,
        "ip_1": ip2,
        "outcome": outcome?.toJson(),
        "onbase": onbase?.toJson(),
        "outs": outs?.toJson(),
      };
}

class Outs {
  num? ktotal;

  Outs({
    this.ktotal,
  });

  Outs.fromJson(Map<String, dynamic> json) {
    ktotal = json['ktotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['ktotal'] = ktotal;

    return data;
  }
}

class Onbase {
  num? s;
  num? d;
  num? t;
  num? hr;
  num? tb;
  num? bb;
  num? ibb;
  num? hbp;
  num? fc;
  num? roe;
  num? h;
  num? h9;
  num? hr9;

  Onbase(
      {this.s,
      this.d,
      this.t,
      this.hr,
      this.tb,
      this.bb,
      this.ibb,
      this.hbp,
      this.fc,
      this.roe,
      this.h,
      this.h9,
      this.hr9});

  Onbase.fromJson(Map<String, dynamic> json) {
    s = json['s'];
    d = json['d'];
    t = json['t'];
    hr = json['hr'];
    tb = json['tb'];
    bb = json['bb'];
    ibb = json['ibb'];
    hbp = json['hbp'];
    fc = json['fc'];
    roe = json['roe'];
    h = json['h'];
    h9 = json['h9'];
    hr9 = json['hr9'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['s'] = s;
    data['d'] = d;
    data['t'] = t;
    data['hr'] = hr;
    data['tb'] = tb;
    data['bb'] = bb;
    data['ibb'] = ibb;
    data['hbp'] = hbp;
    data['fc'] = fc;
    data['roe'] = roe;
    data['h'] = h;
    data['h9'] = h9;
    data['hr9'] = hr9;
    return data;
  }
}

class InPlay {
  num linedrive;
  num groundball;
  num popup;
  num flyball;

  InPlay({
    required this.linedrive,
    required this.groundball,
    required this.popup,
    required this.flyball,
  });

  InPlay copyWith({
    num? linedrive,
    num? groundball,
    num? popup,
    num? flyball,
  }) =>
      InPlay(
        linedrive: linedrive ?? this.linedrive,
        groundball: groundball ?? this.groundball,
        popup: popup ?? this.popup,
        flyball: flyball ?? this.flyball,
      );

  factory InPlay.fromRawJson(String str) => InPlay.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InPlay.fromJson(Map<String, dynamic> json) => InPlay(
        linedrive: json["linedrive"],
        groundball: json["groundball"],
        popup: json["popup"],
        flyball: json["flyball"],
      );

  Map<String, dynamic> toJson() => {
        "linedrive": linedrive,
        "groundball": groundball,
        "popup": popup,
        "flyball": flyball,
      };
}

class Outcome {
  num klook;
  num kswing;
  num ktotal;
  num ball;
  num iball;
  num dirtball;
  num foul;

  Outcome({
    required this.klook,
    required this.kswing,
    required this.ktotal,
    required this.ball,
    required this.iball,
    required this.dirtball,
    required this.foul,
  });

  Outcome copyWith({
    num? klook,
    num? kswing,
    num? ktotal,
    num? ball,
    num? iball,
    num? dirtball,
    num? foul,
  }) =>
      Outcome(
        klook: klook ?? this.klook,
        kswing: kswing ?? this.kswing,
        ktotal: ktotal ?? this.ktotal,
        ball: ball ?? this.ball,
        iball: iball ?? this.iball,
        dirtball: dirtball ?? this.dirtball,
        foul: foul ?? this.foul,
      );

  factory Outcome.fromRawJson(String str) => Outcome.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Outcome.fromJson(Map<String, dynamic> json) => Outcome(
        klook: json["klook"],
        kswing: json["kswing"],
        ktotal: json["ktotal"],
        ball: json["ball"],
        iball: json["iball"],
        dirtball: json["dirtball"],
        foul: json["foul"],
      );

  Map<String, dynamic> toJson() => {
        "klook": klook,
        "kswing": kswing,
        "ktotal": ktotal,
        "ball": ball,
        "iball": iball,
        "dirtball": dirtball,
        "foul": foul,
      };
}

class Pitches {
  num count;
  num btotal;
  num ktotal;
  num perIp;
  num perBf;

  Pitches({
    required this.count,
    required this.btotal,
    required this.ktotal,
    required this.perIp,
    required this.perBf,
  });

  Pitches copyWith({
    num? count,
    num? btotal,
    num? ktotal,
    num? perIp,
    num? perBf,
  }) =>
      Pitches(
        count: count ?? this.count,
        btotal: btotal ?? this.btotal,
        ktotal: ktotal ?? this.ktotal,
        perIp: perIp ?? this.perIp,
        perBf: perBf ?? this.perBf,
      );

  factory Pitches.fromRawJson(String str) => Pitches.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Pitches.fromJson(Map<String, dynamic> json) => Pitches(
        count: json["count"],
        btotal: json["btotal"],
        ktotal: json["ktotal"],
        perIp: json["per_ip"] ?? 0,
        perBf: json["per_bf"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "btotal": btotal,
        "ktotal": ktotal,
        "per_ip": perIp,
        "per_bf": perBf,
      };
}

class Runs {
  num total;
  num unearned;
  num earned;
  num ir;
  num ira;
  num bqr;
  num bqra;

  Runs({
    required this.total,
    required this.unearned,
    required this.earned,
    required this.ir,
    required this.ira,
    required this.bqr,
    required this.bqra,
  });

  Runs copyWith({
    num? total,
    num? unearned,
    num? earned,
    num? ir,
    num? ira,
    num? bqr,
    num? bqra,
  }) =>
      Runs(
        total: total ?? this.total,
        unearned: unearned ?? this.unearned,
        earned: earned ?? this.earned,
        ir: ir ?? this.ir,
        ira: ira ?? this.ira,
        bqr: bqr ?? this.bqr,
        bqra: bqra ?? this.bqra,
      );

  factory Runs.fromRawJson(String str) => Runs.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Runs.fromJson(Map<String, dynamic> json) => Runs(
        total: json["total"],
        unearned: json["unearned"],
        earned: json["earned"],
        ir: json["ir"],
        ira: json["ira"],
        bqr: json["bqr"],
        bqra: json["bqra"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "unearned": unearned,
        "earned": earned,
        "ir": ir,
        "ira": ira,
        "bqr": bqr,
        "bqra": bqra,
      };
}

class Steal {
  num caught;
  num stolen;
  num pickoff;

  Steal({
    required this.caught,
    required this.stolen,
    required this.pickoff,
  });

  Steal copyWith({
    num? caught,
    num? stolen,
    num? pickoff,
  }) =>
      Steal(
        caught: caught ?? this.caught,
        stolen: stolen ?? this.stolen,
        pickoff: pickoff ?? this.pickoff,
      );

  factory Steal.fromRawJson(String str) => Steal.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Steal.fromJson(Map<String, dynamic> json) => Steal(
        caught: json["caught"],
        stolen: json["stolen"],
        pickoff: json["pickoff"],
      );

  Map<String, dynamic> toJson() => {
        "caught": caught,
        "stolen": stolen,
        "pickoff": pickoff,
      };
}

class Team {
  String name;
  String market;
  String abbr;
  String id;

  Team({
    required this.name,
    required this.market,
    required this.abbr,
    required this.id,
  });

  Team copyWith({
    String? name,
    String? market,
    String? abbr,
    String? id,
  }) =>
      Team(
        name: name ?? this.name,
        market: market ?? this.market,
        abbr: abbr ?? this.abbr,
        id: id ?? this.id,
      );

  factory Team.fromRawJson(String str) => Team.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Team.fromJson(Map<String, dynamic> json) => Team(
        name: json["name"],
        market: json["market"],
        abbr: json["abbr"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "market": market,
        "abbr": abbr,
        "id": id,
      };
}
