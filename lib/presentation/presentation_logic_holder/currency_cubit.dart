import 'package:blackstone_task/app/usecase/usecase.dart';
import 'package:blackstone_task/domain/usecase/list_all_currencies_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/utils/app_colors.dart';
import '../../app/utils/get_it_injection.dart';
import '../../app/utils/navigation_helper.dart';
import '../../data/model/currency_model.dart';
import '../../data/model/historical_data_model.dart';
import '../../domain/usecase/convert_currency_usecase.dart';
import '../../domain/usecase/get_historical_data_usecase.dart';
import '../views/main_view.dart';
import '../widgets/custom_alert_dialog.dart';

part 'currency_state.dart';

class CurrencyCubit extends Cubit<CurrencyState> {
  CurrencyCubit() : super(CurrencyInitial());
  static CurrencyCubit get() => BlocProvider.of(getIt<NavHelper>().navigatorKey.currentContext!);
  CurrencyModel? baseCurrencyModel;
  CurrencyModel? currencyModel;
  List<CurrencyModel> currenciesList = [];
  List<HistoricalDataModel> historicalDataModel = [];
  double rate= 0;

  void listAllCurrencies()async{
      emit(CurrencyLoading());
      final response =  await getIt<ListSupportedCurrencyUseCase>()(NoParams());
      response.fold(
              (l) {
            globalAlertDialogue(l.cause??"unknown error",
              iconData: Icons.error_outline,
              iconDataColor: red,
            );
            emit(CurrencyError(l.cause??""));
          } ,
              (r) {
                currenciesList = r;
            emit(CurrencyInitial());
          }
      );
  }

  void convert()async{
    if(validate()){
      emit(CurrencyLoading());
      final response =  await getIt<ConvertCurrencyUseCase>()(
        ConvertCurrencyUseCaseParams(
          baseCurrency: baseCurrencyModel!.code!,
          currency: currencyModel!.code!,
        ),
      );
      response.fold(
              (l) {
            globalAlertDialogue(l.cause??"unknown error",
              iconData: Icons.error_outline,
              iconDataColor: red,
            );
            emit(CurrencyError(l.cause??""));
          } ,
              (r) {
                rate =r.rate??0;
            emit(CurrencyInitial());
          }
      );
    }

  }

  void getHistoricalData()async{
    if(validate()){
      historicalDataDraggableBottomSheet();
      emit(HistoricalLoading());
      final response =  await getIt<GetHistoricalDataUseCase>()(
        GetHistoricalDataUseCaseParams(
          baseCurrency: baseCurrencyModel!.code!,
          currency: currencyModel!.code!,
          days: 7,
        ),
      );
      response.fold(
              (l) {
            globalAlertDialogue(l.cause??"unknown error",
              iconData: Icons.error_outline,
              iconDataColor: red,
            );
            emit(CurrencyError(l.cause??""));
          } ,
              (r) {
                historicalDataModel =r;
            emit(CurrencyInitial());
          }
      );
    }

  }
  bool validate(){
    if(baseCurrencyModel==null){
      globalAlertDialogue("please select your base currency");
      return false;
    }else if(currencyModel==null) {
      globalAlertDialogue("please select currency to convert to");
      return false;
    }else{
      return true;
    }
  }
}
