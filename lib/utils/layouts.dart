import 'package:flutter/material.dart';
import 'package:get/get.dart';

commonImageWidget(String image, {void Function()? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Image.asset(
        image,
        width: Get.width * .29,
        fit: BoxFit.contain,
      ),
    ),
  );
}
