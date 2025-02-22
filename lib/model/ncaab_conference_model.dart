class ConferencesModelNCAAB {
  League? league;
  List<Divisions>? divisions;

  ConferencesModelNCAAB({this.league, this.divisions});

  ConferencesModelNCAAB.fromJson(Map<String, dynamic> json) {
    league =
    json['league'] != null ? League.fromJson(json['league']) : null;
    if (json['divisions'] != null) {
      divisions = <Divisions>[];
      json['divisions'].forEach((v) {
        divisions!.add(Divisions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (league != null) {
      data['league'] = league!.toJson();
    }
    if (divisions != null) {
      data['divisions'] = divisions!.map((v) => v.toJson()).toList();
    }
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

class Divisions {
  String? id;
  String? name;
  String? alias;
  List<Conferences>? conferences;

  Divisions({this.id, this.name, this.alias, this.conferences});

  Divisions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    alias = json['alias'];
    if (json['conferences'] != null) {
      conferences = <Conferences>[];
      json['conferences'].forEach((v) {
        conferences!.add(Conferences.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['alias'] = alias;
    if (conferences != null) {
      data['conferences'] = conferences!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Conferences {
  String? id;
  String? name;
  String? alias;
  List<Teams>? teams;

  Conferences({this.id, this.name, this.alias, this.teams});

  Conferences.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    alias = json['alias'];
    if (json['teams'] != null) {
      teams = <Teams>[];
      json['teams'].forEach((v) {
        teams!.add(Teams.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['alias'] = alias;
    if (teams != null) {
      data['teams'] = teams!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Teams {
  String? id;
  String? name;
  String? market;
  String? alias;
  int? founded;
  List<TeamColors>? teamColors;
  Venue? venue;
  String? subdivision;
  String? mascot;
  String? fightSong;
  int? championshipsWon;
  int? conferenceTitles;
  int? playoffAppearances;
  String? championshipSeasons;
  String? nicknames;
  int? divisionTitles;

  Teams(
      {this.id,
        this.name,
        this.market,
        this.alias,
        this.founded,
        this.teamColors,
        this.venue,
        this.subdivision,
        this.mascot,
        this.fightSong,
        this.championshipsWon,
        this.conferenceTitles,
        this.playoffAppearances,
        this.championshipSeasons,
        this.nicknames,
        this.divisionTitles});

  Teams.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    market = json['market'];
    alias = json['alias'];
    founded = json['founded'];
    if (json['team_colors'] != null) {
      teamColors = <TeamColors>[];
      json['team_colors'].forEach((v) {
        teamColors!.add(TeamColors.fromJson(v));
      });
    }
    venue = json['venue'] != null ? Venue.fromJson(json['venue']) : null;
    subdivision = json['subdivision'];
    mascot = json['mascot'];
    fightSong = json['fight_song'];
    championshipsWon = json['championships_won'];
    conferenceTitles = json['conference_titles'];
    playoffAppearances = json['playoff_appearances'];
    championshipSeasons = json['championship_seasons'];
    nicknames = json['nicknames'];
    divisionTitles = json['division_titles'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['market'] = market;
    data['alias'] = alias;
    data['founded'] = founded;
    if (teamColors != null) {
      data['team_colors'] = teamColors!.map((v) => v.toJson()).toList();
    }
    if (venue != null) {
      data['venue'] = venue!.toJson();
    }
    data['subdivision'] = subdivision;
    data['mascot'] = mascot;
    data['fight_song'] = fightSong;
    data['championships_won'] = championshipsWon;
    data['conference_titles'] = conferenceTitles;
    data['playoff_appearances'] = playoffAppearances;
    data['championship_seasons'] = championshipSeasons;
    data['nicknames'] = nicknames;
    data['division_titles'] = divisionTitles;
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
    rgbColor = json['rgb_color'] != null
        ? RgbColor.fromJson(json['rgb_color'])
        : null;
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
  int? red;
  int? green;
  int? blue;

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

class Venue {
  String? id;
  String? name;
  int? capacity;
  String? address;
  String? city;
  String? state;
  String? zip;
  String? country;
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
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
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
