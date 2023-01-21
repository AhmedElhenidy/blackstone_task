import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';

import '../utils/consts.dart';

class NetworkManager {

   NetworkManager._();

  factory NetworkManager() {
    return NetworkManager._();
  }
   final https = InterceptedHttp.build(interceptors: [
     LoggingInterceptor(),
   ]);

  Uri? _uri;
  Future<http.Response> request<T>({
    required RequestMethod method,
    String baseUrl = kBaseUrl,
    String baseVersion = kBaseVersion,
    required String endPoint,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    // required NetworkResponseHandler responseHandler,

  }) async{
    _uri = Uri(
      scheme:"https" ,
      host: baseUrl,
      path: kBaseVersion+endPoint,
      queryParameters: queryParameters,
    );

    switch (method){
      case RequestMethod.get:
       return await https.get(_uri!, headers: headers,);
        break;
      case RequestMethod.post:
        return await https.post(_uri!, headers: headers, body: json.encode(body),);
        break;
      // case RequestMethod.head:
      //   // TODO: Handle this case.
      //   break;
      // case RequestMethod.put:
      //   // TODO: Handle this case.
      //   break;
      // case RequestMethod.delete:
      //   // TODO: Handle this case.
      //   break;
      // case RequestMethod.connect:
      //   // TODO: Handle this case.
      //   break;
      // case RequestMethod.options:
      //   // TODO: Handle this case.
      //   break;
      // case RequestMethod.trace:
      //   // TODO: Handle this case.
      //   break;
      // case RequestMethod.patch:
      //   // TODO: Handle this case.
      //   break;
      default:
        return await https.post(_uri!, headers: headers, body: json.encode(body),);
    }
  }
}

enum RequestMethod {
  get,
  head,
  post,
  put,
  delete,
  connect,
  options,
  trace,
  patch,
}

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    data.params.addAll({
      'apikey':"N8na7dQL8kt7phAWoSS4brbPX97Ubjo9ydW8JyMN",
    });
    data.headers.addAll(apiHeaders);
    print(data.toString());
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    print(data.toString());
    print(data.body);
    return data;
  }

}