import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hotlines/utils/app_progress.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../generated/assets.dart';

class ContactScreen extends StatefulWidget {
  ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  late final WebViewController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadRequest(Uri.parse('https://www.hotlinesmd.com/contact'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: commonAppBar(context),
        body: WebViewWidget(controller: controller));
  }

  PreferredSize commonAppBar(BuildContext context) {
    return PreferredSize(
        preferredSize: Size.fromHeight(125.w),
        child: AnimatedContainer(
          alignment: Alignment.bottomCenter,
          color: Theme.of(context).secondaryHeaderColor,
          duration: const Duration(milliseconds: 500),
          child: Padding(
            padding: EdgeInsets.only(bottom: 27.w, left: 24.w, right: 24.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: SvgPicture.asset(
                    Assets.imagesBackArrow,
                    height: 30.w,
                    alignment: Alignment.centerLeft,
                  ),
                ),
                SvgPicture.asset(Assets.imagesLogo,
                    height: 34.w, fit: BoxFit.contain),
                SvgPicture.asset(
                  Assets.imagesBackArrow,
                  height: 30.w,
                  color: Colors.transparent,
                  alignment: Alignment.centerLeft,
                ),
              ],
            ),
          ),
        ));
  }
}
