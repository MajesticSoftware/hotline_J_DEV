class HitterPlayerModel {
  Player? player;
  String? sComment;

  HitterPlayerModel({this.player, this.sComment});

  HitterPlayerModel.fromJson(Map<String, dynamic> json) {
    player =
        json['player'] != null ? new Player.fromJson(json['player']) : null;
    sComment = json['_comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.player != null) {
      data['player'] = this.player!.toJson();
    }
    data['_comment'] = this.sComment;
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
    draft = json['draft'] != null ? new Draft.fromJson(json['draft']) : null;
    team = json['team'] != null ? new Team.fromJson(json['team']) : null;
    if (json['seasons'] != null) {
      seasons = <Seasons>[];
      json['seasons'].forEach((v) {
        seasons!.add(new Seasons.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['position'] = this.position;
    data['primary_position'] = this.primaryPosition;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['preferred_name'] = this.preferredName;
    data['jersey_number'] = this.jerseyNumber;
    data['full_name'] = this.fullName;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['throw_hand'] = this.throwHand;
    data['bat_hand'] = this.batHand;
    data['college'] = this.college;
    data['high_school'] = this.highSchool;
    data['birthdate'] = this.birthdate;
    data['birthstate'] = this.birthstate;
    data['birthcountry'] = this.birthcountry;
    data['birthcity'] = this.birthcity;
    data['pro_debut'] = this.proDebut;
    data['updated'] = this.updated;
    data['reference'] = this.reference;
    if (this.draft != null) {
      data['draft'] = this.draft!.toJson();
    }
    if (this.team != null) {
      data['team'] = this.team!.toJson();
    }
    if (this.seasons != null) {
      data['seasons'] = this.seasons!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['team_id'] = this.teamId;
    data['year'] = this.year;
    data['round'] = this.round;
    data['pick'] = this.pick;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['market'] = this.market;
    data['abbr'] = this.abbr;
    data['id'] = this.id;
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
    totals =
        json['totals'] != null ? new Totals.fromJson(json['totals']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['year'] = this.year;
    data['type'] = this.type;
    if (this.totals != null) {
      data['totals'] = this.totals!.toJson();
    }
    return data;
  }
}

class Totals {
  Statistics? statistics;

  Totals({this.statistics});

  Totals.fromJson(Map<String, dynamic> json) {
    statistics = json['statistics'] != null
        ? new Statistics.fromJson(json['statistics'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.statistics != null) {
      data['statistics'] = this.statistics!.toJson();
    }
    return data;
  }
}

class Statistics {
  Hitting? hitting;

  Statistics({this.hitting});

  Statistics.fromJson(Map<String, dynamic> json) {
    hitting =
        json['hitting'] != null ? new Hitting.fromJson(json['hitting']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.hitting != null) {
      data['hitting'] = this.hitting!.toJson();
    }
    return data;
  }
}

class Hitting {
  Overall? overall;

  Hitting({this.overall});

  Hitting.fromJson(Map<String, dynamic> json) {
    overall =
        json['overall'] != null ? new Overall.fromJson(json['overall']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.overall != null) {
      data['overall'] = this.overall!.toJson();
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
    onbase =
        json['onbase'] != null ? new Onbase.fromJson(json['onbase']) : null;
    runs = json['runs'] != null ? new Runs.fromJson(json['runs']) : null;
    outcome =
        json['outcome'] != null ? new Outcome.fromJson(json['outcome']) : null;
    outs = json['outs'] != null ? new Outs.fromJson(json['outs']) : null;
    steal = json['steal'] != null ? new Steal.fromJson(json['steal']) : null;
    pitches =
        json['pitches'] != null ? new Pitches.fromJson(json['pitches']) : null;
    games = json['games'] != null ? new Games.fromJson(json['games']) : null;
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

class Runs {
  num? total;

  Runs({this.total});

  Runs.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['caught'] = this.caught;
    data['stolen'] = this.stolen;
    data['pct'] = this.pct;
    data['pickoff'] = this.pickoff;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['btotal'] = this.btotal;
    data['ktotal'] = this.ktotal;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start'] = this.start;
    data['play'] = this.play;
    data['finish'] = this.finish;
    data['complete'] = this.complete;
    return data;
  }
}
