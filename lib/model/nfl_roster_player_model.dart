class NFLRosterPlayerModel {
  String? id;
  String? name;
  String? market;
  String? alias;
  String? srId;
  num? founded;
  String? owner;
  String? generalManager;
  String? president;
  String? mascot;
  String? fightSong;
  num? championshipsWon;
  String? championshipSeasons;
  num? conferenceTitles;
  num? divisionTitles;
  num? playoffAppearances;
  Franchise? franchise;
  Venue? venue;
  Franchise? division;
  Franchise? conference;
  List<Coaches>? coaches;
  List<Players>? players;
  String? sComment;

  NFLRosterPlayerModel(
      {this.id,
        this.name,
        this.market,
        this.alias,
        this.srId,
        this.founded,
        this.owner,
        this.generalManager,
        this.president,
        this.mascot,
        this.fightSong,
        this.championshipsWon,
        this.championshipSeasons,
        this.conferenceTitles,
        this.divisionTitles,
        this.playoffAppearances,
        this.franchise,
        this.venue,
        this.division,
        this.conference,
        this.coaches,
        this.players,
        this.sComment});

  NFLRosterPlayerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    market = json['market'];
    alias = json['alias'];
    srId = json['sr_id'];
    founded = json['founded'];
    owner = json['owner'];
    generalManager = json['general_manager'];
    president = json['president'];
    mascot = json['mascot'];
    fightSong = json['fight_song'];
    championshipsWon = json['championships_won'];
    championshipSeasons = json['championship_seasons'];
    conferenceTitles = json['conference_titles'];
    divisionTitles = json['division_titles'];
    playoffAppearances = json['playoff_appearances'];
    franchise = json['franchise'] != null
        ? Franchise.fromJson(json['franchise'])
        : null;
    venue = json['venue'] != null ? Venue.fromJson(json['venue']) : null;
    division = json['division'] != null
        ? Franchise.fromJson(json['division'])
        : null;
    conference = json['conference'] != null
        ? Franchise.fromJson(json['conference'])
        : null;
    if (json['coaches'] != null) {
      coaches = <Coaches>[];
      json['coaches'].forEach((v) {
        coaches!.add(Coaches.fromJson(v));
      });
    }
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
    data['id'] = id;
    data['name'] = name;
    data['market'] = market;
    data['alias'] = alias;
    data['sr_id'] = srId;
    data['founded'] = founded;
    data['owner'] = owner;
    data['general_manager'] = generalManager;
    data['president'] = president;
    data['mascot'] = mascot;
    data['fight_song'] = fightSong;
    data['championships_won'] = championshipsWon;
    data['championship_seasons'] = championshipSeasons;
    data['conference_titles'] = conferenceTitles;
    data['division_titles'] = divisionTitles;
    data['playoff_appearances'] = playoffAppearances;
    if (franchise != null) {
      data['franchise'] = franchise!.toJson();
    }
    if (venue != null) {
      data['venue'] = venue!.toJson();
    }
    if (division != null) {
      data['division'] = division!.toJson();
    }
    if (conference != null) {
      data['conference'] = conference!.toJson();
    }
    if (coaches != null) {
      data['coaches'] = coaches!.map((v) => v.toJson()).toList();
    }
    if (players != null) {
      data['players'] = players!.map((v) => v.toJson()).toList();
    }
    data['_comment'] = sComment;
    return data;
  }
}

class Franchise {
  String? id;
  String? name;
  String? alias;

  Franchise({this.id, this.name, this.alias});

  Franchise.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    alias = json['alias'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['alias'] = alias;
    return data;
  }
}

class Venue {
  String? id;
  String? name;
  String? city;
  String? state;
  String? country;
  String? zip;
  String? address;
  num? capacity;
  String? surface;
  String? roofType;
  String? srId;
  Location? location;

  Venue(
      {this.id,
        this.name,
        this.city,
        this.state,
        this.country,
        this.zip,
        this.address,
        this.capacity,
        this.surface,
        this.roofType,
        this.srId,
        this.location});

  Venue.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    zip = json['zip'];
    address = json['address'];
    capacity = json['capacity'];
    surface = json['surface'];
    roofType = json['roof_type'];
    srId = json['sr_id'];
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['zip'] = zip;
    data['address'] = address;
    data['capacity'] = capacity;
    data['surface'] = surface;
    data['roof_type'] = roofType;
    data['sr_id'] = srId;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    return data;
  }
}

class Location {
  String? lat;
  String? lng;

  Location({this.lat, this.lng});

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}

class Coaches {
  String? id;
  String? fullName;
  String? firstName;
  String? lastName;
  String? position;

  Coaches(
      {this.id, this.fullName, this.firstName, this.lastName, this.position});

  Coaches.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = fullName;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['position'] = position;
    return data;
  }
}

