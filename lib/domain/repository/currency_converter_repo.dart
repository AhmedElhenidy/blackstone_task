import 'package:dartz/dartz.dart';

import '../../app/error/failures.dart';
import '../../data/model/currency_model.dart';

abstract class CurrencyConverterRepo{
  Future<Either<Failure, List<CurrencyModel>>> listAllCurrencies();
}