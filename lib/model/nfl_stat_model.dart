class NFLStatModel {
  String? lastUpdated;
  int? leagueYear;
  Stats? stats;

  NFLStatModel({this.lastUpdated, this.leagueYear, this.stats});

  NFLStatModel.fromJson(Map<String, dynamic> json) {
    lastUpdated = json['lastUpdated'];
    leagueYear = json['leagueYear'];
    stats = json['stats'] != null ? Stats.fromJson(json['stats']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lastUpdated'] = lastUpdated;
    data['leagueYear'] = leagueYear;
    if (stats != null) {
      data['stats'] = stats!.toJson();
    }
    return data;
  }
}

class Stats {
  BuffaloBills? buffaloBills;
  BuffaloBills? miamiDolphins;
  BuffaloBills? newEnglandPatriots;
  BuffaloBills? newYorkJets;
  BuffaloBills? cincinnatiBengals;
  BuffaloBills? baltimoreRavens;
  BuffaloBills? pittsburghSteelers;
  BuffaloBills? clevelandBrowns;
  BuffaloBills? jacksonvilleJaguars;
  BuffaloBills? tennesseeTitans;
  BuffaloBills? indianapolisColts;
  BuffaloBills? houstonTexans;
  BuffaloBills? kansasCityChiefs;
  BuffaloBills? losAngelesChargers;
  BuffaloBills? lasVegasRaiders;
  BuffaloBills? denverBroncos;
  BuffaloBills? sanFrancisco49ers;
  BuffaloBills? dallasCowboys;
  BuffaloBills? washingtonCommanders;
  BuffaloBills? philadelphiaEagles;
  BuffaloBills? newOrleansSaints;
  BuffaloBills? tampaBayBuccaneers;
  BuffaloBills? greenBayPackers;
  BuffaloBills? newYorkGiants;
  BuffaloBills? carolinaPanthers;
  BuffaloBills? losAngelesRams;
  BuffaloBills? atlantaFalcons;
  BuffaloBills? seattleSeahawks;
  BuffaloBills? minnesotaVikings;
  BuffaloBills? detroitLions;
  BuffaloBills? arizonaCardinals;
  BuffaloBills? chicagoBears;

  Stats({
    this.buffaloBills,
    this.miamiDolphins,
    this.newEnglandPatriots,
    this.newYorkJets,
    this.cincinnatiBengals,
    this.baltimoreRavens,
    this.pittsburghSteelers,
    this.clevelandBrowns,
    this.jacksonvilleJaguars,
    this.tennesseeTitans,
    this.indianapolisColts,
    this.houstonTexans,
    this.kansasCityChiefs,
    this.losAngelesChargers,
    this.lasVegasRaiders,
    this.denverBroncos,
    this.sanFrancisco49ers,
    this.dallasCowboys,
    this.washingtonCommanders,
    this.philadelphiaEagles,
    this.newOrleansSaints,
    this.tampaBayBuccaneers,
    this.greenBayPackers,
    this.newYorkGiants,
    this.carolinaPanthers,
    this.losAngelesRams,
    this.atlantaFalcons,
    this.seattleSeahawks,
    this.minnesotaVikings,
    this.detroitLions,
    this.arizonaCardinals,
    this.chicagoBears,
  });

  Stats.fromJson(Map<String, dynamic> json) {
    buffaloBills = json['Buffalo Bills'] != null
        ? BuffaloBills.fromJson(json['Buffalo Bills'])
        : null;
    miamiDolphins = json['Miami Dolphins'] != null
        ? BuffaloBills.fromJson(json['Miami Dolphins'])
        : null;
    newEnglandPatriots = json['New England Patriots'] != null
        ? BuffaloBills.fromJson(json['New England Patriots'])
        : null;
    newYorkJets = json['New York Jets'] != null
        ? BuffaloBills.fromJson(json['New York Jets'])
        : null;
    cincinnatiBengals = json['Cincinnati Bengals'] != null
        ? BuffaloBills.fromJson(json['Cincinnati Bengals'])
        : null;
    baltimoreRavens = json['Baltimore Ravens'] != null
        ? BuffaloBills.fromJson(json['Baltimore Ravens'])
        : null;
    pittsburghSteelers = json['Pittsburgh Steelers'] != null
        ? BuffaloBills.fromJson(json['Pittsburgh Steelers'])
        : null;
    clevelandBrowns = json['Cleveland Browns'] != null
        ? BuffaloBills.fromJson(json['Cleveland Browns'])
        : null;
    jacksonvilleJaguars = json['Jacksonville Jaguars'] != null
        ? BuffaloBills.fromJson(json['Jacksonville Jaguars'])
        : null;
    tennesseeTitans = json['Tennessee Titans'] != null
        ? BuffaloBills.fromJson(json['Tennessee Titans'])
        : null;
    indianapolisColts = json['Indianapolis Colts'] != null
        ? BuffaloBills.fromJson(json['Indianapolis Colts'])
        : null;
    houstonTexans = json['Houston Texans'] != null
        ? BuffaloBills.fromJson(json['Houston Texans'])
        : null;
    kansasCityChiefs = json['Kansas City Chiefs'] != null
        ? BuffaloBills.fromJson(json['Kansas City Chiefs'])
        : null;
    losAngelesChargers = json['Los Angeles Chargers'] != null
        ? BuffaloBills.fromJson(json['Los Angeles Chargers'])
        : null;
    lasVegasRaiders = json['Las Vegas Raiders'] != null
        ? BuffaloBills.fromJson(json['Las Vegas Raiders'])
        : null;
    denverBroncos = json['Denver Broncos'] != null
        ? BuffaloBills.fromJson(json['Denver Broncos'])
        : null;
    sanFrancisco49ers = json['San Francisco 49ers'] != null
        ? BuffaloBills.fromJson(json['San Francisco 49ers'])
        : null;
    dallasCowboys = json['Dallas Cowboys'] != null
        ? BuffaloBills.fromJson(json['Dallas Cowboys'])
        : null;
    washingtonCommanders = json['Washington Commanders'] != null
        ? BuffaloBills.fromJson(json['Washington Commanders'])
        : null;
    philadelphiaEagles = json['Philadelphia Eagles'] != null
        ? BuffaloBills.fromJson(json['Philadelphia Eagles'])
        : null;
    newOrleansSaints = json['New Orleans Saints'] != null
        ? BuffaloBills.fromJson(json['New Orleans Saints'])
        : null;
    tampaBayBuccaneers = json['Tampa Bay Buccaneers'] != null
        ? BuffaloBills.fromJson(json['Tampa Bay Buccaneers'])
        : null;
    greenBayPackers = json['Green Bay Packers'] != null
        ? BuffaloBills.fromJson(json['Green Bay Packers'])
        : null;
    newYorkGiants = json['New York Giants'] != null
        ? BuffaloBills.fromJson(json['New York Giants'])
        : null;
    carolinaPanthers = json['Carolina Panthers'] != null
        ? BuffaloBills.fromJson(json['Carolina Panthers'])
        : null;
    losAngelesRams = json['Los Angeles Rams'] != null
        ? BuffaloBills.fromJson(json['Los Angeles Rams'])
        : null;
    atlantaFalcons = json['Atlanta Falcons'] != null
        ? BuffaloBills.fromJson(json['Atlanta Falcons'])
        : null;
    seattleSeahawks = json['Seattle Seahawks'] != null
        ? BuffaloBills.fromJson(json['Seattle Seahawks'])
        : null;
    minnesotaVikings = json['Minnesota Vikings'] != null
        ? BuffaloBills.fromJson(json['Minnesota Vikings'])
        : null;
    detroitLions = json['Detroit Lions'] != null
        ? BuffaloBills.fromJson(json['Detroit Lions'])
        : null;
    arizonaCardinals = json['Arizona Cardinals'] != null
        ? BuffaloBills.fromJson(json['Arizona Cardinals'])
        : null;
    chicagoBears = json['Chicago Bears'] != null
        ? BuffaloBills.fromJson(json['Chicago Bears'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (buffaloBills != null) {
      data['Buffalo Bills'] = buffaloBills!.toJson();
    }
    if (miamiDolphins != null) {
      data['Miami Dolphins'] = miamiDolphins!.toJson();
    }
    if (newEnglandPatriots != null) {
      data['New England Patriots'] = newEnglandPatriots!.toJson();
    }
    if (newYorkJets != null) {
      data['New York Jets'] = newYorkJets!.toJson();
    }
    if (cincinnatiBengals != null) {
      data['Cincinnati Bengals'] = cincinnatiBengals!.toJson();
    }
    if (baltimoreRavens != null) {
      data['Baltimore Ravens'] = baltimoreRavens!.toJson();
    }
    if (pittsburghSteelers != null) {
      data['Pittsburgh Steelers'] = pittsburghSteelers!.toJson();
    }
    if (clevelandBrowns != null) {
      data['Cleveland Browns'] = clevelandBrowns!.toJson();
    }
    if (jacksonvilleJaguars != null) {
      data['Jacksonville Jaguars'] = jacksonvilleJaguars!.toJson();
    }
    if (tennesseeTitans != null) {
      data['Tennessee Titans'] = tennesseeTitans!.toJson();
    }
    if (indianapolisColts != null) {
      data['Indianapolis Colts'] = indianapolisColts!.toJson();
    }
    if (houstonTexans != null) {
      data['Houston Texans'] = houstonTexans!.toJson();
    }
    if (kansasCityChiefs != null) {
      data['Kansas City Chiefs'] = kansasCityChiefs!.toJson();
    }
    if (losAngelesChargers != null) {
      data['Los Angeles Chargers'] = losAngelesChargers!.toJson();
    }
    if (lasVegasRaiders != null) {
      data['Las Vegas Raiders'] = lasVegasRaiders!.toJson();
    }
    if (denverBroncos != null) {
      data['Denver Broncos'] = denverBroncos!.toJson();
    }
    if (sanFrancisco49ers != null) {
      data['San Francisco 49ers'] = sanFrancisco49ers!.toJson();
    }
    if (dallasCowboys != null) {
      data['Dallas Cowboys'] = dallasCowboys!.toJson();
    }
    if (washingtonCommanders != null) {
      data['Washington Commanders'] = washingtonCommanders!.toJson();
    }
    if (philadelphiaEagles != null) {
      data['Philadelphia Eagles'] = philadelphiaEagles!.toJson();
    }
    if (newOrleansSaints != null) {
      data['New Orleans Saints'] = newOrleansSaints!.toJson();
    }
    if (tampaBayBuccaneers != null) {
      data['Tampa Bay Buccaneers'] = tampaBayBuccaneers!.toJson();
    }
    if (greenBayPackers != null) {
      data['Green Bay Packers'] = greenBayPackers!.toJson();
    }
    if (newYorkGiants != null) {
      data['New York Giants'] = newYorkGiants!.toJson();
    }
    if (carolinaPanthers != null) {
      data['Carolina Panthers'] = carolinaPanthers!.toJson();
    }
    if (losAngelesRams != null) {
      data['Los Angeles Rams'] = losAngelesRams!.toJson();
    }
    if (atlantaFalcons != null) {
      data['Atlanta Falcons'] = atlantaFalcons!.toJson();
    }
    if (seattleSeahawks != null) {
      data['Seattle Seahawks'] = seattleSeahawks!.toJson();
    }
    if (minnesotaVikings != null) {
      data['Minnesota Vikings'] = minnesotaVikings!.toJson();
    }
    if (detroitLions != null) {
      data['Detroit Lions'] = detroitLions!.toJson();
    }
    if (arizonaCardinals != null) {
      data['Arizona Cardinals'] = arizonaCardinals!.toJson();
    }
    if (chicagoBears != null) {
      data['Chicago Bears'] = chicagoBears!.toJson();
    }

    return data;
  }
}

class BuffaloBills {
  Defense? defensePerGame;
  Offense? offensePerGame;

  BuffaloBills({
    this.defensePerGame,
    this.offensePerGame,
  });

  BuffaloBills.fromJson(Map<String, dynamic> json) {
    defensePerGame = json['Defense Per Game'] != null
        ? Defense.fromJson(json['Defense Per Game'])
        : null;
    offensePerGame = json['Offense Per Game'] != null
        ? Offense.fromJson(json['Offense Per Game'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (defensePerGame != null) {
      data['Defense Per Game'] = defensePerGame!.toJson();
    }
    if (offensePerGame != null) {
      data['Offense Per Game'] = offensePerGame!.toJson();
    }

    return data;
  }
}

class Defense {
  String? tm;
  String? g;
  String? pA;
  String? yds;
  TotYdsTO? totYdsTO;
  String? fL;
  String? s1stD;
  Passing? passing;
  Rushing? rushing;
  String? sc;
  String? tO;
  String? eXP;

  Defense(
      {this.tm,
      this.g,
      this.pA,
      this.yds,
      this.totYdsTO,
      this.fL,
      this.s1stD,
      this.passing,
      this.rushing,
      this.sc,
      this.tO,
      this.eXP});

  Defense.fromJson(Map<String, dynamic> json) {
    tm = json['Tm'];
    g = json['G'];
    pA = json['PA'];
    yds = json['Yds'];
    totYdsTO = json['Tot Yds & TO'] != null
        ? TotYdsTO.fromJson(json['Tot Yds & TO'])
        : null;
    fL = json['FL'];
    s1stD = json['1stD'];
    passing =
        json['Passing'] != null ? Passing.fromJson(json['Passing']) : null;
    rushing =
        json['Rushing'] != null ? Rushing.fromJson(json['Rushing']) : null;
    sc = json['Sc%'];
    tO = json['TO%'];
    eXP = json['EXP'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Tm'] = tm;
    data['G'] = g;
    data['PA'] = pA;
    data['Yds'] = yds;
    if (totYdsTO != null) {
      data['Tot Yds & TO'] = totYdsTO!.toJson();
    }
    data['FL'] = fL;
    data['1stD'] = s1stD;
    if (passing != null) {
      data['Passing'] = passing!.toJson();
    }
    if (rushing != null) {
      data['Rushing'] = rushing!.toJson();
    }

    data['Sc%'] = sc;
    data['TO%'] = tO;
    data['EXP'] = eXP;
    return data;
  }
}

class TotYdsTO {
  String? ply;
  String? yP;
  String? tO;

  TotYdsTO({this.ply, this.yP, this.tO});

  TotYdsTO.fromJson(Map<String, dynamic> json) {
    ply = json['Ply'];
    yP = json['Y/P'];
    tO = json['TO'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Ply'] = ply;
    data['Y/P'] = yP;
    data['TO'] = tO;
    return data;
  }
}

class Passing {
  String? cmp;
  String? att;
  String? yds;
  String? tD;
  String? int;
  String? nYA;
  String? s1stD;

  Passing(
      {this.cmp, this.att, this.yds, this.tD, this.int, this.nYA, this.s1stD});

  Passing.fromJson(Map<String, dynamic> json) {
    cmp = json['Cmp'];
    att = json['Att'];
    yds = json['Yds'];
    tD = json['TD'];
    int = json['Int'];
    nYA = json['NY/A'];
    s1stD = json['1stD'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Cmp'] = cmp;
    data['Att'] = att;
    data['Yds'] = yds;
    data['TD'] = tD;
    data['Int'] = int;
    data['NY/A'] = nYA;
    data['1stD'] = s1stD;
    return data;
  }
}

class Rushing {
  String? att;
  String? yds;
  String? tD;
  String? yA;
  String? s1stD;

  Rushing({this.att, this.yds, this.tD, this.yA, this.s1stD});

  Rushing.fromJson(Map<String, dynamic> json) {
    att = json['Att'];
    yds = json['Yds'];
    tD = json['TD'];
    yA = json['Y/A'];
    s1stD = json['1stD'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Att'] = att;
    data['Yds'] = yds;
    data['TD'] = tD;
    data['Y/A'] = yA;
    data['1stD'] = s1stD;
    return data;
  }
}

class Offense {
  String? tm;
  String? g;
  String? pF;
  String? yds;
  TotYdsTO? totYdsTO;
  String? fL;
  String? s1stD;
  Passing? passing;
  Rushing? rushing;
  String? sc;
  String? tO;
  String? eXP;

  Offense(
      {this.tm,
      this.g,
      this.pF,
      this.yds,
      this.totYdsTO,
      this.fL,
      this.s1stD,
      this.passing,
      this.rushing,
      this.sc,
      this.tO,
      this.eXP});

  Offense.fromJson(Map<String, dynamic> json) {
    tm = json['Tm'];
    g = json['G'];
    pF = json['PF'];
    yds = json['Yds'];
    totYdsTO = json['Tot Yds & TO'] != null
        ? TotYdsTO.fromJson(json['Tot Yds & TO'])
        : null;
    fL = json['FL'];
    s1stD = json['1stD'];
    passing =
        json['Passing'] != null ? Passing.fromJson(json['Passing']) : null;
    rushing =
        json['Rushing'] != null ? Rushing.fromJson(json['Rushing']) : null;
    sc = json['Sc%'];
    tO = json['TO%'];
    eXP = json['EXP'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Tm'] = tm;
    data['G'] = g;
    data['PF'] = pF;
    data['Yds'] = yds;
    if (totYdsTO != null) {
      data['Tot Yds & TO'] = totYdsTO!.toJson();
    }
    data['FL'] = fL;
    data['1stD'] = s1stD;
    if (passing != null) {
      data['Passing'] = passing!.toJson();
    }
    if (rushing != null) {
      data['Rushing'] = rushing!.toJson();
    }

    data['Sc%'] = sc;
    data['TO%'] = tO;
    data['EXP'] = eXP;
    return data;
  }
}