class Players {
  String? id;
  String? name;
  String? jersey;
  String? lastName;
  String? firstName;
  String? abbrName;
  String? birthDate;
  num? weight;
  num? height;
  String? position;
  String? birthPlace;
  String? highSchool;
  String? college;
  String? collegeConf;
  num? rookieYear;
  String? status;
  String? srId;
  num? experience;
  Draft? draft;
  String? preferredName;
  Rushing? rushing;
  String? nameSuffix;
  Receiving? receiving;
  Fumbles? fumbles;


  Players(
      {this.id,
        this.name,
        this.jersey,
        this.lastName,
        this.firstName,
        this.abbrName,
        this.birthDate,
        this.weight,
        this.height,
        this.position,
        this.birthPlace,
        this.highSchool,
        this.college,
        this.collegeConf,
        this.rookieYear,
        this.rushing,
        this.status,
        this.srId,
        this.experience,
        this.receiving,
        this.draft,
        this.fumbles,
        this.preferredName,
        this.nameSuffix});

  Players.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    jersey = json['jersey'];
    lastName = json['last_name'];
    firstName = json['first_name'];
    abbrName = json['abbr_name'];
    birthDate = json['birth_date'];
    weight = json['weight'];
    height = json['height'];
    receiving = json['receiving'] != null
        ? Receiving.fromJson(json['receiving'])
        : null;
    fumbles = json['fumbles'] != null ? Fumbles.fromJson(json['fumbles']) : null;
    position = json['position'];
    birthPlace = json['birth_place'];
    highSchool = json['high_school'];
    college = json['college'];
    collegeConf = json['college_conf'];
    rookieYear = json['rookie_year'];
    status = json['status'];
    srId = json['sr_id'];
    rushing =
    json['rushing'] != null ? Rushing.fromJson(json['rushing']) : null;
    experience = json['experience'];
    draft = json['draft'] != null ? Draft.fromJson(json['draft']) : null;
    preferredName = json['preferred_name'];
    nameSuffix = json['name_suffix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['jersey'] = jersey;
    data['last_name'] = lastName;
    data['first_name'] = firstName;
    data['abbr_name'] = abbrName;
    if (receiving != null) {
      data['receiving'] = receiving!.toJson();
    }
    if (rushing != null) {
      data['rushing'] = rushing!.toJson();
    }
    if(fumbles != null){
      data['fumbles'] = fumbles!.toJson();
    }
    data['birth_date'] = birthDate;
    data['weight'] = weight;
    data['height'] = height;
    data['position'] = position;
    data['birth_place'] = birthPlace;
    data['high_school'] = highSchool;
    data['college'] = college;
    data['college_conf'] = collegeConf;
    data['rookie_year'] = rookieYear;
    data['status'] = status;
    data['sr_id'] = srId;
    data['experience'] = experience;
    if (draft != null) {
      data['draft'] = draft!.toJson();
    }
    data['preferred_name'] = preferredName;
    data['name_suffix'] = nameSuffix;
    return data;
  }
}

class Draft {
  num? year;
  num? round;
  num? number;
  Team? team;

  Draft({this.year, this.round, this.number, this.team});

  Draft.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    round = json['round'];
    number = json['number'];
    team = json['team'] != null ? Team.fromJson(json['team']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['year'] = year;
    data['round'] = round;
    data['number'] = number;
    if (team != null) {
      data['team'] = team!.toJson();
    }
    return data;
  }
}

class Team {
  String? id;
  String? name;
  String? market;
  String? alias;
  String? srId;

  Team({this.id, this.name, this.market, this.alias, this.srId});

  Team.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    market = json['market'];
    alias = json['alias'];
    srId = json['sr_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['market'] = market;
    data['alias'] = alias;
    data['sr_id'] = srId;
    return data;
  }
}

class Receiving {
  num? targets;
  num? receptions;
  num? avgYards;
  num? yards;
  num? touchdowns;
  num? yardsAfterCatch;
  num? longest;
  num? longestTouchdown;
  num? redzoneTargets;
  num? airYards;
  num? brokenTackles;
  num? droppedPasses;
  num? catchablePasses;
  num? yardsAfterContact;

  Receiving(
      {this.targets,
        this.receptions,
        this.avgYards,
        this.yards,
        this.touchdowns,
        this.yardsAfterCatch,
        this.longest,
        this.longestTouchdown,
        this.redzoneTargets,
        this.airYards,
        this.brokenTackles,
        this.droppedPasses,
        this.catchablePasses,
        this.yardsAfterContact});

