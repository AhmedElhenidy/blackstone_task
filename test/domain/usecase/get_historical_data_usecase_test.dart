import 'package:blackstone_task/data/model/historical_data_model.dart';
import 'package:blackstone_task/domain/repository/currency_converter_repo.dart';
import 'package:blackstone_task/domain/usecase/get_historical_data_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCurrencyConverterRepo extends Mock implements CurrencyConverterRepo{}

void main() {
  late GetHistoricalDataUseCase useCase;
  late MockCurrencyConverterRepo mockCurrencyConverterRepo;

  setUp(() {
    mockCurrencyConverterRepo = MockCurrencyConverterRepo();
    useCase = GetHistoricalDataUseCase(repository: mockCurrencyConverterRepo);
  });

  final List<HistoricalDataModel> tHistoricalData = [];

  test(
    'should get Historical Data from the repository when calling the corresponding use case',
        () async {
      // arrange
      when(() => mockCurrencyConverterRepo.getHistoricalData(any()))
          .thenAnswer((_) async => Right(tHistoricalData));
      final params = GetHistoricalDataUseCaseParams(currency: "USD_PHP", baseCurrency: "PHP_USD", days: 7);
      // act
      final result = await useCase(params);
      // assert
      expect(result, Right(tHistoricalData));
      verify(() => mockCurrencyConverterRepo.getHistoricalData(params.toMap()));
      verifyNoMoreInteractions(mockCurrencyConverterRepo);
    },
  );
}
