class NBARosterModel {
  String? id;
  String? name;
  String? market;
  String? alias;
  num? founded;
  String? srId;
  String? reference;
  Venue? venue;
  League? league;
  League? conference;
  League? division;
  List<Coaches>? coaches;
  List<TeamColors>? teamColors;
  List<Players>? players;

  NBARosterModel(
      {this.id,
      this.name,
      this.market,
      this.alias,
      this.founded,
      this.srId,
      this.reference,
      this.venue,
      this.league,
      this.conference,
      this.division,
      this.coaches,
      this.teamColors,
      this.players});

  NBARosterModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    market = json['market'];
    alias = json['alias'];
    founded = json['founded'];
    srId = json['sr_id'];
    reference = json['reference'];
    venue = json['venue'] != null ? Venue.fromJson(json['venue']) : null;
    league = json['league'] != null ? League.fromJson(json['league']) : null;
    conference =
        json['conference'] != null ? League.fromJson(json['conference']) : null;
    division =
        json['division'] != null ? League.fromJson(json['division']) : null;
    if (json['coaches'] != null) {
      coaches = <Coaches>[];
      json['coaches'].forEach((v) {
        coaches!.add(Coaches.fromJson(v));
      });
    }
    if (json['team_colors'] != null) {
      teamColors = <TeamColors>[];
      json['team_colors'].forEach((v) {
        teamColors!.add(TeamColors.fromJson(v));
      });
    }
    if (json['players'] != null) {
      players = <Players>[];
      json['players'].forEach((v) {
        players!.add(Players.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['market'] = market;
    data['alias'] = alias;
    data['founded'] = founded;
    data['sr_id'] = srId;
    data['reference'] = reference;
    if (venue != null) {
      data['venue'] = venue!.toJson();
    }
    if (league != null) {
      data['league'] = league!.toJson();
    }
    if (conference != null) {
      data['conference'] = conference!.toJson();
    }
    if (division != null) {
      data['division'] = division!.toJson();
    }
    if (coaches != null) {
      data['coaches'] = coaches!.map((v) => v.toJson()).toList();
    }
    if (teamColors != null) {
      data['team_colors'] = teamColors!.map((v) => v.toJson()).toList();
    }
    if (players != null) {
      data['players'] = players!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Venue {
  String? id;
  String? name;
  num? capacity;
  String? address;
  String? city;
  String? state;
  String? zip;
  String? country;
  String? srId;
  Location? location;

  Venue(
      {this.id,
      this.name,
      this.capacity,
      this.address,
      this.city,
      this.state,
      this.zip,
      this.country,
      this.srId,
      this.location});

  Venue.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    capacity = json['capacity'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    zip = json['zip'];
    country = json['country'];
    srId = json['sr_id'];
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['capacity'] = capacity;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['zip'] = zip;
    data['country'] = country;
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

class League {
  String? id;
  String? name;
  String? alias;

  League({this.id, this.name, this.alias});

  League.fromJson(Map<String, dynamic> json) {
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

class Coaches {
  String? id;
  String? fullName;
  String? firstName;
  String? lastName;
  String? position;
  String? experience;
  String? reference;

  Coaches(
      {this.id,
      this.fullName,
      this.firstName,
      this.lastName,
      this.position,
      this.experience,
      this.reference});

  Coaches.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    position = json['position'];
    experience = json['experience'];
    reference = json['reference'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = fullName;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['position'] = position;
    data['experience'] = experience;
    data['reference'] = reference;
    return data;
  }
}

class TeamColors {
  String? type;
  String? hexColor;
  RgbColor? rgbColor;

  TeamColors({this.type, this.hexColor, this.rgbColor});

  TeamColors.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    hexColor = json['hex_color'];
    rgbColor =
        json['rgb_color'] != null ? RgbColor.fromJson(json['rgb_color']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['hex_color'] = hexColor;
    if (rgbColor != null) {
      data['rgb_color'] = rgbColor!.toJson();
    }
    return data;
  }
}

class RgbColor {
  num? red;
  num? green;
  num? blue;

  RgbColor({this.red, this.green, this.blue});

  RgbColor.fromJson(Map<String, dynamic> json) {
    red = json['red'];
    green = json['green'];
    blue = json['blue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['red'] = red;
    data['green'] = green;
    data['blue'] = blue;
    return data;
  }
}

class Players {
  String? id;
  String? status;
  String? fullName;
  String? firstName;
  String? lastName;
  String? abbrName;
  num? height;
  num? weight;
  String? position;
  String? primaryPosition;
  String? jerseyNumber;
  String? experience;
  String? college;
  String? highSchool;
  String? birthPlace;
  String? birthdate;
  String? updated;
  String? srId;
  num? rookieYear;
  String? reference;
  Draft? draft;
  String? nameSuffix;
  List<Injuries>? injuries;

  Players(
      {this.id,
      this.status,
      this.fullName,
      this.firstName,
      this.lastName,
      this.abbrName,
      this.height,
      this.weight,
      this.position,
      this.primaryPosition,
      this.jerseyNumber,
      this.experience,
      this.college,
      this.highSchool,
      this.birthPlace,
      this.birthdate,
      this.updated,
      this.srId,
      this.rookieYear,
      this.reference,
      this.draft,
      this.nameSuffix,
      this.injuries});

  Players.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    fullName = json['full_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    abbrName = json['abbr_name'];
    height = json['height'];
    weight = json['weight'];
    position = json['position'];
    primaryPosition = json['primary_position'];
    jerseyNumber = json['jersey_number'];
    experience = json['experience'];
    college = json['college'];
    highSchool = json['high_school'];
    birthPlace = json['birth_place'];
    birthdate = json['birthdate'];
    updated = json['updated'];
    srId = json['sr_id'];
    rookieYear = json['rookie_year'];
    reference = json['reference'];
    draft = json['draft'] != null ? Draft.fromJson(json['draft']) : null;
    nameSuffix = json['name_suffix'];
    if (json['injuries'] != null) {
      injuries = <Injuries>[];
      json['injuries'].forEach((v) {
        injuries!.add(Injuries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['full_name'] = fullName;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['abbr_name'] = abbrName;
    data['height'] = height;
    data['weight'] = weight;
    data['position'] = position;
    data['primary_position'] = primaryPosition;
    data['jersey_number'] = jerseyNumber;
    data['experience'] = experience;
    data['college'] = college;
    data['high_school'] = highSchool;
    data['birth_place'] = birthPlace;
    data['birthdate'] = birthdate;
    data['updated'] = updated;
    data['sr_id'] = srId;
    data['rookie_year'] = rookieYear;
    data['reference'] = reference;
    if (draft != null) {
      data['draft'] = draft!.toJson();
    }
    data['name_suffix'] = nameSuffix;
    if (injuries != null) {
      data['injuries'] = injuries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Draft {
  String? teamId;
  num? year;
  String? round;
  String? pick;

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

class Injuries {
  String? id;
  String? comment;
  String? desc;
  String? status;
  String? startDate;
  String? updateDate;

  Injuries(
      {this.id,
      this.comment,
      this.desc,
      this.status,
      this.startDate,
      this.updateDate});

  Injuries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    desc = json['desc'];
    status = json['status'];
    startDate = json['start_date'];
    updateDate = json['update_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['comment'] = comment;
    data['desc'] = desc;
    data['status'] = status;
    data['start_date'] = startDate;
    data['update_date'] = updateDate;
    return data;
  }
}
