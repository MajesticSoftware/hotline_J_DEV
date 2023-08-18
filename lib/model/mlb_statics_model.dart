class MLBStaticsModel {
  String? name;
  String? market;
  String? abbr;
  String? id;
  Season? season;
  Statistics? statistics;
  List<Players>? players;
  String? sComment;

  MLBStaticsModel(
      {this.name,
      this.market,
      this.abbr,
      this.id,
      this.season,
      this.statistics,
      this.players,
      this.sComment});

  MLBStaticsModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    market = json['market'];
    abbr = json['abbr'];
    id = json['id'];
    season = json['season'] != null ? Season.fromJson(json['season']) : null;
    statistics = json['statistics'] != null
        ? Statistics.fromJson(json['statistics'])
        : null;
    if (json['players'] != null) {
      players = <Players>[];
      json['players'].forEach((v) {
        players!.add(Players.fromJson(v));
      });
    }
    sComment = json['_comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['market'] = market;
    data['abbr'] = abbr;
    data['id'] = id;
    if (season != null) {
      data['season'] = season!.toJson();
    }
    if (statistics != null) {
      data['statistics'] = statistics!.toJson();
    }
    if (players != null) {
      data['players'] = players!.map((v) => v.toJson()).toList();
    }
    data['_comment'] = sComment;
    return data;
  }
}

class Season {
  String? id;
  num? year;
  String? type;

  Season({this.id, this.year, this.type});

  Season.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    year = json['year'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['year'] = year;
    data['type'] = type;
    return data;
  }
}

class Statistics {
  Hitting? hitting;
  Pitching? pitching;
  Fielding? fielding;

  Statistics({this.hitting, this.pitching, this.fielding});

  Statistics.fromJson(Map<String, dynamic> json) {
    hitting =
        json['hitting'] != null ? Hitting.fromJson(json['hitting']) : null;
    pitching =
        json['pitching'] != null ? Pitching.fromJson(json['pitching']) : null;
    fielding =
        json['fielding'] != null ? Fielding.fromJson(json['fielding']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (hitting != null) {
      data['hitting'] = hitting!.toJson();
    }
    if (pitching != null) {
      data['pitching'] = pitching!.toJson();
    }
    if (fielding != null) {
      data['fielding'] = fielding!.toJson();
    }
    return data;
  }
}

///
class Hitting {
  OverallHitting? overall;

  Hitting({this.overall});

  Hitting.fromJson(Map<String, dynamic> json) {
    overall = json['overall'] != null
        ? OverallHitting.fromJson(json['overall'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (overall != null) {
      data['overall'] = overall!.toJson();
    }
    return data;
  }
}

class OverallHitting {
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
  OnbaseHitting? onbase;
  Runs? runs;
  Outcome? outcome;
  Outs? outs;
  Steal? steal;
  Pitches? pitches;

  OverallHitting(
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
      this.pitches});

  OverallHitting.fromJson(Map<String, dynamic> json) {
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
    onbase =
        json['onbase'] != null ? OnbaseHitting.fromJson(json['onbase']) : null;
    runs = json['runs'] != null ? Runs.fromJson(json['runs']) : null;
    outcome =
        json['outcome'] != null ? Outcome.fromJson(json['outcome']) : null;
    outs = json['outs'] != null ? Outs.fromJson(json['outs']) : null;
    steal = json['steal'] != null ? Steal.fromJson(json['steal']) : null;
    pitches =
        json['pitches'] != null ? Pitches.fromJson(json['pitches']) : null;
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
    return data;
  }
}

class OnbaseHitting {
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

