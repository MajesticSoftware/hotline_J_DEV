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
    season =
        json['season'] != null ? new Season.fromJson(json['season']) : null;
    statistics = json['statistics'] != null
        ? new Statistics.fromJson(json['statistics'])
        : null;
    if (json['players'] != null) {
      players = <Players>[];
      json['players'].forEach((v) {
        players!.add(new Players.fromJson(v));
      });
    }
    sComment = json['_comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['market'] = this.market;
    data['abbr'] = this.abbr;
    data['id'] = this.id;
    if (this.season != null) {
      data['season'] = this.season!.toJson();
    }
    if (this.statistics != null) {
      data['statistics'] = this.statistics!.toJson();
    }
    if (this.players != null) {
      data['players'] = this.players!.map((v) => v.toJson()).toList();
    }
    data['_comment'] = this.sComment;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['year'] = this.year;
    data['type'] = this.type;
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
        json['hitting'] != null ? new Hitting.fromJson(json['hitting']) : null;
    pitching = json['pitching'] != null
        ? new Pitching.fromJson(json['pitching'])
        : null;
    fielding = json['fielding'] != null
        ? new Fielding.fromJson(json['fielding'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.hitting != null) {
      data['hitting'] = this.hitting!.toJson();
    }
    if (this.pitching != null) {
      data['pitching'] = this.pitching!.toJson();
    }
    if (this.fielding != null) {
      data['fielding'] = this.fielding!.toJson();
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
        ? new OverallHitting.fromJson(json['overall'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.overall != null) {
      data['overall'] = this.overall!.toJson();
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
  Onbase? onbase;
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
        json['onbase'] != null ? new Onbase.fromJson(json['onbase']) : null;
    runs = json['runs'] != null ? new Runs.fromJson(json['runs']) : null;
    outcome =
        json['outcome'] != null ? new Outcome.fromJson(json['outcome']) : null;
    outs = json['outs'] != null ? new Outs.fromJson(json['outs']) : null;
    steal = json['steal'] != null ? new Steal.fromJson(json['steal']) : null;
    pitches =
        json['pitches'] != null ? new Pitches.fromJson(json['pitches']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ab'] = this.ab;
    data['lob'] = this.lob;
    data['rbi'] = this.rbi;
    data['abhr'] = this.abhr;
    data['abk'] = this.abk;
    data['bip'] = this.bip;
    data['babip'] = this.babip;
    data['bbk'] = this.bbk;
    data['bbpa'] = this.bbpa;
    data['iso'] = this.iso;
    data['obp'] = this.obp;
    data['ops'] = this.ops;
    data['seca'] = this.seca;
    data['slg'] = this.slg;
    data['xbh'] = this.xbh;
    data['pitch_count'] = this.pitchCount;
    data['lob_risp_2out'] = this.lobRisp2out;
    data['team_lob'] = this.teamLob;
    data['ab_risp'] = this.abRisp;
    data['hit_risp'] = this.hitRisp;
    data['rbi_2out'] = this.rbi2out;
    data['linedrive'] = this.linedrive;
    data['groundball'] = this.groundball;
    data['popup'] = this.popup;
    data['flyball'] = this.flyball;
    data['ap'] = this.ap;
    data['avg'] = this.avg;
    data['gofo'] = this.gofo;
    if (this.onbase != null) {
      data['onbase'] = this.onbase!.toJson();
    }
    if (this.runs != null) {
      data['runs'] = this.runs!.toJson();
    }
    if (this.outcome != null) {
      data['outcome'] = this.outcome!.toJson();
    }
    if (this.outs != null) {
      data['outs'] = this.outs!.toJson();
    }
    if (this.steal != null) {
      data['steal'] = this.steal!.toJson();
    }
    if (this.pitches != null) {
      data['pitches'] = this.pitches!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['s'] = this.s;
    data['d'] = this.d;
    data['t'] = this.t;
    data['hr'] = this.hr;
    data['tb'] = this.tb;
    data['bb'] = this.bb;
    data['ibb'] = this.ibb;
    data['hbp'] = this.hbp;
    data['fc'] = this.fc;
    data['roe'] = this.roe;
    data['h'] = this.h;
    data['cycle'] = this.cycle;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['klook'] = this.klook;
    data['kswing'] = this.kswing;
    data['ktotal'] = this.ktotal;
    data['ball'] = this.ball;
    data['iball'] = this.iball;
    data['dirtball'] = this.dirtball;
    data['foul'] = this.foul;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['po'] = this.po;
    data['fo'] = this.fo;
    data['fidp'] = this.fidp;
    data['lo'] = this.lo;
    data['lidp'] = this.lidp;
    data['go'] = this.go;
    data['gidp'] = this.gidp;
    data['klook'] = this.klook;
    data['kswing'] = this.kswing;
    data['ktotal'] = this.ktotal;
    data['sacfly'] = this.sacfly;
    data['sachit'] = this.sachit;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['caught'] = this.caught;
    data['stolen'] = this.stolen;
    data['pct'] = this.pct;
    data['pickoff'] = this.pickoff;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['btotal'] = this.btotal;
    data['ktotal'] = this.ktotal;
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
        json['overall'] != null ? new Overall.fromJson(json['overall']) : null;
    starters = json['starters'] != null
        ? new Starters.fromJson(json['starters'])
        : null;
    bullpen =
        json['bullpen'] != null ? new Bullpen.fromJson(json['bullpen']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.overall != null) {
      data['overall'] = this.overall!.toJson();
    }
    if (this.starters != null) {
      data['starters'] = this.starters!.toJson();
    }
    if (this.bullpen != null) {
      data['bullpen'] = this.bullpen!.toJson();
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
    onbase =
        json['onbase'] != null ? new Onbase.fromJson(json['onbase']) : null;
    runs = json['runs'] != null ? new Runs.fromJson(json['runs']) : null;
    outcome =
        json['outcome'] != null ? new Outcome.fromJson(json['outcome']) : null;
    outs = json['outs'] != null ? new Outs.fromJson(json['outs']) : null;
    steal = json['steal'] != null ? new Steal.fromJson(json['steal']) : null;
    pitches =
        json['pitches'] != null ? new Pitches.fromJson(json['pitches']) : null;
    inPlay =
        json['in_play'] != null ? new InPlay.fromJson(json['in_play']) : null;
    games = json['games'] != null ? new Games.fromJson(json['games']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['oba'] = this.oba;
    data['lob'] = this.lob;
    data['era'] = this.era;
    data['k9'] = this.k9;
    data['whip'] = this.whip;
    data['kbb'] = this.kbb;
    data['pitch_count'] = this.pitchCount;
    data['wp'] = this.wp;
    data['bk'] = this.bk;
    data['ip_1'] = this.ip1;
    data['ip_2'] = this.ip2;
    data['bf'] = this.bf;
    data['gofo'] = this.gofo;
    data['babip'] = this.babip;
    data['bf_ip'] = this.bfIp;
    data['bf_start'] = this.bfStart;
    data['gbfb'] = this.gbfb;
    data['oab'] = this.oab;
    data['slg'] = this.slg;
    data['obp'] = this.obp;
    if (this.onbase != null) {
      data['onbase'] = this.onbase!.toJson();
    }
    if (this.runs != null) {
      data['runs'] = this.runs!.toJson();
    }
    if (this.outcome != null) {
      data['outcome'] = this.outcome!.toJson();
    }
    if (this.outs != null) {
      data['outs'] = this.outs!.toJson();
    }
    if (this.steal != null) {
      data['steal'] = this.steal!.toJson();
    }
    if (this.pitches != null) {
      data['pitches'] = this.pitches!.toJson();
    }
    if (this.inPlay != null) {
      data['in_play'] = this.inPlay!.toJson();
    }
    if (this.games != null) {
      data['games'] = this.games!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['s'] = this.s;
    data['d'] = this.d;
    data['t'] = this.t;
    data['hr'] = this.hr;
    data['tb'] = this.tb;
    data['bb'] = this.bb;
    data['ibb'] = this.ibb;
    data['hbp'] = this.hbp;
    data['fc'] = this.fc;
    data['roe'] = this.roe;
    data['h'] = this.h;
    data['h9'] = this.h9;
    data['hr9'] = this.hr9;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['unearned'] = this.unearned;
    data['earned'] = this.earned;
    data['ir'] = this.ir;
    data['ira'] = this.ira;
    data['bqr'] = this.bqr;
    data['bqra'] = this.bqra;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['caught'] = this.caught;
    data['stolen'] = this.stolen;
    data['pickoff'] = this.pickoff;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['btotal'] = this.btotal;
    data['ktotal'] = this.ktotal;
    data['per_ip'] = this.perIp;
    data['per_bf'] = this.perBf;
    data['per_start'] = this.perStart;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['linedrive'] = this.linedrive;
    data['groundball'] = this.groundball;
    data['popup'] = this.popup;
    data['flyball'] = this.flyball;
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
    onbase =
        json['onbase'] != null ? new Onbase.fromJson(json['onbase']) : null;
    runs = json['runs'] != null ? new Runs.fromJson(json['runs']) : null;
    outcome =
        json['outcome'] != null ? new Outcome.fromJson(json['outcome']) : null;
    outs = json['outs'] != null ? new Outs.fromJson(json['outs']) : null;
    steal = json['steal'] != null ? new Steal.fromJson(json['steal']) : null;
    pitches =
        json['pitches'] != null ? new Pitches.fromJson(json['pitches']) : null;
    inPlay =
        json['in_play'] != null ? new InPlay.fromJson(json['in_play']) : null;
    games = json['games'] != null ? new Games.fromJson(json['games']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['oba'] = this.oba;
    data['lob'] = this.lob;
    data['era'] = this.era;
    data['k9'] = this.k9;
    data['whip'] = this.whip;
    data['kbb'] = this.kbb;
    data['pitch_count'] = this.pitchCount;
    data['wp'] = this.wp;
    data['bk'] = this.bk;
    data['ip_1'] = this.ip1;
    data['ip_2'] = this.ip2;
    data['bf'] = this.bf;
    data['gofo'] = this.gofo;
    data['babip'] = this.babip;
    data['bf_ip'] = this.bfIp;
    data['bf_start'] = this.bfStart;
    data['gbfb'] = this.gbfb;
    data['oab'] = this.oab;
    data['slg'] = this.slg;
    data['obp'] = this.obp;
    if (this.onbase != null) {
      data['onbase'] = this.onbase!.toJson();
    }
    if (this.runs != null) {
      data['runs'] = this.runs!.toJson();
    }
    if (this.outcome != null) {
      data['outcome'] = this.outcome!.toJson();
    }
    if (this.outs != null) {
      data['outs'] = this.outs!.toJson();
    }
    if (this.steal != null) {
      data['steal'] = this.steal!.toJson();
    }
    if (this.pitches != null) {
      data['pitches'] = this.pitches!.toJson();
    }
    if (this.inPlay != null) {
      data['in_play'] = this.inPlay!.toJson();
    }
    if (this.games != null) {
      data['games'] = this.games!.toJson();
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
    onbase =
        json['onbase'] != null ? new Onbase.fromJson(json['onbase']) : null;
    runs = json['runs'] != null ? new Runs.fromJson(json['runs']) : null;
    outcome =
        json['outcome'] != null ? new Outcome.fromJson(json['outcome']) : null;
    outs = json['outs'] != null ? new Outs.fromJson(json['outs']) : null;
    steal = json['steal'] != null ? new Steal.fromJson(json['steal']) : null;
    pitches =
        json['pitches'] != null ? new Pitches.fromJson(json['pitches']) : null;
    inPlay =
        json['in_play'] != null ? new InPlay.fromJson(json['in_play']) : null;
    games = json['games'] != null ? new Games.fromJson(json['games']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['oba'] = this.oba;
    data['lob'] = this.lob;
    data['era'] = this.era;
    data['k9'] = this.k9;
    data['whip'] = this.whip;
    data['kbb'] = this.kbb;
    data['pitch_count'] = this.pitchCount;
    data['wp'] = this.wp;
    data['bk'] = this.bk;
    data['ip_1'] = this.ip1;
    data['ip_2'] = this.ip2;
    data['bf'] = this.bf;
    data['gofo'] = this.gofo;
    data['babip'] = this.babip;
    data['bf_ip'] = this.bfIp;
    data['gbfb'] = this.gbfb;
    data['oab'] = this.oab;
    data['slg'] = this.slg;
    data['obp'] = this.obp;
    if (this.onbase != null) {
      data['onbase'] = this.onbase!.toJson();
    }
    if (this.runs != null) {
      data['runs'] = this.runs!.toJson();
    }
    if (this.outcome != null) {
      data['outcome'] = this.outcome!.toJson();
    }
    if (this.outs != null) {
      data['outs'] = this.outs!.toJson();
    }
    if (this.steal != null) {
      data['steal'] = this.steal!.toJson();
    }
    if (this.pitches != null) {
      data['pitches'] = this.pitches!.toJson();
    }
    if (this.inPlay != null) {
      data['in_play'] = this.inPlay!.toJson();
    }
    if (this.games != null) {
      data['games'] = this.games!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['throwing'] = this.throwing;
    data['fielding'] = this.fielding;
    data['numerference'] = this.numerference;
    data['total'] = this.total;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['outfield'] = this.outfield;
    data['total'] = this.total;
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
        ? new Statistics.fromJson(json['statistics'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['preferred_name'] = this.preferredName;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['jersey_number'] = this.jerseyNumber;
    data['id'] = this.id;
    data['position'] = this.position;
    data['primary_position'] = this.primaryPosition;
    if (this.statistics != null) {
      data['statistics'] = this.statistics!.toJson();
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
        json['overall'] != null ? new Overall.fromJson(json['overall']) : null;
    if (json['positions'] != null) {
      positions = <Positions>[];
      json['positions'].forEach((v) {
        positions!.add(new Positions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.overall != null) {
      data['overall'] = this.overall!.toJson();
    }
    if (this.positions != null) {
      data['positions'] = this.positions!.map((v) => v.toJson()).toList();
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
    steal = json['steal'] != null ? new Steal.fromJson(json['steal']) : null;
    errors =
        json['errors'] != null ? new Errors.fromJson(json['errors']) : null;
    assists =
        json['assists'] != null ? new Assists.fromJson(json['assists']) : null;
    games = json['games'] != null ? new Games.fromJson(json['games']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['po'] = this.po;
    data['a'] = this.a;
    data['dp'] = this.dp;
    data['tp'] = this.tp;
    data['error'] = this.error;
    data['tc'] = this.tc;
    data['fpct'] = this.fpct;
    data['c_wp'] = this.cWp;
    data['pb'] = this.pb;
    data['rf'] = this.rf;
    data['inn_1'] = this.inn1;
    data['inn_2'] = this.inn2;
    data['position'] = this.position;
    if (this.steal != null) {
      data['steal'] = this.steal!.toJson();
    }
    if (this.errors != null) {
      data['errors'] = this.errors!.toJson();
    }
    if (this.assists != null) {
      data['assists'] = this.assists!.toJson();
    }
    if (this.games != null) {
      data['games'] = this.games!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start'] = this.start;
    data['play'] = this.play;
    data['finish'] = this.finish;
    data['svo'] = this.svo;
    data['qstart'] = this.qstart;
    data['shutout'] = this.shutout;
    data['complete'] = this.complete;
    data['win'] = this.win;
    data['loss'] = this.loss;
    data['save'] = this.save;
    data['hold'] = this.hold;
    data['blown_save'] = this.blownSave;
    data['team_win'] = this.teamWin;
    data['team_loss'] = this.teamLoss;
    return data;
  }
}
