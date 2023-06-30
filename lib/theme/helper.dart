import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotlines/theme/theme.dart';
import 'package:hotlines/utils/extension.dart';
import 'package:shimmer/shimmer.dart';

import '../controller/selecte_game_con.dart';

showAppSnackBar(String tittle, BuildContext context, {bool status = false}) {
  return Get.showSnackbar(GetSnackBar(
    // message: tittle,
    messageText: tittle.appCommonText(
        size: 14,
        color: Theme.of(context).highlightColor,
        align: TextAlign.start,
        weight: FontWeight.w600),
    // messageText: tittle.wallyText(fontSize: 24, fontWeight: wallyLightWeight, color: color),
    borderRadius: 15,
    snackPosition: SnackPosition.BOTTOM,
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    shouldIconPulse: false,
    icon: Icon(
      status ? Icons.check_circle_outline_rounded : Icons.error_outline,
      color: Theme.of(context).highlightColor,
    ),
    backgroundColor: Theme.of(context).backgroundColor,
    duration: const Duration(seconds: 3),
  ));
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
                    color: dividerColor.withOpacity(0.5),
                  ),
                ),
            errorWidget: (context, url, error) => ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                    height: height,
                    width: width,
                    color: dividerColor.withOpacity(0.6),
                  ),
                ))),
  );
}
