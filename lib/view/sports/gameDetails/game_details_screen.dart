import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hotlines/model/game_listing.dart';
import 'package:hotlines/utils/extension.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

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

class _SportDetailsScreenState extends State<SportDetailsScreen>
    with SingleTickerProviderStateMixin {
  final GameDetailsController gameDetailsController = Get.find();

  TabController? _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

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
            hotLinesDate: widget.gameDetails.scheduled ?? "",
            awayTeam: awayTeam,
            homeTeam: homeTeam,
            sportId: widget.sportId);
      }, builder: (con) {
        return RefreshIndicator(
          onRefresh: () async {
            return await gameDetailsController.getResponse(
                isLoad: false,
                gameDetails: widget.gameDetails,
                hotLinesDate: widget.gameDetails.scheduled ?? "",
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
                        mainlinesWidget(
                            context, widget.gameDetails, awayTeam, homeTeam),
                        hotlinesWidget(context, con, widget.gameDetails,
                            awayTeam, homeTeam, _tabController!),
                        20.h.H(),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.width * .01),
                              color: Theme.of(context).canvasColor),
                          child: Row(
                            children: [
                              20.h.W(),
                              ClipTab(
                                isSelected: con.isTeamReportTab,
                                teamLogo:
                                    awayLogo(awayTeam, widget.gameDetails),
                                onTap: () {
                                  con.isTeamReportTab = true;
                                },
                              ),
                              80.h.W(),
                              ClipTab(
                                isSelected: !con.isTeamReportTab,
                                onTap: () {
                                  con.isTeamReportTab = false;
                                },
                                teamLogo:
                                    homeLogo(homeTeam, widget.gameDetails),
                              ),
                              20.h.W(),
                            ],
                          ).paddingSymmetric(
                            vertical: 5,
                          ),
                        ).paddingSymmetric(
                            horizontal:
                                MediaQuery.of(context).size.height * .02),
                        widget.sportKey == 'MLB'
                            ? teamReportWidget(context, widget.sportKey,
                                widget.gameDetails, awayTeam, homeTeam)
                            : teamReportNFL(context, con, widget.gameDetails,
                                awayTeam, homeTeam, widget.sportKey),
                        widget.sportKey == 'MLB'
                            ? playerStatWidget(context, con, widget.sportKey,
                                widget.gameDetails, awayTeam, homeTeam)
                            : widget.sportKey == 'NBA' ||
                                    widget.sportKey == 'NCAAB'
                                ? const SizedBox()
                                : quarterBacks(context, con, widget.gameDetails,
                                    awayTeam, homeTeam, widget.sportKey),
                        hitterPlayerStatWidget(context, con, widget.gameDetails,
                            awayTeam, homeTeam, widget.sportKey),
                        widget.sportKey == 'MLB' ||
                                widget.sportKey == 'NBA' ||
                                widget.sportKey == 'NCAAB'
                            ? const SizedBox()
                            : wrPlayersWidget(context, con, widget.gameDetails,
                                awayTeam, homeTeam, widget.sportKey),
                        widget.sportKey == 'NCAA' || widget.sportKey == 'NCAAB'
                            ? const SizedBox()
                            : injuryReportWidget(context, widget.gameDetails,
                                widget.sportKey, awayTeam, homeTeam, con),
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
