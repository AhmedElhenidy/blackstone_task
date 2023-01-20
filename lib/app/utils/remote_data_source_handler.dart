import 'package:http/http.dart';
import '../../data/model/global_response_model.dart';
import '../error/exceptions.dart';

class RemoteDataSourceCallHandler {
  RemoteDataSourceCallHandler();

  Future<Map<String,dynamic>> call(Response res,) async {
    GlobalResponseModel response ;
    try {
      response = GlobalResponseModel.fromJson(res.body.toString());
    } catch (e) {
      throw DataParsingException(e.toString());
    }
    if (res.statusCode == 200) {
      if(response.data==null){
        throw ServerException(response.errors?.currencies?.first??"unknown Error");
      }else{
        return response.data!;
      }
    } else {
      if(response.errors!=null){
        throw ServerException(response.errors?.currencies?.first??"unknown error");
      }else{
        throw ServerException(response.message??"unknown Error");
      }
    }
  }
}
