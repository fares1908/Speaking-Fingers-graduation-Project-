import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soh/features/camera/ui/detection.dart';

import '../logic/media_pip.dart';
// Correct import based on your project structure

class MediaPip extends StatelessWidget {
  const MediaPip({super.key});


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: ElevatedButton(child: Text('Open Camera'),onPressed: (){
          Navigator.push(context,MaterialPageRoute(builder:(context)=> Detection()));
        },)
      ),
    );
  }
  
}