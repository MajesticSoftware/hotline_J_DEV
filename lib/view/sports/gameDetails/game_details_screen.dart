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
class SportDetailsScreen extends StatefulWidget {
  const SportDetailsScreen({
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

  @override
  State<SportDetailsScreen> createState() => _SportDetailsScreenState();
}

class _SportDetailsScreenState extends State<SportDetailsScreen> {
  final GameDetailsController gameDetailsController = Get.find();

  Competitors? homeTeam;

  Competitors? awayTeam;
  var client = http.Client();
  @override
  void dispose() {
    super.dispose();
    client.close();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = PreferenceManager.getIsDarkMode() ?? false;
    if (widget.gameDetails.competitors[0].qualifier == 'home') {
      homeTeam = widget.gameDetails.competitors[0];
    } else {
      awayTeam = widget.gameDetails.competitors[0];
    }
    if (widget.gameDetails.competitors[1].qualifier == 'away') {
      awayTeam = widget.gameDetails.competitors[1];
    } else {
      homeTeam = widget.gameDetails.competitors[1];
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
                        headerWidget(context, widget.gameDetails, awayTeam,
                            homeTeam, widget.sportKey),
                        hotlinesWidget(context, con, widget.gameDetails,
                            awayTeam, homeTeam),
                        widget.sportKey == 'MLB'
                            ? teamReportWidget(context, widget.sportKey,
                                widget.gameDetails, awayTeam, homeTeam)
                            : teamReportNFL(context, con, widget.gameDetails,
                                awayTeam, homeTeam, widget.sportKey),
                        playerStatWidget(context, con, widget.sportKey,
                            widget.gameDetails, awayTeam, homeTeam),
                        hitterPlayerStatWidget(context, con, widget.gameDetails,
                            awayTeam, homeTeam, widget.sportKey),
                        widget.sportKey == 'MLB'
                            ? const SizedBox()
                            : wrPlayersWidget(context, con, widget.gameDetails,
                                awayTeam, homeTeam, widget.sportKey),
                        widget.sportKey == 'NCAA'
                            ? const SizedBox()
                            : injuryReportWidget(context, widget.gameDetails,
                                widget.sportKey, awayTeam, homeTeam),
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
    if (widget.sportKey == 'MLB') {
      gameDetailsController.mlbStaticsAwayTeamResponse(
          isLoad: false,
          awayTeamId: replaceId(awayTeam?.uuids ?? ''),
          gameDetails: widget.gameDetails);
      gameDetailsController.mlbStaticsHomeTeamResponse(
          isLoad: false,
          homeTeamId: replaceId(homeTeam?.uuids ?? ''),
          gameDetails: widget.gameDetails);
      gameDetailsController.mlbInjuriesResponse(
          isLoad: false,
          sportEvent: widget.gameDetails,
          awayTeamId: replaceId(awayTeam?.uuids ?? ''),
          homeTeamId: replaceId(homeTeam?.uuids ?? ''));
      if ((widget.gameDetails.awayPlayerId).isNotEmpty) {
        gameDetailsController.profileAwayResponse(
          isLoad: false,
          awayTeamId: widget.gameDetails.awayPlayerId,
        );
      }
      if ((widget.gameDetails.homePlayerId).isNotEmpty) {
        gameDetailsController.profileHomeResponse(
          isLoad: false,
          homeTeamId: widget.gameDetails.homePlayerId,
        );
      }
      for (int i = 1; i <= 10; i += 5) {
        log('i====$i');
        await gameDetailsController
            .hotlinesDataResponse(
                awayTeamId: awayTeam?.id ?? "",
                sportId: widget.sportId,
                date: widget.date,
                start: i,
                isLoad: isLoad,
                homeTeamId: homeTeam?.id ?? "")
            .then((value) {
          gameDetailsController.isHotlines = false;
        });
        if (gameDetailsController.hotlinesData.isNotEmpty) {
          gameDetailsController.isHotlines = false;
          gameDetailsController.update();
          break;
        }
      }
    }
    if (widget.sportKey == 'NFL') {
      gameDetailsController.hotlinesData.clear();
      for (int i = 1; i <= 10; i += 5) {
        log('i====$i');
        await gameDetailsController
            .hotlinesDataResponse(
                awayTeamId: awayTeam?.id ?? "",
                sportId: widget.sportId,
                date: widget.date,
                start: i,
                isLoad: isLoad,
                homeTeamId: homeTeam?.id ?? "")
            .then((value) {
          gameDetailsController.isHotlines = false;
          gameDetailsController.isLoading.value = false;
        });

        if (gameDetailsController.hotlinesData.isNotEmpty) {
          gameDetailsController.isHotlines = false;
          gameDetailsController.isLoading.value = false;
          gameDetailsController.update();
          break;
        }
      }
      gameDetailsController.nflStaticsAwayTeamResponse(
          isLoad: false,
          gameDetails: widget.gameDetails,
          sportKey: widget.sportKey,
          awayTeamId: awayTeam?.abbreviation == 'LV'
              ? '7d4fcc64-9cb5-4d1b-8e75-8a906d1e1576'
              : replaceId(awayTeam?.uuids ?? ''));
      gameDetailsController.nflStaticsHomeTeamResponse(
          isLoad: false,
          gameDetails: widget.gameDetails,
          sportKey: widget.sportKey,
          homeTeamId: homeTeam?.abbreviation == 'LV'
              ? '7d4fcc64-9cb5-4d1b-8e75-8a906d1e1576'
              : replaceId(homeTeam?.uuids ?? ''));
      gameDetailsController.mlbInjuriesResponse(
          isLoad: false,
          sportEvent: widget.gameDetails,
          awayTeamId: awayTeam?.abbreviation == 'LV'
              ? '7d4fcc64-9cb5-4d1b-8e75-8a906d1e1576'
              : replaceId(awayTeam?.uuids ?? ''),
          homeTeamId: homeTeam?.abbreviation == 'LV'
              ? '7d4fcc64-9cb5-4d1b-8e75-8a906d1e1576'
              : replaceId(homeTeam?.uuids ?? ''));
    }
    if (widget.sportKey == 'NCAA') {
      for (int i = 1; i <= 10; i += 5) {
        log('i====$i');
        await gameDetailsController
            .hotlinesDataResponse(
                awayTeamId: awayTeam?.id ?? "",
                sportId: widget.sportId,
                date: widget.date,
                start: i,
                isLoad: isLoad,
                homeTeamId: homeTeam?.id ?? "")
            .then((value) {
          gameDetailsController.isHotlines = false;
          gameDetailsController.isLoading.value = false;
        });
        if (gameDetailsController.hotlinesData.isNotEmpty) {
          gameDetailsController.isHotlines = false;
          gameDetailsController.isLoading.value = false;
          gameDetailsController.update();
          break;
        }
      }
      gameDetailsController
          .ncaaGameRanking(
              isLoad: false,
              gameDetails: widget.gameDetails,
              homeTeamId: replaceId(homeTeam?.uuids ?? ''),
              awayTeamId: replaceId(awayTeam?.uuids ?? ''))
          .then((value) {
        gameDetailsController.nflStaticsAwayTeamResponse(
            isLoad: false,
            gameDetails: widget.gameDetails,
            sportKey: widget.sportKey,
            awayTeamId: replaceId(awayTeam?.uuids ?? ''));
        gameDetailsController.nflStaticsHomeTeamResponse(
            isLoad: false,
            gameDetails: widget.gameDetails,
            sportKey: widget.sportKey,
            homeTeamId: replaceId(homeTeam?.uuids ?? ''));
      });
    }
    gameDetailsController.update();
  }
}
