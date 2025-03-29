class MLBTeamsResponse {
  String? generatedAt;
  League? league;
  List<MLBTeam>? teams;

  MLBTeamsResponse({this.generatedAt, this.league, this.teams});

  MLBTeamsResponse.fromJson(Map<String, dynamic> json) {
    generatedAt = json['generated_at'];
    league = json['league'] != null ? League.fromJson(json['league']) : null;
    if (json['teams'] != null) {
      teams = <MLBTeam>[];
      json['teams'].forEach((v) {
        teams!.add(MLBTeam.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['generated_at'] = generatedAt;
    if (league != null) {
      data['league'] = league!.toJson();
    }
    if (teams != null) {
      data['teams'] = teams!.map((v) => v.toJson()).toList();
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

class MLBTeam {
  String? id;
  String? name;
  String? market;
  String? abbr;
  String? logoUrl; // This will be added from another API source

  MLBTeam({this.id, this.name, this.market, this.abbr, this.logoUrl});

  MLBTeam.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    market = json['market'];
    abbr = json['abbr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['market'] = market;
    data['abbr'] = abbr;
    data['logo_url'] = logoUrl;
    return data;
  }
}