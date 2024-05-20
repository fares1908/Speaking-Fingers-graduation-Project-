// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:tflite_flutter/tflite_flutter.dart' as tfl;
// import 'package:image/image.dart' as img; // Add this import for image processing
//
// class ScanScreen extends StatefulWidget {
//   @override
//   _ScanScreenState createState() => _ScanScreenState();
// }
//
// class _ScanScreenState extends State<ScanScreen> {
//   late CameraController _cameraController;
//   bool _isCameraInitialized = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeCamera();
//   }
//
//   void _initializeCamera() async {
//     final cameras = await availableCameras();
//     final camera = cameras.first;
//     _cameraController = CameraController(camera, ResolutionPreset.medium);
//     await _cameraController.initialize();
//     setState(() {
//       _isCameraInitialized = true;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (!_isCameraInitialized) {
//       return Scaffold(
//         body: Center(
//           child: CircularProgressIndicator(),
//         ),
//       );
//     }
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sign Language Detection'),
//       ),
//       body: CameraPreview(_cameraController),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _performInference,
//         child: Icon(Icons.camera),
//       ),
//     );
//   }
//
//   void _performInference() async {
//     // Load TensorFlow Lite model
//     final interpreter = await tfl.Interpreter.fromAsset('assets/tflite.tflite');
//
//     // Process camera frame and pass it to model for inference
//     var image = await _cameraController.takePicture();
//
//     // Preprocess image if needed
//     // Convert the CameraImage to a format compatible with TensorFlow Lite
//     var inputImage = img.copyResize(
//       img.decodeImage(image!.format.group == ImageByteFormatGroup.yuv420
//           ? img.convertYUV420toImage(image.planes[0].bytes, image.planes[1].bytes,
//           image.planes[2].bytes, image.width, image.height)
//           : image.jpeg!.toList(growable: false),
//       ),
//       width: 224,
//       height: 224,
//     );
//     var input = inputImage!.getBytes();
//
//     // Perform inference
//     interpreter.allocateTensors();
//     interpreter.setTensor(interpreter.getInputTensor(0).index, input);
//     interpreter.invoke();
//
//     // Process output to detect sign language gestures
//     var output = interpreter.getOutputTensor(0);
//     // Process the output tensor to detect sign language gestures
//
//     // Close the interpreter to release resources
//     interpreter.close();
//   }
// }