import 'package:flutter/material.dart';
import 'package:soh/features/favourite/logic/videoResponse.dart';
import 'package:soh/features/home/ui/widgets/videoItem.dart';

import '../VideoDetailsScreen.dart';

class VideoContainer extends StatelessWidget {
  final List<Videos> videoList;


  VideoContainer({
    required this.videoList,

  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      // padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 2,
        mainAxisSpacing: .2,
      ),
      itemCount: videoList.length,
      itemBuilder: (context, index) {
        final video = videoList[index];
       return InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => VideoDetailsScreen(video: video, allVideos: videoList,),
              ),
            );
          },
          child: VideoItem(video: video),
        );

      },
    );
  }
}
