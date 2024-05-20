/*import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class ScanController extends GetxController {
  late CameraController cameraController;
  late List<CameraDescription> cameras;
  var isCameraInitialized = false.obs;
  var cameraCount = 0;
  bool isProcessing = false;
  var x, y, w, h = 0.0;
  var label = "";

  @override
  void onInit() {
    super.onInit();
    loadModel().then((_) => initCamera());
  }


  Future<void> loadModel() async {
    try {
      final byteData = await rootBundle.load("assets/tflite.tflite");
      log("Model size: ${byteData.lengthInBytes} bytes");

      // Debugging: Load and print the labels
      final labelsData = await rootBundle.loadString("assets/labels.txt");
      final String labels = labelsData.split('\n').map((label) => label.trim()).where((label) => label.isNotEmpty).join(',');
      log("Labels: $labels");

      await Tflite.loadModel(
        model: "assets/tflite.tflite",
        labels: labels,
        isAsset: true,
        numThreads: 1,
        useGpuDelegate: false,
      );

      log("Model loaded successfully");
    } catch (e) {
      log("Failed to load model: $e");
    }
  }







  Future<void> initCamera() async {
    var cameraStatus = await Permission.camera.status;
    if (cameraStatus.isGranted) {
      cameras = await availableCameras();
      cameraController = CameraController(
        cameras[0],
        ResolutionPreset.max,
        imageFormatGroup: ImageFormatGroup.yuv420,
      );
      await cameraController.initialize().then((_) {
        cameraController.startImageStream((image) => processCameraImage(image));
        isCameraInitialized(true);
        update();
      });
    } else {
      log("Camera permission denied");
      // Handling denied permissions more gracefully
      if (cameraStatus.isPermanentlyDenied) {
        openAppSettings();
      } else {
        await Permission.camera.request();
        initCamera(); // Retry initializing the camera after requesting permission
      }
    }
  }


  void processCameraImage(CameraImage image) {
    // Implementing a more sophisticated throttling mechanism based on time or frame count
    cameraCount++;
    if (cameraCount % 10 == 0 && !isProcessing) {
      objectDetector(image);
      cameraCount = 0;
    }
  }

  Future<void> objectDetector(CameraImage image) async {
    isProcessing = true;
    try {
      var detections = await Tflite.runModelOnFrame(
        bytesList: image.planes.map((plane) => plane.bytes).toList(),
        imageHeight: image.height,
        imageWidth: image.width,
        imageMean: 127.5,
        imageStd: 127.5,
        rotation: 90,
        numResults: 1,
        threshold: 0.4,
        asynch: true,
      );

      if (detections != null && detections.isNotEmpty) {
        var ourDetectedObject = detections.first;
        if (ourDetectedObject['confidenceInClass'] * 100 > 45) {
          label = ourDetectedObject['detectedClass'].toString();
          h = ourDetectedObject['rect']['h'];
          w = ourDetectedObject['rect']['w'];
          x = ourDetectedObject['rect']['x'];
          y = ourDetectedObject['rect']['y'];
          update(); // Ensure UI updates happen on main thread
        }
      }
      log("Results: $detections");
    } catch (e) {
      log("Error running model on frame: $e");
    } finally {
      isProcessing = false;
    }
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
}
*/