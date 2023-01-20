import '../../../app/network/network_manager.dart';
import '../../../app/utils/consts.dart';
import '../../../app/utils/remote_data_source_handler.dart';
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
  Future<List<HistoricalDataModel>> getHistoricalData(Map<String,dynamic> map);

  /// Calls the [GET] {/api/v7/convert?q=USD_PHP,PHP_USD&compact=ultra&apiKey=[YOUR_API_KEY]} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<ConversionResponseModel> convert(Map<String,dynamic> map);

}
// https://api.freecurrencyapi.com/v1/latest?apikey=N8na7dQL8kt7phAWoSS4brbPX97Ubjo9ydW8JyMN&currencies=EUR%2CUSD%2CCAD

class CurrencyConverterRemoteDataSourceImpl extends CurrencyConverterRemoteDataSource {
  final NetworkManager networkManager;

  CurrencyConverterRemoteDataSourceImpl({required this.networkManager});

  @override
  Future<ConversionResponseModel> convert(Map<String, dynamic> map)async {
    final res = await networkManager.request(
        method: RequestMethod.get,
        endPoint: kLatest,
        queryParameters: map
    );
    final data = await RemoteDataSourceCallHandler()(res);
    return ConversionResponseModel(data.entries.first.value as double);
  }

  @override
  Future<List<HistoricalDataModel>> getHistoricalData(Map<String, dynamic> map) async {
    final res = await networkManager.request(
      method: RequestMethod.get,
      endPoint: kHistorical,
      queryParameters: map
    );
    final data = await RemoteDataSourceCallHandler()(res);
    return data.entries.map((e) =>HistoricalDataModel.fromMap(e.value as Map<String,dynamic>, e.key)).toList();
  }

  @override
  Future<List<CurrencyModel>> listAllCurrencies()async {
    final res = await networkManager.request(
      method: RequestMethod.get,
      endPoint: kListAllCurrencies,
    );
    final data =  await RemoteDataSourceCallHandler()(res);
    return data.entries.map((e) => CurrencyModel.fromJson(e.value as Map<String,dynamic>, e.key)).toList();
  }

}