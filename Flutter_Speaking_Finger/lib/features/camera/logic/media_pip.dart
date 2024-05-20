import 'package:flutter_vision/flutter_vision.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';

class CameraControllerX extends GetxController {
  CameraController? cameraController;
  var isCameraInitialized = false.obs;
  var responseText = ''.obs;
  late List<Map<String, dynamic>> yoloResults;
  CameraImage? cameraImage;
  bool isLoaded = false;
  bool isDetecting = false;
  final FlutterVision vision = FlutterVision();

  @override
  void onInit() {
    super.onInit();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();

    if (cameras.isNotEmpty) {
      cameraController = CameraController(cameras[0], ResolutionPreset.medium);
      await cameraController!.initialize();
       isLoaded = true;
          isDetecting = false;
          yoloResults = [];
          await loadYoloModel();
      isCameraInitialized(true);
    }

    

  }

  void closeCamera() {
    cameraController?.dispose();
    isCameraInitialized(false);
    update();  // Trigger UI update
  }
  Future<void> loadYoloModel() async {
    await vision.loadYoloModel(
        labels: 'assets/labels.txt',
        modelPath: 'assets/model.tflite',
        modelVersion: "yolov8",
        numThreads: 2,
        useGpu: true);
  
      isLoaded = true;
   
  }


  Future<void> yoloOnFrame(CameraImage cameraImage) async {
    final result = await vision.yoloOnFrame(
        bytesList: cameraImage.planes.map((plane) => plane.bytes).toList(),
        imageHeight: cameraImage.height,
        imageWidth: cameraImage.width,
        );
    if (result.isNotEmpty) {
    
        yoloResults = result;
       
      
    }
  }

  Future<void> startDetection() async {
   
      isDetecting = true;
   
    if (cameraController!.value.isStreamingImages) {
      return;
    }
    await cameraController!.startImageStream((image) async {
      if (isDetecting) {
        cameraImage = image;
        yoloOnFrame(image);
      }
    });
  }

  Future<void> stopDetection() async {
   
      isDetecting = false;
      yoloResults.clear();
   
  }

 

  
  @override
  void onClose() {
    cameraController?.dispose();
    super.onClose();
  }
}