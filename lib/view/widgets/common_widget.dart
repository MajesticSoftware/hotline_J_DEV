import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotlines/theme/theme.dart';
import 'package:hotlines/utils/extension.dart';

class CommonAppButton extends StatelessWidget {
  const CommonAppButton(
      {Key? key,
      required this.onTap,
      required this.title,
      this.radius,
      this.buttonColor,
      this.textColor,
      this.icon})
      : super(key: key);
  final Function() onTap;
  final String title;
  final double? radius;
  final Color? buttonColor;
  final Color? textColor;
  final Widget? icon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height * .05,
        decoration: BoxDecoration(
            color: buttonColor ?? yellowColor,
            borderRadius: BorderRadius.circular(radius ?? 10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon ?? const SizedBox(),
            title.appCommonText(
              color: textColor ?? appColor,
              size: MediaQuery.of(context).size.height * .02,
              weight: FontWeight.w700,
              align: TextAlign.end,
            ),
          ],
        ),
      ),
    );
  }
}
