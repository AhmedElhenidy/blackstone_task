class CurrencyModel {
  CurrencyModel({this.currency,});

  CurrencyModel.fromJson(Map<String,dynamic> map,k) {
    currency =  Currency.fromMap(map);
    code = k;
  }
  Currency? currency;
  String? code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map[code!] = currency!.toJson();
    return map;
  }
}

class Currency {
  Currency({
      this.symbol, 
      this.name, 
      this.symbolNative, 
      this.decimalDigits, 
      this.rounding, 
      this.code, 
      this.namePlural,});

  Currency.fromMap(Map<String,dynamic> json) {
    symbol = json['symbol'];
    name = json['name'];
    symbolNative = json['symbol_native'];
    decimalDigits = json['decimal_digits'];
    rounding = json['rounding'];
    code = json['code'];
    namePlural = json['name_plural'];
  }
  String? symbol;
  String? name;
  String? symbolNative;
  num? decimalDigits;
  num? rounding;
  String? code;
  String? namePlural;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['symbol'] = symbol;
    map['name'] = name;
    map['symbol_native'] = symbolNative;
    map['decimal_digits'] = decimalDigits;
    map['rounding'] = rounding;
    map['code'] = code;
    map['name_plural'] = namePlural;
    return map;
  }

}