  Receiving.fromJson(Map<String, dynamic> json) {
    targets = json['targets'];
    receptions = json['receptions'];
    avgYards = json['avg_yards'];
    yards = json['yards'];
    touchdowns = json['touchdowns'];
    yardsAfterCatch = json['yards_after_catch'];
    longest = json['longest'];
    longestTouchdown = json['longest_touchdown'];
    redzoneTargets = json['redzone_targets'];
    airYards = json['air_yards'];
    brokenTackles = json['broken_tackles'];
    droppedPasses = json['dropped_passes'];
    catchablePasses = json['catchable_passes'];
    yardsAfterContact = json['yards_after_contact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['targets'] = targets;
    data['receptions'] = receptions;
    data['avg_yards'] = avgYards;
    data['yards'] = yards;
    data['touchdowns'] = touchdowns;
    data['yards_after_catch'] = yardsAfterCatch;
    data['longest'] = longest;
    data['longest_touchdown'] = longestTouchdown;
    data['redzone_targets'] = redzoneTargets;
    data['air_yards'] = airYards;
    data['broken_tackles'] = brokenTackles;
    data['dropped_passes'] = droppedPasses;
    data['catchable_passes'] = catchablePasses;
    data['yards_after_contact'] = yardsAfterContact;
    return data;
  }
}
class Rushing {
  num? avgYards;
  num? attempts;
  num? touchdowns;
  num? tlost;
  num? tlostYards;
  num? yards;
  num? longest;
  num? longestTouchdown;
  num? redzoneAttempts;
  num? brokenTackles;
  num? kneelDowns;
  num? scrambles;
  num? yardsAfterContact;

  Rushing(
      {this.avgYards,
        this.attempts,
        this.touchdowns,
        this.tlost,
        this.tlostYards,
        this.yards,
        this.longest,
        this.longestTouchdown,
        this.redzoneAttempts,
        this.brokenTackles,
        this.kneelDowns,
        this.scrambles,
        this.yardsAfterContact});

  Rushing.fromJson(Map<String, dynamic> json) {
    avgYards = json['avg_yards'];
    attempts = json['attempts'];
    touchdowns = json['touchdowns'];
    tlost = json['tlost'];
    tlostYards = json['tlost_yards'];
    yards = json['yards'];
    longest = json['longest'];
    longestTouchdown = json['longest_touchdown'];
    redzoneAttempts = json['redzone_attempts'];
    brokenTackles = json['broken_tackles'];
    kneelDowns = json['kneel_downs'];
    scrambles = json['scrambles'];
    yardsAfterContact = json['yards_after_contact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['avg_yards'] = avgYards;
    data['attempts'] = attempts;
    data['touchdowns'] = touchdowns;
    data['tlost'] = tlost;
    data['tlost_yards'] = tlostYards;
    data['yards'] = yards;
    data['longest'] = longest;
    data['longest_touchdown'] = longestTouchdown;
    data['redzone_attempts'] = redzoneAttempts;
    data['broken_tackles'] = brokenTackles;
    data['kneel_downs'] = kneelDowns;
    data['scrambles'] = scrambles;
    data['yards_after_contact'] = yardsAfterContact;
    return data;
  }
}
class Fumbles {
  num? fumbles;
  num? lostFumbles;
  num? ownRec;
  num? ownRecYards;
  num? oppRec;
  num? oppRecYards;
  num? outOfBounds;
  num? forcedFumbles;
  num? ownRecTds;
  num? oppRecTds;
  num? ezRecTds;

  Fumbles(
      {this.fumbles,
        this.lostFumbles,
        this.ownRec,
        this.ownRecYards,
        this.oppRec,
        this.oppRecYards,
        this.outOfBounds,
        this.forcedFumbles,
        this.ownRecTds,
        this.oppRecTds,
        this.ezRecTds});

  Fumbles.fromJson(Map<String, dynamic> json) {
    fumbles = json['fumbles'];
    lostFumbles = json['lost_fumbles'];
    ownRec = json['own_rec'];
    ownRecYards = json['own_rec_yards'];
    oppRec = json['opp_rec'];
    oppRecYards = json['opp_rec_yards'];
    outOfBounds = json['out_of_bounds'];
    forcedFumbles = json['forced_fumbles'];
    ownRecTds = json['own_rec_tds'];
    oppRecTds = json['opp_rec_tds'];
    ezRecTds = json['ez_rec_tds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fumbles'] = fumbles;
    data['lost_fumbles'] = lostFumbles;
    data['own_rec'] = ownRec;
    data['own_rec_yards'] = ownRecYards;
    data['opp_rec'] = oppRec;
    data['opp_rec_yards'] = oppRecYards;
    data['out_of_bounds'] = outOfBounds;
    data['forced_fumbles'] = forcedFumbles;
    data['own_rec_tds'] = ownRecTds;
    data['opp_rec_tds'] = oppRecTds;
    data['ez_rec_tds'] = ezRecTds;
    return data;
  }
}