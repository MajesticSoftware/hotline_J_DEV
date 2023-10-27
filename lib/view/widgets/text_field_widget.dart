import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotlines/theme/app_color.dart';

import '../../utils/extension.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField(
      {Key? key,
      this.controller,
      this.hintText = '',
      this.validation,
      this.onChange,
      this.inputFormatters,
      this.keyboardType,
      this.suffixIcon})
      : super(key: key);
  final TextEditingController? controller;
  final String hintText;
  final bool isPasswordField = false;
  final bool obscureText = false;
  final int maxLine = 1;
  final num hintTextSize = 16;
  final double height = 50;
  final Color fillColor = whiteColor;
  final String? Function(String?)? validation;
  final void Function(String)? onChange;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final bool readOnly = false;
  final Widget? suffixIcon;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextFormField(
        readOnly: readOnly,
        onChanged: onChange,
        validator: validation,
        controller: controller ?? TextEditingController(),
        maxLines: maxLine,
        autofocus: false,
        style: GoogleFonts.nunitoSans(
          fontSize: 16,
          color: appColor,
          fontWeight: FontWeight.w500,
        ),
        inputFormatters: inputFormatters,
        obscureText: obscureText,
        textInputAction: TextInputAction.done,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          enabled: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          hintStyle: hintTextStyle(
              size: hintTextSize, weight: FontWeight.w500, color: greyColor),
          suffixIcon: isPasswordField
              ? suffixIcon ?? const SizedBox()
              : const SizedBox(),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: whiteColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: appColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: whiteColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: fillColor,
        ),
      ),
    );
  }
}
