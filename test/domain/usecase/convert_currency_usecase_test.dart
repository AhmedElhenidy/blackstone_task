import 'package:blackstone_task/data/model/conversion_response_model.dart';
import 'package:blackstone_task/domain/repository/currency_converter_repo.dart';
import 'package:blackstone_task/domain/usecase/convert_currency_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCurrencyConverterRepo extends Mock implements CurrencyConverterRepo{}

void main() {
  late ConvertCurrencyUseCase useCase;
  late MockCurrencyConverterRepo mockCurrencyConverterRepo;

  setUp(() {
    mockCurrencyConverterRepo = MockCurrencyConverterRepo();
    useCase = ConvertCurrencyUseCase(repository: mockCurrencyConverterRepo);
  });

  final ConversionResponseModel tConversion = ConversionResponseModel(0.51117);

  test(
    'should get Historical Data from the repository when calling the corresponding use case',
        () async {
      // arrange
      when(() => mockCurrencyConverterRepo.convert(any()))
          .thenAnswer((_) async => Right(tConversion));
      final params = ConvertCurrencyUseCaseParams(baseCurrency: "USD", currency: "PHP",);
      // act
      final result = await useCase(params);
      // assert
      expect(result, Right(tConversion));
      verify(() => mockCurrencyConverterRepo.convert(params.toMap()));
      verifyNoMoreInteractions(mockCurrencyConverterRepo);
    },
  );
}
