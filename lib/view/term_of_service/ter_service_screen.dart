import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hotlines/theme/app_color.dart';
import 'package:hotlines/utils/extension.dart';

import '../../generated/assets.dart';

class TermOfServiceScreen extends StatelessWidget {
  const TermOfServiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        title: 'Term of service'
            .appCommonText(color: whiteColor, weight: FontWeight.w700),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /* SvgPicture.asset(
            Assets.imagesLogo,
            fit: BoxFit.contain,
          ).paddingOnly(
              right: MediaQuery.of(context).size.height * .1,
              left: MediaQuery.of(context).size.height * .1,
              top: 50.h),*/
          "AGREEMENT TO OUR LEGAL TERMS"
              .appCommonText(color: blackColor, weight: FontWeight.bold),
          20.h.H(),
          'We are Hotlines, LLC, doing business as HotlinesCB and Hotlines ("Company," "we," "us," "our"), a company registered in Maryland, United States at 3570 Poole Street, Baltimore, MD 21211.\nWe operate the mobile application Hotlines, LLC (the "App"), as well as any other related products and services that refer or link to these legal terms (the "Legal Terms") (collectively, the "Services").\nYou can contact us by phone at 4438396507, email at casey@hotlinesmd.com, or by mail to 3570 Poole Street, Baltimore, MD 21211, United States.\nThese Legal Terms constitute a legally binding agreement made between you, whether personally or on behalf of an entity ("you"), and Hotlines, LLC, concerning your access to and use of the Services. You agree that by accessing the Services, you have read, understood, and agreed to be bound by all of these Legal Terms. IF YOU DO NOT AGREE WITH ALL OF THESE LEGAL TERMS, THEN YOU ARE EXPRESSLY PROHIBITED FROM USING THE SERVICES AND YOU MUST DISCONTINUE USE IMMEDIATELY.\nWe will provide you with prior notice of any scheduled changes to the Services you are using. Changes to Legal Terms will become effective one (1) days after the notice is given, except if the changes apply to new functionality, security updates, bug fixes, and a court order, in which case the changes will be effective immediately. By continuing to use the Services after the effective date of any changes, you agree to be bound by the modified terms. If you disagree with such changes, you may terminate Services as per the section "TERM AND TERMINATION."\nThe Services are intended for users who are at least 18 years old. Persons under the age of 18 are not permitted to use or register for the Services.\nWe recommend that you print a copy of these Legal Terms for your records.'
              .appCommonText(
                  color: greyColor, size: 18.h, align: TextAlign.start)
        ],
      ).paddingSymmetric(horizontal: 20.h, vertical: 30.h),
    );
  }
}
