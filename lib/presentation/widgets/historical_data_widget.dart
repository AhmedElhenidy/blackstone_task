import 'package:blackstone_task/presentation/presentation_logic_holder/currency_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../app/utils/app_colors.dart';
import '../../data/model/historical_data_model.dart';
import 'loading_widget.dart';


class HistoricalDataWidget extends StatelessWidget {
  final HistoricalDataModel dataModel;

  const HistoricalDataWidget({required this.dataModel, super.key});

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
      child:  Row(
        children: [
          Expanded(
            child: Text(
              "${dataModel.historicalData?.rate??"null rete"}",
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
            dataModel.date?? "",
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
