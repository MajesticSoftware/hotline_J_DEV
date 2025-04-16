class StartingPlayerModel {
  // Game information
  String? gameId;
  String? scheduled;
  
  // Team information
  TeamData? homeTeam;
  TeamData? awayTeam;
  
  StartingPlayerModel({
    this.gameId,
    this.scheduled,
    this.homeTeam,
    this.awayTeam,
  });
  
  StartingPlayerModel.fromJson(Map<String, dynamic> json) {
    // Map from the game model
    gameId = json['game']['id'];
    scheduled = json['game']['scheduled'];
    
    // Map home and away team data
    homeTeam = json['game']['home'] != null 
        ? TeamData.fromBoxScore(json['game']['home'], true) 
        : null;
    awayTeam = json['game']['away'] != null 
        ? TeamData.fromBoxScore(json['game']['away'], false) 
        : null;
  }
  
  // Update with seasonal stats for each team
  void updateWithSeasonalStats(Map<String, dynamic> homeStats, Map<String, dynamic> awayStats) {
    if (homeTeam != null) {
      homeTeam!.updateWithSeasonalStats(homeStats);
    }
    
    if (awayTeam != null) {
      awayTeam!.updateWithSeasonalStats(awayStats);
    }
  }
  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['game_id'] = gameId;
    data['scheduled'] = scheduled;
    
    if (homeTeam != null) {
      data['home_team'] = homeTeam!.toJson();
    }
    
    if (awayTeam != null) {
      data['away_team'] = awayTeam!.toJson();
    }
    
    return data;
  }
}

class TeamData {
  // Team information
  String? name;
  String? market;
  String? abbr;
  String? id;
  
  // Record
  int? wins;
  int? losses;
  
  // Starting Pitcher
  PitcherData? startingPitcher;
  
  // Team Batting stats
  BattingData? teamBatting;
  
  TeamData({
    this.name,
    this.market,
    this.abbr,
    this.id,
    this.wins,
    this.losses,
    this.startingPitcher,
    this.teamBatting,
  });
  
  // Constructor for boxscore data
  TeamData.fromBoxScore(Map<String, dynamic> json, bool isHome) {
    name = json['name'];
    market = json['market'];
    abbr = json['abbr'];
    id = json['id'];
    wins = json['win'];
    losses = json['loss'];
    
    // Get starting pitcher data from boxscore
    startingPitcher = json['starting_pitcher'] != null 
        ? PitcherData.fromBoxScore(json['starting_pitcher'])
        : null;
    
    // Initialize with empty batting data (will be populated with seasonal stats)
    teamBatting = BattingData();
  }
  
  // Update with seasonal statistics
  void updateWithSeasonalStats(Map<String, dynamic> json) {
    if (json['statistics'] != null && 
        json['statistics']['hitting'] != null && 
        json['statistics']['hitting']['overall'] != null) {
          
      var hittingStats = json['statistics']['hitting']['overall'];
      teamBatting = BattingData.fromSeasonalStats(hittingStats);
    }
    
    // Update pitcher stats if available in seasonal data
    if (startingPitcher != null && json['players'] != null) {
      for (var player in json['players']) {
        if (player['id'] == startingPitcher!.id) {
          if (player['statistics'] != null && 
              player['statistics']['pitching'] != null &&
              player['statistics']['pitching']['overall'] != null) {
            startingPitcher!.updateWithSeasonalStats(player['statistics']['pitching']['overall']);
          }
          break;
        }
      }
    }
  }
  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['market'] = market;
    data['abbr'] = abbr;
    data['id'] = id;
    data['wins'] = wins;
    data['losses'] = losses;
    
    if (startingPitcher != null) {
      data['starting_pitcher'] = startingPitcher!.toJson();
    }
    
    if (teamBatting != null) {
      data['team_batting'] = teamBatting!.toJson();
    }
    
    return data;
  }
}

class PitcherData {
  // Pitcher identification
  String? preferredName;
  String? firstName;
  String? lastName;
  String? jerseyNumber;
  String? id;
  
  // Basic pitcher stats available in boxscore
  int? wins;
  int? losses;
  double? era;
  
  // Advanced stats available in seasonal stats
  double? strikeoutsPerGame;  // k9 from API
  double? walksPerGame;       // calculated from stats
  double? hitsPerGame;        // calculated from stats 
  double? homeRunsPerGame;    // calculated from stats
  double? whip;               // from API
  
  PitcherData({
    this.preferredName,
    this.firstName,
    this.lastName,
    this.jerseyNumber,
    this.id,
    this.wins,
    this.losses,
    this.era,
    this.strikeoutsPerGame,
    this.walksPerGame,
    this.hitsPerGame,
    this.homeRunsPerGame,
    this.whip,
  });
  
