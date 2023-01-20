import 'dart:convert';
import 'dart:io';

import 'package:blackstone_task/app/error/exceptions.dart';
import 'package:blackstone_task/app/network/network_manager.dart';
import 'package:blackstone_task/app/utils/consts.dart';
import 'package:blackstone_task/data/data_source/remote_data_source/currency_converter_remote_data_source.dart';
import 'package:blackstone_task/data/model/conversion_response_model.dart';
import 'package:blackstone_task/data/model/currency_model.dart';
import 'package:blackstone_task/data/model/historical_data_model.dart';
import 'package:blackstone_task/domain/usecase/convert_currency_usecase.dart';
import 'package:blackstone_task/domain/usecase/get_historical_data_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/fixture_reader.dart';


class MockNetworkManager extends Mock implements NetworkManager {}

void main() {
  final MockNetworkManager mockNetworkManager = MockNetworkManager();
  final CurrencyConverterRemoteDataSourceImpl currencyConverterRemoteDataSourceImpl =
  CurrencyConverterRemoteDataSourceImpl(networkManager: mockNetworkManager);
  String tListAllCurrenciesJsonData = fixture('list_all_currencies.json');
  String tHistoricalJsonData = fixture('historical_data.json');
  String tCurrencyConversionJsonData = fixture('conversion_data.json');

  const String causingError = 'error message from web';

  group("listAllCurrencies", () {
    test(
      'should get remote data when calling remote datasource listAllCurrencies()',
          () async {
        //  arrange
        when(() => mockNetworkManager.request(
            method: RequestMethod.get,
            endPoint: any(named: 'endPoint'))).thenAnswer(
              (_) async => Response(tListAllCurrenciesJsonData,200,
                  headers: {
                    HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
                  },
              ),
        );
        //  act
        final res = await currencyConverterRemoteDataSourceImpl.listAllCurrencies();
        //  assert
        expect(res, isA<List<CurrencyModel>>());
        verify(() => mockNetworkManager.request(
            method: RequestMethod.get,
            endPoint: kListAllCurrencies,
            ));
        //verifyNoMoreInteractions(mockNetworkManager);
      },
    );

    test(
      'should throw server error ',
          () async {
        //  arrange
            when(() => mockNetworkManager.request(
                method: RequestMethod.get,
                endPoint: any(named: 'endPoint'))).thenAnswer(
                  (_) async => Response("{\"message\": \"$causingError\"}",401,),
            );

        //  act
        final call = currencyConverterRemoteDataSourceImpl.listAllCurrencies;
        //  assert
        expect(() => call(),
            throwsA(isA<ServerException>().having(
                    (p0) => p0.toString(), 'the causing error', causingError)));

            verify(() => mockNetworkManager.request(
              method: RequestMethod.get,
              endPoint: kListAllCurrencies,
            ));
            //verifyNoMoreInteractions(mockNetworkManager);
      },
    );

    test(
      'should throw data parsing exception',
          () async {
        //  arrange
            when(() => mockNetworkManager.request(
                method: RequestMethod.get,
                endPoint: any(named: 'endPoint'))).thenAnswer(
                  (_) async => Response("",200,),
            );
        //  act
        final call = currencyConverterRemoteDataSourceImpl.listAllCurrencies;
        //  assert
        expect(() => call(), throwsA(isA<DataParsingException>()));
      },
    );
  });

  group("getHistoricalData", () {
    final params = GetHistoricalDataUseCaseParams(
      currency: 'BGN',
      baseCurrency: 'EUR',
      days: 7,
    ).toMap();

    test(
      'should get remote data when calling remote datasource getHistoricalData()',
          () async {
        //  arrange
        when(() => mockNetworkManager.request(
            method: RequestMethod.get,
            endPoint: any(named: 'endPoint'),
          queryParameters: any(named: 'queryParameters'),
        )).thenAnswer(
              (_) async => Response(tHistoricalJsonData,200,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
            },
          ),
        );

        //  act
        final res = await currencyConverterRemoteDataSourceImpl.getHistoricalData(params);
        //  assert
        expect(res, isA<List<HistoricalDataModel>>());
        verify(() => mockNetworkManager.request(
          method: RequestMethod.get,
          endPoint: kHistorical,
          queryParameters: params,
        ));
        //verifyNoMoreInteractions(mockNetworkManager);
      },
    );

    test(
      'should throw server error when calling remote datasource getHistoricalData() ',
          () async {
        //  arrange
        when(() => mockNetworkManager.request(
            method: RequestMethod.get,
            queryParameters: any(named: 'queryParameters'),
            endPoint: any(named: 'endPoint'))).thenAnswer(
              (_) async => Response("{\"message\": \"$causingError\"}",401,),
        );

        //  act
        final call = currencyConverterRemoteDataSourceImpl.getHistoricalData;
        //  assert
        expect(() => call(params),
            throwsA(isA<ServerException>().having(
                    (p0) => p0.toString(), 'the causing error', causingError)));

        verify(() => mockNetworkManager.request(
          method: RequestMethod.get,
          endPoint: kHistorical,
          queryParameters: params
        ));
        //verifyNoMoreInteractions(mockNetworkManager);
      },
    );

    test(
      'should throw data parsing exception when calling remote datasource getHistoricalData()',
          () async {
        //  arrange
        when(() => mockNetworkManager.request(
            method: RequestMethod.get,
            queryParameters: any(named: 'queryParameters'),
            endPoint: any(named: 'endPoint'))).thenAnswer(
              (_) async => Response("",200,),
        );
        //  act
        final call = currencyConverterRemoteDataSourceImpl.getHistoricalData;
        //  assert
        expect(() => call(params), throwsA(isA<DataParsingException>()));
        verify(() => mockNetworkManager.request(
            method: RequestMethod.get,
            endPoint: kHistorical,
            queryParameters: params
        ));
        //verifyNoMoreInteractions(mockNetworkManager);
      },
    );
  });

  group("convert", () {
    final params = ConvertCurrencyUseCaseParams(
      currency: 'BGN',
      baseCurrency: 'EUR',
    ).toMap();

    test(
      'should get remote data when calling remote datasource convert()',
          () async {
        //  arrange
        when(() => mockNetworkManager.request(
          method: RequestMethod.get,
          endPoint: any(named: 'endPoint'),
          queryParameters: any(named: 'queryParameters'),
        )).thenAnswer(
              (_) async => Response(tCurrencyConversionJsonData,200,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
            },
          ),
        );

        //  act
        final res = await currencyConverterRemoteDataSourceImpl.convert(params);
        //  assert
        expect(res, isA<ConversionResponseModel>());
        verify(() => mockNetworkManager.request(
          method: RequestMethod.get,
          endPoint: kLatest,
          queryParameters: params,
        ));
        //verifyNoMoreInteractions(mockNetworkManager);
      },
    );

    test(
      'should throw server error  calling remote datasource convert() ',
          () async {
        //  arrange
        when(() => mockNetworkManager.request(
            method: RequestMethod.get,
            queryParameters: any(named: 'queryParameters'),
            endPoint: any(named: 'endPoint'))).thenAnswer(
              (_) async => Response("{\"message\": \"$causingError\"}",401,),
        );

        //  act
        final call = currencyConverterRemoteDataSourceImpl.convert;
        //  assert
        expect(() => call(params),
            throwsA(isA<ServerException>().having(
                    (p0) => p0.toString(), 'the causing error', causingError)));

        verify(() => mockNetworkManager.request(
          method: RequestMethod.get,
          endPoint: kLatest,
          queryParameters: params,
        ));
        //verifyNoMoreInteractions(mockNetworkManager);
      },
    );

    test(
      'should throw data parsing exception  calling remote datasource convert()',
          () async {
        //  arrange
        when(() => mockNetworkManager.request(
            method: RequestMethod.get,
            queryParameters: any(named: 'queryParameters'),
            endPoint: any(named: 'endPoint'))).thenAnswer(
              (_) async => Response("",200,),
        );
        //  act
        final call = currencyConverterRemoteDataSourceImpl.convert;
        //  assert
        expect(() => call(params), throwsA(isA<DataParsingException>()));
        verify(() => mockNetworkManager.request(
            method: RequestMethod.get,
            endPoint: kLatest,
            queryParameters: params
        ));
        //verifyNoMoreInteractions(mockNetworkManager);
      },
    );
  });
}
