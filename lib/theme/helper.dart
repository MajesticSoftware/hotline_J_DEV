import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotlines/theme/theme.dart';
import 'package:hotlines/utils/extension.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

showAppSnackBar(String tittle, {bool status = false}) {
  return Get.showSnackbar(GetSnackBar(
    // message: tittle,
    messageText: tittle.appCommonText(
        size: 14,
        color: Theme.of(Get.context!).secondaryHeaderColor,
        align: TextAlign.start,
        weight: FontWeight.w600),
    // messageText: tittle.wallyText(fontSize: 24, fontWeight: wallyLightWeight, color: color),
    borderRadius: 15,
    snackPosition: SnackPosition.BOTTOM,
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    shouldIconPulse: false,
    icon: Icon(
      status ? Icons.check_circle_outline_rounded : Icons.error_outline,
      color: Theme.of(Get.context!).secondaryHeaderColor,
    ),
    backgroundColor: whiteColor,
    duration: const Duration(seconds: 3),
  ));
}

TextSpan linkTextWidget(BuildContext context,
    {String link = '', String text = '',Color? color}) {
  return TextSpan(
    recognizer: TapGestureRecognizer()
      ..onTap = () => launchInBrowser(Uri.parse(link)),
    text: text,
    style: GoogleFonts.nunitoSans(
        color:color?? Theme.of(context).highlightColor,
        fontWeight: FontWeight.bold,
        fontSize: Get.height * .016,
        decoration: TextDecoration.underline),
  );
}

TextSpan textSpanUnBoldText(int index, BuildContext context,
    {String text = ''}) {
  return TextSpan(
    text: text,
    style: GoogleFonts.nunitoSans(
      color: Theme.of(context).dividerColor,
      fontWeight: FontWeight.w400,
      fontSize: Get.height * .016,
    ),
  );
}

TextSpan textSpanCommonWidget(BuildContext context, {String title = ''}) {
  return TextSpan(
    text: title,
    style: GoogleFonts.nunitoSans(
      color: Theme.of(context).dividerColor,
      fontWeight: FontWeight.bold,
      fontSize: Get.height * .016,
    ),
  );
}

Future<void> launchInBrowser(Uri url) async {
  if (!await launchUrl(
    url,
  )) {
    throw Exception('Could not launch $url');
  }
}

SizedBox commonCachedNetworkImage(
    {required String imageUrl,
    required double height,
    required double width,
    ColorFilter? colorFilter}) {
  return SizedBox(
    height: height,
    width: width,
    child: ClipRRect(
        borderRadius: BorderRadius.circular(1000),
        child: CachedNetworkImage(
            imageUrl: imageUrl,
            imageBuilder: (context, imageProvider) => Container(
                  height: height,
                  width: width,
                  decoration: BoxDecoration(
                    color: backGroundColor,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
            placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: greyColor.withOpacity(0.3),
                  highlightColor: greyColor.withOpacity(0.2),
                  enabled: true,
                  child: Container(
                    height: height,
                    width: width,
                    color: backGroundColor,
                  ),
                ),
            errorWidget: (context, url, error) => ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                    height: height,
                    width: width,
                    color: backGroundColor,
                  ),
                ))),
  );
}