  // Constructor for boxscore data
  PitcherData.fromBoxScore(Map<String, dynamic> json) {
    preferredName = json['preferred_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    jerseyNumber = json['jersey_number'];
    id = json['id'];
    wins = json['win'];
    losses = json['loss'];
    era = json['era']?.toDouble();
  }
  
  // Update with seasonal statistics
  void updateWithSeasonalStats(Map<String, dynamic> json) {
    strikeoutsPerGame = json['k9']?.toDouble();
    whip = json['whip']?.toDouble();
    
    // Calculate per game stats (9 innings) if IP data is available
    if (json['ip_1'] != null) {
      final inningsPitched = json['ip_1']?.toDouble() ?? 0;
      
      // Calculate walks per game (9 innings)
      if (json['onbase'] != null && json['onbase']['bb'] != null) {
        final walks = json['onbase']['bb']?.toDouble() ?? 0;
        walksPerGame = inningsPitched > 0 ? (walks / inningsPitched) * 9 : 0;
      }
      
      // Calculate hits per game (9 innings)
      if (json['onbase'] != null && json['onbase']['h'] != null) {
        final hits = json['onbase']['h']?.toDouble() ?? 0;
        hitsPerGame = inningsPitched > 0 ? (hits / inningsPitched) * 9 : 0;
      }
      
      // Calculate home runs per game (9 innings)
      if (json['onbase'] != null && json['onbase']['hr'] != null) {
        final homeRuns = json['onbase']['hr']?.toDouble() ?? 0;
        homeRunsPerGame = inningsPitched > 0 ? (homeRuns / inningsPitched) * 9 : 0;
      }
    }
  }
  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['preferred_name'] = preferredName;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['jersey_number'] = jerseyNumber;
    data['id'] = id;
    data['wins'] = wins;
    data['losses'] = losses;
    data['era'] = era;
    data['strikeouts_per_game'] = strikeoutsPerGame;
    data['walks_per_game'] = walksPerGame;
    data['hits_per_game'] = hitsPerGame;
    data['home_runs_per_game'] = homeRunsPerGame;
    data['whip'] = whip;
    
    return data;
  }
  
  String get fullName {
    return '$firstName $lastName';
  }
}

class BattingData {
  // Team batting average
  String? battingAverage;
  double? battingAverageValue;
  
  // Team OBP
  double? onBasePercentage;
  
  // Team SLG
  double? sluggingPercentage;
  
  // Team stats per game (calculated from seasonal stats)
  double? strikeoutsPerGame;
  double? walksPerGame;
  double? hitsPerGame;
  double? homeRunsPerGame;
  
  BattingData({
    this.battingAverage,
    this.battingAverageValue,
    this.onBasePercentage,
    this.sluggingPercentage,
    this.strikeoutsPerGame,
    this.walksPerGame,
    this.hitsPerGame,
    this.homeRunsPerGame,
  });
  
  // Constructor for seasonal stats
  BattingData.fromSeasonalStats(Map<String, dynamic> json) {
    // Basic batting stats
    battingAverage = json['avg'];
    battingAverageValue = double.tryParse(json['avg']?.toString().replaceAll('.', '0.') ?? '0');
    onBasePercentage = json['obp']?.toDouble();
    sluggingPercentage = json['slg']?.toDouble();
    
    // Calculate per game stats based on plate appearances
    if (json['ap'] != null) {
      final plateAppearances = json['ap']?.toDouble() ?? 0;
      final gamesPlayed = plateAppearances > 0 ? plateAppearances / 38 : 1; // Approximate PA per game
      
      // Strikeouts per game
      if (json['outs'] != null && json['outs']['ktotal'] != null) {
        final strikeouts = json['outs']['ktotal']?.toDouble() ?? 0;
        strikeoutsPerGame = gamesPlayed > 0 ? strikeouts / gamesPlayed : 0;
      }
      
      // Walks per game
      if (json['onbase'] != null && json['onbase']['bb'] != null) {
        final walks = json['onbase']['bb']?.toDouble() ?? 0;
        walksPerGame = gamesPlayed > 0 ? walks / gamesPlayed : 0;
      }
      
      // Hits per game
      if (json['onbase'] != null && json['onbase']['h'] != null) {
        final hits = json['onbase']['h']?.toDouble() ?? 0;
        hitsPerGame = gamesPlayed > 0 ? hits / gamesPlayed : 0;
      }
      
      // Home runs per game
      if (json['onbase'] != null && json['onbase']['hr'] != null) {
        final homeRuns = json['onbase']['hr']?.toDouble() ?? 0;
        homeRunsPerGame = gamesPlayed > 0 ? homeRuns / gamesPlayed : 0;
      }
    }
  }
  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['batting_average'] = battingAverage;
    data['batting_average_value'] = battingAverageValue;
    data['on_base_percentage'] = onBasePercentage;
    data['slugging_percentage'] = sluggingPercentage;
    data['strikeouts_per_game'] = strikeoutsPerGame;
    data['walks_per_game'] = walksPerGame;
    data['hits_per_game'] = hitsPerGame;
    data['home_runs_per_game'] = homeRunsPerGame;
    
    return data;
  }
}