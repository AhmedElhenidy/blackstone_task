import 'package:blackstone_task/data/model/historical_data_model.dart';
import 'package:dartz/dartz.dart';

import '../../app/error/failures.dart';
import '../../data/model/currency_model.dart';

abstract class CurrencyConverterRepo{
  Future<Either<Failure, List<CurrencyModel>>> listAllCurrencies();
  Future<Either<Failure, HistoricalDataModel>> getHistoricalData(Map<String,dynamic> map);
}