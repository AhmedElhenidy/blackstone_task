import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../app/error/failures.dart';
import '../../../app/usecase/usecase.dart';
import '../../data/model/historical_data_model.dart';
import '../repository/currency_converter_repo.dart';

class GetHistoricalDataUseCase implements UseCase<List<HistoricalDataModel>, GetHistoricalDataUseCaseParams> {
  final CurrencyConverterRepo repository;

  GetHistoricalDataUseCase({required this.repository});

  @override
  Future<Either<Failure, List<HistoricalDataModel>>> call(GetHistoricalDataUseCaseParams params) async{
    return await repository.getHistoricalData(params.toMap());
  }

}

class GetHistoricalDataUseCaseParams {
  final String currency;
  final String baseCurrency;
  final int days;

  GetHistoricalDataUseCaseParams(
      {
        required this.currency,
        required this.baseCurrency,
        required this.days,
      });

  Map<String, dynamic> toMap() {
    final map = {
      "currencies": currency,
      "base_currency": baseCurrency,
      "date_to": DateFormat("yyyy-mm-dd").format(DateTime.now()),
      "date_from": DateFormat("yyyy-mm-dd").format(DateTime.now().subtract( Duration(days: days))),
    };
    return map;
  }
}
