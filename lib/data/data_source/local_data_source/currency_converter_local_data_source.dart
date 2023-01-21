import 'dart:convert';

import 'package:blackstone_task/app/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/utils/get_it_injection.dart';
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

class CurrencyConverterLocalDataSourceImpl extends CurrencyConverterLocalDataSource {
  @override
  Future<bool> cacheCurrencies(List<CurrencyModel> currencies)async {
    Map<String,dynamic> local = {};
    currencies.forEach((element) {local.addAll(element.toJson());});
    print (json.encode(local));
    await getIt<SharedPreferences>().setString("currencies", json.encode(local));
    return true;
  }

  @override
  Future<List<CurrencyModel>?> listCachedCurrencies()async {
    String? cache = getIt<SharedPreferences>().getString("currencies");
    if(cache==null){
      return null;
    }else{
      final data = json.decode(cache) as Map<String,dynamic>;
      return data.entries.map((e) => CurrencyModel.fromJson(e.value as Map<String,dynamic>, e.key)).toList();
    }
  }
}