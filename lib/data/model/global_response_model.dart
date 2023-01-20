import 'dart:convert';

import '../../app/error/exceptions.dart';

class GlobalResponseModel {
  GlobalResponseModel({
      this.message,
      this.data, 
      this.errors,});

  factory GlobalResponseModel.fromJson(String source) {
    try {
      return GlobalResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);
    } catch (e) {
      throw DataParsingException(e.toString());
    }
  }
  GlobalResponseModel.fromMap(Map<String, dynamic> map) {
    message = map['message'];
    data = map['data'];
    errors = map['errors'] != null ? Errors.fromJson(map['errors']) : null;
  }
  String? message;
  Map<String,dynamic>? data;
  Errors? errors;

}

class Errors {
  Errors({this.currencies,});

  Errors.fromJson(dynamic json) {
    currencies = json['currencies'] != null ? json['currencies'].cast<String>() : [];
  }
  List<String>? currencies;
}