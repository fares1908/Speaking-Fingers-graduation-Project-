import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soh/features/favourite/logic/videoResponse.dart';
import 'package:soh/features/favourite/ui/widgets/custom_appBar_forvideoDetails.dart';
import 'package:video_player/video_player.dart';

class VideoDetailsScreen extends StatefulWidget {
  final Videos video;
  final List<Videos> allVideos;

  VideoDetailsScreen({required this.video, required this.allVideos});

  @override
  State<VideoDetailsScreen> createState() => _VideoDetailsScreenState();
}

class _VideoDetailsScreenState extends State<VideoDetailsScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.video.videoFile!);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.addListener(_onControllerUpdated);
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerUpdated);
    _controller.dispose();
    super.dispose();
  }

  void _onControllerUpdated() {
    if (_controller.value.hasError) {
      // Handle error
    }
    if (_controller.value.isPlaying != _isPlaying) {
      setState(() {
        _isPlaying = _controller.value.isPlaying;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_controller.dataSource != widget.video.videoFile) {
      _controller.removeListener(_onControllerUpdated);
      _controller.dispose();
      _controller = VideoPlayerController.network(widget.video.videoFile!);
      _initializeVideoPlayerFuture = _controller.initialize();
      _controller.setLooping(true);
      _controller.addListener(_onControllerUpdated);
    }
  }

  void _togglePlayPause() {
    if (_controller.value.isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200.0),
        child: CustomAppBarVideoDetails(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 12, right: 12, bottom: 12),
              height: 250,
              width: double.infinity,
              child: FutureBuilder(
                future: _initializeVideoPlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          VideoPlayer(_controller),
                          Center(
                            child: IconButton(
                              onPressed: _togglePlayPause,
                              icon: Icon(
                                _isPlaying ? Icons.pause : Icons.play_arrow,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.video.title ?? 'No title',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    widget.video.description ?? 'No Description',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            ...widget.allVideos.where((v) => v != widget.video).map((video) {
              return Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 12),
                child: ListTile(
                  leading: video.thumbnail != null
                      ? CachedNetworkImage(
                    imageUrl: video.thumbnail!,
                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                        Container(
                          width: 50, // Adjust the size as needed
                          height: 50,
                          child: Center(
                            child: CircularProgressIndicator(
                              value: downloadProgress.progress,
                            ),
                          ),
                        ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.fill,
                  )
                      : Placeholder(),
                  title: Text(video.title ?? 'No Title'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VideoDetailsScreen(
                          video: video,
                          allVideos: widget.allVideos,
                        ),
                      ),
                    );
                  },
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
