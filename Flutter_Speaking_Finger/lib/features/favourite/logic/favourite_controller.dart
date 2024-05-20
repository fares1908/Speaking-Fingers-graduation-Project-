import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:soh/core/class/my_services.dart';
import 'dart:convert';
import '../logic/videoResponse.dart';

class FavouriteController extends GetxController {
  MyServices services = Get.find();
  List <Videos> favoriteVideos = [];



  Future<void> addFavoriteVideo(String videoTitle) async {
    final token = services.sharedPreferences.getString('token') ?? ''; // Replace with your actual method of getting the token

    final url = Uri.parse('https://youssifallam.pythonanywhere.com/api/v1/Videos/add-fav-video-to-user/');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {
        'video_title': videoTitle,
      },
    );

    if (response.statusCode == 201|| response.statusCode ==204){
      Get.snackbar('Success', 'Video added to favorites successfully');

    } else {
      Get.snackbar('Error', 'Failed to add video to favorites: ${response.statusCode} - ${response.body}');
    }
  }

  Future<void> removeFavoriteVideo(String videoTitle) async {
    final token = services.sharedPreferences.getString('token') ?? ''; // Replace with your actual method of getting the token

    final url = Uri.parse('https://youssifallam.pythonanywhere.com/api/v1/Videos/remove-favorite-video/');
    final response = await http.delete(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {
        'video_title': videoTitle,
      },
    );

    if (response.statusCode == 200|| response.statusCode ==204) {
      Get.snackbar('Success', 'Video removed from favorites successfully');

    } else {
      Get.snackbar('Error', 'Failed to remove video from favorites: ${response.statusCode} - ${response.body}');
    }
  }
}
