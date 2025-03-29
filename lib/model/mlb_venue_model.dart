class MLBVenuesResponse {
  String? generatedAt;
  League? league;
  List<MLBVenue>? venues;

  MLBVenuesResponse({this.generatedAt, this.league, this.venues});

  MLBVenuesResponse.fromJson(Map<String, dynamic> json) {
    generatedAt = json['generated_at'];
    league = json['league'] != null ? League.fromJson(json['league']) : null;
    if (json['venues'] != null) {
      venues = <MLBVenue>[];
      json['venues'].forEach((v) {
        venues!.add(MLBVenue.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['generated_at'] = generatedAt;
    if (league != null) {
      data['league'] = league!.toJson();
    }
    if (venues != null) {
      data['venues'] = venues!.map((v) => v.toJson()).toList();
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

class MLBVenue {
  String? id;
  String? name;
  String? market;
  String? address;
  String? city;
  String? state;
  String? zip;
  String? country;
  dynamic capacity; // Can be either String or int depending on API response
  String? surface;
  String? fieldOrientation;
  String? stadiumType;
  Location? location;
  Distances? distances;
  String? timeZone;

  MLBVenue({
    this.id,
    this.name,
    this.market,
    this.address,
    this.city,
    this.state,
    this.zip,
    this.country,
    this.capacity,
    this.surface,
    this.fieldOrientation,
    this.stadiumType,
    this.location,
    this.distances,
    this.timeZone,
  });

  MLBVenue.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    market = json['market'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    zip = json['zip'];
    country = json['country'];
    capacity = json['capacity'];
    surface = json['surface'];
    fieldOrientation = json['field_orientation'];
    stadiumType = json['stadium_type'];
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
    distances = json['distances'] != null ? Distances.fromJson(json['distances']) : null;
    timeZone = json['time_zone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['market'] = market;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['zip'] = zip;
    data['country'] = country;
    data['capacity'] = capacity;
    data['surface'] = surface;
    data['field_orientation'] = fieldOrientation;
    data['stadium_type'] = stadiumType;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    if (distances != null) {
      data['distances'] = distances!.toJson();
    }
    data['time_zone'] = timeZone;
    return data;
  }
}

class Location {
  double? lat;
  double? lng;

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

class Distances {
  int? lf;
  int? mlf;
  int? lcf;
  int? cf;
  int? rcf;
  int? mrf;
  int? rf;

  Distances({
    this.lf,
    this.mlf,
    this.lcf,
    this.cf,
    this.rcf,
    this.mrf,
    this.rf,
  });

  Distances.fromJson(Map<String, dynamic> json) {
    lf = json['lf'];
    mlf = json['mlf'];
    lcf = json['lcf'];
    cf = json['cf'];
    rcf = json['rcf'];
    mrf = json['mrf'];
    rf = json['rf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lf'] = lf;
    data['mlf'] = mlf;
    data['lcf'] = lcf;
    data['cf'] = cf;
    data['rcf'] = rcf;
    data['mrf'] = mrf;
    data['rf'] = rf;
    return data;
  }
}