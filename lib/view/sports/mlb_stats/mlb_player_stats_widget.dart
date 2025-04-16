import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../model/starting_player_model.dart';

/// A widget that displays MLB pitcher and batter stats in a comparison format
class MlbPlayerStatsWidget extends StatelessWidget {
  final StartingPlayerModel? startingPlayerData;
  
  const MlbPlayerStatsWidget({
    Key? key,
    required this.startingPlayerData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (startingPlayerData == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(
      children: [
        // Teams & Starters Header
        _buildTeamsHeader(context),
        
        // Stats comparison rows
        _buildStatsRows(context),
      ],
    );
  }

  // Teams header with logos and names
  Widget _buildTeamsHeader(BuildContext context) {
    return Container(
      color: Theme.of(context).secondaryHeaderColor,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      startingPlayerData?.homeTeam?.abbr ?? "AZ",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  "TEAM A - PITCHER (R)",
                  style: GoogleFonts.nunitoSans(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      startingPlayerData?.awayTeam?.abbr ?? "MIA",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  "TEAM (B) BATTING",
                  style: GoogleFonts.nunitoSans(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Build all stats rows
  Widget _buildStatsRows(BuildContext context) {
    return Column(
      children: [
        // ERA vs Batting Average
        _buildStatRow(
          context: context,
          leftLabel: "ERA",
          leftValue: startingPlayerData?.homeTeam?.startingPitcher?.era?.toStringAsFixed(2) ?? "0.0",
          rightLabel: "Team Batting Average",
          rightValue: startingPlayerData?.awayTeam?.teamBatting?.battingAverage ?? ".000",
        ),
        
        // Strikeouts per game
        _buildStatRow(
          context: context,
          leftLabel: "Strike Outs / Game",
          leftValue: startingPlayerData?.homeTeam?.startingPitcher?.strikeoutsPerGame?.toStringAsFixed(1) ?? "0.0",
          rightLabel: "Team SO / Game",
          rightValue: startingPlayerData?.awayTeam?.teamBatting?.strikeoutsPerGame?.toStringAsFixed(1) ?? "0.0",
        ),
        
        // Walks per game
        _buildStatRow(
          context: context,
          leftLabel: "Walks Allowed / Game",
          leftValue: startingPlayerData?.homeTeam?.startingPitcher?.walksPerGame?.toStringAsFixed(1) ?? "0.0",
          rightLabel: "Team Walks / Game",
          rightValue: startingPlayerData?.awayTeam?.teamBatting?.walksPerGame?.toStringAsFixed(1) ?? "0.0",
        ),
        
        // Hits per game
        _buildStatRow(
          context: context,
          leftLabel: "Hits Allowed / Game",
          leftValue: startingPlayerData?.homeTeam?.startingPitcher?.hitsPerGame?.toStringAsFixed(1) ?? "0.0",
          rightLabel: "Team Hits / Game",
          rightValue: startingPlayerData?.awayTeam?.teamBatting?.hitsPerGame?.toStringAsFixed(1) ?? "0.0",
        ),
        
        // Home runs per game
        _buildStatRow(
          context: context,
          leftLabel: "HR Allowed / Game",
          leftValue: startingPlayerData?.homeTeam?.startingPitcher?.homeRunsPerGame?.toStringAsFixed(3) ?? "0.000",
          rightLabel: "Batter HR / Game",
          rightValue: startingPlayerData?.awayTeam?.teamBatting?.homeRunsPerGame?.toStringAsFixed(1) ?? "0.0",
        ),
        
        // On-base percentage vs WHIP (additional row)
        _buildStatRow(
          context: context,
          leftLabel: "WHIP",
          leftValue: startingPlayerData?.homeTeam?.startingPitcher?.whip?.toStringAsFixed(3) ?? "0.000",
          rightLabel: "Team OBP",
          rightValue: startingPlayerData?.awayTeam?.teamBatting?.onBasePercentage?.toStringAsFixed(3) ?? "0.000",
        ),
      ],
    );
  }

  // Build a single stat comparison row
  Widget _buildStatRow({
    required BuildContext context,
    required String leftLabel,
    required String leftValue,
    required String rightLabel,
    required String rightValue,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Left stat (Pitcher)
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Column(
                children: [
                  Text(
                    leftValue,
                    style: GoogleFonts.nunitoSans(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    leftLabel,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunitoSans(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Divider
          Container(
            width: 1,
            height: 75,
            color: Colors.grey.withOpacity(0.2),
          ),
          // Right stat (Batter)
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Column(
                children: [
                  Text(
                    rightValue,
                    style: GoogleFonts.nunitoSans(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    rightLabel,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunitoSans(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}