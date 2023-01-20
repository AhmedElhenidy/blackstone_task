

const String kBaseUrl = 'api.freecurrencyapi.com';
const String kBaseVersion = 'v1/';
const String kListAllCurrencies = 'currencies';
const String kHistorical = 'historical';
const String kLatest = 'latest';


//Static Headers
const Map<String, String> apiHeaders = {
  "Content-Type": "application/json",
  "Accept": "application/json, text/plain, */*",
  "X-Requested-With": "XMLHttpRequest",
};