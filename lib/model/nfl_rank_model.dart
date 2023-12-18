class NFLGameRankModel {
  List<NFLGameRank>? data;
  String? msg;
  bool? status;

  NFLGameRankModel({this.data, this.msg, this.status});

  NFLGameRankModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <NFLGameRank>[];
      json['data'].forEach((v) {
        data!.add(NFLGameRank.fromJson(v));
      });
    }
    msg = json['msg'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['msg'] = msg;
    data['status'] = status;
    return data;
  }
}

class NFLGameRank {
  num? id;
  String? teamId;
  String? teamName;
  num? pointsOffense;
  num? pointsDefense;
  num? rushingOffense;
  num? rushingDefense;
  num? pointOffenceRank;
  num? pointsDefenseRank;
  num? rushingOffenseRank;
  num? rushingDefenseRank;

  NFLGameRank(
      {this.id,
        this.teamId,
        this.teamName,
        this.pointsOffense,
        this.pointsDefense,
        this.rushingOffense,
        this.rushingDefense,
        this.pointOffenceRank,
        this.pointsDefenseRank,
        this.rushingOffenseRank,
        this.rushingDefenseRank});

  NFLGameRank.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teamId = json['team_id'];
    teamName = json['team_name'];
    pointsOffense = json['points_offense'];
    pointsDefense = json['points_defense'];
    rushingOffense = json['rushing_offense'];
    rushingDefense = json['rushing_defense'];
    pointOffenceRank = json['point_offence_rank'];
    pointsDefenseRank = json['points_defense_rank'];
    rushingOffenseRank = json['rushing_offense_rank'];
    rushingDefenseRank = json['rushing_defense_rank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['team_id'] = teamId;
    data['team_name'] = teamName;
    data['points_offense'] = pointsOffense;
    data['points_defense'] = pointsDefense;
    data['rushing_offense'] = rushingOffense;
    data['rushing_defense'] = rushingDefense;
    data['point_offence_rank'] = pointOffenceRank;
    data['points_defense_rank'] = pointsDefenseRank;
    data['rushing_offense_rank'] = rushingOffenseRank;
    data['rushing_defense_rank'] = rushingDefenseRank;
    return data;
  }
}
