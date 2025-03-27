import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/app_color.dart';

class AppProgress extends StatelessWidget {
  const AppProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
      child: Container(
          width: double.infinity,
          height: Get.height,
          color: blackColor.withOpacity(0.4),
          child: Center(
              child: CircularProgressIndicator(
                  color: Theme
                      .of(context)
                      .secondaryHeaderColor))),
    );
  }
}

class PaginationProgress extends StatelessWidget {
  const PaginationProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              color: Theme
                  .of(context)
                  .primaryColor,
            )),
      ),
    );
  }
}
