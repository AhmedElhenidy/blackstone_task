import 'package:dartz/dartz.dart';
import '../../../app/error/failures.dart';
import '../../../app/usecase/usecase.dart';
import '../../data/model/conversion_response_model.dart';
import '../repository/currency_converter_repo.dart';

class ConvertCurrencyUseCase implements UseCase<ConversionResponseModel, ConvertCurrencyUseCaseParams> {
  final CurrencyConverterRepo repository;

  ConvertCurrencyUseCase({required this.repository});

  @override
  Future<Either<Failure, ConversionResponseModel>> call(ConvertCurrencyUseCaseParams params) async{
    return await repository.convert(params.toMap());
  }

}

class ConvertCurrencyUseCaseParams {
  final String firstCurrency;
  final String secondCurrency;

  ConvertCurrencyUseCaseParams(
      {
        required this.firstCurrency,
        required this.secondCurrency,
      });

  Map<String, dynamic> toMap() {
    final map = {
      "q": "$firstCurrency,$secondCurrency",
      "compact": "ultra",
    };
    return map;
  }
}
