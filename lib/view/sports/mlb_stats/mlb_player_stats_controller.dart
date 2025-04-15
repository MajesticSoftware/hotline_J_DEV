import 'package:get/get.dart';
import '../../../model/starting_player_model.dart';
import '../../../network/starting_player_repo.dart';

class MlbPlayerStatsController extends GetxController {
  final StartingPlayerRepo _startingPlayerRepo = StartingPlayerRepo();
  
  // Observable for the starting player data
  final Rx<StartingPlayerModel?> startingPlayerData = Rx<StartingPlayerModel?>(null);
  
  // Loading and error states
  final RxBool isLoading = true.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;
  
  // Game ID for the current game
  final String gameId;
  
  MlbPlayerStatsController({required this.gameId});
  
  @override
  void onInit() {
    super.onInit();
    fetchStartingPlayerData();
  }
  
  // Fetch starting player data from repository
  Future<void> fetchStartingPlayerData() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      
      // Get data by game ID
      final response = await _startingPlayerRepo.getStartingPlayersByGameId(gameId);
      
      if (response.error != null) {
        // Handle API error
        hasError.value = true;
        errorMessage.value = response.error?.message ?? 'Failed to fetch player data';
      } else if (response.data != null) {
        // Update observable with fetched data
        startingPlayerData.value = response.data;
      } else {
        // Handle empty data
        hasError.value = true;
        errorMessage.value = 'No data available for this game';
      }
    } catch (e) {
      // Handle exceptions
      hasError.value = true;
      errorMessage.value = 'An error occurred: $e';
    } finally {
      isLoading.value = false;
    }
  }
  
  // Retry data fetching
  void retryFetch() {
    fetchStartingPlayerData();
  }
  
  // Switch home/away teams display
  void switchTeams() {
    if (startingPlayerData.value != null) {
      final currentData = startingPlayerData.value!;
      
      // Create a new model with swapped teams
      final swappedData = StartingPlayerModel(
        gameId: currentData.gameId,
        scheduled: currentData.scheduled,
        homeTeam: currentData.awayTeam,
        awayTeam: currentData.homeTeam,
      );
      
      startingPlayerData.value = swappedData;
    }
  }
}