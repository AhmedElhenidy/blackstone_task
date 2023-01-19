import 'package:blackstone_task/app/error/exceptions.dart';

import '../../model/currency_model.dart';

abstract class CurrencyConverterLocalDataSource {

  /// cache the currencies list.
  ///
  /// Throws a [CacheException] for all error codes.

  Future<bool> cacheCurrencies(List<CurrencyModel> currencies);

  /// get the cached currencies list.
  ///
  /// Throws a [CacheException] for all error codes.
  Future<List<CurrencyModel>?> listCachedCurrencies();


}