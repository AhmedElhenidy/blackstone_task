import 'package:blackstone_task/data/data_source/local_data_source/currency_converter_local_data_source.dart';
import 'package:blackstone_task/data/data_source/remote_data_source/currency_converter_remote_data_source.dart';
import 'package:blackstone_task/domain/repository/currency_converter_repo.dart';
import 'package:blackstone_task/domain/usecase/convert_currency_usecase.dart';
import 'package:blackstone_task/domain/usecase/get_historical_data_usecase.dart';
import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/repository/currency_converter_repo_impl.dart';
import '../../domain/usecase/list_all_currencies_usecase.dart';
import '../network/network_info.dart';
import '../network/network_manager.dart';
import 'navigation_helper.dart';

final getIt = GetIt.instance;

Future<void> initInjection() async {
  getIt.registerSingleton<NavHelper>(NavHelper());

  // data sources
  getIt.registerLazySingleton<CurrencyConverterRemoteDataSource>(
    () => CurrencyConverterRemoteDataSourceImpl(networkManager: getIt()),);
  getIt.registerLazySingleton<CurrencyConverterLocalDataSource>(
        () => CurrencyConverterLocalDataSourceImpl(),);

   //* Repository
  getIt.registerLazySingleton<CurrencyConverterRepo>(
    () => CurrencyConverterRepoImpl(remoteDataSource: getIt(),localDataSource: getIt(), networkInfo: getIt()),);

  //* Use cases
  _currencyUseCases();

  //! ----------- app -----------
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  getIt.registerLazySingleton<NetworkManager>(() => NetworkManager());
  getIt.registerLazySingleton<DataConnectionChecker>(() => DataConnectionChecker());
 }

void _currencyUseCases() {
  getIt.registerLazySingleton<ConvertCurrencyUseCase>(
      () => ConvertCurrencyUseCase(repository: getIt()));

  getIt.registerLazySingleton<GetHistoricalDataUseCase>(
          () => GetHistoricalDataUseCase(repository: getIt()));

  getIt.registerLazySingleton<ListSupportedCurrencyUseCase>(
          () => ListSupportedCurrencyUseCase(repository: getIt()));

}

