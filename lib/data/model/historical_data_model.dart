class HistoricalDataModel{
  HistoricalDataModel();
  HistoricalDataModel.fromMap(Map<String,dynamic> map,String k){
    date = k;
    historicalData =  HistoricalData.fromMap(map);
  }
  String? date;
  HistoricalData? historicalData;
}

class HistoricalData{
  HistoricalData.fromMap(Map<String,dynamic> map) {
    map.forEach((key, value) {
      currency= key;
      rate = value;
    });
  }
  String? currency;
  double? rate;
}