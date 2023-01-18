import 'package:blackstone_task/app/usecase/usecase.dart';
import 'package:blackstone_task/data/model/currency_model.dart';
import 'package:blackstone_task/domain/repository/currency_converter_repo.dart';
import 'package:blackstone_task/domain/usecase/list_all_currencies_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCurrencyConverterRepo extends Mock implements CurrencyConverterRepo{}

void main() {
  late ListSupportedCurrencyUseCase useCase;
  late MockCurrencyConverterRepo mockCurrencyConverterRepo;

  setUp(() {
    mockCurrencyConverterRepo = MockCurrencyConverterRepo();
    useCase = ListSupportedCurrencyUseCase(repository: mockCurrencyConverterRepo);
  });

  final List<CurrencyModel> tCurrenciesLis = [];

  test(
    'should get Currencies list from the repository when calling the corresponding use case',
        () async {
      // arrange
      when(() => mockCurrencyConverterRepo.listAllCurrencies())
          .thenAnswer((_) async => Right(tCurrenciesLis));
      // act
      final result = await useCase(NoParams());
      // assert
      expect(result, Right(tCurrenciesLis));
      verify(() => mockCurrencyConverterRepo.listAllCurrencies());
      verifyNoMoreInteractions(mockCurrencyConverterRepo);
    },
  );
}
