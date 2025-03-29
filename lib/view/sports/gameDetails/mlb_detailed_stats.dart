import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hotlines/model/game_listing.dart';
import 'package:hotlines/model/game_model.dart'; // For HitterPlayerStatMainModel
import 'package:hotlines/model/mlb_box_score_model.dart';
import 'package:hotlines/model/mlb_statics_model.dart' as stat;
import 'package:hotlines/theme/app_color.dart';
import 'package:hotlines/utils/extension.dart';
import 'package:hotlines/view/sports/gameDetails/game_details_controller.dart';
import 'package:hotlines/view/widgets/common_widget.dart';
import 'package:hotlines/view/widgets/sportsbooks_buttons.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class MLBDetailedStatsView extends StatelessWidget {
  final SportEvents gameDetails;
  final Competitors? awayTeam;
  final Competitors? homeTeam;
  
  const MLBDetailedStatsView({
    Key? key,
    required this.gameDetails,
    required this.awayTeam,
    required this.homeTeam,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GameDetailsController>(
      builder: (controller) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Theme.of(context).canvasColor,
          ),
          margin: EdgeInsets.all(16.r),
          child: Column(
            children: [
              // Game Title Bar
              _buildTitleBar(context),
              
              // Teams and Score
              _buildTeamsAndScore(context),
              
              // Location and Weather
              _buildLocationWeather(context),
              
              // Betting Lines
              _buildBettingLines(context, controller),
              
              // Team Stats Comparison
              _buildTeamStats(context, controller),
              
              // Seasonal Stats (for any team)
              GetBuilder<GameDetailsController>(
                builder: (_) => _buildSeasonalStats(context, controller),
              ),
              
              // Pitcher vs Batter Matchup
              _buildPitcherBatterMatchup(context, controller),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTitleBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.r),
          topRight: Radius.circular(10.r),
        ),
      ),
      child: Center(
        child: "MLB GAME DETAILS".appCommonText(
          color: Colors.white,
          size: 16.sp,
          weight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTeamsAndScore(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: Row(
        children: [
          // Away Team
          Expanded(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Container(
                    height: 80.h,
                    width: 80.h,
                    color: Colors.grey.shade200,
                    child: Center(
                      child: Text(
                        awayTeam?.abbreviation ?? "",
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "${awayTeam?.name}",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          
          // Score
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${gameDetails.awayScore}",
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Text(
                    "-",
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Text(
                    "${gameDetails.homeScore}",
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Text(
                gameDetails.status == "scheduled" 
                    ? "UPCOMING" 
                    : gameDetails.status == "closed" 
                        ? "FINAL" 
                        : "LIVE",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: gameDetails.status == "inprogress" ? Colors.green : null,
                ),
              ),
            ],
          ),
          
          // Home Team
          Expanded(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Container(
                    height: 80.h,
                    width: 80.h,
                    color: Colors.grey.shade200,
                    child: Center(
                      child: Text(
                        homeTeam?.abbreviation ?? "",
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "${homeTeam?.name}",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationWeather(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.location_on, size: 16.r),
          SizedBox(width: 4.w),
          Text(
            "${gameDetails.venue?.name ?? 'TBD'} · ${gameDetails.venue?.cityName ?? ''}",
            style: TextStyle(fontSize: 12.sp),
          ),
          SizedBox(width: 16.w),
          Icon(Icons.wb_sunny, size: 16.r),
          SizedBox(width: 4.w),
          Text(
            // Use a simple weather description based on gameDetails properties
            "Weather: ${gameDetails.temp > 290 ? 'Warm' : gameDetails.temp > 280 ? 'Mild' : 'Cool'}",
            style: TextStyle(fontSize: 12.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildBettingLines(BuildContext context, GameDetailsController controller) {
    return StickyHeader(
      header: Container(
        padding: EdgeInsets.all(12.r),
        color: Theme.of(context).primaryColorLight,
        child: Center(
          child: "BETTING LINES".appCommonText(
            color: Colors.white,
            size: 14.sp,
            weight: FontWeight.bold,
          ),
        ),
      ),
      content: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              children: [
                // Moneyline
                _bettingLineRow(
                  context, 
                  "MONEYLINE", 
                  "${awayTeam?.abbreviation} ML", 
                  "${homeTeam?.abbreviation} ML",
                  "+155", 
                  "-180",
                ),
                Divider(),
                
                // Spread
                _bettingLineRow(
                  context, 
                  "SPREAD", 
                  "${awayTeam?.abbreviation} +1.5", 
                  "${homeTeam?.abbreviation} -1.5",
                  "-140", 
                  "+120",
                ),
                Divider(),
                
                // Over/Under
                _bettingLineRow(
                  context, 
                  "TOTAL", 
                  "OVER 8.5", 
                  "UNDER 8.5",
                  "-110", 
                  "-110",
                ),
              ],
            ),
          ),
          SportsBooksButtons(),
        ],
      ),
    );
  }

  Widget _bettingLineRow(BuildContext context, String title, String awayText, String homeText, String awayOdds, String homeOdds) {
    return Row(
      children: [
        // Title
        SizedBox(
          width: 100.w,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        
        // Away
        Expanded(
          child: Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Column(
              children: [
                Text(
                  awayText,
                  style: TextStyle(fontSize: 12.sp),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 4.h),
                Text(
                  awayOdds,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: awayOdds.startsWith("+") ? Colors.green : Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        
        SizedBox(width: 8.w),
        
        // Home
        Expanded(
          child: Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Column(
              children: [
                Text(
                  homeText,
                  style: TextStyle(fontSize: 12.sp),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 4.h),
                Text(
                  homeOdds,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: homeOdds.startsWith("+") ? Colors.green : Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTeamStats(BuildContext context, GameDetailsController controller) {
    return StickyHeader(
      header: Container(
        padding: EdgeInsets.all(12.r),
        color: Theme.of(context).primaryColorLight,
        child: Center(
          child: "TEAM STATS".appCommonText(
            color: Colors.white,
            size: 14.sp,
            weight: FontWeight.bold,
          ),
        ),
      ),
      content: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            // Offensive section header
            Container(
              margin: EdgeInsets.only(bottom: 16.r),
              padding: EdgeInsets.symmetric(vertical: 8.r),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight.withOpacity(0.3),
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Center(
                child: Text(
                  "OFFENSE (HITTING)",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          
            _teamStatsRow(context, "Hits / Game", controller.mlbAwayHittingList.isNotEmpty ? controller.mlbAwayHittingList[1] : "0", controller.mlbHomeHittingList.isNotEmpty ? controller.mlbHomeHittingList[1] : "0"),
            Divider(),
            _teamStatsRow(context, "Walks / Game", controller.mlbAwayHittingList.isNotEmpty ? controller.mlbAwayHittingList[4] : "0", controller.mlbHomeHittingList.isNotEmpty ? controller.mlbHomeHittingList[4] : "0"),
            Divider(),
            _teamStatsRow(context, "HR / Game", controller.mlbAwayHittingList.isNotEmpty ? controller.mlbAwayHittingList[2] : "0", controller.mlbHomeHittingList.isNotEmpty ? controller.mlbHomeHittingList[2] : "0"),
            Divider(),
            _teamStatsRow(context, "RBI / Game", controller.mlbAwayHittingList.isNotEmpty ? controller.mlbAwayHittingList[3] : "0", controller.mlbHomeHittingList.isNotEmpty ? controller.mlbHomeHittingList[3] : "0"),
            Divider(),
            _teamStatsRow(context, "Runs / Game", controller.mlbAwayHittingList.isNotEmpty ? controller.mlbAwayHittingList[0] : "0", controller.mlbHomeHittingList.isNotEmpty ? controller.mlbHomeHittingList[0] : "0"),
            Divider(),
            _teamStatsRow(context, "SO / Game", controller.mlbAwayHittingList.isNotEmpty ? controller.mlbAwayHittingList[5] : "0", controller.mlbHomeHittingList.isNotEmpty ? controller.mlbHomeHittingList[5] : "0"),
            Divider(),
            _teamStatsRow(context, "SB / Game", controller.mlbAwayHittingList.isNotEmpty ? controller.mlbAwayHittingList[6] : "0", controller.mlbHomeHittingList.isNotEmpty ? controller.mlbHomeHittingList[6] : "0"),
            Divider(),
            _teamStatsRow(context, "Team Batting Avg", controller.mlbAwayHittingList.isNotEmpty ? controller.mlbAwayHittingList[7] : "0", controller.mlbHomeHittingList.isNotEmpty ? controller.mlbHomeHittingList[7] : "0"),
            Divider(),
            _teamStatsRow(context, "On Base %", controller.mlbAwayHittingList.isNotEmpty ? (controller.mlbStaticsAwayList?.hitting?.overall?.obp?.toString() ?? "0") : "0", 
                                            controller.mlbHomeHittingList.isNotEmpty ? (controller.mlbStaticsHomeList?.hitting?.overall?.obp?.toString() ?? "0") : "0"),
            Divider(),
            _teamStatsRow(context, "Slugging %", controller.mlbAwayHittingList.isNotEmpty ? controller.mlbAwayHittingList[8] : "0", controller.mlbHomeHittingList.isNotEmpty ? controller.mlbHomeHittingList[8] : "0"),
            
            // Defensive section header
            Container(
              margin: EdgeInsets.only(top: 24.r, bottom: 16.r),
              padding: EdgeInsets.symmetric(vertical: 8.r),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight.withOpacity(0.3),
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Center(
                child: Text(
                  "DEFENSE (PITCHING)",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            
            _teamStatsRow(context, "ERA", controller.mlbAwayPitchingList.isNotEmpty ? controller.mlbAwayPitchingList[0] : "0", controller.mlbHomePitchingList.isNotEmpty ? controller.mlbHomePitchingList[0] : "0"),
            Divider(),
            _teamStatsRow(context, "WHIP", controller.mlbAwayPitchingList.isNotEmpty ? controller.mlbAwayPitchingList[9] : "0", controller.mlbHomePitchingList.isNotEmpty ? controller.mlbHomePitchingList[9] : "0"),
            Divider(),
            _teamStatsRow(context, "Strikeouts / Game", controller.mlbAwayPitchingList.isNotEmpty ? controller.mlbAwayPitchingList[8] : "0", controller.mlbHomePitchingList.isNotEmpty ? controller.mlbHomePitchingList[8] : "0"),
            Divider(),
            _teamStatsRow(context, "Walks / Game", controller.mlbAwayPitchingList.isNotEmpty ? controller.mlbAwayPitchingList[7] : "0", controller.mlbHomePitchingList.isNotEmpty ? controller.mlbHomePitchingList[7] : "0"),
            Divider(),
            _teamStatsRow(context, "Quality Starts", controller.mlbAwayPitchingList.isNotEmpty ? controller.mlbAwayPitchingList[4] : "0", controller.mlbHomePitchingList.isNotEmpty ? controller.mlbHomePitchingList[4] : "0"),
          ],
        ),
      ),
    );
  }

  Widget _teamStatsRow(BuildContext context, String title, String awayValue, String homeValue) {
    return Row(
      children: [
        // Away Value
        Expanded(
          child: Text(
            awayValue,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        
        // Title
        Expanded(
          child: Text(
            title,
            style: TextStyle(fontSize: 12.sp),
            textAlign: TextAlign.center,
          ),
        ),
        
        // Home Value
        Expanded(
          child: Text(
            homeValue,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildPitcherBatterMatchup(BuildContext context, GameDetailsController controller) {
    // Controller for the page view
    final PageController pageController = PageController(
      initialPage: controller.pitcherBatterCompare.currentBatterIndex,
    );
    
    // Add listener to update the current batter index when page changes
    pageController.addListener(() {
      if (pageController.page?.round() != null) {
        controller.pitcherBatterCompare.currentBatterIndex = pageController.page!.round();
        controller.update();
      }
    });

    // Create a list of batters for comparison
    final List<Widget> batterPages = [];
    
    // Add batters from the controller's list
    if (controller.hitterHomePlayerMainList.isNotEmpty) {
      for (int i = 0; i < controller.hitterHomePlayerMainList.length; i++) {
        if (i < 9) { // Only show top 9 batters in lineup
          batterPages.add(
            _buildPitcherBatterPage(
              context, 
              controller, 
              controller.hitterHomePlayerMainList[i],
              i + 1,
            )
          );
        }
      }
    } else {
      // Fallback if no batters are available
      batterPages.add(
        Padding(
          padding: EdgeInsets.all(16.r),
          child: Center(
            child: Text(
              "No batter data available",
              style: TextStyle(fontSize: 16.sp),
            ),
          ),
        ),
      );
    }

    return StickyHeader(
      header: Container(
        padding: EdgeInsets.all(12.r),
        color: Theme.of(context).primaryColorLight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            "MATCHUP COMPARISON".appCommonText(
              color: Colors.white,
              size: 14.sp,
              weight: FontWeight.bold,
            ),
            SizedBox(width: 8.w),
            Icon(Icons.swipe, color: Colors.white, size: 16.r),
          ],
        ),
      ),
      content: Column(
        children: [
          Container(
            height: 430.h,
            child: PageView(
              controller: pageController,
              children: batterPages,
            ),
          ),
          
          // Page indicator
          GetBuilder<GameDetailsController>(
            builder: (controller) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < batterPages.length; i++)
                    Container(
                      width: 8.0,
                      height: 8.0,
                      margin: EdgeInsets.symmetric(horizontal: 4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: i == controller.pitcherBatterCompare.currentBatterIndex
                            ? Theme.of(context).primaryColor 
                            : Colors.grey,
                      ),
                    ),
                ],
              );
            }
          ),
          
          SizedBox(height: 8.h),
          Text(
            "Swipe left/right to compare pitcher with different batters",
            style: TextStyle(
              fontSize: 12.sp,
              fontStyle: FontStyle.italic,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
  
  Widget _buildPitcherBatterPage(
    BuildContext context, 
    GameDetailsController controller, 
    dynamic batter, // Allow any type since we're manually accessing properties
    int batterNumber,
  ) {
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: Column(
        children: [
          // Starting Pitcher vs Batter header
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.r),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorLight.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "STARTING PITCHER",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "${controller.awayPlayerName}",
                        style: TextStyle(fontSize: 14.sp),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "${awayTeam?.abbreviation} (R)",
                        style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 50.h,
                  width: 1,
                  color: Colors.grey.shade300,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "BATTER #$batterNumber",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        batter.playerName.toString(),
                        style: TextStyle(fontSize: 14.sp),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "${homeTeam?.abbreviation} (${batter.position.toString()}) (L)",
                        style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: 16.h),
          
          // Comparison stats
          _comparisonRow(context, "ERA", "Batting Average", 
              controller.awayPlayerName.isEmpty ? "0.00" : gameDetails.eraAway, 
              batter.avg.toString()),
          Divider(),
          _comparisonRow(context, "Strike Outs / Game", "SO / Game", 
              controller.awayKk, 
              "6.2"), // Placeholder value, replace with actual data
          Divider(),
          _comparisonRow(context, "Walks / Game", "Walks / Game", 
              controller.awayBb, 
              batter.bb.toString()),
          Divider(),
          _comparisonRow(context, "Hits / Game", "Hits / Game", 
              controller.awayH, 
              batter.hAbValue.toString().split("-")[0]),
          Divider(),
          _comparisonRow(context, "HR / Game", "HR / Game", 
              "0.7", // Placeholder value, replace with actual data
              batter.hr.toString()),
          Divider(),
          _comparisonRow(context, "WHIP", "OBP", 
              controller.whipAway, 
              batter.obpValue.toString()),
          Divider(),
          _comparisonRow(context, "IP", "SLG", 
              controller.awayIp, 
              batter.slgValue.toString()),
        ],
      ),
    );
  }

  Widget _comparisonRow(BuildContext context, String pitcherTitle, String batterTitle, String pitcherValue, String batterValue) {
    return Row(
      children: [
        // Pitcher stats
        Expanded(
          child: Column(
            children: [
              Text(
                pitcherValue,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4.h),
              Text(
                pitcherTitle,
                style: TextStyle(fontSize: 12.sp),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        
        Container(
          height: 40.h,
          width: 1,
          color: Colors.grey.shade300,
        ),
        
        // Batter stats
        Expanded(
          child: Column(
            children: [
              Text(
                batterValue,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4.h),
              Text(
                batterTitle,
                style: TextStyle(fontSize: 12.sp),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildSeasonalStats(BuildContext context, GameDetailsController controller) {
    print("Building seasonal stats section...");
    // Check if we have any team's seasonal data
    bool hasHomeSeasonalStats = controller.mlbHomeSeasonalHittingList.isNotEmpty;
    bool hasAwaySeasonalStats = controller.mlbAwaySeasonalHittingList.isNotEmpty;
    
    // Print debugging information to see if data is available
    print("Has home seasonal stats: $hasHomeSeasonalStats (${controller.mlbHomeSeasonalHittingList})");
    print("Has away seasonal stats: $hasAwaySeasonalStats (${controller.mlbAwaySeasonalHittingList})");
    
    if (!hasHomeSeasonalStats && !hasAwaySeasonalStats) {
      print("NO SEASONAL STATS AVAILABLE - returning empty widget");
      return Container(
        padding: EdgeInsets.all(16.r),
        child: Text(
          "No seasonal team stats available for this game.",
          style: TextStyle(fontSize: 16.sp, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      );
    }
    
    // Determine which team's data we're showing
    String teamName = hasHomeSeasonalStats 
        ? "${controller.homeTeamMarket ?? ''} ${controller.homeTeamName ?? ''}"
        : "${controller.awayTeamMarket ?? ''} ${controller.awayTeamName ?? ''}";
    List<String>? seasonalHittingList = hasHomeSeasonalStats 
        ? controller.mlbHomeSeasonalHittingList 
        : hasAwaySeasonalStats ? controller.mlbAwaySeasonalHittingList : null;
    
    List<String>? seasonalPitchingList = hasHomeSeasonalStats 
        ? controller.mlbHomeSeasonalPitchingList 
        : hasAwaySeasonalStats ? controller.mlbAwaySeasonalPitchingList : null;
    
    if (seasonalHittingList == null || seasonalPitchingList == null) {
      return SizedBox.shrink();
    }
    
    // Column titles for the stats
    List<String> hittingTitles = [
      'Runs/Game',
      'Hits/Game',
      'HR/Game',
      'RBI/Game',
      'Walks/Game',
      'SO/Game',
      'SB/Game',
      'Batting Average',
      'Slugging %',
      'OPS',
      'GDP/Game',
      'AB/HR',
    ];
    
    List<String> pitchingTitles = [
      'ERA',
      'WHIP',
      'K/9',
      'K/BB',
      'Opp. Batting Avg',
      'HR/9',
      'Quality Start %',
    ];
    
    return StickyHeader(
      header: Container(
        padding: EdgeInsets.all(12.r),
        color: Theme.of(context).primaryColorLight,
        child: Center(
          child: "$teamName SEASON STATS".appCommonText(
            color: Colors.white,
            size: 14.sp,
            weight: FontWeight.bold,
          ),
        ),
      ),
      content: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header for the season record
            Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Text(
                "Season Record: ${hasHomeSeasonalStats 
                    ? (controller.mlbSeasonalStatsHome?.statistics?.pitching?.overall?.games?.win ?? 0).toString() 
                    : (controller.mlbSeasonalStatsAway?.statistics?.pitching?.overall?.games?.win ?? 0).toString()}-${hasHomeSeasonalStats 
                    ? (controller.mlbSeasonalStatsHome?.statistics?.pitching?.overall?.games?.loss ?? 0).toString() 
                    : (controller.mlbSeasonalStatsAway?.statistics?.pitching?.overall?.games?.loss ?? 0).toString()} (${DateTime.now().year})",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 16.h),
            
            // Header for hitting stats
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.r),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Text(
                "Team Hitting (Offense)",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 8.h),
            
            // Hitting stats
            Column(
              children: [
                for (int i = 0; i < hittingTitles.length && i < seasonalHittingList!.length; i++)
                  Column(
                    children: [
                      _seasonalStatsRow(
                        context, 
                        hittingTitles[i], 
                        seasonalHittingList[i],
                      ),
                      if (i < hittingTitles.length - 1) Divider(),
                    ],
                  ),
              ],
            ),
            
            SizedBox(height: 16.h),
            
            // Header for pitching stats
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.r),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Text(
                "Team Pitching (Defense)",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 8.h),
            
            // Pitching stats
            Column(
              children: [
                for (int i = 0; i < pitchingTitles.length && i < seasonalPitchingList!.length; i++)
                  Column(
                    children: [
                      _seasonalStatsRow(
                        context, 
                        pitchingTitles[i], 
                        seasonalPitchingList[i],
                      ),
                      if (i < pitchingTitles.length - 1) Divider(),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _seasonalStatsRow(BuildContext context, String title, String value) {
    return Row(
      children: [
        // Stat title
        Expanded(
          child: Text(
            title,
            style: TextStyle(fontSize: 14.sp),
          ),
        ),
        
        // Stat value
        Text(
          value,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}