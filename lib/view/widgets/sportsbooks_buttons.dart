import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../network/metric_tracking.dart';

class SportsBooksButtons extends StatelessWidget {

  void handleButtonClick(String sportsbookUrl, String sportsbook) async {
    try{
      if(await canLaunchUrl(Uri.parse(sportsbookUrl))){
        launchUrl(Uri.parse(sportsbookUrl), mode: LaunchMode.externalApplication);
        scheduleMicrotask(() {
          print('inside scheduleMicrotask()');
          MetricTracking().incrementCounter(sportsbook);
        });
      }
    }
    catch (e) {
      //
    }
  }

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.height * .02,
        right: MediaQuery.of(context).size.height * .02,
        bottom: MediaQuery.of(context).size.height * .02
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.circular(5.r)
        ),
        child: Padding(
          padding: EdgeInsets.all(5.h),
          child: Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        handleButtonClick('https://sportsbook.fanduel.com/', "fanduel");
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        backgroundColor: Theme.of(context).disabledColor,
                      ),
                      child: FittedBox(
                        child: SvgPicture.asset(
                          'assets/images/fanduel_emblem.svg',
                          color: Theme.of(context).cardColor,
                          width: 40.h,
                          height: 40.h,
                        ),
                      )
                    )
                ),
                SizedBox(width: 5.h),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      handleButtonClick('https://sportsbook.draftkings.com/', "draftkings");
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        backgroundColor: Theme.of(context).disabledColor
                    ),
                    child: FittedBox(
                      child: SvgPicture.asset(
                        'assets/images/draft_kings_emblem.svg',
                        color: Theme.of(context).cardColor,
                        clipBehavior: Clip.none,
                        width: 40.h,
                        height: 40.h,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5.h),
                Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        handleButtonClick('https://www.caesars.com/sportsbook-and-casino', "caesars");
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          backgroundColor: Theme.of(context).disabledColor
                      ),
                      child: FittedBox(
                          child: SvgPicture.asset(
                            'assets/images/caesars_emblem.svg',
                            color: Theme.of(context).cardColor,
                            clipBehavior: Clip.none,
                            width: 40.h,
                            height: 40.h,
                          )
                      ),
                    )
                ),
                SizedBox(width: 5.h),
                Expanded(
                  child: ElevatedButton(
                      onPressed: () async {
                        handleButtonClick('https://sports.betmgm.com', "mgm");
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          backgroundColor: Theme.of(context).disabledColor
                      ),
                      child: FittedBox(
                        child: SvgPicture.asset(
                          'assets/images/mgm_emblem.svg',
                          color: Theme.of(context).cardColor,
                          clipBehavior: Clip.none,
                          width: 40.h,
                          height: 40.h,
                        ),
                      )
                  ),
                )
              ]
          ),
        )
      )
    );
  }
}