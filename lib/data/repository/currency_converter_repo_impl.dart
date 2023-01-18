import 'package:blackstone_task/app/error/failures.dart';
import 'package:blackstone_task/data/data_source/remote_data_source/currency_converter_remote_data_source.dart';
import 'package:blackstone_task/data/model/conversion_response_model.dart';
import 'package:blackstone_task/data/model/currency_model.dart';
import 'package:blackstone_task/data/model/historical_data_model.dart';
import 'package:blackstone_task/domain/repository/currency_converter_repo.dart';
import 'package:dartz/dartz.dart';

import '../../app/network/network_info.dart';
import '../data_source/local_data_source/currency_converter_local_data_source.dart';

class  CurrencyConverterRepoImpl extends CurrencyConverterRepo{

  final CurrencyConverterRemoteDataSource remoteDataSource;
  final CurrencyConverterLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  CurrencyConverterRepoImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, bool>> cacheCurrencies(List<CurrencyModel> currencies) {
    // TODO: implement cacheCurrencies
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ConversionResponseModel>> convert(Map<String, dynamic> map) {
    // TODO: implement convert
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, HistoricalDataModel>> getHistoricalData(Map<String, dynamic> map) {
    // TODO: implement getHistoricalData
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<CurrencyModel>>> listAllCurrencies() {
    // TODO: implement listAllCurrencies
    throw UnimplementedError();
  }
}