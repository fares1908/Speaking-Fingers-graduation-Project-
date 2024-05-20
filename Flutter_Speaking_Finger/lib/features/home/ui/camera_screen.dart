import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:soh/core/theming/colors.dart';
import 'package:soh/core/theming/spacing.dart';
import 'package:soh/core/theming/text_styles.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late AudioPlayer _player;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    // Add the URL for your audio file here
    _player.setUrl('https://example.com/your_audio_file.mp3');
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    // Get.put(HomePageControllerImpl());
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(height: screenSize.height * 0.01), // dynamic spacing
            Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 20, left: 20),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6))),
                            backgroundColor:
                                const MaterialStatePropertyAll(AppColors.themeColor)),
                        onPressed: () {},
                        child: Text(
                          'Camera',
                          style: TextStyles.font20WhiteSemiBold
                              .copyWith(color: Colors.black, fontSize: 14),
                        )),
                  ),
                  horizontalSpace(20),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6))),
                          backgroundColor: MaterialStatePropertyAll(
                              AppColors.themeColor.withOpacity(.2))),
                      child: Text(
                        'Alphabets',
                        style: TextStyles.font20WhiteSemiBold
                            .copyWith(color: Colors.black, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenSize.height * 0.02), // dynamic spacing
            Padding(
              padding:
                  EdgeInsets.all(screenSize.width * 0.04), // dynamic padding
              child: AspectRatio(
                aspectRatio:
                    4 / 3, // Maintain the aspect ratio of the camera view
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey[300], // Placeholder for camera view
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        child: const CircleAvatar(
                          backgroundColor: Colors.white,
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: screenSize.height * 0.02), // dynamic spacing
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.themeColor.withOpacity(.4),
                            borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.all(6),
                        child: const Text(
                          'Commodo proin diam amet facilisis ac in in nibh. '
                          'Sed nisl nunc ante malesuada. Elit amet vulputate '
                          'loreet dictum. Aliquet aliquam nullam nisi malesuada ipsum.',
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Text',
                          style: TextStyles.font20WhiteSemiBold
                              .copyWith(color: Colors.black, fontSize: 14),
                        ),
                        trailing: Container(
                          decoration: BoxDecoration(
                              color: AppColors.themeColor.withOpacity(.4),
                              borderRadius: BorderRadius.circular(5)),
                          height: 30,
                          child: DropdownButton<String>(
                            icon: const Icon(Icons.keyboard_arrow_down_outlined),
                            hint: Text(
                              'Languages',
                              style: TextStyles.font20WhiteSemiBold
                                  .copyWith(color: Colors.black, fontSize: 12),
                            ),
                            padding: const EdgeInsets.all(6),
                            borderRadius: BorderRadius.circular(6),
                            items: <String>['Languages', 'More', 'Options']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (_) {},
                          ),
                        ),
                      ),
                      SizedBox(
                          height: screenSize.height * 0.02), // dynamic spacing
                      Text(
                        'Record',
                        style: TextStyles.font20WhiteSemiBold
                            .copyWith(color: Colors.black, fontSize: 14),
                      ),
                      SizedBox(
                          height: screenSize.height * 0.02),
                      Container(
                     decoration: BoxDecoration(
                         color: AppColors.themeColor.withOpacity(.3),
                         borderRadius: BorderRadius.circular(8)),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: const Icon(Icons.play_arrow,
                              size: 30,
                              ),
                              onPressed: () {
                                _player.play();
                              },
                            ),
                            StreamBuilder<Duration?>(
                              stream: _player.durationStream,
                              builder: (context, snapshot) {
                                final duration = snapshot.data ?? Duration.zero;
                                return StreamBuilder<Duration>(
                                  stream: _player.positionStream,
                                  builder: (context, snapshot) {
                                    
                                    var position = snapshot.data ?? Duration.zero;
                                    if (position > duration) {
                                      position = duration;
                                    }
                                    return SeekBar(
                                      
                                      duration: duration,
                                      position: position,
                                      onChangeEnd: (newPosition) {
                                        _player.seek(newPosition);
                                      },
                                    );
                                  },
                                );
                              },
                            ),


                          ],
                        ),
                   ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class SeekBar extends StatelessWidget {
  final Duration duration;
  final Duration position;
  final ValueChanged<Duration> onChangeEnd;

  SeekBar({
    required this.duration,
    required this.position,
    required this.onChangeEnd,
  });

  @override
  Widget build(BuildContext context) {
    return Slider(
     activeColor:  AppColors.themeColor,
      inactiveColor: Colors.white,
      min: 0.0,
      max: duration.inMilliseconds.toDouble(),
      value: position.inMilliseconds.toDouble(),
      onChanged: (value) {
        onChangeEnd(Duration(milliseconds: value.round()));
      },
    );
  }
}