part of 'currency_cubit.dart';

abstract class CurrencyState extends Equatable {
  const CurrencyState();
}

class CurrencyInitial extends CurrencyState {
  @override
  List<Object> get props => [];
}

class CurrencyLoading extends CurrencyState {
  @override
  List<Object> get props => [];
}
class HistoricalLoading extends CurrencyState {
  @override
  List<Object> get props => [];
}

class CurrencyConversionSuccess extends CurrencyState {
  final double rate;
  CurrencyConversionSuccess(this.rate);
  @override
  List<Object> get props => [rate];
}

class CurrencyError extends CurrencyState {
  final String msg;
  CurrencyError(this.msg);
  @override
  List<Object> get props => [msg];
}
