import 'dart:io';
import 'dart:math';

import 'package:netflixdemo/rest/netflix_exception.dart';
import 'package:netflixdemo/utils/AppConstants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class ApiProvider{

  final String BASE_URL = AppConstants.TMDB_BASE_URL;


  Future<dynamic> getResponse(String endPoint) async{
    var dynamicResponse;


    try {
      var url = BASE_URL + endPoint +'?api_key=${AppConstants.TMDB_API_KEY}';
      var resp = await http.get(url);
      dynamicResponse = parseResponse(resp);
    } on SocketException catch (e) {
      throw NetflixException('Network Exception',e.toString());
    }

    return dynamicResponse;
  }

  dynamic parseResponse(http.Response response){

    switch(response.statusCode){

      case 200:
        return json.decode(response.body);
      case 400:
          throw BadRequestException(response.body);
      case 401:
        break;
      case 403:
        throw UnauthorizedException(response.body);
      case 404:
        throw ResourceNotFoundException(response.body);
      case 500:
        throw ServerException(response.body.toString());
      default:{

        throw NetflixException('statusCode: ${response.statusCode}',response.body.toString());
      }
    }

  }
}