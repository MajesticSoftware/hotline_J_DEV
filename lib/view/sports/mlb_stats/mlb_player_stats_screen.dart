import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'mlb_player_stats_controller.dart';
import 'mlb_player_stats_widget.dart';

class MlbPlayerStatsScreen extends StatelessWidget {
  final String gameId;
  
  const MlbPlayerStatsScreen({
    Key? key,
    required this.gameId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize controller with GetX
    final controller = Get.put(MlbPlayerStatsController(gameId: gameId));
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Starting Players',
          style: GoogleFonts.nunitoSans(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          // Refresh button
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () => controller.retryFetch(),
          ),
          // Switch teams button
          IconButton(
            icon: Icon(
              Icons.swap_horiz,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () => controller.switchTeams(),
          ),
        ],
      ),
      body: Obx(() {
        // Show loading indicator while data is loading
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        
        // Show error message if error occurred
        if (controller.hasError.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  controller.errorMessage.value,
                  style: GoogleFonts.nunitoSans(
                    color: Theme.of(context).highlightColor,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => controller.retryFetch(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  child: Text(
                    'Retry',
                    style: GoogleFonts.nunitoSans(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        
        // Show the MLB player stats widget with fetched data
        return SingleChildScrollView(
          child: Column(
            children: [
              // Game information header
              if (controller.startingPlayerData.value != null)
                Container(
                  padding: const EdgeInsets.all(15),
                  color: Theme.of(context).cardColor,
                  child: Column(
                    children: [
                      // Game date
                      Text(
                        getFormattedDate(controller.startingPlayerData.value?.scheduled ?? ''),
                        style: GoogleFonts.nunitoSans(
                          color: Theme.of(context).highlightColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      // Teams matchup
                      Text(
                        '${controller.startingPlayerData.value?.homeTeam?.name ?? 'Home Team'} vs ${controller.startingPlayerData.value?.awayTeam?.name ?? 'Away Team'}',
                        style: GoogleFonts.nunitoSans(
                          color: Theme.of(context).highlightColor,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              
              // Title for the player stats section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Text(
                  'Pitcher vs Batting Stats',
                  style: GoogleFonts.nunitoSans(
                    color: Theme.of(context).highlightColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              
              // The main stats widget
              MlbPlayerStatsWidget(
                startingPlayerData: controller.startingPlayerData.value,
              ),
              
              // Note about the data
              Container(
                padding: const EdgeInsets.all(15),
                alignment: Alignment.center,
                child: Text(
                  'Data based on season statistics',
                  style: GoogleFonts.nunitoSans(
                    color: Colors.grey,
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
  
  // Helper method to format date
  String getFormattedDate(String isoDate) {
    if (isoDate.isEmpty) return 'Game Date';
    
    try {
      final dateTime = DateTime.parse(isoDate);
      return '${dateTime.month}/${dateTime.day}/${dateTime.year}';
    } catch (e) {
      return 'Game Date';
    }
  }
}