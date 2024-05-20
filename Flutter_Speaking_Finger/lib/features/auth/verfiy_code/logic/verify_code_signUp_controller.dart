import 'package:get/get.dart';
import 'package:soh/features/auth/verfiy_code/data/verify_code_data.dart';

import '../../../../core/class/status_request.dart';
import '../../../../core/helpers/functions/handling_data.dart';
import '../../../../core/routes/AppRoute/routersName.dart';


abstract class VerifyCodeSignUp extends GetxController {

  goToSuccessSignUp(String verifyCode);
}
class VerifyCodeSignUpImpl extends VerifyCodeSignUp{
  String? email;
  String? id;
  StatusRequest statusRequest=StatusRequest.none;
  VerifyCodeSignUpData verifyCodeSignUpData=VerifyCodeSignUpData(Get.find());


  @override
  goToSuccessSignUp(String verifyCode) async {
    statusRequest = StatusRequest.loading;
    update();
    try {
      var response = await verifyCodeSignUpData.postData(id!, verifyCode);
      print('=====================Controller$response');

      // Assuming handlingData sets statusRequest to success if the server returns a successful response
      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success) {
        // Checking if the "message" key exists and contains the expected success message
        String successMessage = response['message'];
        if (successMessage.isNotEmpty) {
          Get.offNamed(AppRouter.login);
          // Optionally, show a success dialog/message to the user
          Get.defaultDialog(title: "Success", middleText: successMessage);
        } else {
          // If the message is not as expected, handle it as a failure or unexpected response
          Get.defaultDialog(title: "Warning", middleText: "Verification code is incorrect");
          statusRequest = StatusRequest.failure;
        }
      } else if (statusRequest == StatusRequest.serverFailure) {
        // Handle server failure
        Get.defaultDialog(title: "Error", middleText: "An error occurred on the server. Please try again later.");
      }
    } catch (e) {
      // Handle any other errors that might occur
      print(e);
      Get.defaultDialog(title: "Error", middleText: "An unexpected error occurred. Please try again later.");
      statusRequest = StatusRequest.failure;
    } finally {
      update();
    }
  }

  @override
  void onInit() {
    email = Get.arguments['email'];
    id = Get.arguments['id'];
    super.onInit();
  }

  Future<void> resendCode() async {
    var response = await verifyCodeSignUpData.resendCode(email!);
    print('=====================Controller$response');
  }


}