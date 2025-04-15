import 'dart:convert';
import 'package:http/http.dart' as http;
import '../extras/api_exception.dart';
import '../extras/base_api_helper.dart';
import '../extras/request_constants.dart';
import '../model/starting_player_model.dart';
import '../model/response_item.dart';

class StartingPlayerRepo {
  final BaseApiHelper _helper = BaseApiHelper();
  
  // Get daily boxscore with starting pitchers
  Future<ResponseItem<StartingPlayerModel>> getDailyBoxScore(String date) async {
    try {
      // API endpoints
      final boxScoreEndpoint = '${RequestConstants.mlbBaseUrl}v8/en/games/$date/boxscore.json?api_key=${RequestConstants.mlbApiKey}';
      
      // Get boxscore data
      final boxScoreResponse = await _helper.get(boxScoreEndpoint);
      if (boxScoreResponse.error != null) {
        return ResponseItem<StartingPlayerModel>(error: boxScoreResponse.error);
      }
      
      // Parse boxscore data to get starting player model
      StartingPlayerModel model = StartingPlayerModel.fromJson(boxScoreResponse.data);
      
      // If we have both home and away team data, load their seasonal stats
      if (model.homeTeam != null && model.awayTeam != null) {
        // Get team IDs
        final homeTeamId = model.homeTeam!.id;
        final awayTeamId = model.awayTeam!.id;
        
        if (homeTeamId != null && awayTeamId != null) {
          // Load seasonal stats for both teams
          final homeTeamSeasonalStats = await _getTeamSeasonalStats(date.substring(0, 4), homeTeamId);
          final awayTeamSeasonalStats = await _getTeamSeasonalStats(date.substring(0, 4), awayTeamId);
          
          // Update model with seasonal stats
          model.updateWithSeasonalStats(
            homeTeamSeasonalStats?.data ?? {}, 
            awayTeamSeasonalStats?.data ?? {}
          );
        }
      }
      
      return ResponseItem<StartingPlayerModel>(data: model);
    } catch (e) {
      return ResponseItem<StartingPlayerModel>(
        error: ApiException(message: 'Error fetching starting player data: $e', statusCode: 500)
      );
    }
  }
  
  // Helper method to get team seasonal stats
  Future<ResponseItem<Map<String, dynamic>>> _getTeamSeasonalStats(String year, String teamId) async {
    try {
      // API endpoint for team seasonal stats
      final seasonalStatsEndpoint = '${RequestConstants.mlbBaseUrl}v8/en/seasons/$year/REG/teams/$teamId/statistics.json?api_key=${RequestConstants.mlbApiKey}';
      
      // Get seasonal stats data
      final response = await _helper.get(seasonalStatsEndpoint);
      if (response.error != null) {
        return ResponseItem<Map<String, dynamic>>(error: response.error);
      }
      
      return ResponseItem<Map<String, dynamic>>(data: response.data);
    } catch (e) {
      return ResponseItem<Map<String, dynamic>>(
        error: ApiException(message: 'Error fetching team stats: $e', statusCode: 500)
      );
    }
  }
  
  // Get starting player data for a specific game
  Future<ResponseItem<StartingPlayerModel>> getStartingPlayersByGameId(String gameId) async {
    try {
      print("⚾ MLB STATS: Fetching starting player data for game: $gameId");
      
      // API endpoint for specific game boxscore
      final boxScoreEndpoint = '${RequestConstants.mlbBaseUrl}v8/en/games/$gameId/boxscore.json?api_key=${RequestConstants.mlbApiKey}';
      print("⚾ MLB STATS: API endpoint: $boxScoreEndpoint");
      
      // Get boxscore data
      final boxScoreResponse = await _helper.get(boxScoreEndpoint);
      if (boxScoreResponse.error != null) {
        print("⚾ MLB STATS ERROR: ${boxScoreResponse.error?.message}");
        return ResponseItem<StartingPlayerModel>(error: boxScoreResponse.error);
      }
      
      // Parse boxscore data to get starting player model
      StartingPlayerModel model = StartingPlayerModel.fromJson(boxScoreResponse.data);
      print("⚾ MLB STATS: Initial model parsed with starting pitchers: ${model.homeTeam?.startingPitcher?.fullName} vs ${model.awayTeam?.startingPitcher?.fullName}");
      
      // If we have both home and away team data, load their seasonal stats
      if (model.homeTeam != null && model.awayTeam != null) {
        // Get team IDs and current year from scheduled date
        final homeTeamId = model.homeTeam!.id;
        final awayTeamId = model.awayTeam!.id;
        final year = model.scheduled?.substring(0, 4) ?? DateTime.now().year.toString();
        
        print("⚾ MLB STATS: Home Team: ${model.homeTeam!.market} ${model.homeTeam!.name} (ID: $homeTeamId)");
        print("⚾ MLB STATS: Away Team: ${model.awayTeam!.market} ${model.awayTeam!.name} (ID: $awayTeamId)");
        
        if (homeTeamId != null && awayTeamId != null) {
          // Load seasonal stats for both teams
          final homeTeamSeasonalStats = await _getTeamSeasonalStats(year, homeTeamId);
          final awayTeamSeasonalStats = await _getTeamSeasonalStats(year, awayTeamId);
          
          if (homeTeamSeasonalStats?.error != null) {
            print("⚾ MLB STATS ERROR: Home team stats error: ${homeTeamSeasonalStats?.error?.message}");
          }
          
          if (awayTeamSeasonalStats?.error != null) {
            print("⚾ MLB STATS ERROR: Away team stats error: ${awayTeamSeasonalStats?.error?.message}");
          }
          
          // Update model with seasonal stats
          model.updateWithSeasonalStats(
            homeTeamSeasonalStats?.data ?? {}, 
            awayTeamSeasonalStats?.data ?? {}
          );
          
          // Log the pitcher stats after update
          print("⚾ MLB STATS: Home Pitcher Stats (${model.homeTeam?.startingPitcher?.fullName}):");
          print("  ERA: ${model.homeTeam?.startingPitcher?.era}");
          print("  K/9: ${model.homeTeam?.startingPitcher?.strikeoutsPerGame}");
          print("  BB/9: ${model.homeTeam?.startingPitcher?.walksPerGame}");
          print("  H/9: ${model.homeTeam?.startingPitcher?.hitsPerGame}");
          print("  HR/9: ${model.homeTeam?.startingPitcher?.homeRunsPerGame}");
          
          print("⚾ MLB STATS: Away Batting Stats (${model.awayTeam?.name}):");
          print("  AVG: ${model.awayTeam?.teamBatting?.battingAverage}");
          print("  SO/G: ${model.awayTeam?.teamBatting?.strikeoutsPerGame}");
          print("  BB/G: ${model.awayTeam?.teamBatting?.walksPerGame}");
          print("  H/G: ${model.awayTeam?.teamBatting?.hitsPerGame}");
          print("  HR/G: ${model.awayTeam?.teamBatting?.homeRunsPerGame}");
        }
      }
      
      return ResponseItem<StartingPlayerModel>(data: model);
    } catch (e) {
      print("⚾ MLB STATS EXCEPTION: $e");
      return ResponseItem<StartingPlayerModel>(
        error: ApiException(message: 'Error fetching starting player data: $e', statusCode: 500)
      );
    }
  }
}