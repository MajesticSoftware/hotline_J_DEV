class NFLWinLossesModel {
  Embedded? eEmbedded;

  NFLWinLossesModel({
    this.eEmbedded,
  });

  NFLWinLossesModel.fromJson(Map<String, dynamic> json) {
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
  List<TeamWinStatsList>? teamWinStatsList;

  Embedded({this.teamWinStatsList});

  Embedded.fromJson(Map<String, dynamic> json) {
    if (json['teamWinStatsList'] != null) {
      teamWinStatsList = <TeamWinStatsList>[];
      json['teamWinStatsList'].forEach((v) {
        teamWinStatsList!.add(TeamWinStatsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (teamWinStatsList != null) {
      data['teamWinStatsList'] =
          teamWinStatsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TeamWinStatsList {
  String? name;
  int? wins;
  int? losses;
  double? winRatePercentage;

  TeamWinStatsList({this.name, this.wins, this.losses, this.winRatePercentage});

  TeamWinStatsList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    wins = json['wins'];
    losses = json['losses'];
    winRatePercentage = json['winRatePercentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['wins'] = wins;
    data['losses'] = losses;
    data['winRatePercentage'] = winRatePercentage;

    return data;
  }
}
