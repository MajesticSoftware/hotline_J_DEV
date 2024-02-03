class GameListingNCAAB {
  String? date;
  League? league;
  List<Games>? games;

  GameListingNCAAB({this.date, this.league, this.games});

  GameListingNCAAB.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    league =
    json['league'] != null ? new League.fromJson(json['league']) : null;
    if (json['games'] != null) {
      games = <Games>[];
      json['games'].forEach((v) {
        games!.add(new Games.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    if (this.league != null) {
      data['league'] = this.league!.toJson();
    }
    if (this.games != null) {
      data['games'] = this.games!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['alias'] = this.alias;
    return data;
  }
}

class Games {
  String? id;
  String? status;
  String? coverage;
  String? scheduled;
  bool? conferenceGame;
  TimeZones? timeZones;
  Venue? venue;
  List<Broadcasts>? broadcasts;
  League? home;
  League? away;
  bool? trackOnCourt;
  bool? neutralSite;

  Games(
      {this.id,
        this.status,
        this.coverage,
        this.scheduled,
        this.conferenceGame,
        this.timeZones,
        this.venue,
        this.broadcasts,
        this.home,
        this.away,
        this.trackOnCourt,
        this.neutralSite});

  Games.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    coverage = json['coverage'];
    scheduled = json['scheduled'];
    conferenceGame = json['conference_game'];
    timeZones = json['time_zones'] != null
        ? new TimeZones.fromJson(json['time_zones'])
        : null;
    venue = json['venue'] != null ? new Venue.fromJson(json['venue']) : null;
    if (json['broadcasts'] != null) {
      broadcasts = <Broadcasts>[];
      json['broadcasts'].forEach((v) {
        broadcasts!.add(new Broadcasts.fromJson(v));
      });
    }
    home = json['home'] != null ? new League.fromJson(json['home']) : null;
    away = json['away'] != null ? new League.fromJson(json['away']) : null;
    trackOnCourt = json['track_on_court'];
    neutralSite = json['neutral_site'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['coverage'] = this.coverage;
    data['scheduled'] = this.scheduled;
    data['conference_game'] = this.conferenceGame;
    if (this.timeZones != null) {
      data['time_zones'] = this.timeZones!.toJson();
    }
    if (this.venue != null) {
      data['venue'] = this.venue!.toJson();
    }
    if (this.broadcasts != null) {
      data['broadcasts'] = this.broadcasts!.map((v) => v.toJson()).toList();
    }
    if (this.home != null) {
      data['home'] = this.home!.toJson();
    }
    if (this.away != null) {
      data['away'] = this.away!.toJson();
    }
    data['track_on_court'] = this.trackOnCourt;
    data['neutral_site'] = this.neutralSite;
    return data;
  }
}

class TimeZones {
  String? venue;
  String? home;
  String? away;

  TimeZones({this.venue, this.home, this.away});

  TimeZones.fromJson(Map<String, dynamic> json) {
    venue = json['venue'];
    home = json['home'];
    away = json['away'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['venue'] = this.venue;
    data['home'] = this.home;
    data['away'] = this.away;
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
        ? new Location.fromJson(json['location'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['capacity'] = this.capacity;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zip'] = this.zip;
    data['country'] = this.country;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class Broadcasts {
  String? network;
  String? type;
  String? locale;
  String? channel;

  Broadcasts({this.network, this.type, this.locale, this.channel});

  Broadcasts.fromJson(Map<String, dynamic> json) {
    network = json['network'];
    type = json['type'];
    locale = json['locale'];
    channel = json['channel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['network'] = this.network;
    data['type'] = this.type;
    data['locale'] = this.locale;
    data['channel'] = this.channel;
    return data;
  }
}
