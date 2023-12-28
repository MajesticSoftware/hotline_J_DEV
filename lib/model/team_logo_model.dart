class TeamLogoModel {
  List<Sports>? sports;

  TeamLogoModel({this.sports});

  TeamLogoModel.fromJson(Map<String, dynamic> json) {
    if (json['sports'] != null) {
      sports = <Sports>[];
      json['sports'].forEach((v) {
        sports!.add(Sports.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sports != null) {
      data['sports'] = sports!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sports {
  String? id;
  String? uid;
  String? name;
  String? slug;
  List<Leagues>? leagues;

  Sports({this.id, this.uid, this.name, this.slug, this.leagues});

  Sports.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    name = json['name'];
    slug = json['slug'];
    if (json['leagues'] != null) {
      leagues = <Leagues>[];
      json['leagues'].forEach((v) {
        leagues!.add(Leagues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uid'] = uid;
    data['name'] = name;
    data['slug'] = slug;
    if (leagues != null) {
      data['leagues'] = leagues!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Leagues {
  String? id;
  String? uid;
  String? name;
  String? abbreviation;
  String? shortName;
  String? slug;
  List<Teams>? teams;
  int? year;
  Season? season;

  Leagues(
      {this.id,
        this.uid,
        this.name,
        this.abbreviation,
        this.shortName,
        this.slug,
        this.teams,
        this.year,
        this.season});

  Leagues.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    name = json['name'];
    abbreviation = json['abbreviation'];
    shortName = json['shortName'];
    slug = json['slug'];
    if (json['teams'] != null) {
      teams = <Teams>[];
      json['teams'].forEach((v) {
        teams!.add(Teams.fromJson(v));
      });
    }
    year = json['year'];
    season =
    json['season'] != null ? Season.fromJson(json['season']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uid'] = uid;
    data['name'] = name;
    data['abbreviation'] = abbreviation;
    data['shortName'] = shortName;
    data['slug'] = slug;
    if (teams != null) {
      data['teams'] = teams!.map((v) => v.toJson()).toList();
    }
    data['year'] = year;
    if (season != null) {
      data['season'] = season!.toJson();
    }
    return data;
  }
}

class Teams {
  Team? team;

  Teams({this.team});

  Teams.fromJson(Map<String, dynamic> json) {
    team = json['team'] != null ? Team.fromJson(json['team']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (team != null) {
      data['team'] = team!.toJson();
    }
    return data;
  }
}

class Team {
  String? id;
  String? uid;
  String? slug;
  String? abbreviation;
  String? displayName;
  String? shortDisplayName;
  String? name;
  String? nickname;
  String? location;
  String? color;
  String? alternateColor;
  bool? isActive;
  bool? isAllStar;
  List<Logos>? logos;
  List<Links>? links;

  Team(
      {this.id,
        this.uid,
        this.slug,
        this.abbreviation,
        this.displayName,
        this.shortDisplayName,
        this.name,
        this.nickname,
        this.location,
        this.color,
        this.alternateColor,
        this.isActive,
        this.isAllStar,
        this.logos,
        this.links});

  Team.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    slug = json['slug'];
    abbreviation = json['abbreviation'];
    displayName = json['displayName'];
    shortDisplayName = json['shortDisplayName'];
    name = json['name'];
    nickname = json['nickname'];
    location = json['location'];
    color = json['color'];
    alternateColor = json['alternateColor'];
    isActive = json['isActive'];
    isAllStar = json['isAllStar'];
    if (json['logos'] != null) {
      logos = <Logos>[];
      json['logos'].forEach((v) {
        logos!.add(Logos.fromJson(v));
      });
    }
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uid'] = uid;
    data['slug'] = slug;
    data['abbreviation'] = abbreviation;
    data['displayName'] = displayName;
    data['shortDisplayName'] = shortDisplayName;
    data['name'] = name;
    data['nickname'] = nickname;
    data['location'] = location;
    data['color'] = color;
    data['alternateColor'] = alternateColor;
    data['isActive'] = isActive;
    data['isAllStar'] = isAllStar;
    if (logos != null) {
      data['logos'] = logos!.map((v) => v.toJson()).toList();
    }
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Logos {
  String? href;
  String? alt;
  List<String>? rel;
  int? width;
  int? height;

  Logos({this.href, this.alt, this.rel, this.width, this.height});

  Logos.fromJson(Map<String, dynamic> json) {
    href = json['href'];
    alt = json['alt'];
    rel = json['rel'].cast<String>();
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['href'] = href;
    data['alt'] = alt;
    data['rel'] = rel;
    data['width'] = width;
    data['height'] = height;
    return data;
  }
}

class Links {
  String? language;
  List<String>? rel;
  String? href;
  String? text;
  String? shortText;
  bool? isExternal;
  bool? isPremium;
  bool? isHidden;

  Links(
      {this.language,
        this.rel,
        this.href,
        this.text,
        this.shortText,
        this.isExternal,
        this.isPremium,
        this.isHidden});

  Links.fromJson(Map<String, dynamic> json) {
    language = json['language'];
    rel = json['rel'].cast<String>();
    href = json['href'];
    text = json['text'];
    shortText = json['shortText'];
    isExternal = json['isExternal'];
    isPremium = json['isPremium'];
    isHidden = json['isHidden'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['language'] = language;
    data['rel'] = rel;
    data['href'] = href;
    data['text'] = text;
    data['shortText'] = shortText;
    data['isExternal'] = isExternal;
    data['isPremium'] = isPremium;
    data['isHidden'] = isHidden;
    return data;
  }
}

class Season {
  int? year;
  String? displayName;

  Season({this.year, this.displayName});

  Season.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    displayName = json['displayName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['year'] = year;
    data['displayName'] = displayName;
    return data;
  }
}
