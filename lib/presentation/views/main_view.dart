import 'package:blackstone_task/presentation/widgets/custom_image_widget.dart';
import 'package:blackstone_task/presentation/widgets/loading_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

import '../../app/utils/app_assets.dart';
import '../../app/utils/app_colors.dart';
import '../../app/utils/consts.dart';
import '../../app/utils/get_it_injection.dart';
import '../../app/utils/navigation_helper.dart';
import '../../data/model/currency_model.dart';
import '../presentation_logic_holder/currency_cubit.dart';
import '../widgets/currency_data_widget.dart';
import '../widgets/custom_button.dart';
import '../widgets/historical_data_widget.dart';

class CurrencyView extends StatefulWidget {
  @override
  State<CurrencyView> createState() => _CurrencyViewState();
}

class _CurrencyViewState extends State<CurrencyView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CurrencyCubit.get().listAllCurrencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2e2c53),
      body: BlocBuilder<CurrencyCubit, CurrencyState>(
        builder: (context, state) {
          return state is CurrencyLoading
              ? const Center(
                  child: Loading(),
                )
              : ListView(
                  padding:
                      const EdgeInsets.symmetric(vertical: 32, horizontal: 32),
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    SizedBox(
                      height: 188.h,
                      child: Stack(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // transfer inputs
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.w, vertical: 16.h),
                                height: 88.h,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: orangeMain,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        showDraggableBottomSheet(context,
                                            onTap: (currency) {
                                          CurrencyCubit.get()
                                              .baseCurrencyModel = currency;
                                          setState(() {});
                                        });
                                      },
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            CurrencyCubit.get()
                                                    .baseCurrencyModel
                                                    ?.currency
                                                    ?.name ??
                                                "select base currency",
                                          ),
                                          SizedBox(
                                            width: 16.w,
                                          ),
                                          Icon(
                                            Icons.keyboard_arrow_down_outlined,
                                            size: 30.sp,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      "1\t${CurrencyCubit.get().baseCurrencyModel?.currency?.symbol ?? ""}",
                                      style: TextStyle(
                                        color: white,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              //transfer value
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.w, vertical: 16.h),
                                height: 88.h,
                                decoration: BoxDecoration(
                                  color: greenMain,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        showDraggableBottomSheet(context,
                                            onTap: (currency) {
                                          CurrencyCubit.get().currencyModel =
                                              currency;
                                          setState(() {});
                                        });
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                CurrencyCubit.get()
                                                        .currencyModel
                                                        ?.currency
                                                        ?.name ??
                                                    "select currency",
                                              ),
                                              SizedBox(
                                                width: 16.w,
                                              ),
                                              Icon(
                                                Icons
                                                    .keyboard_arrow_down_outlined,
                                                size: 30.sp,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      CurrencyCubit.get().rate.toString(),
                                      style: TextStyle(
                                        color: white,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Center(
                            child: Container(
                              width: 64.w,
                              height: 64.h,
                              decoration: BoxDecoration(
                                  color: white,
                                  border: Border.all(
                                    color: backGround,
                                    width: 5,
                                  ),
                                  shape: BoxShape.circle),
                              child: Transform.rotate(
                                angle: 99,
                                child: Icon(
                                  Icons.repeat,
                                  color: backGround,
                                  size: 32.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    //convert
                    CustomButton(
                      height: 60.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomImageWidget(
                            imageUrl: kSendImg,
                            width: 24.w,
                            height: 24.h,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            kConvert.tr(),
                            style: TextStyle(
                                height: 1.2,
                                fontSize: 16.sp,
                                color: white,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      onPressed: () {
                        CurrencyCubit.get().convert();
                      },
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    //historical
                    CustomButton(
                      height: 60.h,
                      onPressed: () {
                        CurrencyCubit.get().getHistoricalData();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.history_outlined,
                            size: 28.sp,
                            color: white,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            kHistoricalData.tr(),
                            style: TextStyle(
                                height: 1.2,
                                fontSize: 16.sp,
                                color: white,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    const Divider(
                      color: grey333333,
                      thickness: 2,
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                  ],
                );
        },
      ),
    );
  }

  showDraggableBottomSheet(BuildContext context,
      {required Function(CurrencyModel currency) onTap}) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      enableDrag: true,
      context: context,
      builder: (_) {
        return DraggableScrollableSheet(
          initialChildSize: 0.9,
          minChildSize: 0.2,
          maxChildSize: 1,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              padding: const EdgeInsets.only(
                top: 16,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: backGround,
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                controller: scrollController,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          kChooseCurrencyExchangeTxt.tr(),
                          style: TextStyle(
                            color: white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    ...List<Widget>.generate(
                      CurrencyCubit.get().currenciesList.length,
                      (index) {
                        return InkWell(
                          onTap: () {
                            onTap(CurrencyCubit.get().currenciesList[index]);
                            Navigator.pop(context);
                          },
                          child: CurrencyDataWidget(
                            dataCurrencyModel:
                                CurrencyCubit.get().currenciesList[index],
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

historicalDataDraggableBottomSheet() {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    enableDrag: true,
    context: getIt<NavHelper>().navigatorKey.currentState!.context,
    builder: (_) {
      return DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.2,
        maxChildSize: 1,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            padding: const EdgeInsets.only(
              top: 16,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: backGround,
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              controller: scrollController,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Historical Data for Last 7 days",
                        style: TextStyle(
                          color: white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  BlocBuilder<CurrencyCubit, CurrencyState>(
                    builder: (context, state) {
                      return state is HistoricalLoading
                          ?
                      const Center(
                        child: Loading(),
                      )
                          :
                      Column(
                        children: List<Widget>.generate(
                          CurrencyCubit.get().historicalDataModel.length,
                          (index) {
                            return InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: HistoricalDataWidget(
                                dataModel: CurrencyCubit.get()
                                    .historicalDataModel[index],
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
