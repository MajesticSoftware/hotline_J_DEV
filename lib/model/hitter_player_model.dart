class HitterPlayerModel {
  Player? player;
  String? sComment;

  HitterPlayerModel({this.player, this.sComment});

  HitterPlayerModel.fromJson(Map<String, dynamic> json) {
    player = json['player'] != null ? Player.fromJson(json['player']) : null;
    sComment = json['_comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (player != null) {
      data['player'] = player!.toJson();
    }
    data['_comment'] = sComment;
    return data;
  }
}

class Player {
  String? id;
  String? status;
  String? position;
  String? primaryPosition;
  String? firstName;
  String? lastName;
  String? preferredName;
  String? jerseyNumber;
  String? fullName;
  String? height;
  String? weight;
  String? throwHand;
  String? batHand;
  String? college;
  String? highSchool;
  String? birthdate;
  String? birthstate;
  String? birthcountry;
  String? birthcity;
  String? proDebut;
  String? updated;
  String? reference;
  Draft? draft;
  Team? team;
  List<Seasons>? seasons;

  Player(
      {this.id,
      this.status,
      this.position,
      this.primaryPosition,
      this.firstName,
      this.lastName,
      this.preferredName,
      this.jerseyNumber,
      this.fullName,
      this.height,
      this.weight,
      this.throwHand,
      this.batHand,
      this.college,
      this.highSchool,
      this.birthdate,
      this.birthstate,
      this.birthcountry,
      this.birthcity,
      this.proDebut,
      this.updated,
      this.reference,
      this.draft,
      this.team,
      this.seasons});

