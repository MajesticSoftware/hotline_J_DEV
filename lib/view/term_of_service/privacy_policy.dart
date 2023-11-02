import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hotlines/theme/app_color.dart';
import 'package:hotlines/utils/extension.dart';

import '../../generated/assets.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        leading: InkWell(
          highlightColor: Colors.transparent,
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: 30.h,
            color: whiteColor,
          ),
        ),
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        title: 'Privacy Policy'
            .appCommonText(color: whiteColor, weight: FontWeight.w700),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "HotlinesMD".appCommonText(
                color: Theme.of(context).secondaryHeaderColor,
                weight: FontWeight.bold,
                align: TextAlign.start),
            20.h.H(),
            "Effective Date: October 2nd, 2023".appCommonText(
                color: blackColor,
                weight: FontWeight.bold,
                align: TextAlign.start),
            20.h.H(),
            "This Privacy Notice describes how Hotlines LLC (“Hotlines”, “we”, or “our”) collects, uses, shares, and protects personal information when you interact with our website, mobile application, and email communications (the “Services”)."
                .lightText(),
            20.h.H(),
            "Personal Information We Collect".appCommonText(
                color: blackColor,
                weight: FontWeight.bold,
                align: TextAlign.start),
            20.h.H(),
            "Depending on the nature of your interaction with Hotlines, we may collect the following personal information:"
                .lightText(),
            20.h.H(),
            "Contact information and any other information you choose to include when you communicate with us via email or other channels. "
                .lightText(),
            "Survey information in response to questions we may send you through the Services, including for feedback and research purposes."
                .lightText(),
            20.h.H(),
            "Survey information in response to questions we may send you through the Services, including for feedback and research purposes."
                .lightText(),
            20.h.H(),
            "Cookies and Information Collected by Other Automated Means"
                .appCommonText(
                    color: blackColor,
                    weight: FontWeight.bold,
                    align: TextAlign.start),
            20.h.H(),
            "When you interact with our Services, certain information about your use of the Services is automatically collected via cookies. Cookies are small text files that are stored within your device’s memory by a website or application that you visit. We use cookies for functionality, security and fraud prevention, and to remember your preferences (e.g. language). In doing so, these cookies collect the following information: "
                .lightText(),
            20.h.H(),
            "Usage details about your interaction with our Services, such as the date, time, and length of visits, specific pages or content accessed during the visits, and referring website addresses"
                .lightText(),
            20.h.H(),
            'Device information including the IP address and other details of the device that you use to connect to our Services, such as device type and unique device identifier, operating system, and browser type. '
                .lightText(),
            20.h.H(),
            "Location information where you choose to provide access to information about your device’s location."
                .lightText(),
            20.h.H(),
            "You can reject certain cookies as described in Your Privacy Options below."
                .lightText(),
            20.h.H(),
            "How We Use Your Personal Information".appCommonText(
                color: blackColor,
                weight: FontWeight.bold,
                align: TextAlign.start),
            20.h.H(),
            "We share personal information we collect:".lightText(),
            20.h.H(),
            "With service providers that we believe need the information to perform a technology, business, or other professional function for us such as IT services, maintenance and hosting of our Services, and professional advisors."
                .lightText(),
            20.h.H(),
            "In the event of a corporate event, we reserve the right to transfer to another entity or its affiliates or service providers some or all information about you in connection with, or during negotiations of, any merger, acquisition, sale of assets or any line of business, change in ownership control, or financing transaction. We cannot promise that an acquiring party or the merged entity will have the same privacy practices or treat your information the same as described in this Privacy Notice."
                .lightText(),
            20.h.H(),
            "For legal purposes where necessary to comply with applicable law, to respond to requests from law enforcement agencies or other government authorities or third parties, as permitted by law and without your consent when it is necessary to protect you, Hotlines, or our property, in emergency situations, or to enforce our rights."
                .lightText(),
            20.h.H(),
            "How We Protect and Store Your Personal Information".appCommonText(
                color: blackColor,
                weight: FontWeight.bold,
                align: TextAlign.start),
            20.h.H(),
            "We retain your information until we no longer need the information for the purposes for which it was collected, or as may be required by law. We use a combination of physical, technical, and administrative safeguards to protect the information we collect through the Services. While we use these precautions to safeguard your information, we cannot guarantee the security of the networks, systems, servers, devices, and databases we operate or that are operated on our behalf. If you use our Services outside of the United States, you understand that we may collect, process, and store your personal information in the United States and other countries ."
                .lightText(),
            20.h.H(),
            "Your Privacy Options".appCommonText(
                color: blackColor,
                weight: FontWeight.bold,
                align: TextAlign.start),
            20.h.H(),
            "You may have certain choices when it comes to how we collect and use your personal information:"
                .lightText(),
            20.h.H(),
            "Cookies: You may modify your browser setting to disable or reject cookies; but if you do so, some features of our Services may not function properly or be available. While your browser or device may include “Do Not Track” functionality, please note that we do not respond to such signals."
                .lightText(),
            20.h.H(),
            "Marketing communications: If at any time you no longer wish to receive promotional email communications from us, you can click the unsubscribe link at the bottom of any email."
                .lightText(),
            20.h.H(),
            "Updates to This Privacy Notice".appCommonText(
                color: blackColor,
                weight: FontWeight.bold,
                align: TextAlign.start),
            20.h.H(),
            "We may make changes to this Privacy Notice from time to time. The Effective Date at the top of this page indicates when this Privacy Notice was last revised. We may also notify you in other ways from time to time about the collection, use, and disclosure of your personal information described in this Privacy Notice."
                .lightText(),
            20.h.H(),
          ],
        ).paddingSymmetric(horizontal: 20.h, vertical: 30.h),
      ),
    );
  }
}
