
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/utils/app_colors.dart';
import '../../app/utils/helper.dart';
import 'loading_widget.dart';


class CustomButton extends StatelessWidget {
  final String? text ;
  final Function()? onPressed ;
  final double? width ;
  final double? height ;
  final double? textSize ;
  final BoxDecoration? decoration;
  final Color? textColor ;
  final bool loading ;
  final Color? background ;
  final Border? border ;
  final Widget? icon ;
  final double? borderRadius;
  final BorderRadius? borderRadiusObject ;
  final Widget? child ;

  const CustomButton({super.key, this.borderRadius,this.borderRadiusObject,this.textSize = 16,this.text, this.icon, this.background , this.border,this.onPressed, this.width, this.height ,this.decoration ,this.textColor,this.loading =false,this.child });

  @override
  Widget build(BuildContext context) {
    return loading ? const Loading():InkWell(
      onTap: (){
        hideKeyboard(context);
        if(onPressed!= null ){
          onPressed!();
        }

      },
      child: Container(
         width: width,
          height: height ?? 48.h,
          decoration: decoration ?? BoxDecoration(
              color: background ?? orangeMain,
              borderRadius:borderRadiusObject ??BorderRadius.circular(borderRadius ?? 8),
              border:  border
          ),
          child:child??Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon??Container(),
              icon!= null && (text?.isNotEmpty??false) ? const SizedBox(width: 8,) : Container(),
              Text(
                text??"" ,
                style: TextStyle(
                    color: textColor??white ,
                    fontSize: textSize??16.sp ,
                    fontWeight: FontWeight.w600,
                    // fontFamily: AppFontsWeight.regular
                ),
              ),
            ],
          ),
      ),
    );
  }
}