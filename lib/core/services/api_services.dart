import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

enum MethodRequest { get, post }

class ResponseModel {
  final int statusCode;
  final dynamic response;

  ResponseModel({this.statusCode, this.response});

  factory ResponseModel.toModel(List<dynamic> response) {
    return ResponseModel(statusCode: response[0], response: response[1]);
  }
}

class ApiServices {
  ApiServices._();

  static String baseUrl = 'https://jsonplaceholder.typicode.com/';
  static const int timeOut = 60;
  static const Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  static bool isJson(str) {
    try {
      jsonDecode(str);
    } catch (e) {
      return false;
    }
    return true;
  }

  static request(
      {@required MethodRequest methodRequest,
      @required String endpoint,
      dynamic body}) async {
    try {
      final request = methodRequest == MethodRequest.post
          ? await http
              .post('${baseUrl + endpoint}',
                  headers: ApiServices.headers, body: body)
              .timeout(const Duration(seconds: ApiServices.timeOut))
          : await http
              .get('${baseUrl + endpoint}', headers: ApiServices.headers)
              .timeout(const Duration(seconds: ApiServices.timeOut));

      switch (request.statusCode) {
        case 200:
          return isJson(request.body)
              ? ResponseModel.toModel(
                  [request.statusCode, request.body.toString()])
              : null;
          break;
        case 201:
          return isJson(request.body)
              ? ResponseModel.toModel(
                  [request.statusCode, request.body.toString()])
              : null;
          break;
        default:
          return null;
      }
    } catch (e) {
      return null;
    }
  }
}
