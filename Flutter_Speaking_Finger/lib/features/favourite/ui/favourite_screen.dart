import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

// Assuming MyServices is properly defined in your core class
import '../../../core/class/my_services.dart';
import 'widgets/custom_app_bar.dart';
import 'widgets/fav_video_card.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  MyServices services = Get.find();
  final String apiUrl = 'https://youssifallam.pythonanywhere.com//api/v1/Videos/Get-user-favorites-videos/';
  late String token;

  @override
  void initState() {
    super.initState();
    token = services.sharedPreferences.getString('token') ?? '';
  }

  Future<List<Video>> fetchFavoriteVideos() async {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['data'];
      return data.map((item) => Video.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load favorite videos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200.0), // Adjust the height here as needed
        child: CustomAppBar(),
      ),
      body: FutureBuilder<List<Video>>(
        future: fetchFavoriteVideos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No favorite videos found.'));
          } else {
            return GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: (1 / 1),
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final video = snapshot.data![index];
                return FavoriteVideoCard(
                  videoName: video.title ?? 'No Title',
                videoTdm: video.thumbnail ?? '',
                );
              },
            );
          }
        },
      ),
    );
  }
}

class Video {
  final int? id;
  final String? title;
  final String? description;
  final String? videoFile;
  final String? thumbnail;

  Video({
    required this.id,
    required this.title,
    required this.description,
    required this.videoFile,
    required this.thumbnail,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['video']['id'],
      title: json['video']['title'],
      description: json['video']['description'],
      videoFile: json['video']['video_file'],
      thumbnail: json['video']['thumbnail'],
    );
  }
}
