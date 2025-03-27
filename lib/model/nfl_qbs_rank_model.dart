class NFLQBsRankModel {
  List<QBsRank>? data;
  String? msg;
  bool? status;

  NFLQBsRankModel({this.data, this.msg, this.status});

  NFLQBsRankModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <QBsRank>[];
      json['data'].forEach((v) {
        data!.add(QBsRank.fromJson(v));
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

class QBsRank {
  num? id;
  String? teamId;
  String? teamName;
  String? playerId;
  String? playerName;
  num? passingTDSOffense;
  num? rushingTDsOffense;
  num? passingYardOffense;
  num? rushingYardOffense;
  num? interceptionOffense;
  num? rushingTDsOffenseRank;
  num? passingYardOffenseRank;
  num? rushingYardOffenseRank;
  num? passingTDSOffenseRank;
  num? interceptionOffenseRank;

  QBsRank(
      {this.id,
        this.teamId,
        this.teamName,
        this.playerId,
        this.playerName,
        this.passingTDSOffense,
        this.rushingTDsOffense,
        this.passingYardOffense,
        this.rushingYardOffense,
        this.interceptionOffense,
        this.rushingTDsOffenseRank,
        this.passingYardOffenseRank,
        this.rushingYardOffenseRank,
        this.passingTDSOffenseRank,
        this.interceptionOffenseRank});

  QBsRank.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teamId = json['team_id'];
    teamName = json['team_name'];
    playerId = json['player_id'];
    playerName = json['player_name'];
    passingTDSOffense = json['passing_TDS_offense'];
    rushingTDsOffense = json['rushing_TDs_offense'];
    passingYardOffense = json['passing_yard_offense'];
    rushingYardOffense = json['rushing_yard_offense'];
    interceptionOffense = json['interception_offense'];
    rushingTDsOffenseRank = json['rushing_TDs_offense_rank'];
    passingYardOffenseRank = json['passing_yard_offense_rank'];
    rushingYardOffenseRank = json['rushing_yard_offense_rank'];
    passingTDSOffenseRank = json['passing_TDS_offense_rank'];
    interceptionOffenseRank = json['interception_offense_rank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['team_id'] = teamId;
    data['team_name'] = teamName;
    data['player_id'] = playerId;
    data['player_name'] = playerName;
    data['passing_TDS_offense'] = passingTDSOffense;
    data['rushing_TDs_offense'] = rushingTDsOffense;
    data['passing_yard_offense'] = passingYardOffense;
    data['rushing_yard_offense'] = rushingYardOffense;
    data['interception_offense'] = interceptionOffense;
    data['rushing_TDs_offense_rank'] = rushingTDsOffenseRank;
    data['passing_yard_offense_rank'] = passingYardOffenseRank;
    data['rushing_yard_offense_rank'] = rushingYardOffenseRank;
    data['passing_TDS_offense_rank'] = passingTDSOffenseRank;
    data['interception_offense_rank'] = interceptionOffenseRank;
    return data;
  }
}
