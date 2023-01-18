import 'package:dartz/dartz.dart';
import '../../../app/error/failures.dart';
import '../../../app/usecase/usecase.dart';
import '../../data/model/currency_model.dart';
import '../repository/currency_converter_repo.dart';

class ListSupportedCurrencyUseCase implements UseCase<List<CurrencyModel>, NoParams> {
  final CurrencyConverterRepo repository;

  ListSupportedCurrencyUseCase({required this.repository});

  @override
  Future<Either<Failure, List<CurrencyModel>>> call(NoParams noParams) async{
    return await repository.listAllCurrencies();
  }

}

class ListAllCurrenciesUseCase {
  final String OrgID;
  final String page;
  final String size;

  ListAllCurrenciesUseCase(
      {
        required this.OrgID,
        required this.page,
        required this.size,
      });

  Map<String, dynamic> toMap() {
    final map = {
      "OrgID": OrgID,
      "page": page,
      "size": size,
    };
    return map;
  }
}
