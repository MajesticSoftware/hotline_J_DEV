class NFLPassingStatModel {
  Embedded? eEmbedded;

  NFLPassingStatModel({
    this.eEmbedded,
  });

  NFLPassingStatModel.fromJson(Map<String, dynamic> json) {
    eEmbedded =
        json['_embedded'] != null ? Embedded.fromJson(json['_embedded']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (eEmbedded != null) {
      data['_embedded'] = eEmbedded!.toJson();
    }

    return data;
  }
}

class Embedded {
  List<TeamPassingStatsList>? teamPassingStatsList;

  Embedded({this.teamPassingStatsList});

  Embedded.fromJson(Map<String, dynamic> json) {
    if (json['teamPassingStatsList'] != null) {
      teamPassingStatsList = <TeamPassingStatsList>[];
      json['teamPassingStatsList'].forEach((v) {
        teamPassingStatsList!.add(TeamPassingStatsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (teamPassingStatsList != null) {
      data['teamPassingStatsList'] =
          teamPassingStatsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TeamPassingStatsList {
  String? name;
  int? passYards;
  int? completions;
  int? touchdowns;

  TeamPassingStatsList({
    this.name,
    this.passYards,
    this.completions,
    this.touchdowns,
  });

  TeamPassingStatsList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    passYards = json['passYards'];
    completions = json['completions'];
    touchdowns = json['touchdowns'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['passYards'] = passYards;
    data['completions'] = completions;
    data['touchdowns'] = touchdowns;

    return data;
  }
}
