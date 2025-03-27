class NBAGameRankModel {
  List<NBARank>? data;
  String? msg;
  bool? status;

  NBAGameRankModel({this.data, this.msg, this.status});

  NBAGameRankModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <NBARank>[];
      json['data'].forEach((v) {
        data!.add(NBARank.fromJson(v));
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

class NBARank {
  num? id;
  String? teamId;
  String? teamName;
  num? pointOffense;
  num? pointDefense;
  num? reboundesOffense;
  num? reboundesDefense;
  num? assistOffense;
  num? assistDefense;
  num? stealsOffense;
  num? stealsDefense;
  num? blocksOffense;
  num? blocksDefense;
  num? turnOverOffense;
  num? turnOverDefense;
  num? foulsOffense;
  num? foulsDefense;
  num? fgOffense;
  num? fgDefense;
  num? ftOffense;
  num? ftDefense;
  num? threePOffense;
  num? threePDefense;
  num? trueShootingOffense;
  num? trueShootingDefense;
  num? teamPerOffense;
  num? teamPerDefense;
  num? fgMadeOffense;
  num? fgMadeDefense;
  num? fgAttOffense;
  num? fgAttDefense;
  num? ftMadeOffense;
  num? ftMadeDefense;
  num? ftAttOffense;
  num? ftAttDefense;
  num? threePMadeOffense;
  num? threePMadeDefense;
  num? threePAttOffense;
  num? threePAttDefense;
  num? pointOffenseRank;
  num? pointDefenseRank;
  num? reboundesOffenseRank;
  num? reboundesDefenseRank;
  num? assistOffenseRank;
  num? assistDefenseRank;
  num? stealsOffenseRank;
  num? stealsDefenseRank;
  num? blocksOffenseRank;
  num? blocksDefenseRank;
  num? turnOverOffenseRank;
  num? turnOverDefenseRank;
  num? foulsOffenseRank;
  num? foulsDefenseRank;
  num? fgOffenseRank;
  num? fgDefenseRank;
  num? ftOffenseRank;
  num? ftDefenseRank;
  num? threePOffenseRank;
  num? threePDefenseRank;
  num? trueShootingOffenseRank;
  num? trueShootingDefenseRank;
  num? teamPerOffenseRank;
  num? teamPerDefenseRank;
  num? fgMadeOffenseRank;
  num? fgMadeDefenseRank;
  num? fgAttOffenseRank;
  num? fgAttDefenseRank;
  num? ftMadeOffenseRank;
  num? ftMadeDefenseRank;
  num? ftAttOffenseRank;
  num? ftAttDefenseRank;
  num? threePMadeOffenseRank;
  num? threePMadeDefenseRank;
  num? threePAttOffenseRank;
  num? threePAttDefenseRank;

  NBARank(
      {this.id,
        this.teamId,
        this.teamName,
        this.pointOffense,
        this.pointDefense,
        this.reboundesOffense,
        this.reboundesDefense,
        this.assistOffense,
        this.assistDefense,
        this.stealsOffense,
        this.stealsDefense,
        this.blocksOffense,
        this.blocksDefense,
        this.turnOverOffense,
        this.turnOverDefense,
        this.foulsOffense,
        this.foulsDefense,
        this.fgOffense,
        this.fgDefense,
        this.ftOffense,
        this.ftDefense,
        this.threePOffense,
        this.threePDefense,
        this.trueShootingOffense,
        this.trueShootingDefense,
        this.teamPerOffense,
        this.teamPerDefense,
        this.fgMadeOffense,
        this.fgMadeDefense,
        this.fgAttOffense,
        this.fgAttDefense,
        this.ftMadeOffense,
        this.ftMadeDefense,
        this.ftAttOffense,
        this.ftAttDefense,
        this.threePMadeOffense,
        this.threePMadeDefense,
        this.threePAttOffense,
        this.threePAttDefense,
        this.pointOffenseRank,
        this.pointDefenseRank,
        this.reboundesOffenseRank,
        this.reboundesDefenseRank,
        this.assistOffenseRank,
        this.assistDefenseRank,
        this.stealsOffenseRank,
        this.stealsDefenseRank,
        this.blocksOffenseRank,
        this.blocksDefenseRank,
        this.turnOverOffenseRank,
        this.turnOverDefenseRank,
        this.foulsOffenseRank,
        this.foulsDefenseRank,
        this.fgOffenseRank,
        this.fgDefenseRank,
        this.ftOffenseRank,
        this.ftDefenseRank,
        this.threePOffenseRank,
        this.threePDefenseRank,
        this.trueShootingOffenseRank,
        this.trueShootingDefenseRank,
        this.teamPerOffenseRank,
        this.teamPerDefenseRank,
        this.fgMadeOffenseRank,
        this.fgMadeDefenseRank,
        this.fgAttOffenseRank,
        this.fgAttDefenseRank,
        this.ftMadeOffenseRank,
        this.ftMadeDefenseRank,
        this.ftAttOffenseRank,
        this.ftAttDefenseRank,
        this.threePMadeOffenseRank,
        this.threePMadeDefenseRank,
        this.threePAttOffenseRank,
        this.threePAttDefenseRank});

  NBARank.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teamId = json['team_id'];
    teamName = json['team_name'];
    pointOffense = json['point_offense'];
    pointDefense = json['point_defense'];
    reboundesOffense = json['reboundes_offense'];
    reboundesDefense = json['reboundes_defense'];
    assistOffense = json['assist_offense'];
    assistDefense = json['assist_defense'];
    stealsOffense = json['steals_offense'];
    stealsDefense = json['steals_defense'];
    blocksOffense = json['blocks_offense'];
    blocksDefense = json['blocks_defense'];
    turnOverOffense = json['turn_over_offense'];
    turnOverDefense = json['turn_over_defense'];
    foulsOffense = json['fouls_offense'];
    foulsDefense = json['fouls_defense'];
    fgOffense = json['fg_offense'];
    fgDefense = json['fg_defense'];
    ftOffense = json['ft_offense'];
    ftDefense = json['ft_defense'];
    threePOffense = json['three_p_offense'];
    threePDefense = json['three_p_defense'];
    trueShootingOffense = json['true_shooting_offense'];
    trueShootingDefense = json['true_shooting_defense'];
    teamPerOffense = json['team_per_offense'];
    teamPerDefense = json['team_per_defense'];
    fgMadeOffense = json['fg_made_offense'];
    fgMadeDefense = json['fg_made_defense'];
    fgAttOffense = json['fg_att_offense'];
    fgAttDefense = json['fg_att_defense'];
    ftMadeOffense = json['ft_made_offense'];
    ftMadeDefense = json['ft_made_defense'];
    ftAttOffense = json['ft_att_offense'];
    ftAttDefense = json['ft_att_defense'];
    threePMadeOffense = json['three_p_made_offense'];
    threePMadeDefense = json['three_p_made_defense'];
    threePAttOffense = json['three_p_att_offense'];
    threePAttDefense = json['three_p_att_defense'];
    pointOffenseRank = json['point_offense_rank'];
    pointDefenseRank = json['point_defense_rank'];
    reboundesOffenseRank = json['reboundes_offense_rank'];
    reboundesDefenseRank = json['reboundes_defense_rank'];
    assistOffenseRank = json['assist_offense_rank'];
    assistDefenseRank = json['assist_defense_rank'];
    stealsOffenseRank = json['steals_offense_rank'];
    stealsDefenseRank = json['steals_defense_rank'];
    blocksOffenseRank = json['blocks_offense_rank'];
    blocksDefenseRank = json['blocks_defense_rank'];
    turnOverOffenseRank = json['turn_over_offense_rank'];
    turnOverDefenseRank = json['turn_over_defense_rank'];
    foulsOffenseRank = json['fouls_offense_rank'];
    foulsDefenseRank = json['fouls_defense_rank'];
    fgOffenseRank = json['fg_offense_rank'];
    fgDefenseRank = json['fg_defense_rank'];
    ftOffenseRank = json['ft_offense_rank'];
    ftDefenseRank = json['ft_defense_rank'];
    threePOffenseRank = json['three_p_offense_rank'];
    threePDefenseRank = json['three_p_defense_rank'];
    trueShootingOffenseRank = json['true_shooting_offense_rank'];
    trueShootingDefenseRank = json['true_shooting_defense_rank'];
    teamPerOffenseRank = json['team_per_offense_rank'];
    teamPerDefenseRank = json['team_per_defense_rank'];
    fgMadeOffenseRank = json['fg_made_offense_rank'];
    fgMadeDefenseRank = json['fg_made_defense_rank'];
    fgAttOffenseRank = json['fg_att_offense_rank'];
    fgAttDefenseRank = json['fg_att_defense_rank'];
    ftMadeOffenseRank = json['ft_made_offense_rank'];
    ftMadeDefenseRank = json['ft_made_defense_rank'];
    ftAttOffenseRank = json['ft_att_offense_rank'];
    ftAttDefenseRank = json['ft_att_defense_rank'];
    threePMadeOffenseRank = json['three_p_made_offense_rank'];
    threePMadeDefenseRank = json['three_p_made_defense_rank'];
    threePAttOffenseRank = json['three_p_att_offense_rank'];
    threePAttDefenseRank = json['three_p_att_defense_rank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['team_id'] = teamId;
    data['team_name'] = teamName;
    data['point_offense'] = pointOffense;
    data['point_defense'] = pointDefense;
    data['reboundes_offense'] = reboundesOffense;
    data['reboundes_defense'] = reboundesDefense;
    data['assist_offense'] = assistOffense;
    data['assist_defense'] = assistDefense;
    data['steals_offense'] = stealsOffense;
    data['steals_defense'] = stealsDefense;
    data['blocks_offense'] = blocksOffense;
    data['blocks_defense'] = blocksDefense;
    data['turn_over_offense'] = turnOverOffense;
    data['turn_over_defense'] = turnOverDefense;
    data['fouls_offense'] = foulsOffense;
    data['fouls_defense'] = foulsDefense;
    data['fg_offense'] = fgOffense;
    data['fg_defense'] = fgDefense;
    data['ft_offense'] = ftOffense;
    data['ft_defense'] = ftDefense;
    data['three_p_offense'] = threePOffense;
    data['three_p_defense'] = threePDefense;
    data['true_shooting_offense'] = trueShootingOffense;
    data['true_shooting_defense'] = trueShootingDefense;
    data['team_per_offense'] = teamPerOffense;
    data['team_per_defense'] = teamPerDefense;
    data['fg_made_offense'] = fgMadeOffense;
    data['fg_made_defense'] = fgMadeDefense;
    data['fg_att_offense'] = fgAttOffense;
    data['fg_att_defense'] = fgAttDefense;
    data['ft_made_offense'] = ftMadeOffense;
    data['ft_made_defense'] = ftMadeDefense;
    data['ft_att_offense'] = ftAttOffense;
    data['ft_att_defense'] = ftAttDefense;
    data['three_p_made_offense'] = threePMadeOffense;
    data['three_p_made_defense'] = threePMadeDefense;
    data['three_p_att_offense'] = threePAttOffense;
    data['three_p_att_defense'] = threePAttDefense;
    data['point_offense_rank'] = pointOffenseRank;
    data['point_defense_rank'] = pointDefenseRank;
    data['reboundes_offense_rank'] = reboundesOffenseRank;
    data['reboundes_defense_rank'] = reboundesDefenseRank;
    data['assist_offense_rank'] = assistOffenseRank;
    data['assist_defense_rank'] = assistDefenseRank;
    data['steals_offense_rank'] = stealsOffenseRank;
    data['steals_defense_rank'] = stealsDefenseRank;
    data['blocks_offense_rank'] = blocksOffenseRank;
    data['blocks_defense_rank'] = blocksDefenseRank;
    data['turn_over_offense_rank'] = turnOverOffenseRank;
    data['turn_over_defense_rank'] = turnOverDefenseRank;
    data['fouls_offense_rank'] = foulsOffenseRank;
    data['fouls_defense_rank'] = foulsDefenseRank;
    data['fg_offense_rank'] = fgOffenseRank;
    data['fg_defense_rank'] = fgDefenseRank;
    data['ft_offense_rank'] = ftOffenseRank;
    data['ft_defense_rank'] = ftDefenseRank;
    data['three_p_offense_rank'] = threePOffenseRank;
    data['three_p_defense_rank'] = threePDefenseRank;
    data['true_shooting_offense_rank'] = trueShootingOffenseRank;
    data['true_shooting_defense_rank'] = trueShootingDefenseRank;
    data['team_per_offense_rank'] = teamPerOffenseRank;
    data['team_per_defense_rank'] = teamPerDefenseRank;
    data['fg_made_offense_rank'] = fgMadeOffenseRank;
    data['fg_made_defense_rank'] = fgMadeDefenseRank;
    data['fg_att_offense_rank'] = fgAttOffenseRank;
    data['fg_att_defense_rank'] = fgAttDefenseRank;
    data['ft_made_offense_rank'] = ftMadeOffenseRank;
    data['ft_made_defense_rank'] = ftMadeDefenseRank;
    data['ft_att_offense_rank'] = ftAttOffenseRank;
    data['ft_att_defense_rank'] = ftAttDefenseRank;
    data['three_p_made_offense_rank'] = threePMadeOffenseRank;
    data['three_p_made_defense_rank'] = threePMadeDefenseRank;
    data['three_p_att_offense_rank'] = threePAttOffenseRank;
    data['three_p_att_defense_rank'] = threePAttDefenseRank;
    return data;
  }
}
