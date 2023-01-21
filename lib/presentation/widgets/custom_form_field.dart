import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/utils/app_colors.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hint;
  final double? width;
  final double? height;
  final bool? obscure;
  final String? labelText;
  final IconData? suffixIcon;
  final Widget? suffixIconWidget;
  final IconData? prefixIcon;
  final Widget? prefixIconWidget;
  final Color? labelColor;
  final Function(String)? onChange;
  final Function()? iconPressed;
  final GestureTapCallback? onPressed;
  final bool? enabled;
  final TextAlign? align;
  final FocusNode? focusNode;
  final int? maxLines;
  final int? minLines;
  final Color? color;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String? value)? validator;
  CustomFormField(
      {super.key,
        this.controller,
        this.hint = "",
        this.width,
        this.height,
        this.obscure = false,
        this.labelText,
        this.suffixIcon,
        this.suffixIconWidget,
        this.enabled = true,
        this.labelColor,
        this.onPressed,
        this.align,
        this.prefixIcon,
        this.prefixIconWidget,
        this.focusNode,
        this.maxLines,
        this.minLines,
        this.iconPressed,
        this.color,
        this.onChange,
      this.keyboardType,
      this.textInputAction,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height ?? 64,
        width: width ?? (MediaQuery.of(context).size.width - 48),
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(12),
        //   color: color??AppColors.white,
        // ),
        child: Center(
          child: TextFormField(
            validator: validator,
            textInputAction: textInputAction,
            controller: controller,
            minLines: minLines ?? 1,
            maxLines: maxLines ?? 1,
            enabled: enabled,
            keyboardType: keyboardType,
            focusNode: focusNode,
            onChanged: onChange,
            obscureText: obscure??false,
            textAlign: align ?? TextAlign.start,
            style: TextStyle(
              height: 1.2.h
            ),
            decoration: InputDecoration(
              errorStyle: TextStyle(
                fontSize: 11.sp,
                height: 0.2.h,
              ),
              enabledBorder:  const UnderlineInputBorder(
                borderSide: BorderSide(color: grey333333),
              ),
              focusedBorder:  const UnderlineInputBorder(
                borderSide: BorderSide(color: grey333333),
              ),
              hintText: hint ?? "",
              labelText: labelText,
              labelStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color:greyBDBDBD,
              ),
              suffixIcon: suffixIconWidget == null
                  ? (suffixIcon == null
                  ? null
                  : InkWell(
                  onTap: iconPressed ?? () {},
                  child: Icon(
                    suffixIcon,
                    size: 18,
                    color: greyBDBDBD,
                  )))
                  : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  suffixIconWidget!,
                ],
              ),
              prefixIcon: prefixIconWidget == null
                  ? (prefixIcon == null
                  ? null
                  : Icon(
                prefixIcon,
                size: 18,
                color: Colors.grey,
              ))
                  : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  prefixIconWidget!,
                ],
              ),

            ),
          ),
        ),
      ),
    );
  }
}