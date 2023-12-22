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
  num? passingYardOffense;
  num? passingYardDefense;
  num? rushingTDSOffense;
  num? rushingTDSDefence;
  num? passingTDSOffense;
  num? passingTDSDefence;
  num? redzonEfficiencyOffence;
  num? opponentRedzonEfficiency;
  num? thirdDownOffence;
  num? opponentThirdDown;
  num? fourthDownOffense;
  num? opponentFourtDown;
  num? fieldGoalOffense;
  num? fieldGoalDefense;
  num? ternoverOffense;
  num? ternoverDefense;
  num? pointOffenceRank;
  num? pointsDefenseRank;
  num? rushingOffenseRank;
  num? rushingDefenseRank;
  num? passingYardOffenseRank;
  num? passingYardDefenseRank;
  num? rushingTDSOffenseRank;
  num? rushingTDSDefenceRank;
  num? passingTDSOffenseRank;
  num? passingTDSDefenceRank;
  num? redzonEfficiencyOffenceRank;
  num? opponentRedzonEfficiencyRank;
  num? thirdDownOffenceRank;
  num? opponentThirdDownRank;
  num? fourthDownOffenseRank;
  num? opponentFourtDownRank;
  num? fieldGoalOffenseRank;
  num? fieldGoalDefenseRank;
  num? ternoverOffenseRank;
  num? ternoverDefenseRank;

  NFLGameRank(
      {this.id,
        this.teamId,
        this.teamName,
        this.pointsOffense,
        this.pointsDefense,
        this.rushingOffense,
        this.rushingDefense,
        this.passingYardOffense,
        this.passingYardDefense,
        this.rushingTDSOffense,
        this.rushingTDSDefence,
        this.passingTDSOffense,
        this.passingTDSDefence,
        this.redzonEfficiencyOffence,
        this.opponentRedzonEfficiency,
        this.thirdDownOffence,
        this.opponentThirdDown,
        this.fourthDownOffense,
        this.opponentFourtDown,
        this.fieldGoalOffense,
        this.fieldGoalDefense,
        this.ternoverOffense,
        this.ternoverDefense,
        this.pointOffenceRank,
        this.pointsDefenseRank,
        this.rushingOffenseRank,
        this.rushingDefenseRank,
        this.passingYardOffenseRank,
        this.passingYardDefenseRank,
        this.rushingTDSOffenseRank,
        this.rushingTDSDefenceRank,
        this.passingTDSOffenseRank,
        this.passingTDSDefenceRank,
        this.redzonEfficiencyOffenceRank,
        this.opponentRedzonEfficiencyRank,
        this.thirdDownOffenceRank,
        this.opponentThirdDownRank,
        this.fourthDownOffenseRank,
        this.opponentFourtDownRank,
        this.fieldGoalOffenseRank,
        this.fieldGoalDefenseRank,
        this.ternoverOffenseRank,
        this.ternoverDefenseRank});

  NFLGameRank.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teamId = json['team_id'];
    teamName = json['team_name'];
    pointsOffense = json['points_offense'];
    pointsDefense = json['points_defense'];
    rushingOffense = json['rushing_offense'];
    rushingDefense = json['rushing_defense'];
    passingYardOffense = json['passing_yard_offense'];
    passingYardDefense = json['passing_yard_defense'];
    rushingTDSOffense = json['rushing_TDS_offense'];
    rushingTDSDefence = json['rushing_TDS_defence'];
    passingTDSOffense = json['passing_TDS_offense'];
    passingTDSDefence = json['passing_TDS_defence'];
    redzonEfficiencyOffence = json['redzon_efficiency_offence'];
    opponentRedzonEfficiency = json['opponent_redzon_efficiency'];
    thirdDownOffence = json['third_down_offence'];
    opponentThirdDown = json['opponent_third_down'];
    fourthDownOffense = json['fourth_down_offense'];
    opponentFourtDown = json['opponent_fourt_down'];
    fieldGoalOffense = json['field_goal_offense'];
    fieldGoalDefense = json['field_goal_defense'];
    ternoverOffense = json['ternover_offense'];
    ternoverDefense = json['ternover_defense'];
    pointOffenceRank = json['point_offence_rank'];
    pointsDefenseRank = json['points_defense_rank'];
    rushingOffenseRank = json['rushing_offense_rank'];
    rushingDefenseRank = json['rushing_defense_rank'];
    passingYardOffenseRank = json['passing_yard_offense_rank'];
    passingYardDefenseRank = json['passing_yard_defense_rank'];
    rushingTDSOffenseRank = json['rushing_TDS_offense_rank'];
    rushingTDSDefenceRank = json['rushing_TDS_defence_rank'];
    passingTDSOffenseRank = json['passing_TDS_offense_rank'];
    passingTDSDefenceRank = json['passing_TDS_defence_rank'];
    redzonEfficiencyOffenceRank = json['redzon_efficiency_offence_rank'];
    opponentRedzonEfficiencyRank = json['opponent_redzon_efficiency_rank'];
    thirdDownOffenceRank = json['third_down_offence_rank'];
    opponentThirdDownRank = json['opponent_third_down_rank'];
    fourthDownOffenseRank = json['fourth_down_offense_rank'];
    opponentFourtDownRank = json['opponent_fourt_down_rank'];
    fieldGoalOffenseRank = json['field_goal_offense_rank'];
    fieldGoalDefenseRank = json['field_goal_defense_rank'];
    ternoverOffenseRank = json['ternover_offense_rank'];
    ternoverDefenseRank = json['ternover_defense_rank'];
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
    data['passing_yard_offense'] = passingYardOffense;
    data['passing_yard_defense'] = passingYardDefense;
    data['rushing_TDS_offense'] = rushingTDSOffense;
    data['rushing_TDS_defence'] = rushingTDSDefence;
    data['passing_TDS_offense'] = passingTDSOffense;
    data['passing_TDS_defence'] = passingTDSDefence;
    data['redzon_efficiency_offence'] = redzonEfficiencyOffence;
    data['opponent_redzon_efficiency'] = opponentRedzonEfficiency;
    data['third_down_offence'] = thirdDownOffence;
    data['opponent_third_down'] = opponentThirdDown;
    data['fourth_down_offense'] = fourthDownOffense;
    data['opponent_fourt_down'] = opponentFourtDown;
    data['field_goal_offense'] = fieldGoalOffense;
    data['field_goal_defense'] = fieldGoalDefense;
    data['ternover_offense'] = ternoverOffense;
    data['ternover_defense'] = ternoverDefense;
    data['point_offence_rank'] = pointOffenceRank;
    data['points_defense_rank'] = pointsDefenseRank;
    data['rushing_offense_rank'] = rushingOffenseRank;
    data['rushing_defense_rank'] = rushingDefenseRank;
    data['passing_yard_offense_rank'] = passingYardOffenseRank;
    data['passing_yard_defense_rank'] = passingYardDefenseRank;
    data['rushing_TDS_offense_rank'] = rushingTDSOffenseRank;
    data['rushing_TDS_defence_rank'] = rushingTDSDefenceRank;
    data['passing_TDS_offense_rank'] = passingTDSOffenseRank;
    data['passing_TDS_defence_rank'] = passingTDSDefenceRank;
    data['redzon_efficiency_offence_rank'] = redzonEfficiencyOffenceRank;
    data['opponent_redzon_efficiency_rank'] = opponentRedzonEfficiencyRank;
    data['third_down_offence_rank'] = thirdDownOffenceRank;
    data['opponent_third_down_rank'] = opponentThirdDownRank;
    data['fourth_down_offense_rank'] = fourthDownOffenseRank;
    data['opponent_fourt_down_rank'] = opponentFourtDownRank;
    data['field_goal_offense_rank'] = fieldGoalOffenseRank;
    data['field_goal_defense_rank'] = fieldGoalDefenseRank;
    data['ternover_offense_rank'] = ternoverOffenseRank;
    data['ternover_defense_rank'] = ternoverDefenseRank;
    return data;
  }
}
