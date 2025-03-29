class MLBBatterPitcherCompare {
  final String pitcherId;
  final String pitcherName;
  final String pitcherTeam;
  final PitcherStats pitcherStats;
  final List<BatterStats> batters;

  MLBBatterPitcherCompare({
    required this.pitcherId,
    required this.pitcherName,
    required this.pitcherTeam,
    required this.pitcherStats,
    required this.batters,
  });

  factory MLBBatterPitcherCompare.fromJson(Map<String, dynamic> json) {
    return MLBBatterPitcherCompare(
      pitcherId: json['pitcher_id'],
      pitcherName: json['pitcher_name'],
      pitcherTeam: json['pitcher_team'],
      pitcherStats: PitcherStats.fromJson(json['pitcher_stats']),
      batters: (json['batters'] as List)
          .map((batter) => BatterStats.fromJson(batter))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pitcher_id': pitcherId,
      'pitcher_name': pitcherName,
      'pitcher_team': pitcherTeam,
      'pitcher_stats': pitcherStats.toJson(),
      'batters': batters.map((batter) => batter.toJson()).toList(),
    };
  }
}

class PitcherStats {
  final String era;
  final String strikeoutsPerGame;
  final String walksAllowedPerGame;
  final String hitsAllowedPerGame;
  final String homerunsAllowedPerGame;
  final String winLossRecord;
  final String whip;
  final String innings;

  PitcherStats({
    required this.era,
    required this.strikeoutsPerGame,
    required this.walksAllowedPerGame,
    required this.hitsAllowedPerGame,
    required this.homerunsAllowedPerGame,
    required this.winLossRecord,
    required this.whip,
    required this.innings,
  });

  factory PitcherStats.fromJson(Map<String, dynamic> json) {
    return PitcherStats(
      era: json['era'],
      strikeoutsPerGame: json['strikeouts_per_game'],
      walksAllowedPerGame: json['walks_allowed_per_game'],
      hitsAllowedPerGame: json['hits_allowed_per_game'],
      homerunsAllowedPerGame: json['homeruns_allowed_per_game'],
      winLossRecord: json['win_loss_record'],
      whip: json['whip'],
      innings: json['innings'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'era': era,
      'strikeouts_per_game': strikeoutsPerGame,
      'walks_allowed_per_game': walksAllowedPerGame,
      'hits_allowed_per_game': hitsAllowedPerGame,
      'homeruns_allowed_per_game': homerunsAllowedPerGame,
      'win_loss_record': winLossRecord,
      'whip': whip,
      'innings': innings,
    };
  }
}

class BatterStats {
  final String batterId;
  final String batterName;
  final String batterTeam;
  final String position;
  final String battingHand; // L or R
  final String battingAverage;
  final String batterStrikeoutsPerGame;
  final String batterWalksPerGame;
  final String batterHitsPerGame;
  final String batterHomerunsPerGame;
  final String onBasePercentage;
  final String sluggingPercentage;

  BatterStats({
    required this.batterId,
    required this.batterName,
    required this.batterTeam,
    required this.position,
    required this.battingHand,
    required this.battingAverage,
    required this.batterStrikeoutsPerGame,
    required this.batterWalksPerGame,
    required this.batterHitsPerGame,
    required this.batterHomerunsPerGame,
    required this.onBasePercentage,
    required this.sluggingPercentage,
  });

  factory BatterStats.fromJson(Map<String, dynamic> json) {
    return BatterStats(
      batterId: json['batter_id'],
      batterName: json['batter_name'],
      batterTeam: json['batter_team'],
      position: json['position'],
      battingHand: json['batting_hand'],
      battingAverage: json['batting_average'],
      batterStrikeoutsPerGame: json['batter_strikeouts_per_game'],
      batterWalksPerGame: json['batter_walks_per_game'],
      batterHitsPerGame: json['batter_hits_per_game'],
      batterHomerunsPerGame: json['batter_homeruns_per_game'],
      onBasePercentage: json['on_base_percentage'],
      sluggingPercentage: json['slugging_percentage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'batter_id': batterId,
      'batter_name': batterName,
      'batter_team': batterTeam,
      'position': position,
      'batting_hand': battingHand,
      'batting_average': battingAverage,
      'batter_strikeouts_per_game': batterStrikeoutsPerGame,
      'batter_walks_per_game': batterWalksPerGame,
      'batter_hits_per_game': batterHitsPerGame,
      'batter_homeruns_per_game': batterHomerunsPerGame,
      'on_base_percentage': onBasePercentage,
      'slugging_percentage': sluggingPercentage,
    };
  }
}