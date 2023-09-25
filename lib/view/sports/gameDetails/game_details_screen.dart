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
        await gameDetailsController.getResponse(
            isLoad: true,
            gameDetails: widget.gameDetails,
            sportKey: widget.sportKey,
            date: widget.date,
            awayTeam: awayTeam,
            homeTeam: homeTeam,
            sportId: widget.sportId);
      }, builder: (con) {
        return RefreshIndicator(
          onRefresh: () async {
            return await gameDetailsController.getResponse(
                isLoad: false,
                gameDetails: widget.gameDetails,
                sportKey: widget.sportKey,
                date: widget.date,
                awayTeam: awayTeam,
                homeTeam: homeTeam,
                sportId: widget.sportId);
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
}
