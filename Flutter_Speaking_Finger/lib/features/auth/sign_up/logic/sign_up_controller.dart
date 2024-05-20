import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soh/core/class/app_link.dart';
import 'package:soh/features/auth/sign_up/data/sign_up_data.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/class/status_request.dart';
import '../../../../core/helpers/functions/handling_data.dart';
import '../../../../core/routes/AppRoute/routersName.dart';



abstract class SignUpController extends GetxController {
  goToLogin();

}

class SignUpControllerImpl extends SignUpController {
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController name;
  StatusRequest statusRequest = StatusRequest.none;
 SignUpData signUpData =SignUpData(Get.find());
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  IconData showPasswordIcon = Icons.visibility_off_outlined;
  bool isShowPassword = false;

  changeIsShowPassword() {
    isShowPassword = isShowPassword == true ? false : true;
    update();
  }

  showPassword() {
    showPasswordIcon = isShowPassword == true
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
    update();
  }

  // @override
  // goToRegister() async {
  //   if (formState.currentState!.validate()) {
  //     try {
  //       statusRequest = StatusRequest.loading;
  //       update();
  //
  //       var response = await signUpData.registerData(email.text, password.text, name.text);
  //       print("=============================== Controller $response");
  //
  //       if (response['user'] != null) {
  //         String userId = response['user']['id'].toString();
  //         print(userId); // This should now correctly print the user's id
  //         Get.offNamed(AppRouter.verifyCodeSignUp, arguments: {"email": email.text, "id": userId});
  //         print(userId); // Confirms the userId is passed correctly
  //       } else {
  //         String errorMessage = response['message'] ?? 'Check email and password email may be token and password may be had least 1 number and 1 uppercase letter';
  //         showErrorDialog(errorMessage);
  //         statusRequest = StatusRequest.failure;
  //       }
  //
  //     } catch (e) {
  //       showErrorDialog('Check email and password email may be token and password may be had least 1 number and 1 uppercase letter and at least  least 8 characters');
  //       print(e);
  //     } finally {
  //       statusRequest = StatusRequest.none;
  //       update();
  //     }
  //   }
  // }

  goToRegister() async {
    const String apiUrl = AppLink.signUp;

    if (formState.currentState!.validate()) {
      try {
        final response = await http.post(
          Uri.parse(apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'email': email.text,
            'password': password.text,
            'name':name.text
          }),
        );

        if (response.statusCode == 200||response.statusCode ==201) {
          final Map<String, dynamic> responseData = jsonDecode(response.body);
          String userId =responseData ['user']['id'].toString();
          print(userId); // This should now correctly print the user's id
          Get.offNamed(AppRouter.verifyCodeSignUp, arguments: {"email": email.text, "id": userId});

          print('Register successful');
          print('Response Body: ${response.body}');
        } else {
          statusRequest=StatusRequest.serverFailure;
          print('Failed to login. Status Code: ${response.statusCode}');
          final Map<String, dynamic> errorData = jsonDecode(utf8.decode(response.bodyBytes));
          showErrorDialog(errorData['message'] ?? 'An unknown error occurred');
        }
      } catch (e) {
        statusRequest=StatusRequest.failure;
        print('Error occurred while trying to register: $e');
        showErrorDialog('Failed to process your request. Please try again later.');
      }
    }
  }
  void showErrorDialog(String message) {
    Get.defaultDialog(
      title: "Warning",
      middleText: message,
    );
  }



  @override
  goToLogin() {
    Get.offNamed(AppRouter.login);
  }


  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    name = TextEditingController();

    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    name.dispose();

    super.dispose();
  }
}