import '../../model/conversion_response_model.dart';
import '../../model/currency_model.dart';
import '../../model/historical_data_model.dart';

abstract class CurrencyConverterRemoteDataSource {

  /// Calls the [GET] {/api/v7/currencies?apiKey=[YOUR_API_KEY]} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<CurrencyModel>> listAllCurrencies();

  /// Calls the [GET] {/api/v7/convert?q=USD_PHP,PHP_USD&compact=ultra&date=[yyyy-mm-dd]&endDate=[yyyy-mm-dd]&apiKey=[YOUR_API_KEY]} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<HistoricalDataModel> getHistoricalData(Map<String,dynamic> map);

  /// Calls the [GET] {/api/v7/convert?q=USD_PHP,PHP_USD&compact=ultra&apiKey=[YOUR_API_KEY]} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<ConversionResponseModel> convert(Map<String,dynamic> map);

}