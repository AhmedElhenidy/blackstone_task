import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../app/error/failures.dart';
import '../../../app/usecase/usecase.dart';
import '../../data/model/historical_data_model.dart';
import '../repository/currency_converter_repo.dart';

class GetHistoricalDataUseCase implements UseCase<HistoricalDataModel, GetHistoricalDataUseCaseParams> {
  final CurrencyConverterRepo repository;

  GetHistoricalDataUseCase({required this.repository});

  @override
  Future<Either<Failure, HistoricalDataModel>> call(GetHistoricalDataUseCaseParams params) async{
    return await repository.getHistoricalData(params.toMap());
  }

}

class GetHistoricalDataUseCaseParams {
  final String firstCurrency;
  final String secondCurrency;
  final int days;

  GetHistoricalDataUseCaseParams(
      {
        required this.firstCurrency,
        required this.secondCurrency,
        required this.days,
      });

  Map<String, dynamic> toMap() {
    final map = {
      "q": "$firstCurrency,$secondCurrency",
      "compact": "ultra",
      "date": DateFormat("yyyy-mm-dd").format(DateTime.now()),
      "endDate": DateFormat("yyyy-mm-dd").format(DateTime.now().subtract( Duration(days: days))),
    };
    return map;
  }
}
