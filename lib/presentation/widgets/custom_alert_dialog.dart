
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/utils/app_colors.dart';
import '../../app/utils/get_it_injection.dart';
import '../../app/utils/navigation_helper.dart';
import 'custom_button.dart';

globalAlertDialogue(String title1,
    {
      String? title2,
      VoidCallback? onCancel,
      VoidCallback? onOk,
      String ?buttonText,
      String ?buttonText2,
      IconData? iconData,
      Color? iconDataColor,
    }) {
  showDialog(
    context: getIt<NavHelper>().navigatorKey.currentState!.context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return  SizedBox(
        height: 250,
        width: 400.w,
        child: AlertDialog(
          contentPadding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 16),
          insetPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          alignment: Alignment.center,
          title: Center(
            child: Icon(
              iconData??Icons.check_circle,
              color: iconDataColor??green,
              size: 46,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title1,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: blue,
                    fontSize: 20.sp,
                ),
              ),
              title2==null?const SizedBox():Text(
                title2??"",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: green,
                    fontSize: 18.sp,
                ),
              ),
              const SizedBox(height: 24,),
              CustomButton(
                onPressed: onOk?? () {
                      Navigator.pop(context);
                    },
                child: Center(
                  child: Text(
                    "Ok",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: white,
                      fontSize: 18.sp
                    ),
              ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