  OnbaseHitting(
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

  OnbaseHitting.fromJson(Map<String, dynamic> json) {
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

class RunsHitting {
  num? total;

  RunsHitting({this.total});

  RunsHitting.fromJson(Map<String, dynamic> json) {
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

class StealHitting {
  num? caught;
  num? stolen;
  num? pct;
  num? pickoff;

  StealHitting({this.caught, this.stolen, this.pct, this.pickoff});

  StealHitting.fromJson(Map<String, dynamic> json) {
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

class PitchesHitting {
  num? count;
  num? btotal;
  num? ktotal;

  PitchesHitting({this.count, this.btotal, this.ktotal});

  PitchesHitting.fromJson(Map<String, dynamic> json) {
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

///
class Pitching {
  Overall? overall;
  Starters? starters;
  Bullpen? bullpen;

  Pitching({this.overall, this.starters, this.bullpen});

  Pitching.fromJson(Map<String, dynamic> json) {
    overall =
        json['overall'] != null ? Overall.fromJson(json['overall']) : null;
    starters =
        json['starters'] != null ? Starters.fromJson(json['starters']) : null;
    bullpen =
        json['bullpen'] != null ? Bullpen.fromJson(json['bullpen']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (overall != null) {
      data['overall'] = overall!.toJson();
    }
    if (starters != null) {
      data['starters'] = starters!.toJson();
    }
    if (bullpen != null) {
      data['bullpen'] = bullpen!.toJson();
    }
    return data;
  }
}

class Overall {
  num? oba;
  num? lob;
  num? era;
  num? k9;
  num? whip;
  num? kbb;
  num? pitchCount;
  num? wp;
  num? bk;
  num? ip1;
  num? ip2;
  num? bf;
  num? gofo;
  num? babip;
  num? bfIp;
  num? bfStart;
  num? gbfb;
  num? oab;
  num? slg;
  num? obp;
  Onbase? onbase;
  Runs? runs;
  Outcome? outcome;
  Outs? outs;
  Steal? steal;
  Pitches? pitches;
  InPlay? inPlay;
  Games? games;

  Overall(
      {this.oba,
      this.lob,
      this.era,
      this.k9,
      this.whip,
      this.kbb,
      this.pitchCount,
      this.wp,
      this.bk,
      this.ip1,
      this.ip2,
      this.bf,
      this.gofo,
      this.babip,
      this.bfIp,
      this.bfStart,
      this.gbfb,
      this.oab,
      this.slg,
      this.obp,
      this.onbase,
      this.runs,
      this.outcome,
      this.outs,
      this.steal,
      this.pitches,
      this.inPlay,
      this.games});

  Overall.fromJson(Map<String, dynamic> json) {
    oba = json['oba'];
    lob = json['lob'];
    era = json['era'];
    k9 = json['k9'];
    whip = json['whip'];
    kbb = json['kbb'];
    pitchCount = json['pitch_count'];
    wp = json['wp'];
    bk = json['bk'];
    ip1 = json['ip_1'];
    ip2 = json['ip_2'];
    bf = json['bf'];
    gofo = json['gofo'];
    babip = json['babip'];
    bfIp = json['bf_ip'];
    bfStart = json['bf_start'];
    gbfb = json['gbfb'];
    oab = json['oab'];
    slg = json['slg'];
    obp = json['obp'];
    onbase = json['onbase'] != null ? Onbase.fromJson(json['onbase']) : null;
    runs = json['runs'] != null ? Runs.fromJson(json['runs']) : null;
    outcome =
        json['outcome'] != null ? Outcome.fromJson(json['outcome']) : null;
    outs = json['outs'] != null ? Outs.fromJson(json['outs']) : null;
    steal = json['steal'] != null ? Steal.fromJson(json['steal']) : null;
    pitches =
        json['pitches'] != null ? Pitches.fromJson(json['pitches']) : null;
    inPlay = json['in_play'] != null ? InPlay.fromJson(json['in_play']) : null;
    games = json['games'] != null ? Games.fromJson(json['games']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['oba'] = oba;
    data['lob'] = lob;
    data['era'] = era;
    data['k9'] = k9;
    data['whip'] = whip;
    data['kbb'] = kbb;
    data['pitch_count'] = pitchCount;
    data['wp'] = wp;
    data['bk'] = bk;
    data['ip_1'] = ip1;
    data['ip_2'] = ip2;
    data['bf'] = bf;
    data['gofo'] = gofo;
    data['babip'] = babip;
    data['bf_ip'] = bfIp;
    data['bf_start'] = bfStart;
    data['gbfb'] = gbfb;
    data['oab'] = oab;
    data['slg'] = slg;
    data['obp'] = obp;
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
    if (inPlay != null) {
      data['in_play'] = inPlay!.toJson();
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

class Runs {
  num? total;
  num? unearned;
  num? earned;
  num? ir;
  num? ira;
  num? bqr;
  num? bqra;

  Runs(
      {this.total,
      this.unearned,
      this.earned,
      this.ir,
      this.ira,
      this.bqr,
      this.bqra});

  Runs.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    unearned = json['unearned'];
    earned = json['earned'];
    ir = json['ir'];
    ira = json['ira'];
    bqr = json['bqr'];
    bqra = json['bqra'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['unearned'] = unearned;
    data['earned'] = earned;
    data['ir'] = ir;
    data['ira'] = ira;
    data['bqr'] = bqr;
    data['bqra'] = bqra;
    return data;
  }
}

class Steal {
  num? caught;
  num? stolen;
  num? pickoff;

  Steal({this.caught, this.stolen, this.pickoff});

  Steal.fromJson(Map<String, dynamic> json) {
    caught = json['caught'];
    stolen = json['stolen'];
    pickoff = json['pickoff'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['caught'] = caught;
    data['stolen'] = stolen;
    data['pickoff'] = pickoff;
    return data;
  }
}

class Pitches {
  num? count;
  num? btotal;
  num? ktotal;
  num? perIp;
  num? perBf;
  num? perStart;

  Pitches(
      {this.count,
      this.btotal,
      this.ktotal,
      this.perIp,
      this.perBf,
      this.perStart});

  Pitches.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    btotal = json['btotal'];
    ktotal = json['ktotal'];
    perIp = json['per_ip'];
    perBf = json['per_bf'];
    perStart = json['per_start'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['btotal'] = btotal;
    data['ktotal'] = ktotal;
    data['per_ip'] = perIp;
    data['per_bf'] = perBf;
    data['per_start'] = perStart;
    return data;
  }
}

class InPlay {
  num? linedrive;
  num? groundball;
  num? popup;
  num? flyball;

  InPlay({this.linedrive, this.groundball, this.popup, this.flyball});

  InPlay.fromJson(Map<String, dynamic> json) {
    linedrive = json['linedrive'];
    groundball = json['groundball'];
    popup = json['popup'];
    flyball = json['flyball'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['linedrive'] = linedrive;
    data['groundball'] = groundball;
    data['popup'] = popup;
    data['flyball'] = flyball;
    return data;
  }
}

class Starters {
  num? oba;
  num? lob;
  num? era;
  num? k9;
  num? whip;
  num? kbb;
  num? pitchCount;
  num? wp;
  num? bk;
  num? ip1;
  num? ip2;
  num? bf;
  num? gofo;
  num? babip;
  num? bfIp;
  num? bfStart;
  num? gbfb;
  num? oab;
  num? slg;
  num? obp;
  Onbase? onbase;
  Runs? runs;
  Outcome? outcome;
  Outs? outs;
  Steal? steal;
  Pitches? pitches;
  InPlay? inPlay;
  Games? games;

  Starters(
      {this.oba,
      this.lob,
      this.era,
      this.k9,
      this.whip,
      this.kbb,
      this.pitchCount,
      this.wp,
      this.bk,
      this.ip1,
      this.ip2,
      this.bf,
      this.gofo,
      this.babip,
      this.bfIp,
      this.bfStart,
      this.gbfb,
      this.oab,
      this.slg,
      this.obp,
      this.onbase,
      this.runs,
      this.outcome,
      this.outs,
      this.steal,
      this.pitches,
      this.inPlay,
      this.games});

  Starters.fromJson(Map<String, dynamic> json) {
    oba = json['oba'];
    lob = json['lob'];
    era = json['era'];
    k9 = json['k9'];
    whip = json['whip'];
    kbb = json['kbb'];
    pitchCount = json['pitch_count'];
    wp = json['wp'];
    bk = json['bk'];
    ip1 = json['ip_1'];
    ip2 = json['ip_2'];
    bf = json['bf'];
    gofo = json['gofo'];
    babip = json['babip'];
    bfIp = json['bf_ip'];
    bfStart = json['bf_start'];
    gbfb = json['gbfb'];
    oab = json['oab'];
    slg = json['slg'];
    obp = json['obp'];
    onbase = json['onbase'] != null ? Onbase.fromJson(json['onbase']) : null;
    runs = json['runs'] != null ? Runs.fromJson(json['runs']) : null;
    outcome =
        json['outcome'] != null ? Outcome.fromJson(json['outcome']) : null;
    outs = json['outs'] != null ? Outs.fromJson(json['outs']) : null;
    steal = json['steal'] != null ? Steal.fromJson(json['steal']) : null;
    pitches =
        json['pitches'] != null ? Pitches.fromJson(json['pitches']) : null;
    inPlay = json['in_play'] != null ? InPlay.fromJson(json['in_play']) : null;
    games = json['games'] != null ? Games.fromJson(json['games']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['oba'] = oba;
    data['lob'] = lob;
    data['era'] = era;
    data['k9'] = k9;
    data['whip'] = whip;
    data['kbb'] = kbb;
    data['pitch_count'] = pitchCount;
    data['wp'] = wp;
    data['bk'] = bk;
    data['ip_1'] = ip1;
    data['ip_2'] = ip2;
    data['bf'] = bf;
    data['gofo'] = gofo;
    data['babip'] = babip;
    data['bf_ip'] = bfIp;
    data['bf_start'] = bfStart;
    data['gbfb'] = gbfb;
    data['oab'] = oab;
    data['slg'] = slg;
    data['obp'] = obp;
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
    if (inPlay != null) {
      data['in_play'] = inPlay!.toJson();
    }
    if (games != null) {
      data['games'] = games!.toJson();
    }
    return data;
  }
}

class Bullpen {
  num? oba;
  num? lob;
  num? era;
  num? k9;
  num? whip;
  num? kbb;
  num? pitchCount;
  num? wp;
  num? bk;
  num? ip1;
  num? ip2;
  num? bf;
  num? gofo;
  num? babip;
  num? bfIp;
  num? gbfb;
  num? oab;
  num? slg;
  num? obp;
  Onbase? onbase;
  Runs? runs;
  Outcome? outcome;
  Outs? outs;
  Steal? steal;
  Pitches? pitches;
  InPlay? inPlay;
  Games? games;

  Bullpen(
      {this.oba,
      this.lob,
      this.era,
      this.k9,
      this.whip,
      this.kbb,
      this.pitchCount,
      this.wp,
      this.bk,
      this.ip1,
      this.ip2,
      this.bf,
      this.gofo,
      this.babip,
      this.bfIp,
      this.gbfb,
      this.oab,
      this.slg,
      this.obp,
      this.onbase,
      this.runs,
      this.outcome,
      this.outs,
      this.steal,
      this.pitches,
      this.inPlay,
      this.games});

  Bullpen.fromJson(Map<String, dynamic> json) {
    oba = json['oba'];
    lob = json['lob'];
    era = json['era'];
    k9 = json['k9'];
    whip = json['whip'];
    kbb = json['kbb'];
    pitchCount = json['pitch_count'];
    wp = json['wp'];
    bk = json['bk'];
    ip1 = json['ip_1'];
    ip2 = json['ip_2'];
    bf = json['bf'];
    gofo = json['gofo'];
    babip = json['babip'];
    bfIp = json['bf_ip'];
    gbfb = json['gbfb'];
    oab = json['oab'];
    slg = json['slg'];
    obp = json['obp'];
    onbase = json['onbase'] != null ? Onbase.fromJson(json['onbase']) : null;
    runs = json['runs'] != null ? Runs.fromJson(json['runs']) : null;
    outcome =
        json['outcome'] != null ? Outcome.fromJson(json['outcome']) : null;
    outs = json['outs'] != null ? Outs.fromJson(json['outs']) : null;
    steal = json['steal'] != null ? Steal.fromJson(json['steal']) : null;
    pitches =
        json['pitches'] != null ? Pitches.fromJson(json['pitches']) : null;
    inPlay = json['in_play'] != null ? InPlay.fromJson(json['in_play']) : null;
    games = json['games'] != null ? Games.fromJson(json['games']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['oba'] = oba;
    data['lob'] = lob;
    data['era'] = era;
    data['k9'] = k9;
    data['whip'] = whip;
    data['kbb'] = kbb;
    data['pitch_count'] = pitchCount;
    data['wp'] = wp;
    data['bk'] = bk;
    data['ip_1'] = ip1;
    data['ip_2'] = ip2;
    data['bf'] = bf;
    data['gofo'] = gofo;
    data['babip'] = babip;
    data['bf_ip'] = bfIp;
    data['gbfb'] = gbfb;
    data['oab'] = oab;
    data['slg'] = slg;
    data['obp'] = obp;
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
    if (inPlay != null) {
      data['in_play'] = inPlay!.toJson();
    }
    if (games != null) {
      data['games'] = games!.toJson();
    }
    return data;
  }
}

class Errors {
  num? throwing;
  num? fielding;
  num? numerference;
  num? total;

  Errors({this.throwing, this.fielding, this.numerference, this.total});

  Errors.fromJson(Map<String, dynamic> json) {
    throwing = json['throwing'];
    fielding = json['fielding'];
    numerference = json['numerference'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['throwing'] = throwing;
    data['fielding'] = fielding;
    data['numerference'] = numerference;
    data['total'] = total;
    return data;
  }
}

class Assists {
  num? outfield;
  num? total;

  Assists({this.outfield, this.total});

  Assists.fromJson(Map<String, dynamic> json) {
    outfield = json['outfield'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['outfield'] = outfield;
    data['total'] = total;
    return data;
  }
}

class Players {
  String? preferredName;
  String? firstName;
  String? lastName;
  String? jerseyNumber;
  String? id;
  String? position;
  String? primaryPosition;
  Statistics? statistics;

  Players(
      {this.preferredName,
      this.firstName,
      this.lastName,
      this.jerseyNumber,
      this.id,
      this.position,
      this.primaryPosition,
      this.statistics});

  Players.fromJson(Map<String, dynamic> json) {
    preferredName = json['preferred_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    jerseyNumber = json['jersey_number'];
    id = json['id'];
    position = json['position'];
    primaryPosition = json['primary_position'];
    statistics = json['statistics'] != null
        ? Statistics.fromJson(json['statistics'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['preferred_name'] = preferredName;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['jersey_number'] = jerseyNumber;
    data['id'] = id;
    data['position'] = position;
    data['primary_position'] = primaryPosition;
    if (statistics != null) {
      data['statistics'] = statistics!.toJson();
    }
    return data;
  }
}

///
class Fielding {
  Overall? overall;
  List<Positions>? positions;

  Fielding({this.overall, this.positions});

  Fielding.fromJson(Map<String, dynamic> json) {
    overall =
        json['overall'] != null ? Overall.fromJson(json['overall']) : null;
    if (json['positions'] != null) {
      positions = <Positions>[];
      json['positions'].forEach((v) {
        positions!.add(Positions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (overall != null) {
      data['overall'] = overall!.toJson();
    }
    if (positions != null) {
      data['positions'] = positions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Positions {
  num? po;
  num? a;
  num? dp;
  num? tp;
  num? error;
  num? tc;
  num? fpct;
  num? cWp;
  num? pb;
  num? rf;
  num? inn1;
  num? inn2;
  String? position;
  Steal? steal;
  Errors? errors;
  Assists? assists;
  Games? games;

  Positions(
      {this.po,
      this.a,
      this.dp,
      this.tp,
      this.error,
      this.tc,
      this.fpct,
      this.cWp,
      this.pb,
      this.rf,
      this.inn1,
      this.inn2,
      this.position,
      this.steal,
      this.errors,
      this.assists,
      this.games});

  Positions.fromJson(Map<String, dynamic> json) {
    po = json['po'];
    a = json['a'];
    dp = json['dp'];
    tp = json['tp'];
    error = json['error'];
    tc = json['tc'];
    fpct = json['fpct'];
    cWp = json['c_wp'];
    pb = json['pb'];
    rf = json['rf'];
    inn1 = json['inn_1'];
    inn2 = json['inn_2'];
    position = json['position'];
    steal = json['steal'] != null ? Steal.fromJson(json['steal']) : null;
    errors = json['errors'] != null ? Errors.fromJson(json['errors']) : null;
    assists =
        json['assists'] != null ? Assists.fromJson(json['assists']) : null;
    games = json['games'] != null ? Games.fromJson(json['games']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['po'] = po;
    data['a'] = a;
    data['dp'] = dp;
    data['tp'] = tp;
    data['error'] = error;
    data['tc'] = tc;
    data['fpct'] = fpct;
    data['c_wp'] = cWp;
    data['pb'] = pb;
    data['rf'] = rf;
    data['inn_1'] = inn1;
    data['inn_2'] = inn2;
    data['position'] = position;
    if (steal != null) {
      data['steal'] = steal!.toJson();
    }
    if (errors != null) {
      data['errors'] = errors!.toJson();
    }
    if (assists != null) {
      data['assists'] = assists!.toJson();
    }
    if (games != null) {
      data['games'] = games!.toJson();
    }
    return data;
  }
}

class Games {
  num? start;
  num? play;
  num? finish;
  num? svo;
  num? qstart;
  num? shutout;
  num? complete;
  num? win;
  num? loss;
  num? save;
  num? hold;
  num? blownSave;
  num? teamWin;
  num? teamLoss;

  Games(
      {this.start,
      this.play,
      this.finish,
      this.svo,
      this.qstart,
      this.shutout,
      this.complete,
      this.win,
      this.loss,
      this.save,
      this.hold,
      this.blownSave,
      this.teamWin,
      this.teamLoss});

  Games.fromJson(Map<String, dynamic> json) {
    start = json['start'];
    play = json['play'];
    finish = json['finish'];
    svo = json['svo'];
    qstart = json['qstart'];
    shutout = json['shutout'];
    complete = json['complete'];
    win = json['win'];
    loss = json['loss'];
    save = json['save'];
    hold = json['hold'];
    blownSave = json['blown_save'];
    teamWin = json['team_win'];
    teamLoss = json['team_loss'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['start'] = start;
    data['play'] = play;
    data['finish'] = finish;
    data['svo'] = svo;
    data['qstart'] = qstart;
    data['shutout'] = shutout;
    data['complete'] = complete;
    data['win'] = win;
    data['loss'] = loss;
    data['save'] = save;
    data['hold'] = hold;
    data['blown_save'] = blownSave;
    data['team_win'] = teamWin;
    data['team_loss'] = teamLoss;
    return data;
  }
}
