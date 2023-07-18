class NFLRankingModel {
  num? seasonType;
  num? season;
  String? team;
  num? score;
  num? opponentScore;
  num? offensiveYardsPerPlay;
  num? rushingYardsPerAttempt;
  num? rushingTouchdowns;
  num? passingTouchdowns;
  num? passingYardsPerAttempt;
  num? passingYardsPerCompletion;
  num? thirdDownPercentage;
  num? fourthDownPercentage;
  num? redZoneAttempts;
  num? redZoneConversions;
  num? opponentOffensiveYardsPerPlay;
  num? opponentRushingTouchdowns;
  num? opponentPassingTouchdowns;
  num? opponentPassingYardsPerAttempt;
  num? opponentPassingYardsPerCompletion;
  num? opponentRushingYardsPerAttempt;
  num? opponentThirdDownPercentage;
  num? opponentFourthDownPercentage;
  num? opponentRedZoneAttempts;
  num? opponentRedZoneConversions;
  num? opponentTurnoverDifferential;
  num? redZonePercentage;
  String? teamName;
  num? games;
  num? twoPointConversionReturns;
  num? opponentTwoPointConversionReturns;
  num? teamID;

  NFLRankingModel(
      {this.seasonType,
      this.season,
      this.team,
      this.score,
      this.opponentScore,
      this.offensiveYardsPerPlay,
      this.rushingYardsPerAttempt,
      this.rushingTouchdowns,
      this.passingTouchdowns,
      this.passingYardsPerAttempt,
      this.passingYardsPerCompletion,
      this.thirdDownPercentage,
      this.fourthDownPercentage,
      this.redZoneAttempts,
      this.redZoneConversions,
      this.opponentOffensiveYardsPerPlay,
      this.opponentRushingTouchdowns,
      this.opponentPassingTouchdowns,
      this.opponentPassingYardsPerAttempt,
      this.opponentPassingYardsPerCompletion,
      this.opponentRushingYardsPerAttempt,
      this.opponentThirdDownPercentage,
      this.opponentFourthDownPercentage,
      this.opponentRedZoneAttempts,
      this.opponentRedZoneConversions,
      this.opponentTurnoverDifferential,
      this.redZonePercentage,
      this.teamName,
      this.games,
      this.twoPointConversionReturns,
      this.opponentTwoPointConversionReturns,
      this.teamID});

  NFLRankingModel.fromJson(Map<String, dynamic> json) {
    seasonType = json['SeasonType'];
    season = json['Season'];
    team = json['Team'];
    score = json['Score'];
    opponentScore = json['OpponentScore'];
    offensiveYardsPerPlay = json['OffensiveYardsPerPlay'];
    rushingYardsPerAttempt = json['RushingYardsPerAttempt'];
    rushingTouchdowns = json['RushingTouchdowns'];
    passingTouchdowns = json['PassingTouchdowns'];
    passingYardsPerAttempt = json['PassingYardsPerAttempt'];
    passingYardsPerCompletion = json['PassingYardsPerCompletion'];
    thirdDownPercentage = json['ThirdDownPercentage'];
    fourthDownPercentage = json['FourthDownPercentage'];
    redZoneAttempts = json['RedZoneAttempts'];
    redZoneConversions = json['RedZoneConversions'];
    opponentOffensiveYardsPerPlay = json['OpponentOffensiveYardsPerPlay'];
    opponentRushingTouchdowns = json['OpponentRushingTouchdowns'];
    opponentPassingTouchdowns = json['OpponentPassingTouchdowns'];
    opponentPassingYardsPerAttempt = json['OpponentPassingYardsPerAttempt'];
    opponentRushingYardsPerAttempt = json['OpponentRushingYardsPerAttempt'];
    opponentPassingYardsPerCompletion =
        json['OpponentPassingYardsPerCompletion'];
    opponentThirdDownPercentage = json['OpponentThirdDownPercentage'];
    opponentFourthDownPercentage = json['OpponentFourthDownPercentage'];
    opponentRedZoneAttempts = json['OpponentRedZoneAttempts'];
    opponentRedZoneConversions = json['OpponentRedZoneConversions'];
    opponentTurnoverDifferential = json['OpponentTurnoverDifferential'];
    redZonePercentage = json['RedZonePercentage'];
    teamName = json['TeamName'];
    games = json['Games'];
    twoPointConversionReturns = json['TwoPointConversionReturns'];
    opponentTwoPointConversionReturns =
        json['OpponentTwoPointConversionReturns'];
    teamID = json['TeamID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['SeasonType'] = seasonType;
    data['Season'] = season;
    data['Team'] = team;
    data['Score'] = score;
    data['OpponentScore'] = opponentScore;
    data['OffensiveYardsPerPlay'] = offensiveYardsPerPlay;
    data['RushingYardsPerAttempt'] = rushingYardsPerAttempt;
    data['RushingTouchdowns'] = rushingTouchdowns;
    data['PassingTouchdowns'] = passingTouchdowns;
    data['PassingYardsPerAttempt'] = passingYardsPerAttempt;
    data['PassingYardsPerCompletion'] = passingYardsPerCompletion;
    data['ThirdDownPercentage'] = thirdDownPercentage;
    data['FourthDownPercentage'] = fourthDownPercentage;
    data['RedZoneAttempts'] = redZoneAttempts;
    data['RedZoneConversions'] = redZoneConversions;
    data['OpponentOffensiveYardsPerPlay'] = opponentOffensiveYardsPerPlay;
    data['OpponentRushingTouchdowns'] = opponentRushingTouchdowns;
    data['OpponentPassingTouchdowns'] = opponentPassingTouchdowns;
    data['OpponentPassingYardsPerAttempt'] = opponentPassingYardsPerAttempt;
    data['OpponentRushingYardsPerAttempt'] = opponentRushingYardsPerAttempt;
    data['OpponentPassingYardsPerCompletion'] =
        opponentPassingYardsPerCompletion;
    data['OpponentThirdDownPercentage'] = opponentThirdDownPercentage;
    data['OpponentFourthDownPercentage'] = opponentFourthDownPercentage;
    data['OpponentRedZoneAttempts'] = opponentRedZoneAttempts;
    data['OpponentRedZoneConversions'] = opponentRedZoneConversions;
    data['OpponentTurnoverDifferential'] = opponentTurnoverDifferential;
    data['RedZonePercentage'] = redZonePercentage;
    data['TeamName'] = teamName;
    data['Games'] = games;
    data['TwoPointConversionReturns'] = twoPointConversionReturns;
    data['OpponentTwoPointConversionReturns'] =
        opponentTwoPointConversionReturns;
    data['TeamID'] = teamID;
    return data;
  }
}