  Player.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    position = json['position'];
    primaryPosition = json['primary_position'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    preferredName = json['preferred_name'];
    jerseyNumber = json['jersey_number'];
    fullName = json['full_name'];
    height = json['height'];
    weight = json['weight'];
    throwHand = json['throw_hand'];
    batHand = json['bat_hand'];
    college = json['college'];
    highSchool = json['high_school'];
    birthdate = json['birthdate'];
    birthstate = json['birthstate'];
    birthcountry = json['birthcountry'];
    birthcity = json['birthcity'];
    proDebut = json['pro_debut'];
    updated = json['updated'];
    reference = json['reference'];
    draft = json['draft'] != null ? Draft.fromJson(json['draft']) : null;
    team = json['team'] != null ? Team.fromJson(json['team']) : null;
    if (json['seasons'] != null) {
      seasons = <Seasons>[];
      json['seasons'].forEach((v) {
        seasons!.add(Seasons.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['position'] = position;
    data['primary_position'] = primaryPosition;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['preferred_name'] = preferredName;
    data['jersey_number'] = jerseyNumber;
    data['full_name'] = fullName;
    data['height'] = height;
    data['weight'] = weight;
    data['throw_hand'] = throwHand;
    data['bat_hand'] = batHand;
    data['college'] = college;
    data['high_school'] = highSchool;
    data['birthdate'] = birthdate;
    data['birthstate'] = birthstate;
    data['birthcountry'] = birthcountry;
    data['birthcity'] = birthcity;
    data['pro_debut'] = proDebut;
    data['updated'] = updated;
    data['reference'] = reference;
    if (draft != null) {
      data['draft'] = draft!.toJson();
    }
    if (team != null) {
      data['team'] = team!.toJson();
    }
    if (seasons != null) {
      data['seasons'] = seasons!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Draft {
  String? teamId;
  num? year;
  num? round;
  num? pick;

  Draft({this.teamId, this.year, this.round, this.pick});

  Draft.fromJson(Map<String, dynamic> json) {
    teamId = json['team_id'];
    year = json['year'];
    round = json['round'];
    pick = json['pick'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['team_id'] = teamId;
    data['year'] = year;
    data['round'] = round;
    data['pick'] = pick;
    return data;
  }
}

class Team {
  String? name;
  String? market;
  String? abbr;
  String? id;

  Team({this.name, this.market, this.abbr, this.id});

  Team.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    market = json['market'];
    abbr = json['abbr'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['market'] = market;
    data['abbr'] = abbr;
    data['id'] = id;
    return data;
  }
}

class Seasons {
  String? id;
  num? year;
  String? type;
  Totals? totals;

  Seasons({this.id, this.year, this.type, this.totals});

  Seasons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    year = json['year'];
    type = json['type'];
    totals = json['totals'] != null ? Totals.fromJson(json['totals']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['year'] = year;
    data['type'] = type;
    if (totals != null) {
      data['totals'] = totals!.toJson();
    }
    return data;
  }
}

class Totals {
  Statistics? statistics;

  Totals({this.statistics});

  Totals.fromJson(Map<String, dynamic> json) {
    statistics = json['statistics'] != null
        ? Statistics.fromJson(json['statistics'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (statistics != null) {
      data['statistics'] = statistics!.toJson();
    }
    return data;
  }
}

class Statistics {
  Hitting? hitting;

  Statistics({this.hitting});

  Statistics.fromJson(Map<String, dynamic> json) {
    hitting =
        json['hitting'] != null ? Hitting.fromJson(json['hitting']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (hitting != null) {
      data['hitting'] = hitting!.toJson();
    }
    return data;
  }
}

class Hitting {
  Overall? overall;

  Hitting({this.overall});

  Hitting.fromJson(Map<String, dynamic> json) {
    overall =
        json['overall'] != null ? Overall.fromJson(json['overall']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (overall != null) {
      data['overall'] = overall!.toJson();
    }
    return data;
  }
}

class Overall {
  num? ab;
  num? lob;
  num? rbi;
  num? abhr;
  num? abk;
  num? bip;
  num? babip;
  num? bbk;
  num? bbpa;
  num? iso;
  num? obp;
  num? ops;
  num? seca;
  num? slg;
  num? xbh;
  num? pitchCount;
  num? lobRisp2out;
  num? teamLob;
  num? abRisp;
  num? hitRisp;
  num? rbi2out;
  num? linedrive;
  num? groundball;
  num? popup;
  num? flyball;
  num? ap;
  String? avg;
  num? gofo;
  Onbase? onbase;
  Runs? runs;
  Outcome? outcome;
  Outs? outs;
  Steal? steal;
  Pitches? pitches;
  Games? games;

  Overall(
      {this.ab,
      this.lob,
      this.rbi,
      this.abhr,
      this.abk,
      this.bip,
      this.babip,
      this.bbk,
      this.bbpa,
      this.iso,
      this.obp,
      this.ops,
      this.seca,
      this.slg,
      this.xbh,
      this.pitchCount,
      this.lobRisp2out,
      this.teamLob,
      this.abRisp,
      this.hitRisp,
      this.rbi2out,
      this.linedrive,
      this.groundball,
      this.popup,
      this.flyball,
      this.ap,
      this.avg,
      this.gofo,
      this.onbase,
      this.runs,
      this.outcome,
      this.outs,
      this.steal,
      this.pitches,
      this.games});

  Overall.fromJson(Map<String, dynamic> json) {
    ab = json['ab'];
    lob = json['lob'];
    rbi = json['rbi'];
    abhr = json['abhr'];
    abk = json['abk'];
    bip = json['bip'];
    babip = json['babip'];
    bbk = json['bbk'];
    bbpa = json['bbpa'];
    iso = json['iso'];
    obp = json['obp'];
    ops = json['ops'];
    seca = json['seca'];
    slg = json['slg'];
    xbh = json['xbh'];
    pitchCount = json['pitch_count'];
    lobRisp2out = json['lob_risp_2out'];
    teamLob = json['team_lob'];
    abRisp = json['ab_risp'];
    hitRisp = json['hit_risp'];
    rbi2out = json['rbi_2out'];
    linedrive = json['linedrive'];
    groundball = json['groundball'];
    popup = json['popup'];
    flyball = json['flyball'];
    ap = json['ap'];
    avg = json['avg'];
    gofo = json['gofo'];
    onbase = json['onbase'] != null ? Onbase.fromJson(json['onbase']) : null;
    runs = json['runs'] != null ? Runs.fromJson(json['runs']) : null;
    outcome =
        json['outcome'] != null ? Outcome.fromJson(json['outcome']) : null;
    outs = json['outs'] != null ? Outs.fromJson(json['outs']) : null;
    steal = json['steal'] != null ? Steal.fromJson(json['steal']) : null;
    pitches =
        json['pitches'] != null ? Pitches.fromJson(json['pitches']) : null;
    games = json['games'] != null ? Games.fromJson(json['games']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ab'] = ab;
    data['lob'] = lob;
    data['rbi'] = rbi;
    data['abhr'] = abhr;
    data['abk'] = abk;
    data['bip'] = bip;
    data['babip'] = babip;
    data['bbk'] = bbk;
    data['bbpa'] = bbpa;
    data['iso'] = iso;
    data['obp'] = obp;
    data['ops'] = ops;
    data['seca'] = seca;
    data['slg'] = slg;
    data['xbh'] = xbh;
    data['pitch_count'] = pitchCount;
    data['lob_risp_2out'] = lobRisp2out;
    data['team_lob'] = teamLob;
    data['ab_risp'] = abRisp;
    data['hit_risp'] = hitRisp;
    data['rbi_2out'] = rbi2out;
    data['linedrive'] = linedrive;
    data['groundball'] = groundball;
    data['popup'] = popup;
    data['flyball'] = flyball;
    data['ap'] = ap;
    data['avg'] = avg;
    data['gofo'] = gofo;
    if (onbase != null) {
      data['onbase'] = onbase!.toJson();
    }
    if (runs != null) {
      data['runs'] = runs!.toJson();
    }
    if (outcome != null) {
      data['outcome'] = outcome!.toJson();
    }
    if (outs != null) {
      data['outs'] = outs!.toJson();
    }
    if (steal != null) {
      data['steal'] = steal!.toJson();
    }
    if (pitches != null) {
      data['pitches'] = pitches!.toJson();
    }
    if (games != null) {
      data['games'] = games!.toJson();
    }
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
  num? cycle;

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
      this.cycle});

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
    cycle = json['cycle'];
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
    data['cycle'] = cycle;
    return data;
  }
}

class Runs {
  num? total;

  Runs({this.total});

  Runs.fromJson(Map<String, dynamic> json) {
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    return data;
  }
}

class Outcome {
  num? klook;
  num? kswing;
  num? ktotal;
  num? ball;
  num? iball;
  num? dirtball;
  num? foul;

  Outcome(
      {this.klook,
      this.kswing,
      this.ktotal,
      this.ball,
      this.iball,
      this.dirtball,
      this.foul});

  Outcome.fromJson(Map<String, dynamic> json) {
    klook = json['klook'];
    kswing = json['kswing'];
    ktotal = json['ktotal'];
    ball = json['ball'];
    iball = json['iball'];
    dirtball = json['dirtball'];
    foul = json['foul'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['klook'] = klook;
    data['kswing'] = kswing;
    data['ktotal'] = ktotal;
    data['ball'] = ball;
    data['iball'] = iball;
    data['dirtball'] = dirtball;
    data['foul'] = foul;
    return data;
  }
}

class Outs {
  num? po;
  num? fo;
  num? fidp;
  num? lo;
  num? lidp;
  num? go;
  num? gidp;
  num? klook;
  num? kswing;
  num? ktotal;
  num? sacfly;
  num? sachit;

  Outs(
      {this.po,
      this.fo,
      this.fidp,
      this.lo,
      this.lidp,
      this.go,
      this.gidp,
      this.klook,
      this.kswing,
      this.ktotal,
      this.sacfly,
      this.sachit});

  Outs.fromJson(Map<String, dynamic> json) {
    po = json['po'];
    fo = json['fo'];
    fidp = json['fidp'];
    lo = json['lo'];
    lidp = json['lidp'];
    go = json['go'];
    gidp = json['gidp'];
    klook = json['klook'];
    kswing = json['kswing'];
    ktotal = json['ktotal'];
    sacfly = json['sacfly'];
    sachit = json['sachit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['po'] = po;
    data['fo'] = fo;
    data['fidp'] = fidp;
    data['lo'] = lo;
    data['lidp'] = lidp;
    data['go'] = go;
    data['gidp'] = gidp;
    data['klook'] = klook;
    data['kswing'] = kswing;
    data['ktotal'] = ktotal;
    data['sacfly'] = sacfly;
    data['sachit'] = sachit;
    return data;
  }
}

class Steal {
  num? caught;
  num? stolen;
  num? pct;
  num? pickoff;

  Steal({this.caught, this.stolen, this.pct, this.pickoff});

  Steal.fromJson(Map<String, dynamic> json) {
    caught = json['caught'];
    stolen = json['stolen'];
    pct = json['pct'];
    pickoff = json['pickoff'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['caught'] = caught;
    data['stolen'] = stolen;
    data['pct'] = pct;
    data['pickoff'] = pickoff;
    return data;
  }
}

class Pitches {
  num? count;
  num? btotal;
  num? ktotal;

  Pitches({this.count, this.btotal, this.ktotal});

  Pitches.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    btotal = json['btotal'];
    ktotal = json['ktotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['btotal'] = btotal;
    data['ktotal'] = ktotal;
    return data;
  }
}

class Games {
  num? start;
  num? play;
  num? finish;
  num? complete;

  Games({this.start, this.play, this.finish, this.complete});

  Games.fromJson(Map<String, dynamic> json) {
    start = json['start'];
    play = json['play'];
    finish = json['finish'];
    complete = json['complete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['start'] = start;
    data['play'] = play;
    data['finish'] = finish;
    data['complete'] = complete;
    return data;
  }
}
