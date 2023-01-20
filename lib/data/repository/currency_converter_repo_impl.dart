import 'package:blackstone_task/app/error/failures.dart';
import 'package:blackstone_task/data/data_source/remote_data_source/currency_converter_remote_data_source.dart';
import 'package:blackstone_task/data/model/conversion_response_model.dart';
import 'package:blackstone_task/data/model/currency_model.dart';
import 'package:blackstone_task/data/model/historical_data_model.dart';
import 'package:blackstone_task/domain/repository/currency_converter_repo.dart';
import 'package:dartz/dartz.dart';

import '../../app/error/exceptions.dart';
import '../../app/network/network_info.dart';
import '../../app/utils/repo_impl_callhandler.dart';
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

  // @override
  // Future<Either<Failure, bool>> cacheCurrencies(List<CurrencyModel> currencies)async {
  //   return await RepoImplCallHandler<bool>(networkInfo)(() async {
  //     return await localDataSource.cacheCurrencies(currencies);
  //   });
  // }

  @override
  Future<Either<Failure, ConversionResponseModel>> convert(Map<String, dynamic> map)async {
    return await RepoImplCallHandler<ConversionResponseModel>(networkInfo)(() async {
      return await remoteDataSource.convert(map);
    });
  }

  @override
  Future<Either<Failure, List<HistoricalDataModel>>> getHistoricalData(Map<String, dynamic> map) async{
    return await RepoImplCallHandler<List<HistoricalDataModel>>(networkInfo)(() async {
      return await remoteDataSource.getHistoricalData(map);
    });
  }

  @override
  Future<Either<Failure, List<CurrencyModel>>> listAllCurrencies() async{
    List<CurrencyModel>? cachedList;
    try{
      cachedList = await localDataSource.listCachedCurrencies();
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
    if(cachedList==null){
    return await RepoImplCallHandler<List<CurrencyModel>>(networkInfo)(() async {
        final result =  await remoteDataSource.listAllCurrencies();
        await localDataSource.cacheCurrencies(result);
        return result;
    });
    }else{
      return Right(cachedList);
    }
  }
}