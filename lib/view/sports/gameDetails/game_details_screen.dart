import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hotlines/model/game_listing.dart';
import 'package:hotlines/utils/extension.dart';

import '../../../constant/shred_preference.dart';
import 'game_details_controller.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import '../../../utils/app_progress.dart';
import 'game_details_widgets.dart';

// ignore: must_be_immutable
class SportDetailsScreen extends StatelessWidget {
  SportDetailsScreen({
    Key? key,
    required this.gameDetails,
    required this.sportKey,
    required this.sportId,
    required this.date,
  }) : super(key: key);
  final SportEvents gameDetails;
  final String sportKey;
  final String sportId;
  final String date;

  final GameDetailsController gameDetailsController = Get.find();

  Competitors? homeTeam;

  Competitors? awayTeam;

  @override
  Widget build(BuildContext context) {
    bool isDark = PreferenceManager.getIsDarkMode() ?? false;
    if (gameDetails.competitors[0].qualifier == 'home') {
      homeTeam = gameDetails.competitors[0];
    } else {
      awayTeam = gameDetails.competitors[0];
    }
    if (gameDetails.competitors[1].qualifier == 'away') {
      awayTeam = gameDetails.competitors[1];
    } else {
      homeTeam = gameDetails.competitors[1];
    }
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: commonAppBarWidget(context, isDark),
      body: GetBuilder<GameDetailsController>(initState: (state) async {
        await _getResponse(true);
      }, builder: (con) {
        return RefreshIndicator(
          onRefresh: () async {
            return await _getResponse(false);
          },
          color: Theme.of(context).disabledColor,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        headerWidget(context, gameDetails, awayTeam, homeTeam),
                        hotlinesWidget(context, con, gameDetails),
                        teamReportWidget(
                            context, sportKey, gameDetails, awayTeam, homeTeam),
                        playerStatWidget(context, con, sportKey, gameDetails,
                            awayTeam, homeTeam),
                        hitterPlayerStatWidget(context, con, gameDetails,
                            awayTeam, homeTeam, sportKey),
                        sportKey == 'MLB'
                            ? const SizedBox()
                            : wrPlayersWidget(context, con, gameDetails,
                                awayTeam, homeTeam, sportKey),
                        sportKey == 'NCAA'
                            ? const SizedBox()
                            : injuryReportWidget(context, gameDetails, sportKey,
                                awayTeam, homeTeam),
                        40.H(),
                      ],
                    ),
                  ))
                ],
              ),
              Obx(() => gameDetailsController.isLoading.value
                  ? const AppProgress()
                  : const SizedBox())
            ],
          ),
        );
      }),
    );
  }

  Future _getResponse(bool isLoad) async {
    gameDetailsController.hotlinesDData.clear();
    gameDetailsController.hotlinesFData.clear();
    gameDetailsController.hotlinesMData.clear();
    gameDetailsController.hotlinesData.clear();
    if (sportKey == 'MLB') {
      for (int i = 0; i <= 15; i += 5) {
        log('i====$i');
        await gameDetailsController
            .hotlinesDataResponse(
                awayTeamId: awayTeam?.id ?? "",
                sportId: sportId,
                date: date,
                start: i,
                isLoad: isLoad,
                homeTeamId: homeTeam?.id ?? "")
            .then((value) {
          gameDetailsController.isHotlines = false;
        });

        if (gameDetailsController.hotlinesFinalData.isNotEmpty) {
          gameDetailsController.isHotlines = false;
          gameDetailsController.update();
          break;
        }
      }
      if ((gameDetails.awayPlayerId ?? "").isNotEmpty) {
        gameDetailsController.profileAwayResponse(
          isLoad: isLoad,
          awayTeamId: gameDetails.awayPlayerId ?? "",
        );
      }
      if ((gameDetails.homePlayerId ?? "").isNotEmpty) {
        gameDetailsController.profileHomeResponse(
          isLoad: isLoad,
          homeTeamId: gameDetails.homePlayerId ?? "",
        );
      }

      gameDetailsController.mlbStaticsAwayTeamResponse(
          isLoad: isLoad,
          awayTeamId: replaceId(awayTeam?.uuids ?? ''),
          gameDetails: gameDetails);
      gameDetailsController.mlbStaticsHomeTeamResponse(
          isLoad: isLoad,
          homeTeamId: replaceId(homeTeam?.uuids ?? ''),
          gameDetails: gameDetails);
      gameDetailsController.mlbInjuriesResponse(
          isLoad: isLoad,
          sportEvent: gameDetails,
          awayTeamId: replaceId(awayTeam?.uuids ?? ''),
          homeTeamId: replaceId(homeTeam?.uuids ?? ''));
    }
    if (sportKey == 'NFL') {
      gameDetailsController.hotlinesFinalData.clear();
      for (int i = 0; i <= 15; i += 5) {
        log('i====$i');
        await gameDetailsController
            .hotlinesDataResponse(
                awayTeamId: awayTeam?.id ?? "",
                sportId: sportId,
                date: date,
                start: i,
                isLoad: isLoad,
                homeTeamId: homeTeam?.id ?? "")
            .then((value) {
          gameDetailsController.isHotlines = false;
        });

        if (gameDetailsController.hotlinesFinalData.isNotEmpty) {
          gameDetailsController.isHotlines = false;
          gameDetailsController.update();
          break;
        }
      }

      gameDetailsController.nflStaticsAwayTeamResponse(
          isLoad: isLoad,
          gameDetails: gameDetails,
          sportKey: sportKey,
          awayTeamId: awayTeam?.abbreviation == 'LV'
              ? '7d4fcc64-9cb5-4d1b-8e75-8a906d1e1576'
              : replaceId(awayTeam?.uuids ?? ''));
      gameDetailsController.nflStaticsHomeTeamResponse(
          isLoad: isLoad,
          gameDetails: gameDetails,
          sportKey: sportKey,
          homeTeamId: homeTeam?.abbreviation == 'LV'
              ? '7d4fcc64-9cb5-4d1b-8e75-8a906d1e1576'
              : replaceId(homeTeam?.uuids ?? ''));
      gameDetailsController.mlbInjuriesResponse(
          isLoad: isLoad,
          sportEvent: gameDetails,
          awayTeamId: awayTeam?.abbreviation == 'LV'
              ? '7d4fcc64-9cb5-4d1b-8e75-8a906d1e1576'
              : replaceId(awayTeam?.uuids ?? ''),
          homeTeamId: homeTeam?.abbreviation == 'LV'
              ? '7d4fcc64-9cb5-4d1b-8e75-8a906d1e1576'
              : replaceId(homeTeam?.uuids ?? ''));
    }
    if (sportKey == 'NCAA') {
      for (int i = 0; i <= 15; i += 5) {
        log('i====$i');
        await gameDetailsController
            .hotlinesDataResponse(
                awayTeamId: awayTeam?.id ?? "",
                sportId: sportId,
                date: date,
                start: i,
                isLoad: isLoad,
                homeTeamId: homeTeam?.id ?? "")
            .then((value) {
          gameDetailsController.isHotlines = false;
          gameDetailsController.isLoading.value = false;
        });
        if (gameDetailsController.hotlinesFinalData.isNotEmpty) {
          gameDetailsController.isHotlines = false;
          gameDetailsController.isLoading.value = false;
          gameDetailsController.update();
          break;
        }
      }
      gameDetailsController
          .ncaaGameRanking(
              isLoad: isLoad,
              gameDetails: gameDetails,
              homeTeamId: replaceId(homeTeam?.uuids ?? ''),
              awayTeamId: replaceId(awayTeam?.uuids ?? ''))
          .then((value) {
        gameDetailsController.nflStaticsAwayTeamResponse(
            isLoad: isLoad,
            gameDetails: gameDetails,
            sportKey: sportKey,
            awayTeamId: replaceId(awayTeam?.uuids ?? ''));
        gameDetailsController.nflStaticsHomeTeamResponse(
            isLoad: isLoad,
            gameDetails: gameDetails,
            sportKey: sportKey,
            homeTeamId: replaceId(homeTeam?.uuids ?? ''));
      });
    }
    gameDetailsController.update();
  }
}
