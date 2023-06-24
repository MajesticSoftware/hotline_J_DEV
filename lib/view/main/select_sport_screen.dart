import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/constant.dart';
import '../../generated/assets.dart';
import '../../theme/theme.dart';
import '../../utils/utils.dart';
import '../sports/game_details_screen.dart';

class SelectSportScreen extends StatelessWidget {
  const SelectSportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(147.0),
          child: Container(
            height: Get.height * .12,
            alignment: Alignment.bottomCenter,
            color: appColor,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: selectGame.appCommonText(
                  color: whiteColor,
                  size: Get.height * .04,
                  weight: FontWeight.w700),
            ),
          )),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          20.H(),
          Wrap(
            runSpacing: 0,
            alignment: WrapAlignment.start,
            spacing: Get.height * .02,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: commonImageWidget(
                  Assets.imagesNFT,
                  onTap: () {
                    Get.to(GameTeamScreen(
                      sportKey: 'NFL',
                    ));
                  },
                ),
              )

              /*   commonImageWidget(
                Assets.imagesNBA,
                onTap: () {
                  Get.to(GameTeamScreen(
                    sportKey: 'NBA',
                  ));
                },
              ),
              commonImageWidget(
                Assets.imagesMLB,
                onTap: () {
                  Get.to(GameTeamScreen(
                    sportKey: 'MLB',
                  ));
                },
              ),
              commonImageWidget(
                Assets.imagesNHL,
                onTap: () {
                  Get.to(GameTeamScreen(
                    sportKey: 'NHL',
                  ));
                },
              ),
              commonImageWidget(
                Assets.imagesNCAA,
                onTap: () {
                  Get.to(GameTeamScreen(
                    sportKey: 'NCAA',
                  ));
                },
              ),
              commonImageWidget(
                Assets.imagesSOCCER,
                onTap: () {
                  Get.to(GameTeamScreen(
                    sportKey: 'SOCCER',
                  ));
                },
              ),
              commonImageWidget(
                Assets.imagesUFC,
                onTap: () {
                  Get.to(GameTeamScreen(
                    sportKey: 'UFC',
                  ));
                },
              ),
              commonImageWidget(
                Assets.imagesAUTO,
                onTap: () {
                  Get.to(GameTeamScreen(
                    sportKey: 'AUTO RACING',
                  ));
                },
              ),*/
            ],
          ),
        ],
      ),
    );
  }
}
