import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../generated/assets.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      body: Column(
        children: [
          SvgPicture.asset(
            Assets.imagesSplashImage,
            width: Get.width,
            height: Get.height,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
