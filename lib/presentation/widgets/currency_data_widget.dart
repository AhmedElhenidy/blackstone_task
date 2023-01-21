
import 'package:blackstone_task/presentation/widgets/custom_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../app/utils/app_colors.dart';
import '../../data/model/currency_model.dart';


class CurrencyDataWidget extends StatefulWidget {
  final CurrencyModel dataCurrencyModel;
  const CurrencyDataWidget({Key? key,required this.dataCurrencyModel})
      : super(key: key);

  @override
  State<CurrencyDataWidget> createState() => _CurrencyDataWidgetState();
}

class _CurrencyDataWidgetState extends State<CurrencyDataWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 2,
            color: grey333333,
          )
        )
      ),
      child: Row(
        children: [
          CustomImageWidget(
            imageUrl: "https://flagcdn.com/16x12/${widget.dataCurrencyModel.currency?.code?.toLowerCase()}.png",
            width: 16,
            height: 16,
            color: Colors.white,
          ),
          SizedBox(width: 8,),
          Expanded(
            child: Text(
              "${widget.dataCurrencyModel.currency?.name??""}\t${widget.dataCurrencyModel.currency?.name??""}"
             ,
              style: TextStyle(
                color: white,
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
              ),
            ),
          ),

          Container(
            width: 2.w,
            height: 24.h,
            color: grey333333,
            margin: EdgeInsets.symmetric(horizontal: 16),
          ),

          Text(
            widget.dataCurrencyModel.code??"",
            style: TextStyle(
              color: white,
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
