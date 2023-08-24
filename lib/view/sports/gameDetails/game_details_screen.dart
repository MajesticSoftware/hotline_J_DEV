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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    var client = http.Client();
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
        await _refreshLocalGallery(true);
      }, builder: (con) {
        return RefreshIndicator(
          onRefresh: () async {
            return await _refreshLocalGallery(false);
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
                        headerWidget(
                            context, widget.gameDetails, awayTeam, homeTeam),
                        hotlinesWidget(context, con),
                        teamReportWidget(context, widget.sportKey,
                            widget.gameDetails, awayTeam, homeTeam),
                        playerStatWidget(context, con, widget.sportKey,
                            widget.gameDetails, awayTeam, homeTeam),
                        widget.sportKey == 'MLB'
                            ? hitterPlayerStatWidget(context, con,
                                widget.gameDetails, awayTeam, homeTeam)
                            : const SizedBox(),
                        widget.sportKey == 'MLB'
                            ? mlbInjuryReportWidget(context, widget.gameDetails,
                                widget.sportKey, awayTeam, homeTeam)
                            : awayTeam?.abbreviation == 'DET' &&
                                    homeTeam?.abbreviation == 'KC'
                                ? nflStaticInjuryReportWidget(
                                    context,
                                    con,
                                    widget.sportKey,
                                    widget.gameDetails,
                                    awayTeam,
                                    homeTeam)
                                : nflStaticInjuryReportWidget(
                                    context,
                                    con,
                                    widget.sportKey,
                                    widget.gameDetails,
                                    awayTeam,
                                    homeTeam),
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

  Future _refreshLocalGallery(bool isLoad) async {
    if (widget.sportKey == 'MLB') {
      gameDetailsController.hotlinesFinalData.clear();
      for (int i = 0; i <= 15; i += 5) {
        log('i====$i');
        await gameDetailsController
            .hotlinesDataResponse(
                awayTeamId: awayTeam?.id ?? "",
                sportId: widget.sportId,
                date: widget.date,
                start: i,
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

      gameDetailsController.mlbStaticsAwayTeamResponse(
          isLoad: isLoad, awayTeamId: awayTeam?.uuids ?? '');
      gameDetailsController.profileAwayResponse(
        isLoad: isLoad,
        awayTeamId: widget.gameDetails.awayPlayerId,
      );
      gameDetailsController.profileHomeResponse(
        isLoad: isLoad,
        homeTeamId: widget.gameDetails.homePlayerId,
      );
      gameDetailsController.mlbStaticsHomeTeamResponse(
          isLoad: isLoad, homeTeamId: homeTeam?.uuids ?? '');
      gameDetailsController.mlbInjuriesResponse(
          isLoad: isLoad,
          sportEvent: widget.gameDetails,
          awayTeamId: awayTeam?.uuids ?? "",
          homeTeamId: homeTeam?.uuids ?? "");
    }
    if (widget.sportKey == 'NFL') {
      gameDetailsController.hotlinesFinalData.clear();
      for (int i = 0; i <= 15; i += 5) {
        log('i====$i');
        gameDetailsController
            .hotlinesDataResponse(
          awayTeamId: awayTeam?.id ?? "",
          sportId: widget.sportId,
          date: widget.date,
          start: i,
          homeTeamId: homeTeam?.id ?? "",
        )
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
          awayTeamId:
              (awayTeam?.uuids ?? '').contains(awayTeam?.abbreviation ?? "")
                  ? (awayTeam?.uuids ?? '')
                      .replaceAll(awayTeam?.abbreviation ?? "", '')
                      .replaceAll(',', '')
                  : awayTeam?.uuids ?? "");
      gameDetailsController.nflStaticsHomeTeamResponse(
          isLoad: isLoad,
          homeTeamId:
              (homeTeam?.uuids ?? '').contains(homeTeam?.abbreviation ?? "")
                  ? (homeTeam?.uuids ?? '')
                      .replaceAll(homeTeam?.abbreviation ?? "", '')
                      .replaceAll(',', '')
                  : homeTeam?.uuids ?? "");
    }
    gameDetailsController.update();
  }
}
