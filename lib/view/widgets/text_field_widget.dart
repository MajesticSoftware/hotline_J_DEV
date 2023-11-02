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
      this.suffixIcon,
      this.height,
      this.hintTextSize,
      this.obscureText,
      this.readOnly,
      this.isPasswordField})
      : super(key: key);
  final TextEditingController? controller;
  final String hintText;
  final bool? isPasswordField;
  final bool? obscureText;
  final int maxLine = 1;
  final num? hintTextSize;
  final double? height;
  final Color fillColor = whiteColor;
  final String? Function(String?)? validation;
  final void Function(String)? onChange;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final Widget? suffixIcon;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? MediaQuery.sizeOf(context).height * .05,
      child: TextFormField(
        readOnly: readOnly ?? false,
        onChanged: onChange,
        validator: validation,
        controller: controller ?? TextEditingController(),
        maxLines: maxLine,
        autofocus: false,
        style: GoogleFonts.nunitoSans(
          fontSize: MediaQuery.of(context).size.height * .018,
          color: Theme.of(context).secondaryHeaderColor,
          fontWeight: FontWeight.w700,
        ),
        inputFormatters: inputFormatters,
        obscureText: obscureText ?? false,
        textInputAction: TextInputAction.done,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          enabled: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          hintStyle: hintTextStyle(
              size: hintTextSize ?? MediaQuery.of(context).size.height * .018,
              weight: FontWeight.w500,
              color: Theme.of(context).secondaryHeaderColor),
          suffixIcon: isPasswordField ?? false
              ? suffixIcon ?? const SizedBox()
              : const SizedBox(),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: whiteColor,
              width: 0,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: appColor,
              width: 0,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
              width: 0,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: whiteColor,
              width: 0,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          filled: true,
          fillColor: fillColor,
        ),
      ),
    );
  }
}
