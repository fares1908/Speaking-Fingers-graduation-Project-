import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HandSignController extends GetxController {
  RxString detectedSign = 'None'.obs;

  Future<void> sendFrameToYOLO(List<int> frameData) async {
    final String apiUrl = 'https://8e88-41-232-32-20.ngrok-free.app/api/v1/api/v1/Mediapipe/hand-tracking/';

    try {
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        body: {'frame': frameData},
      );

      if (response.statusCode == 200) {
        detectedSign.value = response.body;
      } else {
        detectedSign.value = 'Error: ${response.reasonPhrase}';
      }
    } catch (e) {
      detectedSign.value = 'Error: $e';
    }
  }
}
