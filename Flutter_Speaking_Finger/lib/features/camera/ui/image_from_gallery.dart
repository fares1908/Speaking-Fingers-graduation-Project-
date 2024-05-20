import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:soh/core/class/my_services.dart';
import 'package:soh/core/theming/colors.dart';

class ImagePickScreen extends StatefulWidget {
  @override
  _ImagePickScreenState createState() => _ImagePickScreenState();
}

class _ImagePickScreenState extends State<ImagePickScreen> {
  File? _image;
  String? _responseLetter;
  final MyServices myServices = Get.find();
  final AudioPlayer audioPlayer = AudioPlayer();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // audioPlayer.playerStateStream.listen((state) {
    //   if (state.processingState == ProcessingState.completed) {
    //     // Auto rewind to start for replay capability.
    //     audioPlayer.seek(Duration.zero);
    //   }
    // });
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _responseLetter = null;
        isLoading = true;
      });
      await uploadImage(_image!);
    }
  }

  Future<void> uploadImage(File imageFile) async {
    try {
      var uri = Uri.parse(
          'https://youssifallam.pythonanywhere.com/api/CNN-api/predict_class');
      var request = http.MultipartRequest('POST', uri)
        ..files
            .add(await http.MultipartFile.fromPath('picture', imageFile.path));

      final String? bearerToken =
          myServices.sharedPreferences.getString('token');
      if (bearerToken == null) {
        setState(() {
          _responseLetter = "No authentication token found.";
          isLoading = false;
        });
        return;
      }

      request.headers.addAll({"Authorization": "Bearer $bearerToken"});

      var response = await request.send();

      if (response.statusCode == 200) {
        final responseString = await response.stream.bytesToString();
        final jsonResponse = json.decode(responseString);

        setState(() {
          _responseLetter =
              jsonResponse['data']['arabic_letter'] ?? "Letter not detected.";
          isLoading = false;
        });

        if (_responseLetter != null && _responseLetter!.isNotEmpty) {
          convertTextToSpeech(_responseLetter!);
        }
      } else {
        print('Failed to upload image. Status code: ${response.statusCode}');
        setState(() {
          _responseLetter = "Failed to process image.";
          isLoading = false;
        });
      }
    } catch (e) {
      print('Exception caught: $e');
      setState(() {
        _responseLetter = "An error occurred during processing.";
        isLoading = false;
      });
    }
  }

  Future<void> convertTextToSpeech(String text) async {
    var uri = Uri.parse(
        'https://youssifallam.pythonanywhere.com/api/v1/GTTS/text-to-speech/');
    try {
      var response = await http.post(uri,
          headers: {"Content-Type": "application/json"},
          body: json.encode({"text": text, "language": "ar"}));

      if (response.statusCode == 201) {
        var jsonResponse = json.decode(response.body);
        await playAudio(jsonResponse['URL']);
      } else {
        print(
            'Failed to convert text to speech. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        setState(() {
          _responseLetter =
              "Error converting text to speech: Server responded with status code ${response.statusCode}.";
        });
      }
    } catch (e) {
      print('Exception caught during conversion to speech: $e');
      setState(() {
        _responseLetter = "An error occurred during processing: $e";
      });
    }
  }

  Future<void> playAudio(String url) async {
    try {
      await audioPlayer.setUrl(url);
      await audioPlayer.play();
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading) CircularProgressIndicator(),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(AppColors.themeColor)),
              onPressed: !isLoading ? pickImage : null,
              child: Text('Pick Image From Gallery'),
            ),
            const SizedBox(height: 20),
            _image != null
                ? ClipRRect(
              borderRadius: BorderRadius.circular(12),
                    child: Image.file(_image!,
                        width: 200, height: 200, fit: BoxFit.cover))
                : const Text('No image selected.'),
            const SizedBox(height: 20),
            _responseLetter != null
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                      color: AppColors.themeColor,
                    ),
                    height: 50,
                    width: 200,
                    child: Center(
                        child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: DefaultTextStyle.of(context)
                            .style, // Default text style
                        children: <TextSpan>[
                          const TextSpan(
                              text: 'Detected Letter : ',
                              style: TextStyle(color: Colors.black)),
                          TextSpan(
                              text: _responseLetter,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12)), // Customize color as needed
                        ],
                      ),
                    )),
                  )
                : Container(),
            if (_responseLetter != null && !isLoading) audioControls(),
          ],
        ),
      ),
    );
  }

  Widget audioControls() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // IconButton(
            //   icon: Icon(audioPlayer.playing ? Icons.pause : Icons.play_arrow),
            //   onPressed: () {
            //     if (audioPlayer.playing) {
            //       audioPlayer.pause();
            //     } else {
            //       audioPlayer.play();
            //     }
            //   },
            // ),
            IconButton(
              icon: Icon(Icons.replay),
              onPressed: () {
                // This button will allow the user to manually rewind the audio
                audioPlayer.seek(Duration.zero);
                audioPlayer
                    .play(); // Optionally start playing immediately after rewind
              },
            ),
          ],
        ),
        StreamBuilder<Duration>(
          stream: audioPlayer.positionStream,
          builder: (context, snapshot) {
            final position = snapshot.data ?? Duration.zero;
            final totalDuration = audioPlayer.duration ?? Duration.zero;
            return Slider(

              activeColor: AppColors.themeColor,
              min: 0.0,
              max: totalDuration.inSeconds.toDouble(),
              value: position.inSeconds
                  .clamp(0.0, totalDuration.inSeconds.toDouble())
                  .toDouble(),
              onChanged: (value) {
                audioPlayer.seek(Duration(seconds: value.toInt()));
              },
            );
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
}
