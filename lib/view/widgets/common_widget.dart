import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotlines/theme/theme.dart';
import 'package:hotlines/utils/extension.dart';

class CommonAppButton extends StatelessWidget {
  const CommonAppButton({Key? key, required this.onTap, required this.title})
      : super(key: key);
  final Function() onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: yellowColor, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: title.appCommonText(
            color: whiteColor,
            size: 25.h,
            weight: FontWeight.w700,
            align: TextAlign.end,
          ),
        ),
      ),
    );
  }
}
