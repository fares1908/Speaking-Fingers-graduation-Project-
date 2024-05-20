import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../helpers/functions/check_internet.dart';
import 'status_request.dart';
class Crud {
  Future<Either<StatusRequest, Map>> postData(String linkUrl, Map data) async {
    if (await checkInternet()) {
      http.Response response = await http.post(Uri.parse(linkUrl), body: data ,

      headers: {
        'Cookie': 'csrftoken=wx4U7zdYJwTde0Lo4KguKPpNTUWyje39; sessionid=c673tcvmy7a4pl15dt75k0amnprgwnes'
      });
      if (kDebugMode) {
        print(response.statusCode);
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (kDebugMode) {
          print('Response Body: ${response.body}');
        }
        Map responseBody = json.decode(utf8.decode(response.bodyBytes));
        if (kDebugMode) {
          print(responseBody);
        }
        return Right(
            responseBody); // Return a Right containing the response body
      } else {
        return const Left(
            StatusRequest.serverFailure); // Return a Left with serverfailure
      }
    } else {
      return const Left(StatusRequest.offlineFailure);
    }
  }

  Future<Either<StatusRequest, Map>> getDataWithAuthorization(String linkUrl, String authToken) async {
    if (await checkInternet()) {
      http.Response response = await http.get(
        Uri.parse(linkUrl),
        headers: {'Authorization': 'Bearer $authToken'},
      );

      if (kDebugMode) {
        print(response.statusCode);
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (kDebugMode) {
          print('Response Body: ${response.body}');
        }
        Map responseBody = json.decode(response.body);
        if (kDebugMode) {
          print(responseBody);
        }
        return Right(responseBody);
      } else {
        return const Left(StatusRequest.serverFailure);
      }
    } else {
      return const Left(StatusRequest.offlineFailure);
    }
  }
}
