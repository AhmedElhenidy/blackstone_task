import 'package:blackstone_task/app/error/exceptions.dart';
import 'package:blackstone_task/app/error/failures.dart';
import 'package:blackstone_task/app/network/network_info.dart';
import 'package:blackstone_task/data/data_source/local_data_source/currency_converter_local_data_source.dart';
import 'package:blackstone_task/data/data_source/remote_data_source/currency_converter_remote_data_source.dart';
import 'package:blackstone_task/data/model/conversion_response_model.dart';
import 'package:blackstone_task/data/model/currency_model.dart';
import 'package:blackstone_task/data/model/historical_data_model.dart';
import 'package:blackstone_task/data/repository/currency_converter_repo_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCurrencyConverterRemoteDatasource extends Mock implements CurrencyConverterRemoteDataSource {}
class MockCurrencyConverterLocalDatasource extends Mock implements CurrencyConverterLocalDataSource {}
class MockNetworkInfo extends Mock implements NetworkInfo {}


void main() {
  //repository impl
  late CurrencyConverterRepoImpl currencyConverterRepo;
  //mocked datasource
  late MockCurrencyConverterRemoteDatasource mockCurrencyConverterRemoteDatasource;
  late MockCurrencyConverterLocalDatasource mockCurrencyConverterLocalDatasource;
  //mocked network
  late MockNetworkInfo mockNetworkInfo;


  setUp(() {
    mockCurrencyConverterRemoteDatasource = MockCurrencyConverterRemoteDatasource();
    mockCurrencyConverterLocalDatasource = MockCurrencyConverterLocalDatasource();
    mockNetworkInfo = MockNetworkInfo();
    currencyConverterRepo = CurrencyConverterRepoImpl(
      remoteDataSource: mockCurrencyConverterRemoteDatasource,
      localDataSource: mockCurrencyConverterLocalDatasource,
      networkInfo: mockNetworkInfo,
    );
  });

  final HistoricalDataModel tHistoricalDataModel = HistoricalDataModel();
  final ConversionResponseModel tConversionResponse = ConversionResponseModel();

  group('listAllCurrencies', () {
    final List<CurrencyModel> tCurrencies = [];

    test(
      'should check if the device is online',
          () async {
        // arrange
            when(()=>mockCurrencyConverterLocalDatasource.listCachedCurrencies())
                .thenAnswer((_) async => null);
        when(()=>mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
            final result = await currencyConverterRepo.listAllCurrencies();
        // assert
            verify(()=>mockCurrencyConverterLocalDatasource.listCachedCurrencies());
             verify(()=>mockNetworkInfo.isConnected);

      },
    );

    test(
      'should return remote data when this is the first time call and cache the data',
          () async {
        // arrange
        when(()=>mockCurrencyConverterRemoteDatasource.listAllCurrencies())
            .thenAnswer((_) async => tCurrencies);
        when(()=>mockCurrencyConverterLocalDatasource.cacheCurrencies(any()))
            .thenAnswer((_) async => true);
        when(()=>mockCurrencyConverterLocalDatasource.listCachedCurrencies())
            .thenAnswer((_) async => null);
        when(() => mockNetworkInfo.isConnected,
        ).thenAnswer((_) async => true);
        // act
        final result = await currencyConverterRepo.listAllCurrencies();
        // assert
        verify(() => mockNetworkInfo.isConnected);
        verify(()=>mockCurrencyConverterRemoteDatasource.listAllCurrencies());
        verify(()=>mockCurrencyConverterLocalDatasource.cacheCurrencies(tCurrencies));
        verify(()=>mockCurrencyConverterLocalDatasource.listCachedCurrencies());
        expect(result, equals(Right(tCurrencies)));
      },
    );

    test(
      'should cache the data locally when the call to remote data source is successful',
          () async {
        // arrange
        when(()=>mockCurrencyConverterRemoteDatasource.listAllCurrencies())
            .thenAnswer((_) async => tCurrencies);
        when(()=>mockCurrencyConverterLocalDatasource.listCachedCurrencies())
            .thenAnswer((_) async => null);
        when(() => mockNetworkInfo.isConnected,).thenAnswer((_) async => true);
        // act
        final result = await currencyConverterRepo.listAllCurrencies();
        // assert
        verify(() => mockNetworkInfo.isConnected);
        verify(()=>mockCurrencyConverterRemoteDatasource.listAllCurrencies());
        verify(()=>mockCurrencyConverterLocalDatasource.listCachedCurrencies());
        verify(()=>mockCurrencyConverterLocalDatasource.cacheCurrencies(tCurrencies));
      },
    );

    test(
      'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
            when(()=>mockCurrencyConverterLocalDatasource.listCachedCurrencies())
                .thenAnswer((_) async => null);
        when(()=>mockCurrencyConverterRemoteDatasource.listAllCurrencies())
            .thenThrow(ServerException("server exception"));
        when(() => mockNetworkInfo.isConnected,).thenAnswer((_) async => true);
        // act
        final result = await currencyConverterRepo.listAllCurrencies();
        // assert
        verify(()=>mockCurrencyConverterLocalDatasource.listCachedCurrencies());
        verify(()=>mockCurrencyConverterRemoteDatasource.listAllCurrencies());
        verify(() => mockNetworkInfo.isConnected);
        expect(result, isA<Left<Failure, List<CurrencyModel>>>().having((p0) => p0.value,
            'server exception',
            isA<ServerFailure>()));
      },
    );


    test(
      'should return last locally cached data when the cached data is present',
          () async {
        // arrange
        when(()=>mockCurrencyConverterLocalDatasource.listCachedCurrencies())
            .thenAnswer((_) async => tCurrencies);
        // act
        final result = await currencyConverterRepo.listAllCurrencies();
        // assert
        verifyZeroInteractions(mockCurrencyConverterRemoteDatasource);
        verify(()=>mockCurrencyConverterLocalDatasource.listCachedCurrencies());
        expect(result, equals(Right(tCurrencies)));
      },
    );

    test(
      'should return CacheFailure when there is no cached data present',
          () async {
        // arrange
        when(()=>mockCurrencyConverterLocalDatasource.listCachedCurrencies())
            .thenThrow(CacheException("cache Error"));
        when(() => mockNetworkInfo.isConnected,).thenAnswer((_) async => true);
        // act
        final result = await currencyConverterRepo.listAllCurrencies();
        // assert
        verifyZeroInteractions(mockCurrencyConverterRemoteDatasource);
        verify(()=>mockCurrencyConverterLocalDatasource.listCachedCurrencies());
        expect(result, isA<Left<Failure, List<CurrencyModel>>>().having((p0) => p0.value,
            'cache Error',
            isA<CacheFailure>()));
      },
    );
  });

  group("getHistoricalData", () {
    test(
      'should get historical data from the repo when calling getHistoricalData()',
      () async {
        // arrange
        when(
          () => mockCurrencyConverterRemoteDatasource.getHistoricalData(any()),
        ).thenAnswer((_) async => tHistoricalDataModel);
        when(() => mockNetworkInfo.isConnected,
        ).thenAnswer((_) async => true);
        // act
        final res = await currencyConverterRepo.getHistoricalData({});

        // assert
        expect(res, equals(Right(tHistoricalDataModel)));
        verify(() => mockNetworkInfo.isConnected);
        verify(() => mockCurrencyConverterRemoteDatasource.getHistoricalData({}));
      },
    );

    test(
      'should throw ConnectionFailure from CurrencyConverterRepo when calling getHistoricalData() when app is offline',
      () async {
        // arrange
        when(
          () => mockCurrencyConverterRemoteDatasource.getHistoricalData(any()),
        ).thenAnswer((_) async => tHistoricalDataModel);
        when(
          () => mockNetworkInfo.isConnected,
        ).thenAnswer((_) async => false);

        // act
        final res = await currencyConverterRepo.getHistoricalData({});

        // assert
        expect(res, isA<Left<Failure, HistoricalDataModel>>().having((p0) => p0.value,
                'Left throw a connection failure',
                isA<ConnectionFailure>()));

        verify(() => mockNetworkInfo.isConnected);
        verifyNever(() => mockCurrencyConverterRemoteDatasource.getHistoricalData({}));
      },
    );

    test(
      'should throw ParsingFailure from CurrencyConverterRepo when calling getHistoricalData() when app is online and getting right error object',
      () async {
        // arrange
        when(
          () => mockCurrencyConverterRemoteDatasource.getHistoricalData(any()),
        ).thenThrow(DataParsingException("parsing Error"));
        when(
          () => mockNetworkInfo.isConnected,
        ).thenAnswer((_) async => true);

        // act
        final res = await currencyConverterRepo.getHistoricalData({});

        // assert
        expect(res,
            isA<Left<Failure, HistoricalDataModel>>().having((p0) => p0.value,
                'Left throw a connection failure', isA<DataParsingFailure>()));

        verify(() => mockNetworkInfo.isConnected);
        verify(() => mockCurrencyConverterRemoteDatasource.getHistoricalData({}));
      },
    );
  });

  group("convert", () {
    test(
      'should get convert response from the repo when calling convert()',
      () async {
        // arrange
        when(
          () => mockCurrencyConverterRemoteDatasource.convert(any()),
        ).thenAnswer((_) async => tConversionResponse);
        when(
          () => mockNetworkInfo.isConnected,
        ).thenAnswer((_) async => true);

        // act
        final res = await currencyConverterRepo.convert({});

        // assert
        expect(res, equals(Right(tConversionResponse)));
        verify(() => mockNetworkInfo.isConnected);
        verify(() => mockCurrencyConverterRemoteDatasource.convert({}));
      },
    );

    test(
      'should throw ConnectionFailure from repo when calling convert() when app is offline',
      () async {
        // arrange
        when(
          () => mockCurrencyConverterRemoteDatasource.convert(any()),
        ).thenAnswer((_) async => tConversionResponse);
        when(
          () => mockNetworkInfo.isConnected,
        ).thenAnswer((_) async => false);
        // act

        final res = await currencyConverterRepo.convert({});

        // assert
        expect(
            res,
            isA<Left<Failure, ConversionResponseModel>>().having((p0) => p0.value,
                'Left throw a connection failure', isA<ConnectionFailure>()));

        verify(() => mockNetworkInfo.isConnected);
        verifyNever(() => mockCurrencyConverterRemoteDatasource.convert({}));
      },
    );

    test(
      'should throw ParsingFailure from DriverRopeImpl when calling convert() when app is online and getting right error object',
      () async {
        // arrange
        when(
          () => mockCurrencyConverterRemoteDatasource.convert(any()),
        ).thenThrow(DataParsingException("parsing error"));
        when(
          () => mockNetworkInfo.isConnected,
        ).thenAnswer((_) async => true);
        // act
        final res = await currencyConverterRepo.convert({});

        // assert
        expect(
            res,
            isA<Left<Failure, ConversionResponseModel>>().having((p0) => p0.value,
                'Left throw a connection failure', isA<DataParsingFailure>()));

        verify(() => mockNetworkInfo.isConnected);
        verify(() => mockCurrencyConverterRemoteDatasource.convert({}));
      },
    );
  });
}
