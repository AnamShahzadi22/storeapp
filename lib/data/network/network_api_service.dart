
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:store_app/data/exception/app_exception.dart';
import 'package:store_app/data/network/base_api_service.dart';


class NetworkApiServices implements BaseApiServices {

  @override
  Future<dynamic> getApi(String url) async {
    dynamic responseJson;
    try {

      final response =
      await http.get(Uri.parse(url)).timeout( Duration(seconds: 50));
      responseJson = returnResponse(response);
    } on SocketException {
      throw NoInternetException('');
    } on TimeoutException{
      throw FetchDataException('Time Out Try Again');
    }
    return responseJson;
  }




  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        throw UnAuthorizedException();
      case 500:
        throw FetchDataException(
            'Error Occured while communicated with server' +
                'with status code' +
                response.statusCode.toString());
      default:
        throw FetchDataException();
    }
  }
}
