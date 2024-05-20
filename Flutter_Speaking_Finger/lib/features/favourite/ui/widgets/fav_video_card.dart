import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../logic/favourite_controller.dart';

class FavoriteVideoCard extends StatelessWidget {
  final String videoName;
  final String videoTdm;

  const FavoriteVideoCard({
    Key? key,
    required this.videoName,
    required this.videoTdm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(FavouriteController());
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(10)),
                color: Colors.grey.shade300,
              ),
              child: Center(
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(10)),
                  child: CachedNetworkImage(
                    imageUrl: videoTdm,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => SizedBox(
                      width: 50,
                      height: 50,
                      child: Center(
                        child: CircularProgressIndicator(
                          value: downloadProgress.progress,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  videoName,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
