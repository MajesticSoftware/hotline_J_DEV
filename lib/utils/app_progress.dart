import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/app_color.dart';

class AppProgress extends StatelessWidget {
  const AppProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: Get.height,
        color: whiteColor.withOpacity(0.3),
        child: Center(
            child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor)));
  }
}
