class NFLRushingStatModel {
  Embedded? eEmbedded;

  NFLRushingStatModel({this.eEmbedded});

  NFLRushingStatModel.fromJson(Map<String, dynamic> json) {
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
  List<TeamRushingStatsList>? teamRushingStatsList;

  Embedded({this.teamRushingStatsList});

  Embedded.fromJson(Map<String, dynamic> json) {
    if (json['teamRushingStatsList'] != null) {
      teamRushingStatsList = <TeamRushingStatsList>[];
      json['teamRushingStatsList'].forEach((v) {
        teamRushingStatsList!.add(TeamRushingStatsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (teamRushingStatsList != null) {
      data['teamRushingStatsList'] =
          teamRushingStatsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TeamRushingStatsList {
  String? name;
  int? yards;
  int? touchdowns;

  TeamRushingStatsList({this.name, this.yards, this.touchdowns});

  TeamRushingStatsList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    yards = json['yards'];
    touchdowns = json['touchdowns'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['yards'] = yards;
    data['touchdowns'] = touchdowns;
    return data;
  }
}
