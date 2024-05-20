import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:soh/features/favourite/logic/ResModel.dart';
import 'package:soh/features/favourite/logic/videoDetailsResponse.dart';
import 'package:soh/features/favourite/logic/videoResponse.dart';

import '../../../core/class/my_services.dart';

class apiManger {
  // https://youssifallam.pythonanywhere.com/api/v1/Videos/Get_All_Videos/
  //https://youssifallam.pythonanywhere.com/api/v1/Videos/Get-Video-Details/?video_title=lesson 1
  static const String baseUrl = 'youssifallam.pythonanywhere.com';
  static const String apikey = '263b8ef3b6cb41e1aa193c089088ca13';

  static Future<VideoResponse> getVideos() async {
    MyServices services = Get.find();
    final token = services.sharedPreferences.getString('token') ?? ''; // Retrieve the token

    var url = Uri.https(baseUrl, '/api/v1/Videos/Get_All_Videos/', {});
    var response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var bodyString = response.body;
      var json = jsonDecode(bodyString);
      var videoResponse = VideoResponse.fromJson(json);
      print(response);
      print(videoResponse);
      print(json);
      return videoResponse;
    } else {
      throw Exception('Failed to load videos');
    }
  }


  static Future<VideoDetailsResponse> getVideoDetails(String videoTitle) async {
    MyServices services = Get.find();
    final token = services.sharedPreferences.getString('token') ?? ''; // Retrieve the token

    var headers = {
      'Authorization': 'Bearer $token',
    };

    var url = Uri.parse('https://youssifallam.pythonanywhere.com/api/v1/Videos/Get-Video-Details/?video_title=${Uri.encodeComponent(videoTitle)}');
    var request = http.Request('GET', url);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var bodyString = await response.stream.bytesToString();
    var json = jsonDecode(bodyString);
    var videoDetailsResponse = VideoDetailsResponse.fromJson(json);

    if (response.statusCode == 200) {
      print(videoDetailsResponse);
    } else {
      print(response.reasonPhrase);
    }

    return videoDetailsResponse;
  }


  static Future<RespModel> logout() async {
    var headers = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzE1MjgxNjE5LCJpYXQiOjE3MTM5ODU2MTksImp0aSI6IjNkYjYwMTI5NWRhOTQyOThhODg2Y2Y5ZmM4M2ZiMDZjIiwidXNlcl9pZCI6MTc1fQ.WGZD3If4Oe8RskXO2AoBTcGSaSAh0MHGtxoC8uq-xqE'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://youssifallam.pythonanywhere.com/api/v1/Videos/Get-Video-Details/?video_title=lesson+1'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var body = await response.stream.bytesToString();
    var responseModel = RespModel.fromJson(jsonDecode(body));

    return responseModel;
  }
}

/*var body = await response.stream.bytesToString();
var responseModel = RespModel.fromJson(jsonDecode(body));


 return responseModel;*/

// static Future<VideoDetailsResponse> getVideoDetails() async {
//   var headers = {
//     'Authorization':
//         'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzE1MjgxNjE5LCJpYXQiOjE3MTM5ODU2MTksImp0aSI6IjNkYjYwMTI5NWRhOTQyOThhODg2Y2Y5ZmM4M2ZiMDZjIiwidXNlcl9pZCI6MTc1fQ.WGZD3If4Oe8RskXO2AoBTcGSaSAh0MHGtxoC8uq-xqE'
//   };
//   var url = Uri.http(
//       baseUrl, '/api/v1/Videos/Get-Video-Details/?video_title=lesson 1');
//   var response = await http.get(url, headers: headers);
//  // response.headers.addAll(headers);
//   var bodyString = response.body;
//   var json = jsonDecode(bodyString);
//   var videoDetailsResponse = VideoDetailsResponse.fromJson(json);
//
//    print(response);
//    print(bodyString);
//     return videoDetailsResponse;
//
//   }
