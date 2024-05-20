import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../favourite/logic/favourite_controller.dart';
import '../../../favourite/logic/videoResponse.dart';

class VideoItem extends StatelessWidget {
  final Videos video;
  final FavouriteController favouriteController = Get.put(FavouriteController());

  VideoItem({required this.video});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GetBuilder<FavouriteController>(
        builder: (controller) => Column(
          children: [
            Container(
              padding: const EdgeInsets.only(right: 12, left: 12),
              width: double.infinity,
              height: 140,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(10),
                ),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: CachedNetworkImage(
                      imageUrl: video.thumbnail!,
                      progressIndicatorBuilder: (context, url, downloadProgress) => Container(
                        width: 50,
                        height: 50,
                        child: Center(
                          child: CircularProgressIndicator(
                            value: downloadProgress.progress,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        if (video.isFav == true) {
                          favouriteController.removeFavoriteVideo(video.title!);
                        } else {
                          favouriteController.addFavoriteVideo(video.title!);
                        }
                        video.isFav = !(video.isFav ?? false); // Toggle favorite status
                        controller.update(); // Notify controller of the change
                      },
                      child: Container(
                        color: Colors.black.withOpacity(0.5),
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                video.title ?? '',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Icon(
                              video.isFav == true ? Icons.favorite : Icons.favorite_border,
                              color: video.isFav == true ? Colors.red : Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
